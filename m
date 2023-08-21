Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548767834F3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjHUVj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHUVj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:39:58 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DCB10E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:39:56 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bc63e0d8cdso35247341fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692653994; x=1693258794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G0EKwEgwpxLoJoQonV7N63EDw/RpmfssFT2FoDBVEL8=;
        b=g7qX7sQ/Rs8bZjNmNyXLm5+gc5kNDYyDLFNc3q5+ZrkAbAMffug47cj8hWl9GApAL4
         ePKRg5CDGMT5ZpX2I1Qjf4fnPHZSsAIpyaqJAAPuRW/r8m2Xmh5BMDLOU+I5sVXO2D/J
         nouLUEYFCYm0ok2N9fL3DPJF9jmhqmNABcnfRvJ2TP3hYDrKIqt7omtEqU55rmK3qZ98
         bYZHX5wSpr0UaAEyAmlK+Kw4tbkYJR9fb0WMxSmJZFJ+wXELO0s6Rm3YjGBorY7Ruqar
         oYh+jsMrkagvojX8gWt9A3Fcdsmd66pkMh4lQ8qwHozOVBui5gh4rx8oc+3jqKtYUJmb
         Isow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692653994; x=1693258794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0EKwEgwpxLoJoQonV7N63EDw/RpmfssFT2FoDBVEL8=;
        b=fajLqXujT6XYSbXzNLFXLT1Wz1f+OEqPooThLWBsaJb/V+1yaP21mCOOb8YOEilq4X
         8IIva7Spnx2vOu3nys7GyOfExd3RVEH5ZWnUihblDeFQN++xLQHmn2MphjKDlhGNakJb
         hoHhkCdJrt8vMSpm/YlHnTrIBMr2MXYqSooweTEKKK/mM1JgVIUpeI779Zq53vo1q5Ex
         Zx4SKZ2hVoSwxPHF85zW8t+IEMxoHW3AfnD9u1YudktfeBlrOjSG/VnSA8aBpNZ68p+0
         8bvYsrNH/coy9aCBfOraQAhQWvOocH0P9onAjnjhKbJbx1yB1MHDmHqRgDOIIkj9lhuz
         WGWw==
X-Gm-Message-State: AOJu0YwZmBQg+aS1TF32mp9yfenBmrF6ldGZJ7LaOV0HabX/uINs2XVl
        sc6P33z3/ipJGwq/rSgWzsI=
X-Google-Smtp-Source: AGHT+IHhOmR8TzN4tM4XCWA5/HiA4fDXN4ZfpxFnlpl5S1uIRiE68fdOsY2fCkQtdbQwwvvHB6Yu/w==
X-Received: by 2002:a2e:9d58:0:b0:2bc:bc7e:e2df with SMTP id y24-20020a2e9d58000000b002bcbc7ee2dfmr3010671ljj.33.1692653994101;
        Mon, 21 Aug 2023 14:39:54 -0700 (PDT)
Received: from f (cst-prg-85-121.cust.vodafone.cz. [46.135.85.121])
        by smtp.gmail.com with ESMTPSA id k26-20020a1709062a5a00b00997cce73cc7sm7161693eje.29.2023.08.21.14.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:39:53 -0700 (PDT)
Date:   Mon, 21 Aug 2023 23:39:51 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] execve scalability issues, part 1
Message-ID: <20230821213951.bx3yyqh7omdvpyae@f>
References: <20230821202829.2163744-1-mjguzik@gmail.com>
 <ZOPSEJTzrow8YFix@snowbird>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZOPSEJTzrow8YFix@snowbird>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 02:07:28PM -0700, Dennis Zhou wrote:
> On Mon, Aug 21, 2023 at 10:28:27PM +0200, Mateusz Guzik wrote:
> > With this out of the way I'll be looking at some form of caching to
> > eliminate these allocs as a problem.
> > 
> 
> I'm not against caching, this is just my first thought. Caching will
> have an impact on the backing pages of percpu. All it takes is 1
> allocation on a page for the current allocator to pin n pages of memory.
> A few years ago percpu depopulation was implemented so that limits the
> amount of resident backing pages.
> 

I'm painfully aware.

> Maybe the right thing to do is preallocate pools of common sized
> allocations so that way they can be recycled such that we don't have to
> think too hard about fragmentation that can occur if we populate these
> pools over time?
> 

This is what I was going to suggest :)

FreeBSD has a per-cpu allocator which pretends to be the same as the
slab allocator, except handing out per-cpu bufs. So far it has sizes 4,
8, 16, 32 and 64 and you can act as if you are mallocing in that size.

Scales perfectly fine of course since it caches objs per-CPU, but there
is some waste and I have 0 idea how it compares to what Linux is doing
on that front.

I stress though that even if you were to carve out certain sizes, a
global lock to handle ops will still kill scalability.

Perhaps granularity better than global, but less than per-CPU would be a
sweet spot for scalabability vs memory waste.

That said...

> Also as you've pointed out, it wasn't just the percpu allocation being
> the bottleneck, but percpu_counter's global lock too for hotplug
> support. I'm hazarding a guess most use cases of percpu might have
> additional locking requirements too such as percpu_counter.
> 

True Fix(tm) is a longer story.

Maybe let's sort out this patchset first, whichever way. :)

> Thanks,
> Dennis
> 
> > Thoughts?
> > 
> > Mateusz Guzik (2):
> >   pcpcntr: add group allocation/free
> >   fork: group allocation of per-cpu counters for mm struct
> > 
> >  include/linux/percpu_counter.h | 19 ++++++++---
> >  kernel/fork.c                  | 13 ++------
> >  lib/percpu_counter.c           | 61 ++++++++++++++++++++++++----------
> >  3 files changed, 60 insertions(+), 33 deletions(-)
> > 
> > -- 
> > 2.39.2
> > 
