Return-Path: <linux-kernel+bounces-55574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326CF84BE5C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571D81C21935
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106F017744;
	Tue,  6 Feb 2024 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0VGSleE"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EC217BA0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707249256; cv=none; b=oVrXvTWEkuyd2Q0wLDCpJNBVTqO8Wynbw5ojl5neLFaAlxTKRd4X3pJaxdkSTPNjhadDZ92n9O3znHoqXxNi/QX0WtmuC6QBdU7p59zI4iU79pvPIj4SanE+E0LPBTSoVM/8j61u7/ko4fsDqLaroXRsFFgxhZV+q5S7q3i8U7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707249256; c=relaxed/simple;
	bh=jODo+zosjzHBhJww0hAEoI1p+aRxm982Rla+Go1sJVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toU9L+QwRobvGbFbtF/Wjt0kxi4WbCVoqT7EBihOQ7uxVu1q3P/1Its37yImvom4iJ1Q8vdfRnd6pSiSuS6zP7fs4U7Aa+/zBuF87cJ3nXsGiVuO4dGwuMO6afWZTMl8W6Tyt8YkTZkdq1FhO1HFf95up9xvU3wLVCgbUoi6Ssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z0VGSleE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso48928475e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 11:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707249253; x=1707854053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nx/yTPyhmOjGQrQvbrtSQalnTl1/h54gJP+tE433ByI=;
        b=Z0VGSleEmmkrjoPTLYoHcfdVF1IzaOQrNHlWaHi3xmSVoLzzLTHxx5H8Uc3Yb58K7+
         oIa8P+GSC0TqiCqAgQHYwx6ml+fuZom7i9PLm1nPnnsRTmATUpOXSrliYn+0sB3nOg28
         x6Cx30iIzojVFiarz8pIU4cFodfaf3w0N4KSJOc92ihPeqniTP8vgEl4aQQnXzUGgpJJ
         hhAi/MkdYeYBtAhEVPaNX06//+Fx9eP3wnk6liLoi3FWAga7OhjSZQwjPzU2zmS8q1Ih
         GrGgCTH0WThiCLVrHekXc0grYNJ+kQ1/eBXqTvkYjqIvOKTzlLri4s8Ad4xCksX5PXVs
         UssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707249253; x=1707854053;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nx/yTPyhmOjGQrQvbrtSQalnTl1/h54gJP+tE433ByI=;
        b=i3fLVkGBGvoHJkPKlD+OfGj+ohdmirANGopH6dimb2nvYgG1wQHFVnFhzRlDR7ep7h
         ky4tS19RSh4sRuEIQZA6c5foxhbn0Dd/JZko10kx/IpRxNT57F6NjiZBObz+0tPAM4gt
         TAQBQR2FGVn6loCdMR0N7WRkFsTSOebefXswf1f5V0xatXfmbQxLyLqqolMm1TFyb7KE
         rZvtHXAUsTAbZjO94TLqtuCVMvogbDf3JC9HpiNavQAM6bFQjFR1vDEWI2rvAMCk0HGj
         eiw7dvVLAcu0sSmWwzTIn4ao8zh6iJqICFOPiL0a53JdWrsoZPd76nGApleWMHM1s4+z
         GhOw==
X-Gm-Message-State: AOJu0YxPleDJKg5CzwTkULmJnHVnxdZoLy/A5gQl08nG3rKLw7eL3pfD
	rlIFFbfdc3FQ3uBecsGxOZTCdBACJnesgjRX1D5pf5Yc+i5B8r4zJZmLgdd1L7w=
X-Google-Smtp-Source: AGHT+IGCRa0ddDOotuHynHO/BZaS61+icuEMLRwC1nABRPECJQYY2nkwV4yERMx8U2KKI5yvXvJz8w==
X-Received: by 2002:a05:600c:3494:b0:40f:2d7:287c with SMTP id a20-20020a05600c349400b0040f02d7287cmr3012168wmq.8.1707249252857;
        Tue, 06 Feb 2024 11:54:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvqHjZp6qXz5tcuT3kuWQpDBcmV+YpNEJ+8GtYuTlQP98BTV9iqUq+vs5fHiWXNJOUKjAedXDHhYBN7eCLIXSaDzflUscqqdzRo++VbJ4Y0N0oOo/rVcZptroMIQ6ISuU7ox0RhwUOzJa7gT1u1SR+F8x0f3oDSUOcpt6p3LT+we2trwjiiw/v4XvAOcbWNopC2gsJee8Cuh+NwO903VdhuG79vjRHyE2t1zVHIjCQcW6olT9DwedIlWAfUy7Ar960K30O13ywTaVV1OdI5qho3gayIRX8AUdb+ZZEKjFuHzeIFoIyyh7qgo83Ln9YzHpGMrrshAveQQ==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c35cb00b0040fe3147babsm2836286wmq.0.2024.02.06.11.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 11:54:12 -0800 (PST)
Message-ID: <d78b4bce-7bcd-4ab0-a76b-135cee3ec9b0@linaro.org>
Date: Tue, 6 Feb 2024 20:54:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] LLCC: Support for Broadcast_AND region
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <cover.1707202761.git.quic_uchalich@quicinc.com>
 <be9d964b-7900-4fef-9268-67ef404cd611@linaro.org>
 <ab88f10f-d752-4c6a-b0e5-d8b05af99c28@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ab88f10f-d752-4c6a-b0e5-d8b05af99c28@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 20:41, Unnathi Chalicheemala wrote:
> On 2/6/2024 12:34 AM, Krzysztof Kozlowski wrote:
>> On 06/02/2024 08:15, Unnathi Chalicheemala wrote:
>>> This series adds:
>>> 1. Device tree register mapping for Broadcast_AND region in SM8450,
>>> SM8550, SM8650.
>>> 2. LLCC driver updates to reflect addition of Broadcast_AND regmap.
>>>
>>> To support CSR programming, a broadcast interface is used to program all
>>> channels in a single command. Until SM8450 there was only one broadcast
>>> region (Broadcast_OR) used to broadcast write and check for status bit
>>> 0. From SM8450 onwards another broadcast region (Broadcast_AND) has been
>>> added which checks for status bit 1.
>>>
>>> This series updates the device trees from SM8450 onwards to have a
>>> mapping to this Broadcast_AND region. It also updates the llcc_drv_data
>>> structure with a regmap for Broadcast_AND region and corrects the
>>> broadcast region used to check for status bit 1.
>>>
>>> Merging strategy
>>> ----------------
>>>
>>> All patches should be merged due to LLCC DeviceTree/driver dependency.
>>
>> Dependency? Sorry, there cannot be a dependency between DTS and driver.
>> Please fix your patchset.
>>
> 
> This is the suggested merge strategy. But I have updated the driver in v2
> to ensure that applying the driver patch alone will work with existing DTs.
> Sorry for being unclear; "should" does make it sound like there is a hard
> dependency. 

OK, anyway, the patch was not tested.

Please drop my Reviewed-by and test the patch before sending.

Best regards,
Krzysztof


