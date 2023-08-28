Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E743778A382
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjH0XgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjH0Xft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:35:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C4F19B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:35:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so24186575e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693179326; x=1693784126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5y6/ZTjfXJEZbiKUq7WiVLqlVma4fac9mBsqpVtToc=;
        b=Y+xN6CskKFlhmnznfmJANIYNZI/rBGg0IytL+b7I6Prqr2/PZa9zDAeilCxz5UEzhC
         uKpkDYhdrtEzqLfGSZevY+E2VbxaQ3wraLYdFmGP7peBfJYA6jRXniMSUheCvixmXF4m
         XwKUtu6Nm4PxjGHpu03M2e5C+ZO+30RwBDmnVJPBrQLz+Z9jj2jEhlmuIdQ6QhiXBGvh
         Z2tnwLaYO1SupFQGAqQLgieByrPF9QyKHtG9zkv+UwwX0TNwYDmZTpc8PiLqRhisVkew
         e729/B2D9V/fUPjsEcZUNFqJ49LI6svji101PpBPMv7ytDmxQZhBOEcADJmjZLP/Bd8w
         lgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693179326; x=1693784126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5y6/ZTjfXJEZbiKUq7WiVLqlVma4fac9mBsqpVtToc=;
        b=CdZjSTkuS759vPmQI7oTM9c2jl3OAy+OSU/npBh+0GX6Mb9JV4iR8C6ODqG2zNKmow
         8kQ1M6G4L35BIXXQBBFZImeu9edpPUvltl6kIdV0POaxgHIQZIgmm7OVOsXeC+tTgd9l
         qjjZH8Vy5Gk14rGKhu3VhcB3HdwC91+rupWzcZ/EwkN48x2DxPjREGh07ItUV89PMiIy
         4wnV4NoOb7WNUEY/A5O3P2oMMOgHAqACils8x/igmSuVZfZXTsCSSMYIlU1z3EXOe3Fa
         DpsKkTeo91PugdZMQljDGgT8LTISuoZWZYYc3AkZIJh5CAGPodgzI+OlI2EMqrAPfrS3
         vpiw==
X-Gm-Message-State: AOJu0YwNAZxR+ZQaMYAhYWOA9dj3d3MN5tzYj7AzEVzqse/ogWGlfBhz
        WcUYLv13oI1hYKE3B8RfrSyYcw==
X-Google-Smtp-Source: AGHT+IGx8pXa4uGgS+za3PgW3mU2GQ0Sq4+vpbherXwwFbaV+ELmK+8aQ44JoxJym3E9cwbahi0oBA==
X-Received: by 2002:a1c:7510:0:b0:3fb:c9f4:150e with SMTP id o16-20020a1c7510000000b003fbc9f4150emr19786178wmc.14.1693179326021;
        Sun, 27 Aug 2023 16:35:26 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id a13-20020a05600c224d00b003fefca26c72sm9061716wmm.23.2023.08.27.16.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 16:35:25 -0700 (PDT)
Date:   Mon, 28 Aug 2023 00:35:24 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Greg KH <greg@kroah.com>
Cc:     stable@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Backport rework of deadline bandwidth restoration
 for 6.4.y
Message-ID: <20230827233524.7anzxffj4v7srxzd@airbuntu>
References: <20230821221956.698117-1-qyousef@layalina.io>
 <2023082742-dad-henna-cb35@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023082742-dad-henna-cb35@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/23 10:34, Greg KH wrote:
> On Mon, Aug 21, 2023 at 11:19:50PM +0100, Qais Yousef wrote:
> > This is a backport of the series that fixes the way deadline bandwidth
> > restoration is done which is causing noticeable delay on resume path. It also
> > converts the cpuset lock back into a mutex which some users on Android too.
> > I lack the details but AFAIU the read/write semaphore was slower on high
> > contention.
> > 
> > Compile tested against some randconfig for different archs. Only boot tested on
> > x86 qemu.
> > 
> > Based on v6.4.11
> > 
> > Original series:
> > 
> > 	https://lore.kernel.org/lkml/20230508075854.17215-1-juri.lelli@redhat.com/
> > 
> > Thanks!
> 
> All backports now queued up, thanks for doing this work!

And thanks for your patience!

--
Qais Yousef
