Return-Path: <linux-kernel+bounces-104162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2398287C9ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12FE1F23286
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D00C17555;
	Fri, 15 Mar 2024 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4+4BKNi"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35511A38D3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710491579; cv=none; b=Inbn53D/uVLKG9QxdUTuM3ijTQ1uF6Ha6rH8oifwSxHbZ48aPuRUpkX5wDRL2A4l85YsOFJdMvDWt04lTaLoMc5A1mF4bEHcOlb70ch5PM5uAKyzmbwePsUjVUpZzHQijZzXXgNU9zpT2sLGuVt3x1qpXoauQ0PwUfDgTvqiA2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710491579; c=relaxed/simple;
	bh=+e6/1GErH5VWnjMn/jGSiiUGKKqSs4swP/artBmjMzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqgyDF46m6mhxrEDo2UQzGrKbQkbxc4sKd+jmQFUjKEakUSyBwqIhc3KBZXuHsLmGkojMlfJCrBepI5N5Q9A2CyxAIt44qHMCjdQFbJhik1doTEOTV16t0fPRykIyxMBhvAbEyi61OpVSKFuap2K9Qdncrz3W5DK/1PnEmA0rDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q4+4BKNi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-414037e9acdso656775e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710491576; x=1711096376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=912VkOYSMkN++wd8G/6htVj/pI09oi7P454LjC3DVyY=;
        b=Q4+4BKNiOH4xCsYUhBXSRI3FVCpQgiTwu1bXa3lnVS6j29NIN6XbuPqXO1yETvpm2a
         xUOYzp77GJuY314EZuh0dejv1Ps53vB+ESkNhxDcEFtKaxZ0OJH5h7wVLc7CRfZzLesD
         zlnGNMkoyGMHz2g0Dvpph2BJloDiiUQNpfvmNJaJAyNKwauFjuAGFMgOD9+2VRhokKEC
         6P5helL/0U4oy5mG4EUmM73D+q+jGIKdpqeQqcoY/V+pa0PNX+/H1NR63hHADHSE6W9i
         lKq9rdwcPljJgVwW6AWdMPrW6tm4jyyD8PrHfrNvoWDNE3kmTtpBgtv8SPKNgNmnPj0U
         xBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710491576; x=1711096376;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=912VkOYSMkN++wd8G/6htVj/pI09oi7P454LjC3DVyY=;
        b=BBdkOnIjguuY8JzsDIbanMNy/L44tBHufPwd+lI60tJ/kG+cv8bYsdIhSBoLRvCBWy
         gIpbfHRl9qLwm4HXtZJnSsDFKDOx1+PSRLaLxOLieJH247LnYe9gaHseV748pJCqsR/P
         lIof72YLvWtq+DkGK4FC+pSJAMbKz0DQukmjaeQIrh/pUQF645sdQIVrsw+ov84I88BH
         h3o6whhBrDq7tVeli6Cifr7JBD8BqH7nL4dUF442swyMi9umz2J31+auqwtrZFhf03pF
         dzXZEABWUr43rtfj6IB2c5Uvk1KUw5EwHQtLpyoWgu/b9bermR9qRJiU3CCrhBqfodki
         GJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa1Ef0+w2TObXKNSIN9FXl4qBCz+fc/gtzEUkybftwRx/N9OyVd3uhYbMmbES7BTZH0H3YNuDtBiudpjFJ2zHYQmmIglYbo+McReUf
X-Gm-Message-State: AOJu0Ywmyb5wbyFR9B7oIA5FulLdr9IbdK0MA+Zlj1+ilA73nEuTgn/A
	iLzWLw9mhEkWl6tOWjPnZ2qL5/ELUSGXZroVH6XWy2eudb+gxFZ23tor7P3xgR8=
X-Google-Smtp-Source: AGHT+IFUhdJe0MKmFgC1Gj0zisLof6IEM8A6yNh2YmY0WICwzETlVaZ8BJ0OSTJpcR5dtwC1ERJfnQ==
X-Received: by 2002:a05:600c:5006:b0:414:1d8:18ea with SMTP id n6-20020a05600c500600b0041401d818eamr757651wmr.2.1710491575892;
        Fri, 15 Mar 2024 01:32:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b00413ea26f942sm7699529wmq.14.2024.03.15.01.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 01:32:55 -0700 (PDT)
Message-ID: <ae04d6e9-1eb3-4d71-b7f1-c0fb3bddcfe8@linaro.org>
Date: Fri, 15 Mar 2024 09:32:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm630-nile: add pinctrl for camera
 key
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Sebastian Raase <linux@sraa.de>
Cc: marijn.suijten@somainline.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240314200037.549206-1-linux@sraa.de>
 <20240314232043.1441395-1-linux@sraa.de>
 <359dafcc-4774-4ff4-8df0-03e3641082e5@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <359dafcc-4774-4ff4-8df0-03e3641082e5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2024 00:49, Konrad Dybcio wrote:
> 
> 
> On 3/15/24 00:20, Sebastian Raase wrote:
>> Add pinctrl configuration for gpio-keys. Without this,
>> camera button half-presses are not detected.
>>
>> Tested on discovery and pioneer.
>>
>> Fixes: e781633b6067 ("arm64: dts: qcom: Add support for Sony Xperia XA2/Plus/Ultra (Nile platform)")
>> Signed-off-by: Sebastian Raase <linux@sraa.de>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
>> index 87d0293c728d..823c21d5ee59 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
>> @@ -90,6 +90,8 @@ cam_vana_rear_vreg: cam-vana-rear-regulator {
>>   
>>   	gpio-keys {
>>   		compatible = "gpio-keys";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&gpio_keys_default>;
> 
> It's fine to keep the "non-preferred" order, I'll probably send some
> changes to nile and fix up the style while at it in the near future.

Sebastian,
Although it is also preferred to implement feedback the reviewer is
asking. I don't understand why you insisted to keep the other order.

Best regards,
Krzysztof


