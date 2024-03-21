Return-Path: <linux-kernel+bounces-110555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB43886087
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E661F23089
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FA213341E;
	Thu, 21 Mar 2024 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk50kXp0"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116E79C3;
	Thu, 21 Mar 2024 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711045746; cv=none; b=Kw2arp/VyeTwT4+WqxfYKi50mIWg1kOekGwSXV8+oxZ5fEtkFCMFVIgtZQVVCBAoHR5WAEwKuxdGIvA7ZKdU1nNO32AoE6+7Q3Vo4B0cQsomJezNKz1KzR6lBIiHdZRXoXPU8hBE+2AyfYdrxZTRQq7PEfjm5stXJzHTm4Do1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711045746; c=relaxed/simple;
	bh=zAYATeMtAMSyXywpEjHIrjoVSN0gBr394TEV8OH5uaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/6bYQ2PwU4V//c6WLBYighlX3h2z1NXA3o1+qs6oBj/3cscUzRusXNiVLY3ppreDlWlIBCH7GPRJCj80nXnt/ROznYV3x/7u0dzgweA2M4ut99ntD1ZczmWWbIPCEWX5KPGbYEInJ3zRvNs9BI8KUeFTw5e2/m/+IAyCV4AesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dk50kXp0; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d4a901e284so28531781fa.1;
        Thu, 21 Mar 2024 11:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711045743; x=1711650543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vs5BZUwaXWyx9DjsP3hmBPa0Q/mMIBukAIBdGCnvVlg=;
        b=dk50kXp00FStVEFHbmgDVFXONESk+IqBY23Mkyxa8P/WJHVSsZ+K4kAKeWter0TanJ
         jPd6/UOqvBafj8WJJatfx3nGAA+2Y0+uF2ZdAgtnYwQcNQ8B9/Up+Ami0uw4Eu76+3ML
         N67CpQxmxqaxZCiQl5TLlcM7h06EtLyqcB47XPFjM6HURZubyC9ei5cqJ2YiwiDFQttz
         FsMEpgRKp2DLFdejwr0ikDB6Wtz6NSzXamYqdz4hYFZDxp29gLF4zCY3Ug6rE9vr8VgK
         1Ss/kCmnIwOChwNgcDM5eEAMiMrY7hYV8UJRBi6X9u+WQlmJRt9js0Oe57Drzo6orzPx
         A49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711045743; x=1711650543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vs5BZUwaXWyx9DjsP3hmBPa0Q/mMIBukAIBdGCnvVlg=;
        b=SP3XxRY5L4F9VxOXNNyOJ9E1in9zGGlD7RxjQsKbz3LcP3HeJBx89FhLsQx0dV3U3/
         AcrjL4bqaogswOeHfYGu6ur8227fKAH5nT1vzVQ5IPw3nyJi2czK5FXL8tix01yYJ9sN
         vD1/e0ajUFL6QJuxLgU1Y+Q0TySwG2TVV2FNtlwz7OKiZa8X4MJCdibX0rkv1lStgPcp
         KQ3FUN2azTfWnUEw7JRjRosW3Z9A1f7Q92rKa/HQwrowlk3OAseDbsLoaqvn360T2W8J
         IxdhZhhPVY6nvL7JrGIL5Tll/uC/ZANgYoe/4YtrC57tj0XJAdOATQaLsV+WIGnPRi1x
         9fCw==
X-Forwarded-Encrypted: i=1; AJvYcCWGQktJbh9d0cstj7lgpw2y1S5hcP4I8ZqS8Z8ed3ctCb5dUQWhXW/1+oHhDCpUXgDBCMi5YuMhBd+I4aZzxObXpwT1Wpjm29g85pqmpDx3k8IQsuLuRkzg4HqRK9wnVkIAmNJcB5UkBw==
X-Gm-Message-State: AOJu0Yy9TjDpDCTBp3jJ7U3NJ/eSU7Va8JsnI9BxzOv3ca+sLV1U7AwU
	sBcPXw0eX64BKxctvXqJBFe0UJqSTk4U4YvLl76iQ8i5JIzPyYrW
X-Google-Smtp-Source: AGHT+IHlLxV084PNF9KvdinqIY/5RnBQjRLaYTLjnsTeGxJShM01hzRIKLza1dnWvqk3W23qcD2dAA==
X-Received: by 2002:a2e:9556:0:b0:2d4:7004:ba8a with SMTP id t22-20020a2e9556000000b002d47004ba8amr259463ljh.53.1711045742805;
        Thu, 21 Mar 2024 11:29:02 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-76-118.kaisa-laajakaista.fi. [85.29.76.118])
        by smtp.gmail.com with ESMTPSA id p22-20020a2e9a96000000b002d45dd6004esm40852lji.121.2024.03.21.11.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 11:29:02 -0700 (PDT)
Message-ID: <e6994ff1-6c32-4dac-846a-5f4f18b2f996@gmail.com>
Date: Thu, 21 Mar 2024 20:31:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] ASoC: ti: davinci-i2s: Opitonally drive DX pin
 during capture streams
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-14-bastien.curutchet@bootlin.com>
 <00182d1d-ef29-457f-9e3e-6e9b57592118@gmail.com>
 <0bb26153-8bcb-475f-8892-5eb925fec538@bootlin.com>
 <7925bbe5-17e8-42cb-a5f0-4f3e06810a90@gmail.com>
 <d20dc37c-13fa-43d1-af52-dce8d8dcdd75@gmail.com>
 <5467add6-0099-4e54-a4f7-12aa149d03c7@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <5467add6-0099-4e54-a4f7-12aa149d03c7@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Bastien,

On 3/21/24 17:14, Bastien Curutchet wrote:
>>> I think the definition of the 'ti,drive-dx' is somehow odd. It allows
>>> you to set it to 0x1234 and the DX pin will show 0x1234 when you capture
>>> 32bit. If you capture 16bit then it will transmit 0x12 (or 0x34?), no?
>>> If you have 4 channel capture then I won't speculate what will be on the
>>> DX pin ;)
>>>
>>> Would not be better to say that the DX pin will be driven low or high
>>> during capture _and_ disable the playback support?
>>
>> After some thinking, it might be still better to use the DX pin as GPIO
>> and either have a custom machine driver which would handle it (set low
>> when a capture trigger happens) or connect it in DAPM as a supply, bias
>> or something and ASoC would handle it automagically.
>>
>> I think that would be cleaner in many ways. What do you think?
>>
> I agree, that would be cleaner. I ran a few tests to see if that would
> work on my hardware. It doesn't ... So I looked back to the schematics
> and found two reasons :
>  * the DX pin needs to be in sync with the clock.

I'm not sure what this means, sync with which clock?

>  * the DX pin needs to be in a high-impedance state between two frames
>    so a pull-up can drive it back up. Actually, the DX pin is also
>    linked to the FSR pin so it provides the frame clock to the capture
>    stream.

Hrm, you are using the DX pin as FSR for the capture? Why not McBSP.FSR pin?

Looking back to the patch, one thing stood out: you are setting the
XDATDLY to 2.
You have some sort of T1 framing on the bus? The pullup will make the DX
line high in for the framing bit, right?
Or you simulate another FSR line with T1 framing DX?

The 'ti,drive-dx' sounds like a bad property for sure, you have T1
framing and driving the DX to certain level.
It is like DSP_A (1 bit delay) playing constant 0x2 ?

Can you use aplay /dev/zero and a DT property to select T1 framing for
the playback? Or that would be too coarse for timing the start of
playback and capture?

-- 
Péter

