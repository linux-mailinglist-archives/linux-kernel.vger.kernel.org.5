Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D28761C33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjGYOq4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 10:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjGYOqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:46:54 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2242319B;
        Tue, 25 Jul 2023 07:46:53 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-583f99641adso26075787b3.2;
        Tue, 25 Jul 2023 07:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690296412; x=1690901212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kxOdPyZyaJv5gxG+QtuGeWvPDhLsU0ZIVKhTdMmlNw=;
        b=X0LxQB7X99KnCUyv3+DnZNuo4sUL6GUapEvNdqPxoRlDaJc0KKREC6yn+Q2BEmaIfh
         8ah2YYrxZWyOmgVTlydnhN7OBzppK4+JebbHdWFfQVRMX1mdgaZPcJiQF71C88tOD0PU
         UidLKUFhvy+LiswFphm4q7XSRGODrxb2a7z9TYT7ACrdlBM2nrx0H+0OwPv2p0msaylM
         tpMJ26mAq6eMBtct86spgV+KqNi2XVhMA59eTwp6e2JGo6iTvBG9UjrRoPcT3T4MWWGW
         u0Iv+U6Tajs4F1igevacOMYyYR+HbITRRZCGXGEdvctPsDtDZQ30oqQ4pZPMR0FPxNNx
         WwLA==
X-Gm-Message-State: ABy/qLajEW7uKuAXzjkAqvo7amR6RbIhfrWJVOxDk3xscmhiIx4TZJ7+
        sx8YW0Nq1AFPM8Zo0E/pNsxMPWhzwic/yg==
X-Google-Smtp-Source: APBJJlH1/GgAaLm9I9Ev8XypDOwyhl9MGgeOHlP1baA0DBCE4RSWv5XEN2Nh+/7ily0Yqg7c+bgjgA==
X-Received: by 2002:a0d:c8c7:0:b0:57d:24e9:e7f3 with SMTP id k190-20020a0dc8c7000000b0057d24e9e7f3mr8176525ywd.38.1690296412031;
        Tue, 25 Jul 2023 07:46:52 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id j131-20020a819289000000b00570253fc3e5sm3544519ywg.105.2023.07.25.07.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 07:46:51 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso4820537276.0;
        Tue, 25 Jul 2023 07:46:51 -0700 (PDT)
X-Received: by 2002:a05:6902:1350:b0:c83:27d4:c0d6 with SMTP id
 g16-20020a056902135000b00c8327d4c0d6mr8607825ybu.37.1690296411349; Tue, 25
 Jul 2023 07:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230511181931.869812-1-tj@kernel.org> <20230511181931.869812-7-tj@kernel.org>
 <ZF6WsSVGX3O1d0pL@slm.duckdns.org> <CAMuHMdVCQmh6V182q4g---jvsWiTOP2hBPZKvma6oUN6535LEg@mail.gmail.com>
 <CAMuHMdW1kxZ1RHKTRVRqDNAbj1Df2=v0fPn5KYK3kfX_kiXR6A@mail.gmail.com>
 <ZK3MBfPS-3-tJgjO@slm.duckdns.org> <ZK30CR196rs-OWLq@slm.duckdns.org>
 <CAMuHMdUCXPi+aS-7bR3qRetKF9T3W9jk_HKjvaXmfHv5SEeuFg@mail.gmail.com>
 <ZLXIvXBvhsnL-ik_@slm.duckdns.org> <CAMuHMdU8CGhsU-1PZNdWH1xjbWcWSg2s2RFAegXi+vs=d-0t8Q@mail.gmail.com>
 <ZLcLnoAoJmQ9WTuM@slm.duckdns.org>
In-Reply-To: <ZLcLnoAoJmQ9WTuM@slm.duckdns.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jul 2023 16:46:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUo=17kYsNEYr=qyVceRpJ4D3jMFrMOiqaH--OOhJOM4w@mail.gmail.com>
Message-ID: <CAMuHMdUo=17kYsNEYr=qyVceRpJ4D3jMFrMOiqaH--OOhJOM4w@mail.gmail.com>
Subject: Re: Consider switching to WQ_UNBOUND messages (was: Re: [PATCH v2
 6/7] workqueue: Report work funcs that trigger automatic CPU_INTENSIVE mechanism)
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@meta.com, Linux PM list <linux-pm@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rtc@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Wed, Jul 19, 2023 at 12:01 AM Tejun Heo <tj@kernel.org> wrote:
> On Tue, Jul 18, 2023 at 11:54:58AM +0200, Geert Uytterhoeven wrote:
> > I gave it a try on a system with an 800 MHz Cortex A9, only to discover
> > it makes no difference, as that machine has 1600 BogoMIPS:
>
> Oops.
>
> > workqueue: blk_mq_run_work_fn hogged CPU for >10000us 4 times,
> > consider switching to WQ_UNBOUND
>
> It could be that we actually want to switch to UNBOUND for some reports but
> the above triggering most likely indicates that the threshold is too
> aggressive.
>
> > Artificially low BogoMIPS numbers only happen on systems that have
> > the related timers (Cortex A7/A15 and later, Cortex A9 MPCore,
> > and arm64).
>
> Ah, I see. Thanks for the explanation.
>
> > I will test on more systems, but that will probably not happen until
> > next week...
>
> Thanks, really appreciate it. Can you try the following instead when you
> have time? I just pushed up the lower boundary to 4000 MIPS. The scaling is
> still capped at 1s.

Thanks, with the below, I see no more WQ_UNBOUND messages.

> From 8555cbd4b22e5f85eb2bdcb84fd1d1f519a0a0d3 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Mon, 17 Jul 2023 12:50:02 -1000
> Subject: [PATCH] workqueue: Scale up wq_cpu_intensive_thresh_us if BogoMIPS is
>  below 4000

> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c

> @@ -6513,6 +6516,42 @@ void __init workqueue_init_early(void)
>                !system_freezable_power_efficient_wq);
>  }
>
> +static void __init wq_cpu_intensive_thresh_init(void)
> +{
> +       unsigned long thresh;
> +       unsigned long mips;

This fails to build on mips.
Apparently mips is a predefined preprocessor macro:

$ echo | mipsel-linux-gnu-gcc -dM -E - | grep -w mips
#define mips 1

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
