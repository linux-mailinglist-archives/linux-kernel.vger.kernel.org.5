Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD0778DE87
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbjH3TEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242040AbjH3HNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:13:14 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A411AE;
        Wed, 30 Aug 2023 00:13:12 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34dee07e676so3826035ab.3;
        Wed, 30 Aug 2023 00:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693379591; x=1693984391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOo62IJdDzvF7uZuAvu3wjLRfyhiLnIykyk4B9I2bl0=;
        b=AhmmZD50n2sp1Z6HTpWom+wk0H0JjkdPjyNP2zJ1LlNihZoEkz0L+1DT1KzruyUMIU
         aXVBr31Y/xHqJYRuNRXbHDf2gjotlZzUOaio5mTuOBWzICM5hzEXdwaXq7KhXedTcyYr
         nfnmd/B1lAR0cGRcbfsBhkCdGNYaFBYeO05x0ZFAbT2KoL+y3l9moJ5veb7QVCiXHanl
         YvcBsLjhhC2C1oDGZCYatqBwQFxRBGLlFFWHzbjq1Hdh/RsBYjTE+r3vlmS956PTlgYu
         vtYwuMcNcOateU+jrvRshhB0KgOcQxw27/uxRn9JtIzJX0arAdgGa41W30/V2tEhfbHG
         Fb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693379591; x=1693984391;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOo62IJdDzvF7uZuAvu3wjLRfyhiLnIykyk4B9I2bl0=;
        b=C1iKKTdeYtJfslKqqJjapBfNNImUroT6fGS+3BilJwEyx5eGa/wvNmh71U46BJjk5j
         jNz/uTqKG/GdBGl1MEDb7AQ03DFCD1EKdVr7A2wianOjAyN7mNy3tlxt60sf1icnpx1H
         ynS40ttC3iziLWeq2PeLzLw+76gi7I44GUmb/K7ZR4u7ZQ28K1a4fnjMV2yUrTf42t/F
         So1S0c9PK1bhOXNeN7wb3y44MG1wlF7rAfZOe/vjwIGQvVSP494OXBo/bTFWBu5BM87/
         hOSU+QK9/VuNpewEQvTDth4MgzBZRRuCPMISGOQUk3KVt+zFhIfqXQ3iEbnZ2QaoM7CB
         zs7Q==
X-Gm-Message-State: AOJu0YysGqWeP5n368Wmk8v0I403ILR+Prggg7NlPfQk1JrTLle5e6+G
        0uQVcrITKdjzW65FVnjYgrAddbmdorQ=
X-Google-Smtp-Source: AGHT+IEvSfnF8jHlR+J/Z8FkFF/Opui6zecxDp5Jgq8Bk7gLVtei0PNQR+LQ9iwKSCBmTOkP3rcEWg==
X-Received: by 2002:a05:6e02:c74:b0:34c:e84b:4c63 with SMTP id f20-20020a056e020c7400b0034ce84b4c63mr1537554ilj.1.1693379591610;
        Wed, 30 Aug 2023 00:13:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q24-20020a02c8d8000000b0042b4437d857sm3764197jao.106.2023.08.30.00.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 00:13:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <afa30d68-4f53-4903-b470-0d337c9aa7aa@roeck-us.net>
Date:   Wed, 30 Aug 2023 00:13:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
References: <20230817225537.4053865-1-linux@roeck-us.net>
 <20230817225537.4053865-3-linux@roeck-us.net>
 <6991631008bab403e957534d6d05360c.sboyd@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/7] rtc: alarmtimer: Use maximum alarm time offset
