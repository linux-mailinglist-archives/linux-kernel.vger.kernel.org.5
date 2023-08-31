Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB9B78E9B6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239949AbjHaJnx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Aug 2023 05:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjHaJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:43:52 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A015BCF2;
        Thu, 31 Aug 2023 02:43:40 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-58dce1f42d6so24752047b3.0;
        Thu, 31 Aug 2023 02:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693475020; x=1694079820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15fJYkK70EO/L01pQbhlxvsvLOdh5C+6wf2tECW+cxA=;
        b=BBhr1m1cDVSyTTpYlnoyT2KFW3qtPNpUjX8Y8dl9aVpZ8w92/P8NDjx0I9D6ZQKUJa
         LpeQTA2B2oM32VjTw2UKD8eG2Fe7X68txhelrzTflfmRjJcNANnhPJ41TbirHVbRMx1y
         Q5KUkcNnZUSy6FyzSWDvW2Cnf5nMSJhiagPSXY4J3mxiFnlTe7Fv16rHI1bAKKNpVtLi
         0V15CUZy2vQSY+p2fjVcxb5/fEFop+pp/EtOM6YPi4cc9FbKIBnhg1cx0MpzTaCMGMpN
         GjJ2wdXm5JWElggTbKpOHOraqRACs74RI+jf5JuIv9vONwE99y2t+X9ltPAvYhUiWKwz
         GMOQ==
X-Gm-Message-State: AOJu0YzVGL+QxJZUhWVJLv5CgU3tFoJ42GBYRCnqiBx+Ju07ZAo9vbOL
        uWhLwZj/d/iOdf1W1q5k8mVl8kKT2DZw/A==
X-Google-Smtp-Source: AGHT+IGV3oWpIkFQCRh6pUiD+AR9nPLL5f/86qEUlIQ9akcbu6HwX10apBOMez98Nv80e89ipFpuzQ==
X-Received: by 2002:a81:498b:0:b0:58c:5598:be97 with SMTP id w133-20020a81498b000000b0058c5598be97mr2002843ywa.15.1693475019652;
        Thu, 31 Aug 2023 02:43:39 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id b131-20020a0dd989000000b005772abf6234sm305977ywe.11.2023.08.31.02.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 02:43:39 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d7830c5b20aso785038276.0;
        Thu, 31 Aug 2023 02:43:39 -0700 (PDT)
X-Received: by 2002:a25:fc10:0:b0:d71:7d2f:c548 with SMTP id
 v16-20020a25fc10000000b00d717d2fc548mr2178292ybd.15.1693475018810; Thu, 31
 Aug 2023 02:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
 <20230819004356.1454718-2-Liam.Howlett@oracle.com> <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
 <87v8cv22jh.fsf@mail.lhotse> <CAMuHMdXMpr0spdprjwsV56nJE3vHGTFaodcnVXUa=GMYaB5yKw@mail.gmail.com>
 <6f663185-2ef1-5075-99c9-e16050329d74@bytedance.com>
