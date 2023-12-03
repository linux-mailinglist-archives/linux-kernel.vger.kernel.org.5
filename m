Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33FE80212F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjLCFnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 00:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjLCFnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 00:43:13 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7083BFA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 21:43:19 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1fa26074783so1461922fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 21:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701582198; x=1702186998; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ulpex2/K0nFLvwaganrs1elk8GQQ5l+5GEHyn5YwooQ=;
        b=ZBPy5tGpyqv3pIHbfgR41j4KsfESZ6uofHwtr1GzZblT1RTsUqsR0UfEshMJQykWGU
         E5hYDSpGJWD6AZRnKd0wuwfgaBORSgLipg/XHLCRMae+KzpxNAFaCfrsM+Htv1eGRN9r
         WTNdFiB8GmbCd6zO6F8JUyqKd/Cy1IT8wUbbq28Cew/xR2PyCtT/gEoXea75ulElRqpc
         kGSDkkea59/oAhmVVJyxdRoi/gazS8a/R/Z4mbwv1/VxkOgKwnSKKBTdrQ1CIYIYhx04
         pjRx1s09xeRadnFW9Tg42CD8H4YIKoN0ZA1YWDn89kFdtpkoQdmvl6FVF155m9KZa3q9
         jtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701582198; x=1702186998;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ulpex2/K0nFLvwaganrs1elk8GQQ5l+5GEHyn5YwooQ=;
        b=Q1+QzrslHGnVemurFAUuzBIkbvKUOQSlAiAkt1MVD2Vf4rSwojVuO9pTjb/R9gJRJl
         05zYXV5okUWMphz+kjKMtpLr3/6O4RMoHQGUPQRAvC36zhhOoLjZ18X1oVaxmW++Fp0z
         ZAsWk1ocEkLz2s/3xIeV4Wsh8i+dadYK3XW8/aeMb3mV4zhaXnOuQC8aXvFRJo/AZqmk
         JLoaHbiRJL71EZmq7c7+YfzJBErtsFa8MO2xdrbvcgiQmleXRZ4gGB0cqPe85j7zdjo/
         Zg9Ma11jUjFq5fEI06Jcy91psjmrjcHonPcFK+vhu/IKy1ilLpRGJykeOsdix1lI8fAf
         AP5g==
X-Gm-Message-State: AOJu0YzVXc0G4WsIAVuI9L/T+n5OJ2JNEGYT+VtwGlH/nmMMiYzKRWue
        W6k89iSF++FvfS4MxmWBg4x7S5yMm4Wb/A==
X-Google-Smtp-Source: AGHT+IHw+PS2DOyoNngsHLoHfwVNHqBw9yoPg6sTyYXO+vualSGM3APgi04B0s49HgFnLD/jC6UXmg==
X-Received: by 2002:a05:6870:d24a:b0:1fb:22f4:c49d with SMTP id h10-20020a056870d24a00b001fb22f4c49dmr1342317oac.23.1701582198569;
        Sat, 02 Dec 2023 21:43:18 -0800 (PST)
Received: from cuiyangpei ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id a1-20020a656041000000b005891f3af36asm4872025pgp.87.2023.12.02.21.43.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Dec 2023 21:43:18 -0800 (PST)
Date:   Sun, 3 Dec 2023 13:43:13 +0800
From:   cuiyangpei <cuiyangpei@gmail.com>
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     xiongping1@xiaomi.com
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <20231203054313.GA14316@cuiyangpei>
References: <20231201122507.GA15806@cuiyangpei>
 <20231201173112.64300-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201173112.64300-1-sj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 05:31:12PM +0000, SeongJae Park wrote:
