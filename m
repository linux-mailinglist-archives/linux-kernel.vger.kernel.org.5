Return-Path: <linux-kernel+bounces-16619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCDB824149
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09331C21D99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B4A2137E;
	Thu,  4 Jan 2024 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2hAgAPR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB0821369
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a26f5e937b5so49812366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704370061; x=1704974861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8jCwMDgZSyl6nR1Fd9Z+yK1tqC9F+y4Fnvbfm9QdOo=;
        b=L2hAgAPRZESEczY18IocUr+4g9YeKy06kK8lAArXN4b8jaQ735ZRIhr9rAQjrdNrxY
         BZqvl/NUxYYNx+Z4Nxv5UuIZrRZ0fPTRqHtpGygrvKlffbM8HVCu/OgrdB0HFVhYOCtl
         RFgbOvUHCG9OzprmHtIS1bGivyAoi0y/oeNv8PEKgTISidUvy8CrziaVhFqh1wHJzi3I
         yfwkkMSU1h1Bk1++EIIil2H5gY9dqOngZlJKvnp5Fw1EJS5QMANgluc+0hoDLFlytILW
         C4gf9f2TGbEqah5nZPKoucXzqnjT/5/9ktPXTm3qpHcBID7hUFYRfPjgth4IIkmAhMXb
         KEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704370061; x=1704974861;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8jCwMDgZSyl6nR1Fd9Z+yK1tqC9F+y4Fnvbfm9QdOo=;
        b=aAOuDQR/GCKgPJgWfchHh0U0YFGO8xemAy4SdvDaxMAum2aRU2T/xz+AIkI36mE8X5
         5in7nM+rMscxgTxpYpMa51mvDMJ9faq1Mfy8GbQC5+St44kXZCSdwhDk9osxv7t6RTQP
         b7WPoKGWkPoWON9LtmyJ6aVpV7pBIHipdyBHUC5kCWP+QaTpw/Jo1s/ebGRswr6X4mGa
         8QTXGyOk0GmYsLKo607jy3r3Zv55IoCw5XnEmSKxsog8MIp7XESWi6KKq49ubm/NDrEa
         vbxrA0IsWP6YiHqj+9smX4VXqvG3jYq4GrJyMC2Dorf2mvistVzlaQ45VMymp/c4Nmqg
         vn7Q==
X-Gm-Message-State: AOJu0YwN2Optf8deYsdoigMhYpSeXbaL+F7yQiTwk2JOi6gEFL6MfMuB
	BOs+wX7yyBt4h0P9/UZ1QRFEN16fs//z8A==
X-Google-Smtp-Source: AGHT+IFzYMSyCJ9fZ4PHUD/vE+PZ5odR4nVxHjsWim15tqnHJR9IsUjahbejBEWkodskfOWG/UDoaw==
X-Received: by 2002:a17:906:4153:b0:a28:ab53:eda1 with SMTP id l19-20020a170906415300b00a28ab53eda1mr283695ejk.34.1704370061429;
        Thu, 04 Jan 2024 04:07:41 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id wh14-20020a170906fd0e00b00a234907311asm13622465ejb.55.2024.01.04.04.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 04:07:40 -0800 (PST)
Message-ID: <166fb0ff-dfd7-408a-ade1-2aa5a51d96aa@linaro.org>
Date: Thu, 4 Jan 2024 13:07:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq6018: add #power-domain-cells for
 gcc node
Content-Language: en-US
To: Fenglin Wu <quic_fenglinw@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Robert Marko <robimarko@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, quic_tdas@quicinc.com,
 quic_aiquny@quicinc.com, kernel@quicinc.com, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240104-gcc-docs-update-v1-1-127e4816b798@quicinc.com>
 <CAA8EJprsGke9zZBy_x=YSxz7R1aSpx8r3ndjjXVVKhjKBxd=QQ@mail.gmail.com>
 <724f608a-cbfe-48f6-a1f7-59b961a7d724@quicinc.com>
 <56ee556d-ec31-4553-bce3-0c1e12c111ed@linaro.org>
 <685f45d9-48e8-49c6-9de0-6771777ba62e@gmail.com>
 <a8012b92-6072-406d-8aab-ecb167ea44d2@quicinc.com>
 <CAA8EJpoAA7RyD=9JZ9aYLMhyvCMWLVr1yhe7NSryRe=VjfmZPw@mail.gmail.com>
 <c9f258f7-d075-47e9-8750-3e1427d03180@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c9f258f7-d075-47e9-8750-3e1427d03180@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/01/2024 11:55, Fenglin Wu wrote:
