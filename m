Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959E57B2E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjI2IuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjI2IuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:50:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1D194;
        Fri, 29 Sep 2023 01:49:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53636f98538so2306952a12.1;
        Fri, 29 Sep 2023 01:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695977398; x=1696582198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te4b1PNsB0Yknxr0mUDdVjWFVfbjX5kmo6KfA0rnUCA=;
        b=iYGiS9OW/m798o8ZHIQIqcjepjPetcoGXcklxArLmxMllrH9eZz3iNXz3BxU9aF+AE
         pUY6+gmYvSAl6rk1GZGdxAg0eEZFm3y9fba0ehCrWivEmN0PzLiVckhHIxpGuGN4QHVa
         PdVMAufen6+wyq1zbuxpnbxb92JWWiE0CSFhwNQJD6YRky8+Wt8Do9hMKMpwhaRtgdGG
         bgBIbH3tu26OVku/AOtPz6oVtzSLLlhVtxSQywslAsKMDgil9+sVuB9pAZddoLLPYHO5
         AH/1KnUHxJATCEPnsLi8vM0MutZhcyIcCljnDiHsFNPz3LqiXUCgCbKpQgl/94MHIigd
         iZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695977398; x=1696582198;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=te4b1PNsB0Yknxr0mUDdVjWFVfbjX5kmo6KfA0rnUCA=;
        b=SvsN9p/KgeEpogSs2NAVW7hp79RrUT8URoygffekipBmFi3ld2P49hSo503uF5C5ar
         4XkoCgm7UYgix7MmPIkhxCgayqOLuDYGgCLIeY706dij9LanXPNUV0h2DQTQMmIoosYy
         f7qPEOzDs5QvcHGLmrwk/wVIbffLE4O4JxKPZQUImCNq5Xes+q7md4Hvb21VABA8tv1i
         zJ6WIotXr+6HfstI3mdUYfNeax1WsjvzF3JTEEAgoESmuOmGC8Q/HBof0pRs7W4yjrpK
         XpedoKyZ3lA5R9PkbL4CCeACL9HqGj+xu5QgGKtZYZL7wh136pLeknOnmc8uUStXgU14
         QDEA==
X-Gm-Message-State: AOJu0Yyfn7SHj+SCNCk4F8xRwtLG6KNpblh0oTxjYTKwrSvSzqFrIITH
        3ejx61zKw7RuIWs6u42FgKPGRnBqU3g=
X-Google-Smtp-Source: AGHT+IGkwTaArXzVpJmzZgPglOob8sAd4UGu8QTGLt/hEQaKJys4uNNBq/WNkTPchd0iM5/AQQiQjw==
X-Received: by 2002:a05:6402:2055:b0:530:c0ac:8ca1 with SMTP id bc21-20020a056402205500b00530c0ac8ca1mr2512649edb.42.1695977397823;
        Fri, 29 Sep 2023 01:49:57 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id fd18-20020a056402389200b005331f6d4a30sm5247689edb.56.2023.09.29.01.49.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Sep 2023 01:49:57 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] media: rc: remove ir-rx51 in favour of generic
 pwm-ir-tx
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Timo Kokkonen <timo.t.kokkonen@iki.fi>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        "Sicelo A . Mhlongo" <absicsz@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <cover.1693577725.git.sean@mess.org>
 <e5325e826935f0bd8566152b6a5fa799b2429d43.1693577725.git.sean@mess.org>
 <99f0042f-538c-bcaf-96fd-bac24a87f88e@gmail.com>
 <ZRKFUb1vRtn82bgn@gofer.mess.org>
 <1715e2bf-5d02-4f20-1476-29a1fdf350b1@gmail.com>
 <ZRM8iLORjKw3z/h5@gofer.mess.org>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <179c4674-aa5c-0573-6d1f-ea6f2694d156@gmail.com>
Date:   Fri, 29 Sep 2023 11:49:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ZRM8iLORjKw3z/h5@gofer.mess.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26.09.23 г. 23:18 ч., Sean Young wrote:
> On Tue, Sep 26, 2023 at 03:43:18PM +0300, Ivaylo Dimitrov wrote:
>> On 26.09.23 г. 10:16 ч., Sean Young wrote:
>>> On Mon, Sep 25, 2023 at 07:06:44PM +0300, Ivaylo Dimitrov wrote:
>>>> On 1.09.23 г. 17:18 ч., Sean Young wrote:
>>>>> The ir-rx51 is a pwm-based TX driver specific to the N900. This can be
>>>>> handled entirely by the generic pwm-ir-tx driver, and in fact the
>>>>> pwm-ir-tx driver has been compatible with ir-rx51 from the start.
>>>>>
>>>>
>>>> Unfortunately, pwm-ir-tx does not work on n900. My investigation shows that
>>>> for some reason usleep_range() sleeps for at least 300-400 us more than what
>>>> interval it is requested to sleep. I played with cyclictest from rt-tests
>>>> package and it gives similar results - increasing the priority helps, but I
>>>> was not able to make it sleep for less that 300 us in average. I tried
>>>> cpu_latency_qos_add_request() in pwm-ir-tx, but it made no difference.
>>>>
>>>> I get similar results on motorola droid4 (OMAP4), albeit there average sleep
>>>> is in 200-300 us range, which makes me believe that either OMAPs have issues
>>>> with hrtimers or the config we use has some issue which leads to scheduler
>>>> latency. Or, something else...
>>>
>>> The pwm-ir-tx driver does suffer from this problem, but I was under the
>>> impression that the ir-rx51 has the same problem.
>>>
>>
>> Could you elaborate on the "pwm-ir-tx driver does suffer from this problem"?
>> Where do you see that?
> 
> So on a raspberry pi (model 3b), if I use the pwm-ir-tx driver, I get random
> delays of up to 100us. It's a bit random and certainly depends on the load.
> 
> I'm measuring using a logic analyzer.
> 
> There have been reports by others on different machines with random delays
> and/or transmit failures (as in the receiver occassionally fails to decode
> the IR). I usually suggest they use the gpio-ir-tx driver, which does work
> as far as I know (the signal looks perfect with a logic analyzer).
> 
> So far I've taken the view that the driver works ok for most situations,
> since IR is usually fine with upto 100us missing here or there.
> 
> The gpio-ir-tx driver works much better because it does the entire send
> under spinlock - obviously that has its own problems, because an IR transmit
> can be 10s or even 100s of milliseconds.
> 
> I've never known of a solution to the pwm-ir-tx driver. If using hrtimers
> directly improves the situation even a bit, then that would be great.
> 