In-Reply-To: <6f663185-2ef1-5075-99c9-e16050329d74@bytedance.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 31 Aug 2023 11:43:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW+wNma-Nr+595kRgZfG_fS2zgbZxJNbtcNRxnmpCJ=5w@mail.gmail.com>
Message-ID: <CAMuHMdW+wNma-Nr+595kRgZfG_fS2zgbZxJNbtcNRxnmpCJ=5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Thu, Aug 31, 2023 at 10:45 AM Peng Zhang <zhangpeng.00@bytedance.com> wrote:
> 在 2023/8/31 16:25, Geert Uytterhoeven 写道:
> > On Thu, Aug 31, 2023 at 7:39 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> >>> On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> >>>> The current implementation of append may cause duplicate data and/or
> >>>> incorrect ranges to be returned to a reader during an update.  Although
> >>>> this has not been reported or seen, disable the append write operation
> >>>> while the tree is in rcu mode out of an abundance of caution.
> >>>>
> >>>> During the analysis of the mas_next_slot() the following was
> >>>> artificially created by separating the writer and reader code:
> >>>>
> >>>> Writer:                                 reader:
> >>>> mas_wr_append
> >>>>     set end pivot
> >>>>     updates end metata
> >>>>     Detects write to last slot
> >>>>     last slot write is to start of slot
> >>>>     store current contents in slot
> >>>>     overwrite old end pivot
> >>>>                                         mas_next_slot():
> >>>>                                                 read end metadata
> >>>>                                                 read old end pivot
> >>>>                                                 return with incorrect range
> >>>>     store new value
> >>>>
> >>>> Alternatively:
> >>>>
> >>>> Writer:                                 reader:
> >>>> mas_wr_append
> >>>>     set end pivot
> >>>>     updates end metata
> >>>>     Detects write to last slot
> >>>>     last lost write to end of slot
> >>>>     store value
> >>>>                                         mas_next_slot():
> >>>>                                                 read end metadata
> >>>>                                                 read old end pivot
> >>>>                                                 read new end pivot
> >>>>                                                 return with incorrect range
> >>>>     set old end pivot
> >>>>
> >>>> There may be other accesses that are not safe since we are now updating
> >>>> both metadata and pointers, so disabling append if there could be rcu
> >>>> readers is the safest action.
> >>>>
> >>>> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> >>>> Cc: stable@vger.kernel.org
> >>>> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> >>>
> >>> Thanks for your patch, which is now commit cfeb6ae8bcb96ccf
> >>> ("maple_tree: disable mas_wr_append() when other readers are
> >>> possible") in v6.5, and is being backported to stable.
> >>>
> >>> On Renesas RZ/A1 and RZ/A2 (single-core Cortex-A9), this causes the
> >>> following warning:
> >>>
> >>>        clocksource: timer@e803b000: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 28958491609 ns
> >>>        sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 32537631224ns
> >>>        /soc/timer@e803b000: used for clocksource
> >>>        /soc/timer@e803c000: used for clock events
> >>>       +------------[ cut here ]------------
> >>>       +WARNING: CPU: 0 PID: 0 at init/main.c:992 start_kernel+0x2f0/0x480
> >>>       +Interrupts were enabled early
> >> ...
> >>>
> >>> I do not see this issue on any other platform
> >>> (arm/arm64/risc-v/mips/sh/m68k), several of them use the same
> >>> RCU configuration.
> >>
> >> There's something similar on pmac32 / mac99.
> >>
> >>> Do you have a clue?
> >>
> >> It seems something in the maple tree code is setting TIF_NEED_RESCHED,
> >> and that causes a subsequent call to cond_resched() to call schedule()
> >> and enable interrupts.
> >>
> >> On pmac32 enabling CONFIG_DEBUG_ATOMIC_SLEEP fixes/hides the problem.
> >> But I don't see why.
> >
> > Enabling CONFIG_DEBUG_ATOMIC_SLEEP on RZ/A1 and RZ/A2 does
> > fix the problem.
> > But there must be more to it, as some of my test configs had it enabled,
> > and others hadn't, while only RZ/A showed the issue.
> > I tried disabling it on R-Car M2-W (arm32) and R-Car H3 (arm64), and
> > that did not cause the problem to happen...
>
> I guess this patch triggers a potential problem with the maple tree.
> I don't have the environment to trigger the problem. Can you apply the
> following patch to see if the problem still exists? This can help locate
> the root cause. At least narrow down the scope of the code that has bug.

Thanks for your suggestion!

> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index f723024e1426..1b4b6f6e3095 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4351,9 +4351,6 @@ static inline void mas_wr_modify(struct
> ma_wr_state *wr_mas)
>         if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
>                 return;
>
> -       if (mas_wr_node_store(wr_mas, new_end))
> -               return;
> -
>         if (mas_is_err(mas))
>                 return;

Unfortunately removing these lines does not help.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
