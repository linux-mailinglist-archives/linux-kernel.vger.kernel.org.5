Return-Path: <linux-kernel+bounces-67787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E8C8570BB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122CD1C21A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27851420D4;
	Thu, 15 Feb 2024 22:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="Cb4lUyAp"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE7313A86F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037584; cv=none; b=rNkgtEBgJ76spO4gr1xU6xdkijx0knq5qaVcl4KqatuBHGyVSFPSBFVM6j87FJU249YXBDqSv//IB+M6brx52jEbeqAIYrSbKHITfLHi7eKMo0Edq+KF29ItBqWtRUPPLTEa3OGW2pxeksCqBN4xYU9JtKcUzZ+SR97TMfTfRcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037584; c=relaxed/simple;
	bh=gVtwWwBmoGcxD/Dd81RsCvFFLgug1u8njms8eH1uLvU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=nr7NSOvYnOOZgQJ/xHFEnj5IzjRDlenRUsfASlhJUAe2XdJR6q2wG0N2sm08FmrXZ35ev6Z6Eb3sLkZ0ddXCY9D0JQBXBc502kjlGays8umvWfi90Ms//QbFIY/Pat8vdhQgQdPlXkiBz+e000zXF5Bnecs2k7zFAloPDqD++y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=Cb4lUyAp; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59883168a83so775128eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1708037581; x=1708642381; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s1EKbpN+e7JKAG/MkqriqG+x1Jw40LA+jNb66bBx2Ww=;
        b=Cb4lUyApjkcEli2xl0ccC+rTXPMcyIgKedPkf1wQGFRdK1JuyjsC+tvxl6r1hnT5HF
         P1TwckLCnnH669qKXsKNbktVasQWPzT6G5wO3S2SPwk9p6/DIMNT4A+Mrtt8Y3uXcCVr
         EGFXo9Wt27UmyF2cz4Ef74ioHY4a2AsCFLDZ6L7EvIdgAoGEo72FRXF0tKWkcFCtbbRU
         0bjwUugcS0O3U8pLnzNOmiiiHaivQLOhBmNsBVL6VAsVsvOeIBcT4DVlBxp+VmbrU03/
         AXN49si2kex74s6vBRQtWOhVc8dRluSdM6ZK5f163UHUWyfTC2cKNSRlwygCDVWowZHg
         TKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708037581; x=1708642381;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1EKbpN+e7JKAG/MkqriqG+x1Jw40LA+jNb66bBx2Ww=;
        b=Uw6qyCCQfo166VHvcaqDPf3Spz3Yl7i7BT/ZooPA5CNyNTJHmy5CbrPfU2O0TFyahs
         4aparEWyy7lKwkL5idpdAoLRaffU3Iv4RWc/+UiQ9LCuozj7CYo9SI2uDhPZVp66UIBq
         BSvQpW/yejUBRjFg2lDZpCPBC6VNQS+AS3GvGuygxga3MdSP8B+9DwenSmOnRfPQEUIO
         anAqJmCdMFUUrV20FxL8yvFhVwOXR1wtiOmgJUOFzf4c3HNDM6NJX8viTt8nQs6KINfe
         sqevTfEeQywK6lYW5sKVQ2B/TGGQYSEDP2nzW7N1O+TjTdL4sOntvxtBLOsPf6dnsyMT
         abXw==
X-Forwarded-Encrypted: i=1; AJvYcCWAGAzpZYMQ15u4tNIr4Bdu3s4Ix3QuR2K4TIw/pLvXYup3MxKnEa0OXWerBvivL23X9zBHBJ9ZOaYCihBuKuxRNHNzUaRgzMANc5UB
X-Gm-Message-State: AOJu0YwWCf8pSJZfExu+BuHwSTae8cEgmh1qcDSXLBmFWYhNIQtIgRiW
	q+gKbdsNi7ZmbX4vpnM5CTE+n146xhdNqyu6x2jkj8DmK5WLNEH2pBCFGBNZKz8=