In-Reply-To: <6991631008bab403e957534d6d05360c.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 14:50, Stephen Boyd wrote:
> Quoting Guenter Roeck (2023-08-17 15:55:32)
>> Some userspace applications use timerfd_create() to request wakeups after
>> a long period of time. For example, a backup application may request a
>> wakeup once per week. This is perfectly fine as long as the system does
>> not try to suspend. However, if the system tries to suspend and the
>> system's RTC does not support the required alarm timeout, the suspend
>> operation will fail with an error such as
>>
>> rtc_cmos 00:01: Alarms can be up to one day in the future
>> PM: dpm_run_callback(): platform_pm_suspend+0x0/0x4a returns -22
>> alarmtimer alarmtimer.4.auto: platform_pm_suspend+0x0/0x4a returned -22 after 117 usecs
>> PM: Device alarmtimer.4.auto failed to suspend: error -22
>>
>> This results in a refusal to suspend the system, causing substantial
>> battery drain on affected systems.
>>
>> To fix the problem, use the maximum alarm time offset as reported by rtc
>> drivers to set the maximum alarm time. While this will result in brief
>> spurious wakeups from suspend, it is still much better than not suspending
>> at all.
>>
>> Cc: Brian Norris <briannorris@chromium.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Rename range_max_offset -> alarm_offset_max
>>
>>   kernel/time/alarmtimer.c | 13 +++++++++++++
>>
>> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
>> index 8d9f13d847f0..895e3a6d6444 100644
>> --- a/kernel/time/alarmtimer.c
>> +++ b/kernel/time/alarmtimer.c
>> @@ -290,6 +290,19 @@ static int alarmtimer_suspend(struct device *dev)
>>          rtc_timer_cancel(rtc, &rtctimer);
>>          rtc_read_time(rtc, &tm);
>>          now = rtc_tm_to_ktime(tm);
>> +
>> +       /*
>> +        * If the RTC alarm timer only supports a limited time offset, set
>> +        * the alarm time to the maximum supported value.
>> +        * The system will wake up earlier than necessary and is expected
>> +        * to go back to sleep if it has nothing to do.
> 
> Does this assume that the kernel is configured for autosuspend
> (CONFIG_PM_AUTOSLEEP)? Maybe we should only do this when that config is
> enabled.
> 

It doesn't really assume anything. It standardizes behavior if the rtc
does not support the requested alarm time. Today that either fails
or the rtc silently adjusts the alarm time (sometimes to 1 day + 1 minute ->
one minute) depending on the implementation in the rtc driver. With this
patch in place, the the rtc driver informing the rtc core about the limit,
the alarm would fire at the maximum time supported by the rtc if the
requested alarm time is larger than its limit.

I see that as improvement, no matter if CONFIG_PM_AUTOSLEEP is enabled or not.

> If userspace is the one autosuspending, then I don't know what we do, or
> how the kernel knows it is OK. Maybe we need another alarmtimer clock id
> that will fail creation if the wakeup time is larger than what the rtc
> can be programmed for? Or maybe that new clock id can have this fixed
> behavior to wakeup early with the assumption that userspace will go back
> to sleep, and outdated userspace can use the original alarmtimer clock
> id if they don't care about suspend failing?
> 

I don't know how to answer this. Again, I see my suggested patch as improvement
over not suspending at all or resuming at a more or less random time, which
is what you get today depending on the rtc driver.

Actually, I would argue that the above situation applies even if the rtc supports
the requested alarm time. Currently, if userspace is the one autosuspending,
the system wakes up after the alarm time expires (assuming the rtc supports it).
Then what ? Your above question applies to that situation as well and is
really independent of the alarm time limit supported by the rtc.

I would agree that various improvements on how to handle the situation where
the requested alarm time is larger than the rtc limit may be possible,
but I see those as independent and orthogonal to this patch.

> I see another problem too. What do we do if an alarmtimer is created,
> the rtc device is unregistered, and then we enter suspend? It looks like
> alarmtimer_suspend() bails out early with no error, so suspend
> continues. That looks wrong. Presumably we should fail suspend entirely
> at that point because we'll never be able to wakeup to run the
> alarmtimer.

Maybe I am missing something, but I think this is equivalent of not having
an rtc in the system, or for CONFIG_RTC_CLASS=n. Currently the system just
suspends without waking up in those situations. Changing that would be a
substantial functional change since suddenly systems without rtc would
simply fail to suspend if there is a pending alarm.

Thanks,
Guenter

