Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CF07A3389
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 03:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbjIQBFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 21:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjIQBF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 21:05:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A2E1A5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 18:05:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-404571cbb8dso34866535e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 18:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694912719; x=1695517519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/pQuCGgxzF9AsCBKNkJ7L4cEdQKndjj38XlHX9F4meo=;
        b=rH83utkwXJqM9RpbaM4ywrHty1wIbfrZ3hRadDA8H1zAmorsePeVyyysFc5KiddbKN
         uqFVnrCPs0BV8seEhep4pt8PrsyZKGWxD529ubb7C9irmFhuqrKSpiCy7hiemdlvxwbq
         ByNWXNOKWO15swLAQ4qxz/3LgAm7ZqlzqXy/0kVMGgI/9bnszr+IsHzsqSRmAls4FjiC
         nDEYTFK5Rskxb2oH44WQ4jLMcmz75PBIMJ0nfOugfX2NnuHGa6a8nAxi6jZkdOegQfUG
         olNjIlVy7AI30hiRLZ9jbL/LPKjXPLsjs1cUeG+4CMo2CZoFXr0+a1v+OZuQWY5gG0zT
         saVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694912719; x=1695517519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pQuCGgxzF9AsCBKNkJ7L4cEdQKndjj38XlHX9F4meo=;
        b=pU0R9cq1DfDyBUhmfSU4RgY+n+6EsE0clq9tE2gy0BESTN53P/QzT2ESVRzIOtBQtg
         4S0Xfh3F32SkNSlPJJOZwqHyJe87UInVSM4t6D6FTzPlmmjGzIWxqvXaBSOCl2yqjH/k
         9NREtS1U7i+MM+HEBdD6+xrlHWHRu2pmf5I0Q31F0hW8qcYCpgas84LFLqClsdmJefie
         27w/k0sXLZHXIJSlhN3bTgksgUUKRQjDtNazpz8mhWQN5z9dFKmLHDAX/0woNoam6hej
         RJfT01z+56idXaDp212g9bVUke9jKQi2WyZI+sq1fw8HfEIcJZw8tiv/9DqMeZS5uf3p
         YnYA==
X-Gm-Message-State: AOJu0Yw/OAOx9TqhlUYMtmrzyeSVCPqjTAPrHt8UTq3NLqAYoZean1UZ
        fpjE+NlBC65kc+lx/D5A3w1AWA==
X-Google-Smtp-Source: AGHT+IEkP8tCGIgme+/MmmbYafSgpi51x2fL2+vu0U+kM/pXGUYe4j/cp6sUgeiddgWUWF0/rVlvXA==
X-Received: by 2002:a05:600c:ac8:b0:402:f54d:745 with SMTP id c8-20020a05600c0ac800b00402f54d0745mr4594745wmr.17.1694912718966;
        Sat, 16 Sep 2023 18:05:18 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c220700b00403038d7652sm8506706wml.39.2023.09.16.18.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 18:05:18 -0700 (PDT)
Date:   Sun, 17 Sep 2023 02:05:16 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
Message-ID: <20230917010516.54dgcmms44wyfrvx@airbuntu>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com>
 <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kajetan

On 07/18/23 14:24, Qais Yousef wrote:

> These patches are in GKI. So we'll if there are uncaught problems I guess :)
> 
> No appetite for a knob, but the very low value for littles did strike me and
> thought I better ask at least. Today's littles are too tiny for their own good
> and it seemed the threshold could end up being too aggressive especially in low
> activity state. You effectively are saying that if we have few 100us of
> activity, normal TEO predictions based on timers are no good and better to stay
> shallower anyway.
> 
> Note that due to NOHZ, if we go to idle for an extended period the util value
> might not decay for a while and miss some opportunities. Especially that when
> it next wakes up, it's enough for this wake up to run for few 100s us to block
> a deeper state before going back to sleep for extended period of time.
> 
> But we shall see. I got the answer I was looking for for now.

Unfortunately not too long after the patches got merged I got regression report
of worse power. As you know on Android things are not as mainline, so I need to
untangle this to make sure it's not a red herring. But if you want to take my
word for it, I think the chances of it being a true regression is high. I had
to introduce knobs to allow controlling the thresholds for now, so the good
news they do help and it's not a total revert. I don't have a lot of info to
share, but it's the low activity use cases that seem to got impacted. Like
video playback for instance.

Generally, I'm trying to remove some hardcoded values from the scheduler that
enforces a behavior that is not universally desired on all systems/workloads.
And I think the way the util awareness threshold are done today fall into the
same category.

As I tried to highlight before, it is easy to trick the threshold by a task
that runs for a short time then goes back to sleep for a long time.

And when the system runs full throttle for a while, it'll take around 150+ms
for the util to decay to the threshold value. That's a long time to block
entering deeper idle states for. I'm not sure how NOHZ and blocked averaged
updates can make this potentially worse.

In my view, the absolute comparison against util can be misleading. Even when
util is 512 for example, we still have 50% of idle time. How this time is
distributed can't be known from util alone. It could be one task waking up and
sleeping. It could be multiple tasks at many combination of patterns all
leading to the same outcome of CPU util being 512.

IIUC the idea is that if we have even small activity, then erring on the
shallow side is better. But given that target-residency is usually in few ms
range, do we really need to be that quite? With a target-residency of 3ms for
example, even at util of 900 there can be opportunities to enter it.

Can't we instead sample util at entry to idle loop and see if it is on a rising
or falling trend? When rising it makes sense to say there's demand, let's block
deeper idle state. But if it is falling, then if the decay time is longer than
target-residency we can say it's okay to permit the deeper idle states?

I need to think more about this; but I think it's worth trying to make these
thresholds more deterministic and quantifiable. There are too many workloads
and system variations. I'm not sure if a knob to control these thresholds is
good for anything but a workaround like I had to do. These hardcoded values
can be improved IMHO. Happy to help to find alternatives.


Cheers

--
Qais Yousef