> Hi Cuiyangpei,
> 
> On Fri, 1 Dec 2023 20:25:07 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> 
> > On Thu, Nov 30, 2023 at 07:44:20PM +0000, SeongJae Park wrote:
> > > Hi Cuiyangpei,
> > > 
> > > On Thu, 30 Nov 2023 17:14:26 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:
> > > 
> > > > Hi SeongJae,
> > > > 
> > > > We also investigated the operation schemes you mentioned, but we don't
> > > > think it can fit our needs.
> > > > 
> > > > On android, user will open many apps and switch between these apps as
> > > > needs. We hope to monitor apps' memory access only when they are on
> > > > foreground and record the memory access pattern when they are switched
> > > > to the background. 
> > > > 
> > > > When avaliable memory reaches a threshold, we will use these access
> > > > patterns with some strategies to recognize those memory that will have
> > > > little impact on user experience and to reclaim them proactively.  
> > > > 
> > > > I'm not sure I have clarified it clearly, if you still have questions
> > > > on this, please let us know.
> > > 
> > > So, to my understanding, you expect applications may keep similar access
> > > pattern when they are in foreground, but have a different, less aggressive
> > > access pattern in background, and therefore reclaim memory based on the
> > > foreground-access pattern, right?
> > >
> > 
> > Different apps may have different access pattern. On android, the apps will
> > join in freeze cgroup and be frozen after switch to the background. So we 
> > monitor apps' memory access only when they are in foreground.
> 
> Thank you for this enlightening me :)
> 
> > > Very interesting idea, thank you for sharing!
> > > 
> > > Then, yes, I agree current DAMOS might not that helpful for the situation, and
> > > this record feature could be useful for your case.
> > > 
> > > That said, do you really need full recording of the monitoring results?  If
> > > not, DAMOS provides DAMOS tried regions feature[1], which allows users get the
> > > monitoring results snapshot that include both frequency and recency of all
> > > regions in an efficient way.  If single snapshot is not having enough
> > > information for you, you could collect multiple snapshots.
> > > 
> > > You mentioned absence of Python on Android as a blocker of DAMOS use on the
> > > previous reply[2], but DAMOS tried regions feature is not depend on tracepoints
> > > or Python.
> > > 
> > > Of course, I think you might already surveyed it but found some problems.
> > > Could you please share that in detail if so?
> > > 
> > DAMOS tried regions feature you mentioned is not fully applicable. It needs to
> > apply schemes on regions. There is no available scheme we can use for our use
> > case. What we need is to return regions with access frequency and recency to
> > userspace for later use.
> 
> 
> Thank you for the answer, I understand your concern.  One of the available
> DAMOS action is 'stat'[1], which does nothing but just count the statistic.
> Using DAMOS scheme for any access pattern with 'stat' action, you can extract
> the access pattern via DAMOS tried regions feature of DAMON sysfs interface,
> without making any unnecessary impact to the workload.
> 
> Quote from [2]:
> 
>     The expected usage of this directory is investigations of schemes' behaviors,
>     and query-like efficient data access monitoring results retrievals. For the
>     latter use case, in particular, users can set the action as stat and set the
>     access pattern as their interested pattern that they want to query.
> 
> For example, you could
> 
> # cd /sys/kernel/mm/damon/admin
> #
> # # populate directories
> # echo 1 > kdamonds/nr_kdamonds; echo 1 > kdamonds/0/contexts/nr_contexts;
> # echo 1 > kdamonds/0/contexts/0/schemes/nr_schemes
> # cd kdamonds/0/contexts/0/schemes/0
> #
> # # set the access pattern for any case (max as 2**64 - 1), and action as stat
> # echo 0 > access_pattern/sz/min
> # echo 18446744073709551615 > access_pattern/sz/max
> # echo 0 > access_pattern/nr_accesses/min
> # echo 18446744073709551615 > access_pattern/nr_accesses/max
> # echo 0 > access_pattern/age/min
> # echo 18446744073709551615 > access_pattern/age/max
> # echo stat > action
> 
> And this is how DAMON user-space tool is getting the snapshot with 'damo show'
> command[3].
> 
> Could this be used for your case?  Please ask any question if you have :)
> 
> [1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n
> [2] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n-tried-regions,
> [3] https://github.com/awslabs/damo/blob/next/USAGE.md#damo-show

Thank you for your detailed response, it is very helpful to us. We will look into it
and contact you if we have any questions.

> 
> 
> Thanks,
> SJ
> 
> > > [1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#schemes-n-tried-regions 
> > > [2] https://lore.kernel.org/damon/20231129131315.GB12957@cuiyangpei/
> > > 
> > > 
> > > Thanks,
> > > SJ
> > > 
> > > > 
> > > > Thanks.
