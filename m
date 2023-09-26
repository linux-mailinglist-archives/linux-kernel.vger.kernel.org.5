Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB6E7AED14
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjIZMnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjIZMnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:43:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37818E5;
        Tue, 26 Sep 2023 05:43:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5344d996bedso2768329a12.3;
        Tue, 26 Sep 2023 05:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695732202; x=1696337002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hA28nfmDNZCbL4Ew/7n+0PE3pEqWXZnhkySX1hHyL4=;
        b=Kv93Zju4/FKUwKzWH79hP/4d4Batk8oKPirBimT8+9QBRDVtdQz6y+PHmtDTsaF6Bn
         8PJHey3yotRq7f80QaoDSgzVVwfql+EbVkHE+c9gSRkAvtMy2g9KHhxE/ex+Ylim0onE
         BeoexZpjuj9MwmC1glCxLh8moMrTmyC/Htloj6vpJxGF1EevZEwc5hEVWGrp6JQ/7YS2
         /EjxonCreYv9CaHK8tIsGyfQUoLLA7bV22RvQR9Q6j6EcVppiD6lahRGQo4hZUPEn4+z
         oZjiGOLschMqQKaOQG2CNhNJSabzS/T5ZLxkF14cYmU5EurxSaJ6CEsw1wbCeft6kP6n
         hEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695732202; x=1696337002;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hA28nfmDNZCbL4Ew/7n+0PE3pEqWXZnhkySX1hHyL4=;
        b=QGnyyYKc6a3YuGFR17s7+dQpXsa4lqx+ZKS/G591xV+5ujH6F/xNJUtcb6R86X81kb
         /z9gCO0JF01MRWtdQXXVIP+nJzRyl90i7Xyg9FY5KRF/2P4SpJx+pykstYQBIcXu7XKy
         ZMjvcjpEKMC+4MfZR7L69npaRHpL6hAzDkbwHNRusCJkDxTl1e7syOSHg5oqGG5wOqmq
         liYn4E6RxeWqed97y1mPSrvBhuMAMSbhzkR5NwxCM4nmmoHtCz6hTgJ8NpWq/TtbrHRN
         zrR10UL7nSuCUbAkbM1GnFJEvJzy2y4D9yTFFMqSsavDjGoOEgJ+8IGeOGFl8ddW4W5B
         oiyw==
X-Gm-Message-State: AOJu0Yz6BTeubo59TTFn8VJSykEVpzUn/hI+cbOBEnZVvJrJK+krAsgl
        ND3RU/RONJ1gxs/0fPW4M/gY1Bdl//w=
X-Google-Smtp-Source: AGHT+IGNoam+P9Q0Tdh3q3qXJ2zE2RGt+wQ8R2+1xFs1gsVP2rUGMVnrwZIrAT0CNxOm20fyT33QLQ==
X-Received: by 2002:a05:6402:150d:b0:530:8801:47aa with SMTP id f13-20020a056402150d00b00530880147aamr8268057edw.19.1695732202444;
        Tue, 26 Sep 2023 05:43:22 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id l24-20020aa7c318000000b00533349696f1sm6736617edq.16.2023.09.26.05.43.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 05:43:22 -0700 (PDT)
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
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <1715e2bf-5d02-4f20-1476-29a1fdf350b1@gmail.com>
Date:   Tue, 26 Sep 2023 15:43:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ZRKFUb1vRtn82bgn@gofer.mess.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.09.23 г. 10:16 ч., Sean Young wrote:
> On Mon, Sep 25, 2023 at 07:06:44PM +0300, Ivaylo Dimitrov wrote:
>> On 1.09.23 г. 17:18 ч., Sean Young wrote:
>>> The ir-rx51 is a pwm-based TX driver specific to the N900. This can be
>>> handled entirely by the generic pwm-ir-tx driver, and in fact the
>>> pwm-ir-tx driver has been compatible with ir-rx51 from the start.
>>>
>>
>> Unfortunately, pwm-ir-tx does not work on n900. My investigation shows that
>> for some reason usleep_range() sleeps for at least 300-400 us more than what
>> interval it is requested to sleep. I played with cyclictest from rt-tests
>> package and it gives similar results - increasing the priority helps, but I
>> was not able to make it sleep for less that 300 us in average. I tried
>> cpu_latency_qos_add_request() in pwm-ir-tx, but it made no difference.
>>
>> I get similar results on motorola droid4 (OMAP4), albeit there average sleep
>> is in 200-300 us range, which makes me believe that either OMAPs have issues
>> with hrtimers or the config we use has some issue which leads to scheduler
>> latency. Or, something else...
> 
> The pwm-ir-tx driver does suffer from this problem, but I was under the
> impression that the ir-rx51 has the same problem.
> 

Could you elaborate on the "pwm-ir-tx driver does suffer from this 
problem"? Where do you see that?

ir-rx51 does not suffer from the same problem (albeit it has its own 
one, see bellow)

>> In either case help is appreciated to dig further trying to find the reason
>> for such a big delay.
> 
> pwm-ir-tx uses usleep_range() and ir-rx51 uses hrtimers. I thought that
> usleep_range() uses hrtimers; however if you're not seeing the same delay
> on ir-rx51 then maybe it's time to switch pwm-ir-tx to hrtimers.
> 

usleep_range() is backed by hrtimers already, however the difference 
comes from how hrtimer is used in ir-rx51: it uses timer callback 
function that gets called in softirq context, while usleep_range() puts 
the task in TASK_UNINTERRUPTIBLE state and then calls 
schedule_hrtimeout_range(). For some reason it takes at least 200-400 us 
(on average) even on OMAP4 to switch back to TASK_RUNNING state.

The issue with ir-rx51 and the way it uses hrtimers is that it calls 
pwm_apply_state() from hrtimer function, which is not ok, per the 
comment here 
https://elixir.bootlin.com/linux/v6.6-rc3/source/drivers/pwm/core.c#L502

I can make pwm-ir-tx switch to hrtimers, that's not an issue, but I am 
afraid that there is some general scheduler or timers (or something 
else) issue that manifests itself with usleep_range() misbehaving.

> I don't have a n900 to test on, unfortunately.
> 

I have and once I have an idea what's going on will port pwm-ir-tx to 
hrtimers, if needed. Don't want to do it now as I am afraid the 
completion I will have to use will have the same latency problems as 
usleep_range()

Thanks,
Ivo

> Thanks
> Sean
> 