X-Google-Smtp-Source: AGHT+IE6sE0XGtC0W9O2UAq9sQ2FS1xveLUA+FW7BMsfBKSodwfMr6XYElbX4okl+S2tbPhc34EvQQ==
X-Received: by 2002:a05:6358:5927:b0:17a:a774:93a3 with SMTP id g39-20020a056358592700b0017aa77493a3mr2299269rwf.15.1708037580892;
        Thu, 15 Feb 2024 14:53:00 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id n6-20020aa79846000000b006ddcadb1e2csm1848022pfq.29.2024.02.15.14.53.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Feb 2024 14:53:00 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Vincent Guittot'" <vincent.guittot@linaro.org>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>
Cc: "'Ingo Molnar'" <mingo@kernel.org>,
	<linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <002f01da5ba0$49cbf810$dd63e830$@telus.net> <CAKfTPtA-jizig0sh_shmkAMudAxDPYHP0SdanZe=Gc57jVKouQ@mail.gmail.com> <003801da5bae$02d6f550$0884dff0$@telus.net> <CAKfTPtC7pOtb-srrgQLFbTueLLDqHay+GQBm9=sNsnZDg_UYSQ@mail.gmail.com> <000b01da5d09$8219f900$864deb00$@telus.net> <CAKfTPtB8v30LzL3EufRqbfcCceS2nQ_2G8ZHuoD5N1_y-pvFbg@mail.gmail.com> <001b01da5ea7$86c7a070$9456e150$@telus.net> <CAKfTPtD4Un-A2FcdsvKnNZskG=xH0wrsT3xzaWDs--mQjgZ3rg@mail.gmail.com>
In-Reply-To: <CAKfTPtD4Un-A2FcdsvKnNZskG=xH0wrsT3xzaWDs--mQjgZ3rg@mail.gmail.com>
Subject: RE: sched/cpufreq: Rework schedutil governor performance estimation - Regression bisected
Date: Thu, 15 Feb 2024 14:53:03 -0800
Message-ID: <003001da6061$bbad1e30$33075a90$@telus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHymzO4ho/iLx8gQfQ33x85MlP38AE230H5ATs9P70BGBlhKwIBEbUgAWfpSqoB1OxCigJA5W0AsIM54tA=

Hi Vincent,

This email thread appears as if it might be moving away from a =
regression
caused by your commit towards a conclusion that your commit exposed
a pre-existing bug in the intel_psate.c code.

Therefore, I have moved Rafael from the C.C. line to the "to" line and
added Srinivas.

On 2024.02.14 07:38 Vincent wrote:
> On Tue, 13 Feb 2024 at 19:07, Doug Smythies <dsmythies@telus.net> =
wrote:
>> On 2024.02.13 03:27 Vincent wrote:
>>> On Sun, 11 Feb 2024 at 17:43, Doug Smythies <dsmythies@telus.net> =
wrote:
>>>> On 2024.02.11 05:36 Vincent wrote:
>>>>> On Sat, 10 Feb 2024 at 00:16, Doug Smythies <dsmythies@telus.net> =
wrote:
>>>>>> On 2024.02.09.14:11 Vincent wrote:
>>>>>>> On Fri, 9 Feb 2024 at 22:38, Doug Smythies <dsmythies@telus.net> =
wrote:
>>>>>>>>
>>>>>>>> I noticed a regression in the 6.8rc series kernels. Bisecting =
the kernel pointed to:
>>>>>>>>
>>>>>>>> # first bad commit: [9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d]
>>>>>>>> sched/cpufreq: Rework schedutil governor performance estimation
>>>>>>>>
>>>>>>>> There was previous bisection and suggestion of reversion,
>>>>>>>> but I guess it wasn't done in the end. [1]
>>>>>>>
>>>>>>> This has been fixed with
>>>>>>> =
https://lore.kernel.org/all/170539970061.398.16662091173685476681.tip-bot=
2@tip-bot2/
>>>>>>
>>>>>> Okay, thanks. I didn't find that one.
>>>>>>
>>>>>>>> The regression: reduced maximum CPU frequency is ignored.
>>>>
>>>> Perhaps I should have said "sometimes ignored".
>>>> With a maximum CPU frequency for all CPUs set to 2.4 GHz and
>>>> a 100% load on CPU 5, its frequency was sampled 1000 times:
>>>> 28.6% of samples were 2.4 GHz.
>>>> 71.4% of samples were 4.8 GHz (the max turbo frequency)
>>>> The results are highly non-repeatable, for example another sample:
>>>> 32.8% of samples were 2.4 GHz.
>>>> 76.2% of samples were 4.8 GHz
>>>>
>>>> Another interesting side note: If load is added to the other CPUs,
>>>> the set maximum CPU frequency is enforced.
>>>
>>> Could you trace cpufreq and pstate ? I'd like to understand how
>>> policy->cur can be changed
>>> whereas there is this comment in intel_pstate_set_policy():
>>>        /*
>>>         * policy->cur is never updated with the intel_pstate driver, =
but it
>>>         * is used as a stale frequency value. So, keep it within =
limits.
>>>         */
>>>
>>> but cpufreq_driver_fast_switch() updates it with the freq returned =
by
>>> intel_cpufreq_fast_switch()
>>
>> Perhaps I should submit a patch clarifying that comment.
>> It is true for the "intel_pstate" CPU frequency scaling driver but =
not for the
>> "intel_cpufreq" CPU frequency scaling driver, also known as the =
intel_pstate
>> driver in passive mode. Sorry for any confusion.
>>
>> I ran the intel_pstate_tracer.py during the test and do observe many, =
but
>> not all, CPUs requesting pstate 48 when the max is set to 24.
>> The calling request seems to always be via "fast_switch" path.
>> The root issue here appears to be a limit clamping problem for that =
path.
>
> Yes, I came to a similar conclusion as well. Whatever does schedutil
> ask for, it should be clamped by  cpu->max|min_perf_ratio.

