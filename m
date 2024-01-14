Return-Path: <linux-kernel+bounces-25538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF4082D20A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 21:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF101F21049
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 20:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A27112E67;
	Sun, 14 Jan 2024 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePGXnL/D"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C558D1640B;
	Sun, 14 Jan 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eac018059so9977143e87.0;
        Sun, 14 Jan 2024 12:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705262655; x=1705867455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1M8TnteeflGvZ6cvygRfCUgIwPLJ+AIgzs8KqJCXdg4=;
        b=ePGXnL/DTRZnOCEow+iLh6xmQfk3bqzVWRVSDQjZPbt3iPIfuSOQQlTl6Kpmf0CAP0
         RsxegdLDhNiwESojT0olQs4j2jklg5e8L2ghy93NtMRk3UJ/dn9+Cxqc9q5t7VrAHxXF
         LA5TtIwbv1x5GZiOm1agY1C7IirFeWIWNZwamcfTCK5QO7jf5pCglPtnKuNWhXPd8KGH
         kZD5TY/94I7vobcKzUV/Pfj4VMGXHqCMq7d4DLsfUu8h4mmLzmOGJALckBvxET5tbLuT
         MKt0MHGf87PLSC6T4rixj8Iz9ZSOARVxic6k2FVsHBbb9wufekqOTq2EniBbt00N880j
         yZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705262655; x=1705867455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1M8TnteeflGvZ6cvygRfCUgIwPLJ+AIgzs8KqJCXdg4=;
        b=Z1O8HvA1eDFeKhXxMXKLF+6l/lsAzc6mUNDf9gRRuIvSAtLFvFodKJJCgHyMThQM7F
         bsSDieOO9YtBq9w7luSkcq5ECbvKeoF3c2du1Li2TlVBFpf+I5nLiNSIo4DibUdIga+d
         KYe47+gjeZ7vnW8rDF/8ppsqvGjnfpyipIiRhz3Il02XC9gyIZExDTUmNwTkwSTrNoQO
         vDtFMWKLIA7pyzy6SpOsuJGKft/ocfLBEyjAZcGhvVBvAGs0g3B2DnY1ujGDbaV/5oaw
         z/hJuCz406/XZxEHg9/0GLWYJ6BAbpZ/pjBHSgPVQHTDCpbYEMxLPwcv9EgzpCdrZgi3
         nNBw==
X-Gm-Message-State: AOJu0Yy/pS5bk29TbPeTyjmDO7I7C2F5g8mDuiUlyVymnh/2MzXN2QA4
	a5toLnmYjKjZEcISw+27YjozrQVFr8wZ2w==
X-Google-Smtp-Source: AGHT+IGkfOIZ8AVDwrJ3tiwAvZND/IC123Qo5/HJeTyhG0YWZvGHJ+zfFrj5/AiOSJAZV8MOyELKXw==
X-Received: by 2002:ac2:4249:0:b0:50e:378b:5187 with SMTP id m9-20020ac24249000000b0050e378b5187mr2083619lfl.41.1705262654407;
        Sun, 14 Jan 2024 12:04:14 -0800 (PST)
Received: from [192.168.1.99] ([151.62.194.53])
        by smtp.gmail.com with ESMTPSA id t10-20020a170906178a00b00a28ba0c3821sm4421996eje.101.2024.01.14.12.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jan 2024 12:04:14 -0800 (PST)
Message-ID: <053a5c27-68fd-41b1-8b40-783dfb83d488@gmail.com>
Date: Sun, 14 Jan 2024 21:04:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iio: iio-trig-hrtimer bug on suspend/resume when used with bmi160
 and bmi323
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jagath Jog J <jagathjog1996@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <31d7f7aa-e834-4fd0-a66a-e0ff528425dc@gmail.com>
 <20240113174351.47a20239@jic23-huawei>
Content-Language: en-US, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <20240113174351.47a20239@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/24 18:46, Jonathan Cameron wrote:
> On Wed, 10 Jan 2024 23:35:01 +0100
> Denis Benato <benato.denis96@gmail.com> wrote:
> 
>> Hello,
>>
>> With this mail I am submitting bug report that is probably related to
>> iio-trig-hrtimer but there is also the possibility for it to be
>> specific to bmi160 and bmi323.
>>
>> The described problem have been reproduced on my handheld PC (Asus
>> RC71L) and in another handheld PC with two different gyroscope
>> drivers: bmi323 (backported by me on v6.7, on RC71L) and bmi160.
>>
>> My target hardware (RC71L that yeld to this discovery) has a bmi323
>> chip that does not have any interrupt pins reaching the CPU, yet I
>> need to fetch periodically data from said device, therefore I used
>> iio-trig-hrtimer: created a trigger, set the device and trigger
>> sampling frequencies, bound the trigger to the device and enabled
>> buffer: data is being read and available over /dev/iio:device0.
>>
>> While in this state if I suspend my handheld I receive (from dmesg)
>> the warning reported below and at resume data is not coming out of
>> the iio device and the hrtimer appears to not be working. If I create
>> a new trigger and bind the new trigger to said iio device and
>> re-enable buffer data does come out of /dev/iio:device0 once more,
>> until the next sleep.
>>
>> Since this is important to me I have taken the time to look at both
>> drivers and iio-trig-hrtimer and I have identified three possible
>> reasons:
>>
>> 1) iio-trig-hrtimer won't work after suspend regardless of how it is
>> used (this is what I believe is the cause)
> me too.
who and how should investigate this issue? Would putting a kprintf in the hrtimer callback be enough to check?