> 
> 
> On 1/4/2024 6:49 PM, Dmitry Baryshkov wrote:
>> On Thu, 4 Jan 2024 at 12:41, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
>>>
>>>
>>>
>>> On 1/4/2024 6:32 PM, Robert Marko wrote:
>>>>
>>>> On 04. 01. 2024. 11:16, Konrad Dybcio wrote:
>>>>> On 4.01.2024 11:13, Fenglin Wu wrote:
>>>>>>
>>>>>> On 1/4/2024 5:53 PM, Dmitry Baryshkov wrote:
>>>>>>> On Thu, 4 Jan 2024 at 10:06, Fenglin Wu via B4 Relay
>>>>>>> <devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
>>>>>>>> From: Fenglin Wu <quic_fenglinw@quicinc.com>
>>>>>>>>
>>>>>>>> Property '#power-domain-cells' is required as per defined in
>>>>>>>> qcom,gcc.yaml
>>>>>>>> so add it for ipq6018 gcc device node to eliminate following
>>>>>>>> warning in
>>>>>>>> dtbs_check:
>>>>>>>>
>>>>>>>> arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: gcc@1800000:
>>>>>>>>            '#power-domain-cells' is a required property
>>>>>>>> from schema $id:
>>>>>>>> http://devicetree.org/schemas/clock/qcom,gcc-ipq6018.yaml#
>>>>>>> But ipq6018 doesn't implement GDSC support. So for the sake of fixing
>>>>>>> the warning you are adding a bogus property.
>>>>>>>
>>>>>> I agree. However, there are also some gcc drivers not implementing
>>>>>> GDSC support but the bindings are adding '#power-domain-cells' in the
>>>>>> DT example, such as: qcom,gcc-apq8064.yaml, qcom,gcc-ipq4019.yaml,
>>>>>> qcom,gcc-ipq6018.yaml, qcom,gcc-ipq8064.yaml, qcom,gcc-msm8660.yaml.
>>>>>>
>>>>>> Actually I thought that maybe we should do a clean up by removing
>>>>>> '#power-domain-cells' out of the qcom,gcc.yaml binding and only
>>>>>> adding it into individual qcom,gcc-xxx.yaml for the driver which has
>>>>>> implemented GDSC support. I checked this with Taniya offline, but she
>>>>>> prefers only fixing it in ipq6018.dtsi as it doesn't hurt anything by
>>>>>> adding the property, and she expects the GDSC support should be
>>>>>> existing in most of qcom,gcc drivers especially the newer Qcom chipsets.
>>>>> Before we start changing anything, we should assess whether these
>>>>> platforms actually have GDSCs within this clock controller block,
>>>>> even if they are (currently) not described in the clk driver.
>>>> Hi,
>>>> IPQ6018 has GDSC-s, at least for the USB-s.
>>>> I tried configuring them a while ago, but the USB2.0 GDSC seems to
>>>> either have a HW bug or
>>>> it uses some special configuration as its status bits never show that
>>>> its ON [1].
>>>>
>>>> [1]
>>>> https://patchwork.kernel.org/project/linux-arm-msm/patch/20231025104457.628109-2-robimarko@gmail.com/
>>>>
>>> Thanks for the link! I checked the spec internal, and I did see GDSC
>>> device for USB0/USB1 controller is present in GCC clock controller.
>>> So considering there is a patch ongoing to add GDSC device for ipq6018
>>> gcc driver, can the DT commit which adds '#power-domain-cells' be accepted?
>>
>> What for?
> Maria (quic_aiquny@quicinc.com, copied) is working on automation tool in 
> Qcom internally to check dt_binding and dtbs and she expects all the 

Check existing tree is trivial, I had something running months ago.
Unless you meant checking patches before you send them?

> warnings/errors reported on Qcom board files can be fixed. She can help 
> to comment further.

Anyway, fixing something incorrectly just because your tool cannot
handle existing issues, is not the reason.


Best regards,
Krzysztof


