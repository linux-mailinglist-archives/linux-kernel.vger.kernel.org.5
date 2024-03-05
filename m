Return-Path: <linux-kernel+bounces-92991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E93872922
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC456B25391
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0594D12C811;
	Tue,  5 Mar 2024 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6pjJNYH"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A212BF32
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672879; cv=none; b=p9UW7eo/i6kk+/GXWO3IyfLBvZO59XpQZZlCUSCZGf44Rz0qH+gJQ0R6aD3N/n587ERX9IFY0OA0ZUVLUcWKD2nKWimBCHP21rQe4+tDqcIbZRLaf4UVXqHzlRGuXEPDSY6QZKa2VFE8xBxev1w18P2hil5T/6Wn0RT9xSyLY8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672879; c=relaxed/simple;
	bh=b09ID0S8XkErCqQ2Ru57MwiOAeJTYdJ0mk6wlA5iiPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DPDmAAlQlZ2+PBgTtmSXwdyKpKcus3rlGu0D59qEt3X7T2QOZIDmarjn92V+qFLYn17DuCURmmzqMiR/8tN6hvbeLTpivuNqDJ6QrBktlRZxy2L9VVcYTfqR9/gSQOvBwC++NL+FbLXkxVaJ8c/Eon/VJKy25XSY0dUbR+QCEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b6pjJNYH; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5131bec457eso161368e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 13:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709672875; x=1710277675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b09ID0S8XkErCqQ2Ru57MwiOAeJTYdJ0mk6wlA5iiPQ=;
        b=b6pjJNYH8qiTMx3PGtSfc0eRO7APB4h2wPVWKuvTs2npXiseiriE2Yv0Lmt3arIY5e
         aWVsbXJ73ADVr6KoW62Wwwsep9coBfXHltW1mWlLUNaVntkTqAaGmxMWU7JthpdVMvq+
         YAbl4kYGgYYh5P1pZ7DxvBT0scSZKI96R3gSjBzf2BpdFz/npXLDquvB7BDvx6Ueq8Yg
         K99lZTejysCZ3ks+dkotnsMNi1DkdxUEBoNJTslOKp9j4gBHgJlmJfGJI+vz3aB8iDwZ
         GXk4qInyX5wly4kCaH7zDE5Q+JkYAlbkM19IJWFFkcrOIX0YUiC7AbB/pv0jWFjfy+fh
         z1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709672875; x=1710277675;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b09ID0S8XkErCqQ2Ru57MwiOAeJTYdJ0mk6wlA5iiPQ=;
        b=udOnNByp8k0ZgnKUXUVHqUIrcymHVcM1ZeM0g0/OPxD9qd5GuagbKI2ixrLFr/NqBJ
         Kqsn5GSlHir07yJ4L52E/GNksxdqyZxQ7JsoUkpcqbnTGDj9uE7RRnHDQ7UUleoMNg9d
         3vFi2yU2vGZPoIaJ5qkFTZBuzuo+NiAmvFE3bJI7WLg3N09ypHooBgrglrSr4OsdDpJ1
         57dAls2NVoOwUx4SqajT7qYMRgxwYzbZlwX1sBTkms5V4KgGFCcdP2aHFVHaENR1DLa7
         xx3X/1QWMIokzzbVezrxNxoQeYUN/er+pDy1O4LZ/ga95RMAu/5tskNtnqy/5TzsdWCE
         nTKg==
X-Forwarded-Encrypted: i=1; AJvYcCXiZUd/07JSD0YO1XeJ0qJhhtbtCIqMhbLwecX8tkT/i8XcHkoP8S+AFv+RHaTeVOoVxGXMIKADuqOUBxglnYz/MqEDbe67Ej1bEUpi
X-Gm-Message-State: AOJu0YyJpZ1J0xo2iKUQzGFY0hZ4PUyim1yNetb4bhs0ouhY+A1FhED8
	hQzwptubxqV1X0ugikPCpXDqVsMKhwvU7kWeyWjAaMlt0xuNMSY5CIUv1Z8C2Vo=
