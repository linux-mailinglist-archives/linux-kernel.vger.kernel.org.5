Return-Path: <linux-kernel+bounces-90700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C2487038B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7C22822BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DDC3F9D3;
	Mon,  4 Mar 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNVJp4Zd"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034E3F8E2;
	Mon,  4 Mar 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561072; cv=none; b=SxpPFSZNRV5qNRypzOGLkN2MbqXnji0G7bOmFFnfsVVJiW2lDbu9qYNlIoQrOu8ItztZtAqPTm/qNaeaIO3t4rNYDv2JgeJ+4Nz3nur5936SoVM8uNLe5gp5vWUk9R6WsSotPp7MvGVDEfj4FvH+RYZSvaZixYsjpNXO3McNx1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561072; c=relaxed/simple;
	bh=SLbSjt9SbkPv+g6/vROjXm/Gz3EE39aUaCGhCyjYusE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZqcCfKA1XvWVszmgO9Q9jNHF02Bk2B1DDqBU2kKcDYc2K5qwmaYg6X9uQOx0pf4Xo2WIpFccmYXHxeliKOWU5Dvck8zxAMONRzpRXSKxEZDKFn8WIoPkuL7yI6nDqhqxX8dlsFybVc8F1PfesJskvXuJdutfcNIAgPsbhHk38w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNVJp4Zd; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51320ca689aso5277189e87.2;
        Mon, 04 Mar 2024 06:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709561069; x=1710165869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+A2MIgcuwPWk7lZwI41C//csGmOFt/MFKi0gAzZz/R8=;
        b=jNVJp4Zd1kqK0JOh8wzUQal45ptHZeQKbv4gwNFVXmBsWOyu8BT9LRGanUvH4BwTst
         oVsah7sJTMfAE2f1o1Zc8mDf7I/fOwbSpQT1dQ1XWN/apqPF74tEWZvY3KXjl0XU2SJt
         C4MMWzbhr0nd2LuZbfCL5R2dmVTNYoxEQrTq7sC5l5MrGz6tEXlSdGzZP0tTgbr4+m8f
         ZdSyOjzxCzQSkMES8bxZjmQhDyM4DzVkC4qwXzfXh5sMnvwU64JxoIKFkFCEHyfNMbHB
         gc7Kel3/Ps3PlwPoheDsXV53XtH0gbVYOI6/ks0FFwaQfDU447pT4VpVN9zDdpXcRcL/
         SDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709561069; x=1710165869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+A2MIgcuwPWk7lZwI41C//csGmOFt/MFKi0gAzZz/R8=;
        b=Ux+CIXiBEkY83fvCKrpBPuu3o+sIgR+P14ha12RQ4bsV6qyd2XC2vjJfJOZCpBqOuC
         biin8QxIG9YmHngnzUvyVXAC3SRYQXckSce0TnmmZqRAJBvqYVC1xouAh5UzhQKaGiym
         oSoiJTEat4k6pL3DFOOfNL9i6q1aGMD3v0xyqjfgTuvQZPpmywnXFzWJXRwA13G8RUpC
         9VO0+0J3hlXleyl+V+b96LlxmU5Cdq772jaICr+fSImH/rtZb9fovU+uf8Q+3bFpw7NZ
         NAA0ZvsGNENh6ic8kBWBb3tG1dzltEKCLoaoyhp43bvw1eO4i8wtBKMzjrL6d8PDVAdt
         cBCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdfzgPoTkRKwpGLwzEVAMOJM4mWJKgwolA9rMXjSwEHGmXJhlgLiJYcGOwk2Z8fLv+7jUrLDB326XX7jL6yQ0SvZwod7wcV42XSKvNhB5i+MXU6QTgK48J4NYFiAe4eY91NWP1A95+pbA=
X-Gm-Message-State: AOJu0Ywr1f0kRtr/ZLvFOCckwRpbACb2yqsYl2PPAzoz/k+wJl9E08pH
	EUoms/6kMCjvd5in3wxUW5iOTQwWXxpWEdDsCV8v//IpRXBBYCGW