The issue with hrtimers is that we cannot use them directly, as 
pwm_apply_state() may sleep, but hrtimer function is called in atomic 
context.

>> ir-rx51 does not suffer from the same problem (albeit it has its own one,
>> see bellow)
>>
>>>> In either case help is appreciated to dig further trying to find the reason
>>>> for such a big delay.
>>>
>>> pwm-ir-tx uses usleep_range() and ir-rx51 uses hrtimers. I thought that
>>> usleep_range() uses hrtimers; however if you're not seeing the same delay
>>> on ir-rx51 then maybe it's time to switch pwm-ir-tx to hrtimers.
>>>
>>
>> usleep_range() is backed by hrtimers already, however the difference comes
>> from how hrtimer is used in ir-rx51: it uses timer callback function that
>> gets called in softirq context, while usleep_range() puts the task in
>> TASK_UNINTERRUPTIBLE state and then calls schedule_hrtimeout_range(). For
>> some reason it takes at least 200-400 us (on average) even on OMAP4 to
>> switch back to TASK_RUNNING state.
>>
>> The issue with ir-rx51 and the way it uses hrtimers is that it calls
>> pwm_apply_state() from hrtimer function, which is not ok, per the comment
>> here
>> https://elixir.bootlin.com/linux/v6.6-rc3/source/drivers/pwm/core.c#L502
>>
>> I can make pwm-ir-tx switch to hrtimers, that's not an issue, but I am
>> afraid that there is some general scheduler or timers (or something else)
>> issue that manifests itself with usleep_range() misbehaving.
> 
> If we can switch pwm-ir-tx to hrtimers, that would be great.
> 

I made some POC here, but unfortunately it failed more or less. The idea 
of POC is: setup hrtimer, start it in pwm_ir_tx() and do 
wait_for_completion() in a loop while calling complete() for the timer 
function. While it improves things a bit, I wouldn't say it makes the 
driver working ok on n900 - my TV registers one of let's say 5-10 pulse 
packages.

We have couple of issues:

- scheduler seems to use 32kHz timer, which means that we can never have 
precise pulse width, with error up to ~30 us, no matter what we do, IIUC.

- wait_for_completion() suffers from the same latency issue that 
usleep_range() has - it exits after 300-400 us after complete() has been 
called in the timer function.

- turning pwm off needs ~300us, because of either omap_dm_timer_stop() 
calling clk_get_rate() or __omap_dm_timer_stop() waiting for fclk period 
* 3.5 (see 
https://elixir.bootlin.com/linux/v6.6-rc3/source/drivers/clocksource/timer-ti-dm.c#L269)

- in order to achieve some sane latency distribution, I have to 
set_user_nice(current, MIN_NICE); in pwm_ir_tx()


> The ir-rx51 removal patches have already been queued to media_staging;
> we may have to remove them from there if we can't solve this problem.
> 

ir-rx51 has conceptual problem of calling function that might sleep from 
atomic context, however, we can fix omap_dm_timer_stop() to not call 
clk_get_rate() and that would make it working. So yeah, if we can't fix 
pwm-ir-tx then patches removal along with fixing dmtimer and fixing a 
couple of code issues ir-rx51 has, seems the only option to have working 
IRTX on n900. Maybe we can rename it to pwm-ir-tx-hrtimer as there is 
nothing n900 specific in it.

>>> I don't have a n900 to test on, unfortunately.
>>>
>>
>> I have and once I have an idea what's going on will port pwm-ir-tx to
>> hrtimers, if needed. Don't want to do it now as I am afraid the completion I
>> will have to use will have the same latency problems as usleep_range()
> 
> That would be fantastic. Please do keep us up to date with how you are
> getting on. Like I said, it would be nice to this resolved before the next
> merge window.
> 

The only thing I didn't try yet is to start another thread and to set 
that thread to use FIFO scheduler. I will report once I have tried that.

Regards,
Ivo

> Thanks,
> Sean
> 
