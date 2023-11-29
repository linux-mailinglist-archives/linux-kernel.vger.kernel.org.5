Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6817FE169
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjK2Uza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjK2Uz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:55:27 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07896D67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:55:34 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-462e19c29baso52209137.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701291333; x=1701896133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mh8mfkKmbZyezogReiTmoJ2/ZEYTC/jfxX54yQ12YVc=;
        b=jFfsOIk4af1CGZLS53I/gWvS4Nl8m6ju0Xm2BXXNjzP3TXnU7cYL2CZN5x7w5BOg4C
         TT3teqGSTN4/uY2zf1O0ChqgkPengLrDWWFBZCRTy0arb6gP96T3rdY8NsVYKthpfpiU
         QjPLGht1tF/mOU3Z1Ma4hBbB36UHpb5WgXDBVDVU7HJKYrlvG9AU2oc0SVe7KsMCQLkS
         Uebze4zgGETguXNLHUMu3nBh+z+iBC00KzvMczCtlHv0G5RM8FdvbUvg3M2d8sPDh6Vc
         +zGijiLY50KXhercsRmgztvdg0pTrwoPVYkYInvOl9k68kusGQKF/dvWlMzZfZhIsgTS
         C2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701291333; x=1701896133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mh8mfkKmbZyezogReiTmoJ2/ZEYTC/jfxX54yQ12YVc=;
        b=Q6eH5KshMCazyzPQNYO3IPAcpIt6phUIQoL3PQm/EB+lmFwYjTG5cduxvUY85RIaa9
         kDbapUA2Ds7vY5X3Pni2PQgwQ6YWK56tCln90lhzyhAUcZsRTZkv3qcgQETvl7ynArI0
         EVy7DMhpY4Gnx1rH0JmqiTv5mCq99CaSI+3gWsEzMbRAnKB7Xt6BlsoNKkIyPlRFWQpZ
         MVSNFn/UPF1Rc2a/T7Wafgp3PtoZsq1OTIS7eu3Oj/Ipat7sQTZ5+LNS8Iai2RSTW7UG
         qUg6dJqJ+XN3o96Kn0flBgmtMrmGArO4jHAAp29L3uf8e6Vs/XT/lU3FwYPFzBZomQq5
         Gytw==
X-Gm-Message-State: AOJu0Yx7dGPKjwwTihCybUbH6tytUfQafovU+mVtFgD0c008Z2padbmh
        n3oIaOT7E/F8S+7B4vmHGOfKxWcNDuXHoXC5DaljCg==
X-Google-Smtp-Source: AGHT+IHZofM+mWPqplXKo3oO5HK96UwBHrlAhtemO+AXxBVHuzRUX5DN/4Q8F5GFPbEvlwAl5R5uHEJrdpwE3tWD9CA=
X-Received: by 2002:a05:6102:244f:b0:464:4d97:2c01 with SMTP id
 g15-20020a056102244f00b004644d972c01mr2523133vss.31.1701291332997; Wed, 29
 Nov 2023 12:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20231127234946.2514120-1-swboyd@chromium.org> <202311291219.A6E3E58@keescook>
 <CAE-0n53x8AXUPaq5_TaqF6PN5u5J6g5RYoNWALN-MnEJBa5syA@mail.gmail.com>
