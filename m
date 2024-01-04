Return-Path: <linux-kernel+bounces-16507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BBD823F7B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C4E2872AB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951B520B05;
	Thu,  4 Jan 2024 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUr/M+fd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6549220B28;
	Thu,  4 Jan 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso444369e87.1;
        Thu, 04 Jan 2024 02:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704364371; x=1704969171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rtz1xNRlMswnqcuKEEgCXeQXrJfizAMkC6Qe5Iyxzog=;
        b=jUr/M+fdfJTkt8L2kYcOIpM+JEWj/LUbb/tVxLsgRRp1ARXqdMWZM9rGM+Xm5UUirh
         82KAQYNnYNiFJtKkU6CSvUFmHe2yLk7icjSzKMDHkwWFBdY1SdRSgIjVa0Xp4XFysCOo
         hHFF5U815ZfHVmZVFbYJ6uE4KXloE6SlmTrD6FhstbUvRKYbMtWV4pfnHodr6NT8y7+J
         PmhwZGIsSeJXaJxugkD6Y+fJ43l8a8PEkCXikOfoZt6QC+jRzTdEKInon7iB0bOspNsj
         vJoSvJOxg5MzGlxaaQoqa28s01kOj2CoP+5MU6nC6BKcCS/iZcfN5gBFmJkXK7Nmw/sW
         l3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704364371; x=1704969171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rtz1xNRlMswnqcuKEEgCXeQXrJfizAMkC6Qe5Iyxzog=;
        b=FssM33ccSCPG3fBXG57dPrQ3CkLwpFVKAroA44TC6LYQV5FEPedP8IiBUkOdJ7yLYD
         K5tKewU1YEDJpj81UmdMVpV4Ho9GR9BiuotQj82qdAygm3L6JdEv8/P1Nde+Q9n3wPV8
         7Qu3kf2w3eo83RZx/kQAiQyLkGb648zoZ9mq0KkN3odfoiqtr2MOaVYrMu78TFOoqXW7
         5uy33QgmZnwkSbPjwzuz5S5IdE9NjVMILgKXVm5hNwMI2nb59adA92Q+RoAbRLeDr41k
         isvTiGF8Yd4Rxly2/Bkyf+I1jLw4vX5kuqWITVUoekb/V2RwIPFk3beRCZe4inJIvfqi
         N0XA==
X-Gm-Message-State: AOJu0Yzh9HUpw+9aljEDeKGY+oX6hPuIw6BzY2ME/yT5PNlyqg08MOQc
	f69fjoiT1fBbbXE4mUGgjso=
X-Google-Smtp-Source: AGHT+IGFsv99DMSiISYdT+EBH3jsO+fGLVth82tNHEPrOgs4CJmgAu4ggXShhXsO6z1UYQNgiOkcqw==
X-Received: by 2002:a05:6512:ba3:b0:50e:7044:7656 with SMTP id b35-20020a0565120ba300b0050e70447656mr337718lfv.57.1704364371133;
        Thu, 04 Jan 2024 02:32:51 -0800 (PST)
Received: from [192.168.3.32] (dh207-98-100.xnet.hr. [88.207.98.100])
        by smtp.gmail.com with ESMTPSA id ka16-20020a170907921000b00a28ab7cd8e5sm1142096ejb.191.2024.01.04.02.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 02:32:50 -0800 (PST)
Message-ID: <685f45d9-48e8-49c6-9de0-6771777ba62e@gmail.com>
Date: Thu, 4 Jan 2024 11:32:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq6018: add #power-domain-cells for
 gcc node
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Fenglin Wu <quic_fenglinw@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, quic_tdas@quicinc.com,
 quic_aiquny@quicinc.com
Cc: kernel@quicinc.com, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240104-gcc-docs-update-v1-1-127e4816b798@quicinc.com>
 <CAA8EJprsGke9zZBy_x=YSxz7R1aSpx8r3ndjjXVVKhjKBxd=QQ@mail.gmail.com>
 <724f608a-cbfe-48f6-a1f7-59b961a7d724@quicinc.com>
 <56ee556d-ec31-4553-bce3-0c1e12c111ed@linaro.org>
Content-Language: en-US
From: Robert Marko <robimarko@gmail.com>
In-Reply-To: <56ee556d-ec31-4553-bce3-0c1e12c111ed@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 04. 01. 2024. 11:16, Konrad Dybcio wrote:
> On 4.01.2024 11:13, Fenglin Wu wrote:
>>
>> On 1/4/2024 5:53 PM, Dmitry Baryshkov wrote:
>>> On Thu, 4 Jan 2024 at 10:06, Fenglin Wu via B4 Relay
>>> <devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
>>>> From: Fenglin Wu <quic_fenglinw@quicinc.com>
>>>>
>>>> Property '#power-domain-cells' is required as per defined in qcom,gcc.yaml
>>>> so add it for ipq6018 gcc device node to eliminate following warning in
>>>> dtbs_check:
>>>>
>>>> arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: gcc@1800000:
>>>>           '#power-domain-cells' is a required property
>>>> from schema $id: http://devicetree.org/schemas/clock/qcom,gcc-ipq6018.yaml#
>>> But ipq6018 doesn't implement GDSC support. So for the sake of fixing
>>> the warning you are adding a bogus property.
>>>
>> I agree. However, there are also some gcc drivers not implementing GDSC support but the bindings are adding '#power-domain-cells' in the DT example, such as: qcom,gcc-apq8064.yaml, qcom,gcc-ipq4019.yaml, qcom,gcc-ipq6018.yaml, qcom,gcc-ipq8064.yaml, qcom,gcc-msm8660.yaml.
>>
>> Actually I thought that maybe we should do a clean up by removing '#power-domain-cells' out of the qcom,gcc.yaml binding and only adding it into individual qcom,gcc-xxx.yaml for the driver which has implemented GDSC support. I checked this with Taniya offline, but she prefers only fixing it in ipq6018.dtsi as it doesn't hurt anything by adding the property, and she expects the GDSC support should be existing in most of qcom,gcc drivers especially the newer Qcom chipsets.
> Before we start changing anything, we should assess whether these
> platforms actually have GDSCs within this clock controller block,
> even if they are (currently) not described in the clk driver.
Hi,
IPQ6018 has GDSC-s, at least for the USB-s.
I tried configuring them a while ago, but the USB2.0 GDSC seems to 
either have a HW bug or
it uses some special configuration as its status bits never show that 
its ON [1].

[1] 
https://patchwork.kernel.org/project/linux-arm-msm/patch/20231025104457.628109-2-robimarko@gmail.com/

Regards,
Robert

>
> Konrad

