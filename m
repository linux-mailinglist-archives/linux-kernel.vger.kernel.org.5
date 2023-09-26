Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3454C7AED4F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjIZMzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjIZMzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:55:10 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091F2124;
        Tue, 26 Sep 2023 05:55:03 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ad8a822508so1088582166b.0;
        Tue, 26 Sep 2023 05:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695732901; x=1696337701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtZUjiYxLryjulqmofSoSPz/vXsvJQv9EIQwllIJJ1Q=;
        b=h8ZIpWWKZEn6JxNXgelUeup/cHgYFZFzuh2hYdfEI9OeiIxBuAuw0TvhPz8oRLh4zO
         pM8SQ8Wlg4AnBNqMLUS/5uFRX4GYBtg2gyja0cNY0p8X/XpjvHjnKUlvwgQcIzff6K42
         ZGCA07WDG1JfhxmpbBet8jInPfsB2PRia0s8OqtNn3IKZPpgrdsm696ziiNCV9UkruQm
         L7/RrWHFSOUDeRY46Z4jOG7C6S44Xbtqz11x1b/PlnEcrB+6M+wCOJCV4G1RvHDqwKPu
         Y7WCb0JEgCbZtda6I4VXeaGjpAG0JlokEHC5DhhVTyJ9dSiswPqVHEXwDEztk/h/t3hQ
         AlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695732901; x=1696337701;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YtZUjiYxLryjulqmofSoSPz/vXsvJQv9EIQwllIJJ1Q=;
        b=X+IfY2L+fT8ynDm9+/WIShlPTRlZZrbeibQQpBVOjUWY/WeUBfg2vHsCtjdwqBB0eM
         QTYtMi1NGDrTzZthst5K89saJrXZvD/i5eg9ESuGOW6s95+ZWPd53/MaZD2mgi7lM/xc
         Z7X2vWbwIWmz9wjib0P3lABP9nTShvSgk2xVfi50T7a5wmm1+CnJsIGwhZWtbV//i5QH
         dAGjkcv7UU9q/8qwOFhFWeBGhQm7wIZqyXcE8zuieJasTcDxZmNCZ46W9IFYAjzvxfH9
         d22wuJNHT0Unrr+8sfSzkXH9xbJWGh2Jol8hdWZ0QWbh7nAelJsZRY93aQW6PV0xECDx
         zm3Q==
X-Gm-Message-State: AOJu0YyEZNtLA7FlS3zYnXt8x9a8IzmVhzFAdOR2/B3Y9AXeC9XxQp6a
        y/z2Ne/ouyRGFEJPKAOOM5BKKSmP3us=
X-Google-Smtp-Source: AGHT+IEIgSOnM9nWgU3CH6MFtsFoLHrezbgSdcz6k5Y/bnAqqO4VUway+4TqF0ssjOolYPUjg/uFrw==
X-Received: by 2002:a17:906:5386:b0:9ae:614f:2037 with SMTP id g6-20020a170906538600b009ae614f2037mr9035770ejo.61.1695732901234;
        Tue, 26 Sep 2023 05:55:01 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id ez23-20020a1709070bd700b009b285351817sm1411385ejc.116.2023.09.26.05.55.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 05:55:01 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] media: rc: remove ir-rx51 in favour of generic
 pwm-ir-tx
To:     Tony Lindgren <tony@atomide.com>, Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
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
 <ZRKFUb1vRtn82bgn@gofer.mess.org> <20230926073744.GA5285@atomide.com>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <f2ca8923-2e25-3748-e44f-a5b6e7222320@gmail.com>
Date:   Tue, 26 Sep 2023 15:54:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20230926073744.GA5285@atomide.com>
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



On 26.09.23 г. 10:37 ч., Tony Lindgren wrote:
> * Sean Young <sean@mess.org> [230926 07:16]:
>> On Mon, Sep 25, 2023 at 07:06:44PM +0300, Ivaylo Dimitrov wrote:
>>> On 1.09.23 г. 17:18 ч., Sean Young wrote:
>>>> The ir-rx51 is a pwm-based TX driver specific to the N900. This can be
>>>> handled entirely by the generic pwm-ir-tx driver, and in fact the
>>>> pwm-ir-tx driver has been compatible with ir-rx51 from the start.
>>>>
>>>
>>> Unfortunately, pwm-ir-tx does not work on n900. My investigation shows that
>>> for some reason usleep_range() sleeps for at least 300-400 us more than what
>>> interval it is requested to sleep. I played with cyclictest from rt-tests
>>> package and it gives similar results - increasing the priority helps, but I
>>> was not able to make it sleep for less that 300 us in average. I tried
>>> cpu_latency_qos_add_request() in pwm-ir-tx, but it made no difference.
>>>
>>> I get similar results on motorola droid4 (OMAP4), albeit there average sleep
>>> is in 200-300 us range, which makes me believe that either OMAPs have issues
>>> with hrtimers or the config we use has some issue which leads to scheduler
>>> latency. Or, something else...
>>
>> The pwm-ir-tx driver does suffer from this problem, but I was under the
>> impression that the ir-rx51 has the same problem.
>>
>>> In either case help is appreciated to dig further trying to find the reason
>>> for such a big delay.
>>
>> pwm-ir-tx uses usleep_range() and ir-rx51 uses hrtimers. I thought that
>> usleep_range() uses hrtimers; however if you're not seeing the same delay
>> on ir-rx51 then maybe it's time to switch pwm-ir-tx to hrtimers.
> 
> Maybe using fsleep() fixes this issue? See commit c6af13d33475 ("timer: add
> fsleep for flexible sleeping"), and Documentation/timers/timers-howto.rst.
> 

I doubt, time intervals we are talking about are > 500 us, which means 
fsleep will always use usleep_range() (or even worse, msleep()), see 
https://elixir.bootlin.com/linux/v6.6-rc3/source/include/linux/delay.h#L82

> The long wake-up time for an idle state could explain the values. I think
> Ivaylo already tested with most cpuidle states disabled via sysfs though.
> 

Yes, I disabled all idle states on both n900 and droid4 (when doing 
cyclictest experiments), with no difference. I also locked frequency on 
n900 to 500MHz, which improved the things a bit, by some 20-50 us 
(IIRC), which makes sense, but also makes me think frequency scaling is 
not the one to blame either.

>> I don't have a n900 to test on, unfortunately.
> 
> If you want one for development, the maemo folks cc:ed here likely have
> some available devices.
> 

I think we can arrange one, yes, but my gut feeling tells me the issue 
is not n900 specific, it is just a bit worse there as the device is 
relatively slow already. I have no sane explanation why one would see 
similar latencies on droid4, given that it is times faster than n900.

Regards,

Ivo

> Regards,
> 
> Tony
> 
