Return-Path: <linux-kernel+bounces-60868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 532D6850A5B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E33C2833E3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2CF5C5EC;
	Sun, 11 Feb 2024 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=telus.net header.i=@telus.net header.b="FwWBjo4D"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8770954666
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707669839; cv=none; b=t2GDqhwipLMSS6C2mIP6yNegetGlHobI+wXW6ob0csAqiRx7bfJ9QeoGCqT4YF4n04XBp1kuhKQi5HP/OPFi+3xjwxTAMyZ/xW4jTkSIhfVd5sfOA7nooRafkvki0AkMIKzqPPPyg69cSXr1I789hwogjqo5NcxMlN6IyBW4mL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707669839; c=relaxed/simple;
	bh=IUsuXjX03NWMrGdlBVw/b0WIQxpF85sr152/0Pzn9ZM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NLcb3V/fTwrbx1SsKyykHmfWaHv9M3B+Ny4qsZtC0un7/c82RU704H6jyJbNQ45n7q7eRzl94awYZVkgJl+oIxK0L71jLufIJM5QF2z5eUzoopZ0DAxHMC8erECoTtH+mZDmezYehrEdm4H9JLxvuQqhYt1Bf1sJgaybgEaVCkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=FwWBjo4D; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e2e58feaefso136536a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 08:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1707669836; x=1708274636; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IUsuXjX03NWMrGdlBVw/b0WIQxpF85sr152/0Pzn9ZM=;
        b=FwWBjo4DiDCQQ3+EledAZOY9Qc21srVdj8stoNghQjeJAGZSWh+Y605QnrZiyYLSrq
         LCULw8OrRM2anIckhc1j8D9h3jf7jDdAMV/XA5DDOU2mZtNLNnG+pVQphAAhb2TVXvuJ
         r+0mTTP3t2S4K7vnX6CV7CUBjV4+ASvjTCMiK3GL9ANy2I+ss9ehae0494HD9vBgnj1q
         V7rPyhM6Jc2ywgLYlAlzCzZCKnnF4Kg98sJwQRUQ4m8berbHWnhhR3coWXNE9e/aoA8j
         Ld3baxIhFio06QQFarAAVuxsr1jQMxeKO415K5KveMLkwkGA7DCfpp5OK1d8nlI12HHf
         xBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707669836; x=1708274636;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUsuXjX03NWMrGdlBVw/b0WIQxpF85sr152/0Pzn9ZM=;
        b=BTt4NMvlujGzxTh69Yo6YZPx9nVwmllKhGhVwaX7ckh5HOKcorGxe+izb4damtPEV3
         tDMSBYWUli+4QI1TV2uzZ1rQagv89tMogi8uwtk9fUnQWGfZlolNwPjKJ6WF4QknPIDh
         3XwLSkoiqHt6UNQ+FtdoZDefAoUoDcm2hQ08lIyC17jcF+zfmu4BUpp3gVPGaP/lhua+
         j/y3PmIoF4adTnCv+SkZUMcxWTgVp7JQYMJPHvmdh1jl+Hj0BwrmSD9BTNCZgqbRZi7K
         cPCiqzAWGpXgWWjGyw0nqjg00FqZK1GfGnuHlwS5E3Dv5tVVReCBw/y6QLWmlPp9cmI1
         OnJA==
X-Forwarded-Encrypted: i=1; AJvYcCWdenMR6DWtosnDHv5c2Gpzu0ng/Xeg1lfRWHVeNsVJLDfkb2WKpTEOWPEwG6G1vDOiR1lrId6tb0pSUObTP1k5d4xLGyXyZFF5Jzbu
X-Gm-Message-State: AOJu0YwkCB5uA+DjIdbHcuzZGS84Jr63L9iwQnJS8X0HGb24B58QEpLH
	xGmoMKu/iS5UbafshGUnRIzpGpYVdQ69wgVjLp/bKwX16PK7EVJiL0BzZoWYKRE=