Just to make sure I understood correctly: is this a separate issue from the warning I receive or are those linked?
> 
>> 2) iio-trig-hrtimer is stopped by the -ESHTDOWN returned by the
>> function printing "Transfer while suspended", however that stack
>> trace does not include function calls related to iio-trig-hrtimer and
>> this seems less plausible 3) bmi160 and bmi323 appears to be similar
>> and maybe are sharing a common bug with suspend (this is also why I
>> have maintainers of those drivers in the recipient list)
>>
>> Thanks for your time, patience and understanding,
> 
> Hi Denis,
> 
> I suspect this is the legacy of the platform I used to test the hrtimer
> and similar triggers on never had working suspend and resume (we ripped
> support for that board out of the kernel a while back now...)
> Hence those paths were never tested by me and others may not have cared
> about this particular case.
> 
> Anyhow, so I think what is going on is fairly simple.
> 
> There is no way for a driver to indicate to a trigger provided by a separate
> module / hardware device that it should stop triggering data capture.
> The driver in question doesn't block data capture when suspended, which
> would be easy enough to add but doesn't feel like the right solution.
> 
> So my initial thought is that we should add suspend and resume callbacks to
> iio_trigger_ops and call them manually from iio device drivers in their
> suspend and resume callbacks.  These would simply pause whatever the
> trigger source was so that no attempts are made to trigger the use of
> the device when it is suspended.
> 
> It gets a little messy though as triggers can be shared between
> multiple devices so we'd need to reference count suspend and resume
> for the trigger to make sure we only resume once all consumers of
> the trigger have said they are ready to cope with triggers again.
> 
> As mentioned, the alternative would be to block the triggers at ingress
> to the bmi323 and bmi160 drivers.  There may be a helpful pm flag that could
> be used but if not, then setting an is_suspended flag under the data->mutex
> to avoid races. and reading it in the trigger_handler to decide whether
> to talk to the device should work.
I was thinking of doing this too, but I don't know if adding a mutex to frequently invoked functions is going to introduce some timing problems and so I was waiting for some comments on that matter. If nothing bad is expected I can surely try it.
> 
> I'd kind of like the generic solution of actually letting the trigger
> know, but not sure how much work it would turn out to be.  Either way there
> are a lot of drivers to fix this problem in as in theory most triggers can
> be used with most drivers that support buffered data capture.
> There may also be fun corners where a hardware trigger from one IIO
> device A is being used by another B and the suspend timing is such that B
> finishing with the trigger results in A taking an action (in the try_reenable
> callback) that could result in bus traffic.
> That one is going to be much more fiddly to handle than the simpler case
> you have run into.
Since more and more handheld PCs are coming and provided many vendors such as asus tends to improve what they did built on previous generations I think a general solution would be desirable.

Plus there are handheld PCs that does not yet have a driver (bmi270) or are using an existing one and it would be very difficult to fix it in every of them as of now, in the future I fear it will become almost impossible or extremely time consuming as market expands.
> 
> Thanks for the detailed bug report btw.   To get it fixed a few
> questions:
> 1) Are you happy to test proposed fixes?
> 2) Do you want to have a go at fixing it yourself? (I'd suggest trying
>    the fix in the bmi323 driver first rather than looking at the other 
>    solution)
>    If we eventually implement the more general version, then a bmi323
>    additional protection against this problem would not be a problem.
> 
> Clearly I'd like the answers to be yes to both questions, but up to you!
> 
> Jonathan
> 
> 
Hello Jonathan and thank you kindly for you answer,

I am very interested in the iio ecosystem as in those aforementioned handheld PCs the gyroscope plays the role as a mouse so it's a pretty important input device.

I am writing to lkml not just as a single developer, but as part of a larger community in this matter: this means we will be able to test any solution and in more than just one hardware.

To answers your questions:
1) yes, we all will be very happy to
2) as I am very busy right now I might be unable to do that immediately, but I will surely do it if one general solution cannot be found or is impractical.

As of my limited knowledge the number of drivers now existing that are affected are 2, and the number of drivers that will be affected, once the driver is written, will be at least 3.

Thank you very much for your answer,
Denis

