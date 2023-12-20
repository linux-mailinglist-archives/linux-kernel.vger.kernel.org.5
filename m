Return-Path: <linux-kernel+bounces-6809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872DA819DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9198B22789
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC982137D;
	Wed, 20 Dec 2023 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oKP0PgpJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CF721356
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so62614335e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703071204; x=1703676004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IAmlDlInxuQrZ1cE1pP47ocBQk8ES4XUkRZRFq3xVa4=;
        b=oKP0PgpJizdPjrHFvhWxiY0djhRZoc8PfWYJV6MBJDzig7X5s+YHpXVNy8fiVJvXjg
         W/D7EG7+3wKhzfuAw+8JpKfKYlQnmKsTSail4+wFUxUw7lCogSo/mPOSdWxhNKa1JJmw
         ZIw2yL49Gyyr18evnb/1os4y6HjQ1+4220OdYtJ8XExZ4OETz7aX4obwfai71BRPo99f
         7Ju+31363wtA4bL7e9ek+iuH4CT7gbyq9TO9VkU39r6/NyblM64g7NmFZJUMZF7JckxW
         9TU4BdccptMP07pIr7Urc/5dgbXhi8tAkkhTFZKk9hGwnjFQV5UPae0RtEOzKRMGFfly
         bPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703071204; x=1703676004;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAmlDlInxuQrZ1cE1pP47ocBQk8ES4XUkRZRFq3xVa4=;
        b=YemfKXBrT5gFQq4p3/cQ/EkaQFeFPUUdi6J9AEmJHlN6jMauGkoowinlWSJWtsMLil
         ooW2yWzkl8MlIBlkUTU6ggBO4Ypi6gsn9OhsdxTrb393zbcvVYwqKCQ0jjvKzj5DdPRR
         jPsGHAcQoIxUsad9uxdqg/IpG5hCP6cnXKL7FKj4MAXCJO/1dPn+GK/7FD7SK7D9gtoP
         egSmGar88y5+YqvFpwIzclECu+c5hheLGStbvoQ3ijInPuN7GCri4TGjvl2KUnklArHo
         4+4LZs8aa7E62omAQRsTBl5i/C8ClbOqGRS5zuBbu/Pc6EVHaYzae/A6YhMSJE302BdW
         smFA==
X-Gm-Message-State: AOJu0YyRv29P0Yd6AXF0ctO1Q7mTX9LwI2lU1XmWxU6s5zg65b0BWTbJ
	r1OKF6xXPce2rXbN1SxllhJcjAnM9q2zQ7pL87s=
X-Google-Smtp-Source: AGHT+IE4OPqXHN9xe8HeBW+oIWLnaNLFDOWpgf+uMrHPDDKnKVZy22hD8yDPLE3qC2DGi8l9HPxUew==
X-Received: by 2002:a05:600c:8512:b0:40d:38c6:7cec with SMTP id gw18-20020a05600c851200b0040d38c67cecmr114039wmb.299.1703071204012;
        Wed, 20 Dec 2023 03:20:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b0040b349c91acsm6912026wmo.16.2023.12.20.03.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 03:20:03 -0800 (PST)
Message-ID: <596c4ed6-bf3d-4406-8b28-2b34548520d1@linaro.org>
Date: Wed, 20 Dec 2023 12:20:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] arm64: dts: qcom: sm8550: remove
 address/size-cells from mdss_dsi1
Content-Language: en-US
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20231219003106.8663-1-quic_tengfan@quicinc.com>
 <20231219003106.8663-2-quic_tengfan@quicinc.com>
 <457e336e-004c-4721-b58d-e9ada16dc04b@linaro.org>
 <a8f168da-14f7-4377-8dea-f282a3eac0a4@quicinc.com>
 <13b61d41-6045-499e-864b-51c6cb6eacf9@linaro.org>
 <38604415-b410-4995-9c4f-525536435699@quicinc.com>
 <CAA8EJpo07gE7ZeNP6wSGTLtmF_3PKQAKFyMRZ8dk1K+f7PAxrg@mail.gmail.com>
 <ad1547cf-0520-422d-a105-ec426f526d71@quicinc.com>
 <CAA8EJppwsezPV21Uw8xTn=ra8L2jfnkHoRghDPN96O5tJsOD7A@mail.gmail.com>
 <72305a35-02e6-4ff6-8251-01f986530c5d@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <72305a35-02e6-4ff6-8251-01f986530c5d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/12/2023 11:33, Aiqun Yu (Maria) wrote:
>>>>
>>>> Don't touch the bindings unless you understand what you are doing.
>>>> Your patch will be NAKed. There can be a DSI panel attached to the DSI
>>>> host, which means there is a need for #address-cells / #size-cells.
>>>>
>>> Could you please help to elaborate more on details? Like what's the
>>> right example here for the "qcom,mdss-dsi-ctrl" driver node needed to
>>> have "#address-cells"/"#size-cells".
>>
>> As I wrote, the attached DSI panels make use of #address-cells / #size-cells.
>>
>> Please take a look at the sdm845-mtp.dts, which provides a complex
>> enough example (a panel which is attached to both DSI0 and DSI1
>> hosts).
> I can see the panel example now.
> While panel@0 likely node is not at in the binding that I've checked. 

"Likely not" is not the same as "cannot".

> There are quite a few of binding document about the same driver. I 

You keep mixing drivers, bindings and devices which does not help this
discussion. I really do not understand above sentence.

> checked 5 of the bindings document and moste of them are alike, and 
> don't have the panel example.:(

Example like the example DTS in the binding? What does it have to do
with anything here? What are we talking here about?

>>
>>> Thx to chime in that we have put a good amount of time here.
>>
>> Can't quite catch you here.
>>
>>>> Please stop wasting the time on dtc warning. The bindings (and the
>>>> file) are correct.
>>> I don't agree here.
>>> Either it is a wrong usage of "#address-cells"/"#size-cells", or dtc
>>> warning should be fixed with this usage take into account.
>>> "dtb check" will be a good guideline for developers to follow, I don't
>>> think it is wasting time here.
>>
>> It is a guideline, but not a rule. No warnings by default is more of
>> the rule. W=1 enables warnings that developers have to classify and
>> cope with.
>>
>> E.g. I don't think dtc correctly handles the case when there are both
>> with-address and no-address nodes (e.g. 'panel@0' and 'ports'). Note,
>> I might be mistaken there.
> Now I understand the issue, here is some thinking from my end, and 
> welcome others to chime in with more ideas:
> 1. Only put "#address-cells" "#size-cells" right before node of panel@0.
> 2. Align current binding document with "panel@0" examples.

Examples? Again, about what examples are you talking? Mixing terminology
does not help this discussion, so let's be specific:
Touching examples just because you want, without valid reason: no

> 3. Too many bindings files for driver "qcom,mdss-dsi-ctrl", shall we 
> align them into 1 binding files.

You are joking right? First of all, there is no driver
"qcom,mdss-dsi-ctrl". Don't mix the terms, because it does not help the
discussion. Second, please read previous discussions related to these
bindings.

> 4. enhance the dtc warning check if we still want to have 
> "#address-cells" "#size-cells" even if there is no "panel@0" attached.
> 
> @krzy here I try to answer your comments here as well.
> I am disagree on leave the warning as it is. And want to do something to 
> improve this. Ideas above.
> Let me know if any comments is not right addressed from your comments.

You want to do something without understanding the problem which results
in random band-aids over some warning. Instead, please dig deeper to
understand the problem and then propose solution.

Best regards,
Krzysztof