X-Google-Smtp-Source: AGHT+IH+tY7O6WFeho5VnKia8cngNwgyEbGjks7wJwe5NBKvAhQK8uMFWgK7Gf9pOFFoEejPRTeWgA==
X-Received: by 2002:a05:6358:199e:b0:176:5a5e:4bf9 with SMTP id v30-20020a056358199e00b001765a5e4bf9mr7844088rwn.22.1707669836539;
        Sun, 11 Feb 2024 08:43:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXewZJOIg0FJAFqMImWK4z50DpnckeNc80B+nFTY9O0XMLKaT35n0FyWTxi4rtkQLcFj15j7xZFZxap6rB7UR7583aoC+Uuzy7KNIrC7uUEGmlJGedBkcelNGabjQ0RvmKHrAKKF7K7sCVdDRWr4nbYiu2rJ2GyvgdwBEVKNJjTXkHGV4rXaGEhQ1ezh/Ca
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id y20-20020a62b514000000b006e08da9c29csm3927793pfe.54.2024.02.11.08.43.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Feb 2024 08:43:55 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Vincent Guittot'" <vincent.guittot@linaro.org>
Cc: "'Ingo Molnar'" <mingo@kernel.org>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>,
	<linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <002f01da5ba0$49cbf810$dd63e830$@telus.net> <CAKfTPtA-jizig0sh_shmkAMudAxDPYHP0SdanZe=Gc57jVKouQ@mail.gmail.com> <003801da5bae$02d6f550$0884dff0$@telus.net> <CAKfTPtC7pOtb-srrgQLFbTueLLDqHay+GQBm9=sNsnZDg_UYSQ@mail.gmail.com>
In-Reply-To: <CAKfTPtC7pOtb-srrgQLFbTueLLDqHay+GQBm9=sNsnZDg_UYSQ@mail.gmail.com>
Subject: RE: sched/cpufreq: Rework schedutil governor performance estimation - Regression bisected
Date: Sun, 11 Feb 2024 08:43:57 -0800
Message-ID: <000b01da5d09$8219f900$864deb00$@telus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHymzO4ho/iLx8gQfQ33x85MlP38AE230H5ATs9P70BGBlhK7C4e+GA

On 2024.02.11 05:36 Vincent wrote:
> On Sat, 10 Feb 2024 at 00:16, Doug Smythies <dsmythies@telus.net> wrote:
>> On 2024.02.09.14:11 Vincent wrote:
>>> On Fri, 9 Feb 2024 at 22:38, Doug Smythies <dsmythies@telus.net> wrote:
>>>>
>>>> I noticed a regression in the 6.8rc series kernels. Bisecting the kernel pointed to:
>>>>
>>>> # first bad commit: [9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d]
>>>> sched/cpufreq: Rework schedutil governor performance estimation
>>>>
>>>> There was previous bisection and suggestion of reversion,
>>>> but I guess it wasn't done in the end. [1]
>>>
>>> This has been fixed with
>>> https://lore.kernel.org/all/170539970061.398.16662091173685476681.tip-bot2@tip-bot2/
>>
>> Okay, thanks. I didn't find that one.
>>
>>>> The regression: reduced maximum CPU frequency is ignored.

Perhaps I should have said "sometimes ignored".
With a maximum CPU frequency for all CPUs set to 2.4 GHz and
a 100% load on CPU 5, its frequency was sampled 1000 times:
28.6% of samples were 2.4 GHz.
71.4% of samples were 4.8 GHz (the max turbo frequency)
The results are highly non-repeatable, for example another sample:
32.8% of samples were 2.4 GHz.
76.2% of samples were 4.8 GHz

Another interesting side note: If load is added to the other CPUs,
the set maximum CPU frequency is enforced.

>>
>>> This seems to be something new.
>>> schedutil doesn't impact the max_freq and it's up to cpufreq driver
>>> select the final freq which should stay within the limits
>>
>> Okay. All I know is this is the commit that caused the regression.
>
> Could you check if the fix solved your problem ?

Given the tags for that commit:

$ git tag --contains e37617c8e53a
v6.8-rc1
v6.8-rc2
v6.8-rc3

It does not solve issue I have raised herein, as it exists in v6.8-rc1 but not v6.7

>> I do not know why, but I do wonder if there could any relationship with
>> the old, never fixed, problem of incorrect stale frequencies reported
>> under the same operating conditions. See the V2 note:
>> https://lore.kernel.org/all/001d01d9d3a7$71736f50$545a4df0$@telus.net/
>
> IIUC the problem is that policy->cur is not used by intel_cpufreq and
> stays set to the last old/init value.

Yes, exactly.

> Do I get it right that this is only informative ?

I don't know, that is what I was wondering. I do not know if the two issues
are related or not.

> Normally cpufreq governor checks the new limits and updates current
> freq if necessary except when fast switch is enabled.

>> where I haven't been able to figure out a solution.

>>>> Conditions:
>>>> CPU frequency scaling driver: intel_cpufreq (a.k.a intel_pstate in passive mode)
>>>> CPU frequency scaling governor: schedutil
>>>> HWP (HardWare Pstate) control (a.k.a. Intel_speedshift): Enabled
>>>> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
>>>>
>>>> I did not check any other conditions, i.e. HWP disabled or the acpi-cpufreq driver.

Changing from HWP enabled to HWP disabled, it works properly.

..

>>>> [1] https://lore.kernel.org/all/CAKfTPtDCQuJjpi6=zjeWPcLeP+ZY5Dw7XDrZ-LpXqEAAUbXLhA@mail.gmail.com/