X-Google-Smtp-Source: AGHT+IEz+skFuqRkbnNFQLR4g/WSQnRAMiBY6M1c7WhrM5/JBrRjGoqo0wpSyC71RQNJ1tmb9ttgfg==
X-Received: by 2002:a05:6512:34c8:b0:512:b00f:a55e with SMTP id w8-20020a05651234c800b00512b00fa55emr5880137lfr.13.1709561068360;
        Mon, 04 Mar 2024 06:04:28 -0800 (PST)
Received: from [192.168.0.31] (84-115-209-225.cable.dynamic.surfer.at. [84.115.209.225])
        by smtp.gmail.com with ESMTPSA id q22-20020aa7da96000000b005669ce3f761sm4660283eds.59.2024.03.04.06.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 06:04:27 -0800 (PST)
Message-ID: <c2e4ae25-1e8a-4f54-8321-800a7b7f8583@gmail.com>
Date: Mon, 4 Mar 2024 15:04:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Missing bcm5974 touchpad on Macbooks
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>,
 Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <87sf161jjc.wl-tiwai@suse.de>
 <6ef6c5bf-e6e5-4711-81c6-6ae41de2e61e@wolfvision.net>
 <874jdm17yt.wl-tiwai@suse.de>
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <874jdm17yt.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 04.03.24 13:45, Takashi Iwai wrote:
> On Mon, 04 Mar 2024 12:26:48 +0100,
> Javier Carrasco wrote:
>>
>> On 04.03.24 09:35, Takashi Iwai wrote:
>>> Hi,
>>>
>>> we've received a few regression reports for openSUSE Leap about the
>>> missing touchpad on Macbooks.  After debugging, this turned out to be
>>> the backport of the commit 2b9c3eb32a699acdd4784d6b93743271b4970899
>>>     Input: bcm5974 - check endpoint type before starting traffic
>>>
>>> And, the same regression was confirmed on the upstream 6.8-rc6
>>> kernel.
>>>
>>> Reverting the commit above fixes the problem, the touchpad reappears.
>>>
>>> The detailed hardware info is found at:
>>>   https://bugzilla.suse.com/show_bug.cgi?id=1220030
>>>
>>> Feel free to join the bugzilla above, or let me know if you need
>>> something for debugging, then I'll delegate on the bugzilla.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>
>> Hi Takashi,
>>
>> The commit adds a check to ensure that the endpoint type is interrupt.
>>
>> According to that report, the issue arose with a MacBook Pro 5.1 (no
>> button, only trackpad endpoint), so the check on the tp_ep address
>> (0x81) returns false. I assume that you see an error message
>> ("Unexpected non-int endpoint) and  the probe function fails returning
>> -ENODEV.
> 
> Right, there is the message.
> 
>> Do you see any warning in the logs when you revert the commit? It was
>> added to prevent using wrong endpoint types, which will display the
>> following warning: "BOGUS urb xfer, pipe "some_number" != type
>> "another_number""
> 
> The revert was tested on the downstream kernel, but it has also the
> check of bogus pipe, and there was no such warning, as far as I see
> the report.
> 
>> I am just wondering if for some reason the check on interrupt type is
>> wrong here.
> 
> I'll ask reporters to give the lsusb -v output so that we can take a
> deeper look.  Also, I'm building a test kernel based on 6.8-rc7 with
> the revert, and ask reporters to test with it, just to be sure.
> 
> 
> thanks,
> 
> Takashi


Getting the output of lsusb would be awesome, thank you.

The bcm9547 driver has always made the assumption that the endpoint type
is interrupt, and the expected output from lsusb would be something like

bEndpointAddress     0x81  EP 1 IN
bmAttributes         3
Transfer Type        Interrupt

which is what the reverted commit checks.

I don't have the specific piece of hardware the report mentions, but I
triggered the probe with the endpoint type = interrupt and the check was
fine i.e. the probe did not fail. That made me think that the endpoint
type could be different, but I am dubious about that.

I will keep an eye on the bugzilla you linked, in case we get feedback
quickly.

Best regards,
Javier Carrasco