In-Reply-To: <CAE-0n53x8AXUPaq5_TaqF6PN5u5J6g5RYoNWALN-MnEJBa5syA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 29 Nov 2023 21:54:54 +0100
Message-ID: <CANpmjNP9Koro2FKS9xG5LDvOvyRKrQBFkyKhJVSsqFJdEE+peA@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: Add kfence read after free crash type
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 at 21:42, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Adding kfence folks (will add on v2).
>
> Quoting Kees Cook (2023-11-29 12:22:27)
> > On Mon, Nov 27, 2023 at 03:49:45PM -0800, Stephen Boyd wrote:
> > > Add the ability to allocate memory from kfence and trigger a read after
> > > free on that memory to validate that kfence is working properly. This is
> > > used by ChromeOS integration tests to validate that kfence errors can be
> > > collected on user devices and parsed properly.
> >
> > This looks really good; thanks for adding this!
> >
> > >
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > >  drivers/misc/lkdtm/heap.c | 64 +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 64 insertions(+)
> > >
> > > diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
> > > index 0ce4cbf6abda..608872bcc7e0 100644
> > > --- a/drivers/misc/lkdtm/heap.c
> > > +++ b/drivers/misc/lkdtm/heap.c
> > > @@ -4,6 +4,7 @@
> > >   * page allocation and slab allocations.
> > >   */
> > >  #include "lkdtm.h"
> > > +#include <linux/kfence.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/vmalloc.h>
> > >  #include <linux/sched.h>
> > > @@ -132,6 +133,66 @@ static void lkdtm_READ_AFTER_FREE(void)
> > >       kfree(val);
> > >  }
> > >
> > > +#if IS_ENABLED(CONFIG_KFENCE)
> >
> > I really try hard to avoid having tests disappear depending on configs,
> > and instead report the expected failure case (as you have). Can this be
> > built without the IS_ENABLED() tests?
> >
>
> We need IS_ENABLED() for the kfence_sample_interval variable. I suppose
> if the config isn't set that variable can be assumed as zero and then
> the timeout would hit immediately. We can either define the name
> 'kfence_sample_interval' as 0 in the header, or put an ifdef in the
> function.

I think it's fair to put it in the kfence header, so you don't need
the #ifdefs in the test code.

We didn't think anyone should depend on kfence_sample_interval outside
KFENCE code, but probably only tests would anyway.

> ---8<---
> diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
> index 4f467d3972a6..574d0aa726dc 100644
> --- a/drivers/misc/lkdtm/heap.c
> +++ b/drivers/misc/lkdtm/heap.c
> @@ -138,6 +138,14 @@ static void lkdtm_KFENCE_READ_AFTER_FREE(void)
>         int *base, val, saw;
>         unsigned long timeout, resched_after;
>         size_t len = 1024;
> +       unsigned long interval;
> +
> +#ifdef CONFIG_KFENCE
> +       interval = kfence_sample_interval;
> +#else
> +       interval = 0;
> +#endif
> +
>         /*
>          * The slub allocator will use the either the first word or
>          * the middle of the allocation to store the free pointer,
> @@ -150,13 +158,13 @@ static void lkdtm_KFENCE_READ_AFTER_FREE(void)
>          * 100x the sample interval should be more than enough to ensure we get
>          * a KFENCE allocation eventually.
>          */
> -       timeout = jiffies + msecs_to_jiffies(100 * kfence_sample_interval);
> +       timeout = jiffies + msecs_to_jiffies(100 * interval);
>         /*
>          * Especially for non-preemption kernels, ensure the allocation-gate
>          * timer can catch up: after @resched_after, every failed allocation
>          * attempt yields, to ensure the allocation-gate timer is scheduled.
>          */
> -       resched_after = jiffies + msecs_to_jiffies(kfence_sample_interval);
> +       resched_after = jiffies + msecs_to_jiffies(interval);
>         do {
>                 base = kmalloc(len, GFP_KERNEL);
>                 if (!base) {
>
> ---8<----
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index 401af4757514..88100cc9caba 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -223,6 +223,8 @@ bool __kfence_obj_info(struct kmem_obj_info *kpp,
> void *object, struct slab *sla
>
>  #else /* CONFIG_KFENCE */
>
> +#define kfence_sample_interval (0)
> +
>  static inline bool is_kfence_address(const void *addr) { return false; }
>  static inline void kfence_alloc_pool_and_metadata(void) { }
>  static inline void kfence_init(void) { }

Acked-by: Marco Elver <elver@google.com>

FWIW, I've occasionally been using repeatedly invoked READ_AFTER_FREE
to test if KFENCE is working. Having a dedicated test like this seems
more reliable though.
