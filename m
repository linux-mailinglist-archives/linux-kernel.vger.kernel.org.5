Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589DF7ADCAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjIYQHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYQHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:07:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EE7FF;
        Mon, 25 Sep 2023 09:06:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso10989868e87.1;
        Mon, 25 Sep 2023 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695658008; x=1696262808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjZKX49WJeWkaYPbNflpa2QWaqaLadeSJAuUwOEodTY=;
        b=K2ANID33kOdxOpUxB3MgFwKFezipaVNhlsNOPpja4SZ+AhZ/Nj9KLQAT+J5RSNrrUJ
         UX8NxTSdd2oBj7G2sOyik0xh0WtGuABS3X1d13EY2zCIfDvhOTKV98aX4LiEfnQXEcQf
         7XREOQd9TamEyo4g9M+EBrmt0AsrHWxoxrrsVBiG6t5YMu52N2yWqLyQue5K5PDsfdTv
         xwQYnCo/JvkjQHSvC5Afp8Ngpzps3sh43qVahgpceJGQkoFNUPYAbkeIhghTcUX2VLTG
         7FlnRQ5Ohnm+450Y/YND3U1wJnvJlCodk+bRWwXpjpAc7VAchmBnI/xn25SyWYvcA6U1
         g/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695658008; x=1696262808;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FjZKX49WJeWkaYPbNflpa2QWaqaLadeSJAuUwOEodTY=;
        b=SOLIEkLXjaPcC2A86TD6RHkQyP2l0w5tDEW3/g6t7ipwTGCh3tp2iJW8yXLuIsbPIO
         vL4woBBaTukneuQZlGKEmCPHwcu/r76pc4C+2Qo6k7WGRoYcaF9c9NmTiVkuHn2UxfWX
         ULSvK8/ZLKTXYc7AbwbnudQncz1tbEEZNTe3worFmGsyltBydwgtn15QoFdvJmzwN4Mb
         ilZbMw4uOrkL6oqd3Sa7rL2fUvOXjxLVyXoeLPZVofDk+2SPhDGRoRAiPRlZmhYDd5vf
         l+NIreYS5BRhzo0ALG21Ni9/hpfhQWms4a9UsQBSnq80+kFUJqWC56/63jXgmdpoRbas
         98Vw==
X-Gm-Message-State: AOJu0YzEtSvDkl+5qzwriJ4ysfUvimux6ZUKqdIbi3Wv5TikK9m6rgdR
        ewbVQGOoTVDKr5Lmd++FCWevgLX0sso=
X-Google-Smtp-Source: AGHT+IH0wCeQkCSpQeBTRA9+Npw8GsrZOWLPf6GO4bZlYYGot9Sw0NpfireqAbkt3KX+f2GH23iRxA==
X-Received: by 2002:a05:6512:3b2a:b0:500:780b:5bdc with SMTP id f42-20020a0565123b2a00b00500780b5bdcmr6788554lfv.49.1695658007769;
        Mon, 25 Sep 2023 09:06:47 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id h20-20020a0564020e9400b0053441519ed5sm542151eda.88.2023.09.25.09.06.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Sep 2023 09:06:47 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] media: rc: remove ir-rx51 in favour of generic
 pwm-ir-tx
To:     Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Timo Kokkonen <timo.t.kokkonen@iki.fi>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        "Sicelo A . Mhlongo" <absicsz@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <cover.1693577725.git.sean@mess.org>
 <e5325e826935f0bd8566152b6a5fa799b2429d43.1693577725.git.sean@mess.org>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <99f0042f-538c-bcaf-96fd-bac24a87f88e@gmail.com>
Date:   Mon, 25 Sep 2023 19:06:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e5325e826935f0bd8566152b6a5fa799b2429d43.1693577725.git.sean@mess.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.09.23 г. 17:18 ч., Sean Young wrote:
> The ir-rx51 is a pwm-based TX driver specific to the N900. This can be
> handled entirely by the generic pwm-ir-tx driver, and in fact the
> pwm-ir-tx driver has been compatible with ir-rx51 from the start.
> 

Unfortunately, pwm-ir-tx does not work on n900. My investigation shows 
that for some reason usleep_range() sleeps for at least 300-400 us more 
than what interval it is requested to sleep. I played with cyclictest 
from rt-tests package and it gives similar results - increasing the 
priority helps, but I was not able to make it sleep for less that 300 us 
in average. I tried cpu_latency_qos_add_request() in pwm-ir-tx, but it 
made no difference.

I get similar results on motorola droid4 (OMAP4), albeit there average 
sleep is in 200-300 us range, which makes me believe that either OMAPs 
have issues with hrtimers or the config we use has some issue which 
leads to scheduler latency. Or, something else...

In either case help is appreciated to dig further trying to find the 
reason for such a big delay.

Regards,
Ivo
