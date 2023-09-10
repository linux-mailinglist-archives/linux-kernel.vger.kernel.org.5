Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73814799F4C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 20:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjIJSO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 14:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjIJSO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 14:14:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D910718E
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 11:14:22 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-403012f276dso14405655e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694369661; x=1694974461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=icIgELLog2G9Vw36oIaIvquI+JCNvgmeTDovopl0gM4=;
        b=uzWwZda4vbWiqYbTS9vo6y1lUsZhpalX3Brjj/eOAbH1zkNHGEK78vLFvjr1ySsZlI
         /njfyglmU7qsbYharEJMdVuXb90u/kk9bndL9cZMMIJEZKi8q/u4z5wa/pXFeY4pnG0Z
         AJAfFlKXVyHqA/BYi5X/QRoH044Yo8k/cU+IkLEnAAigILh6mS1dwofTLvj8iweVs/8v
         rUHfl3/f8t8zLJLjimfUAOy7u1a7aCHqKVYzmuiL2n3Gbpl8Pbz5GIqftfxTlj3v2bhK
         aUZbHBrjwDmPqg0RDgpr+jtufAtDMoo9E6R5TpjUgIeywOXILU+H6a3P0m6LxkKga53d
         Qtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694369661; x=1694974461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icIgELLog2G9Vw36oIaIvquI+JCNvgmeTDovopl0gM4=;
        b=H/fC4Mbv+/nGHckImJKJazTCtjvCP9NrUadn5V5u1FTFLxPX3WfnCPCV5zcqvE/q2M
         jgoSBOwcL8zeld1fmuBKbm7JZL5daTVdXx8DdgSKGovbLeNSPfEM62IjJA898304tBos
         jE3ej572MIWBTzZKoMgOh0t0u7Q6ddW84VWksMIthQ739NnWItqGy7ZVQAksdRdOgnRA
         JQmRoG6jC+aUyBllesGNHGrq7MP9WytikMfvOyeudlGz7dtGoMhOHPJCukg6n/M5AEtw
         Y+rKVUyPHepFTU7Z/i8sVHPUguJME/o+VV06abXes1CTGXbQ7z4OmQ+zFYyKZJS1c4Ml
         nWhw==
X-Gm-Message-State: AOJu0Yy7hkGaa5inI9FyV3pIM1YR1pfF6dOhPh4Ori/FICv1ZNxuPjIc
        dbzQO3VYfnpmAPrcdfCkiPhWGbyIuTahV+jNOCY=
X-Google-Smtp-Source: AGHT+IHMgh8B4pIBXdkf7i7qD3RpzTmN0Qz0dF0cbhkghHfrWHzh1ZvPTV0PryGBP8Rswp+/hHdM5Q==
X-Received: by 2002:a7b:cd15:0:b0:401:cb45:3fb8 with SMTP id f21-20020a7bcd15000000b00401cb453fb8mr6521997wmj.38.1694369661255;
        Sun, 10 Sep 2023 11:14:21 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bca46000000b00401dc20a070sm10859189wml.43.2023.09.10.11.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 11:14:20 -0700 (PDT)
Date:   Sun, 10 Sep 2023 19:14:19 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230910181419.ljejml3qazom2jgt@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
 <6011d8bb-9a3b-1435-30b0-d75b39bf5efa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6011d8bb-9a3b-1435-30b0-d75b39bf5efa@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/23 08:48, Lukasz Luba wrote:

> They are periodic in a sense, they wake up every 16ms, but sometimes
> they have more work. It depends what is currently going in the game
> and/or sometimes the data locality (might not be in cache).
> 
> Although, that's for games, other workloads like youtube play or this
> one 'Yahoo browser' (from your example) are more 'predictable' (after
> the start up period). And I really like the potential energy saving
> there :)

It is more complicated than that from what I've seen. Userspace is sadly
bloated and the relationship between the tasks are a lot more complex. They
talk to other frame work elements, other hardware, have network elements coming
in, and specifically for gaming, could be preparing multiple frames in
parallel. The task wake up and sleep time is not that periodic. It can busy
loop for periods of time, other wake up for short periods of time (pattern of
which might not be on point as it interacts with other elements in a serial
manner where one prepared something and can take variable time every wake up to
prepare it before handing it over to the next task).

Browsers can be tricky as well as when user scrolls what elements appear and
what java script will execute and how heavy it is, and how many tabs are have
webpages being opened and how the user is moving between them.

It is organized chaos :-)

> 
> > 
> > I think the model of a periodic task is not suitable for most workloads. All
> > of them are dynamic and how much they need to do at each wake up can very
> > significantly over 10s of ms.
> 
> Might be true, the model was built a few years ago when there wasn't
> such dynamic game scenario with high FPS on mobiles. This could still
> be tuned with your new design IIUC (no need extra hooks in Android).

It is my perception of course. But I think generally, not just for gaming,
there are a lot of elements interacting with each others in a complex way.
The wake up time and length is determined by these complex elements; and it is
a very dynamic interaction where they could get into steady state for a very
short period of time but could change quickly. As an extreme example a player
could be standing in empty room doing nothing but another player in another
part of the world launches a rocket on this room and we'd get to know when the
network packet arrives that we have to draw a big explosion.

A lot of workloads are interactive and these moments of interactions are the
challenging ones.

> 
> > 
> > > 2. Plumb in this new idea of dvfs_update_delay as the new
> > >     'margin' - this I don't understand
> > > 
> > > For the 2. I don't see that the dvfs HW characteristics are best
> > > for this problem purpose. We can have a really fast DVFS HW,
> > > but we need some decent spare idle time in some workloads, which
> > > are two independent issues IMO. You might get the higher
> > > idle time thanks to 1.1. but this is a 'side effect'.
> > > 
> > > Could you explain a bit more why this dvfs_update_delay is
> > > crucial here?
> > 
> > I'm not sure why you relate this to idle time. And the word margin is a bit
> > overloaded here. so I suppose you're referring to the one we have in
> > map_util_perf() or apply_dvfs_headroom(). And I suppose you assume this extra
> > headroom will result in idle time, but this is not necessarily true IMO.
> > 
> > My rationale is simply that DVFS based on util should follow util_avg as-is.
> > But as pointed out in different discussions happened elsewhere, we need to
> > provide a headroom for this util to grow as if we were to be exact and the task
> > continues to run, then likely the util will go above the current OPP before we
> > get a chance to change it again. If we do have an ideal hardware that takes
> 
> Yes, this is another requirement to have +X% margin. When the tasks are
> growing, we don't know their final util_avg and we give them a bit more
> cycles.
> IMO we have to be ready always for such situation in the scheduler,
> haven't we?

Yes we should. I think I am not ignoring this part. Hope I clarified things
offline.


Cheers

--
Qais Yousef