Agreed. And it is not clamping properly under specific conditions.

> Do you know if you use fast_switch or adjust_perf call back ?

I am not certain, but I think it uses "adjust_perf" call back.
I do know for certain that it never takes the
"intel_cpufreq_update_pstate" path
and always takes the
"intel_cpu_freq_adjust_perf" path.

The problem seems to occur when that function is called with:
min_perf =3D 1024
target_perf =3D 1024
capacity =3D 1024

Even though cpu->max_perf_ratio is 24, the related HWP MSR,
0x774: IA32_HWP_REQUEST, ends up as 48, 48, 48 for min, max, des.

This patch appears to fix the issue (still has my debug code and
includes a question):

diff --git a/drivers/cpufreq/intel_pstate.c =
b/drivers/cpufreq/intel_pstate.c
index ca94e60e705a..8f88a04a494b 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2987,12 +2987,22 @@ static void intel_cpufreq_adjust_perf(unsigned =
int cpunum,
        if (min_pstate < cpu->min_perf_ratio)
                min_pstate =3D cpu->min_perf_ratio;

+//     if (min_pstate > cpu->pstate.max_pstate)   /* needed? I don't =
know */
+//             min_pstate =3D cpu->pstate.max_pstate;
+
+       if (min_pstate > cpu->max_perf_ratio)
+               min_pstate =3D cpu->max_perf_ratio;
+
        max_pstate =3D min(cap_pstate, cpu->max_perf_ratio);
        if (max_pstate < min_pstate)
                max_pstate =3D min_pstate;

        target_pstate =3D clamp_t(int, target_pstate, min_pstate, =
max_pstate);

+       if((max_pstate > 40) || (max_pstate < 7) || (min_pstate < 7) || =
min_pstate > 40 || target_pstate > 40){
+               pr_debug("Doug: t: %d : min %d : max %d : minp %d : maxp =
%d : mnperf %lu : tgperf %lu : capacity %lu\n", target_pstate, =
min_pstate, max_pstate, cpu->min_perf_ratio, cpu->max_perf_ratio, =
min_perf, target_perf, capacity);
+       }
+
        intel_cpufreq_hwp_update(cpu, min_pstate, max_pstate, =
target_pstate, true);

        cpu->pstate.current_pstate =3D target_pstate;

With the patch, I never hit the debug statement if the max CPU frequency =
is limited to 2.4 GHz,
whereas it used to get triggered often.
More importantly, the system seems to now behave properly and obey set =
CPU frequency limits.