X-Google-Smtp-Source: AGHT+IGBKoiS7ffna3KjUqa82zmNiDZh4gX9qfpTO1pytymFQ8KydevY5xCfcZoe8Xkpy4Obklbznw==
X-Received: by 2002:a05:6512:281a:b0:513:2c5f:1078 with SMTP id cf26-20020a056512281a00b005132c5f1078mr1337677lfb.8.1709672875550;
        Tue, 05 Mar 2024 13:07:55 -0800 (PST)
Received: from [172.30.204.154] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id g13-20020ac24d8d000000b0051316ccc5besm2300433lfe.269.2024.03.05.13.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 13:07:54 -0800 (PST)
Message-ID: <5736796f-061b-46a0-b4eb-ab447fac4426@linaro.org>
Date: Tue, 5 Mar 2024 22:07:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] arm64: dts: qcom: sa8775p-ride: Enable support for
 firmware managed resources
Content-Language: en-US
To: Sriram Dash <quic_sriramd@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, andersson@kernel.org,
 vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 gregkh@linuxfoundation.org, quic_wcheng@quicinc.com,
 Thinh.Nguyen@synopsys.com, p.zabel@pengutronix.de,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 quic_psodagud@quicinc.com, quic_nkela@quicinc.com,
 manivannan.sadhasivam@linaro.org, ulf.hansson@linaro.org,
 sudeep.holla@arm.com, quic_shazhuss@quicinc.com, devicetree@vger.kernel.org
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
 <1709657858-8563-4-git-send-email-quic_sriramd@quicinc.com>
 <b9142874-0afb-40a6-9008-b33bd8f56840@linaro.org>
 <399555e8-d8fa-46b7-8b15-3d3a4a30809b@quicinc.com>
 <a2e863e2-9c8b-47c2-b4d8-5664d954cd49@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <a2e863e2-9c8b-47c2-b4d8-5664d954cd49@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/5/24 19:25, Sriram Dash wrote:
> On 3/5/2024 11:33 PM, Sriram Dash wrote:
>> On 3/5/2024 10:38 PM, Krzysztof Kozlowski wrote:
>>> On 05/03/2024 17:57, Sriram Dash wrote:
>>>> Establish the channel and domain mapping for the power domains to connect
>>>> with firmware, enabling the firmware to handle the assigned resources.
>>>> Since these delegated resources will remain invisible to the operating
>>>> system, ensure that any references to them are removed.
>>>>
>>>> Signed-off-by: Sriram Dash <quic_sriramd@quicinc.com>
>>>> ---
>>>>   arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 96 +++++++++++++++++++++++++------
>>>>   1 file changed, 77 insertions(+), 19 deletions(-)
>>>
>>> Do not mix DTS patches with submissions to netdev or USB.
>>>
>>> Please put it inside your internal guides, so you will not be repeating
>>> this over and over.
>>>
>>
>> Sure. Will take care. Thanks.
>>
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>>>> index 26ad05b..b6c9cac 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>>>> @@ -764,8 +764,18 @@
>>>>   };
>>>>   &usb_0 {
>>>> -    pinctrl-names = "default";
>>>> -    pinctrl-0 = <&usb0_en_state>;
>>>> +    /delete-property/ clocks;
>>>> +    /delete-property/ clock-names;
>>>> +    /delete-property/ assigned-clocks;
>>>> +    /delete-property/ assigned-clock-rates;
>>>> +    /delete-property/ required-opps;
>>>> +    /delete-property/ resets;
>>>> +    /delete-property/ interconnects;
>>>> +    /delete-property/ interconnect-names;

This is totally unacceptable.. And especially makes no sense given
ride is likely the only sa8775 board in existence..

>>>> +
>>>> +    power-domains = <TODO>, <TODO>;
>>>
>>> This wasn't even tested.
>>>
>>
>> This is tested with the specific power domains in place
>> of <TODO>. SCMI interface is used for the power domains.

I'm sorry, but "break compilation successfully" is not a valid
test result..

Konrad

