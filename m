Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6A679C9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjILIYB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 04:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjILIXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:23:54 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DED410D2;
        Tue, 12 Sep 2023 01:23:50 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-ccc462deca6so4763162276.0;
        Tue, 12 Sep 2023 01:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694507029; x=1695111829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHZ8eeFK6SlfNu714uZ9TQyNIbYwztkyzv/gWNYPv8w=;
        b=V1fLdHqEQw+6b64FQ11TsQ4iYdId2L8yJKVKJBEUwIL7HpPMKThDLzk33bo7UNH26q
         AdMjGQTxyR4IAbTKpbN5C55wAY88RiAFniU6wI0XjI9hlNfyz7RNyx4HWPo1gmfzvEXu
         bcVDOaHUC8x9+fm32P9hhNckp1B32R8B4S0EjMwOs/bNWRGupNGWcCzmDHtW+KZuVEw0
         dHnya/a1HqMLWDS1AI6Wo6xlp3/ASNrFZiJbsVLHErzbms9UlQYfIdC9pM/TWsWdOLAX
         8WlOKhqNasoKVqEq0QKYk8AX8Po84yujQkGWO3lkJSVxwXkYf+0PxocuzCbGJH3ZkJyf
         vHQA==
X-Gm-Message-State: AOJu0YxSaMf3nmcr7LCWgLNpaDJsIYU0Hu/P2+vxiYLfr+nGfmn89aK/
        L/T+pTHJbpJZxoo7zAz/cov5gL9a0TzjHg==
X-Google-Smtp-Source: AGHT+IHtOow33hNCOqxCkGvhPebCi9u++ZPebCeWAqvSa2GFqAWVEHgZiVXhYFXtkeeDxmmYyEYrmQ==
X-Received: by 2002:a25:5058:0:b0:d7b:9d44:7574 with SMTP id e85-20020a255058000000b00d7b9d447574mr11070117ybb.64.1694507029333;
        Tue, 12 Sep 2023 01:23:49 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id n197-20020a2540ce000000b00d780f43b66dsm2078997yba.63.2023.09.12.01.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 01:23:48 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-ccc462deca6so4763146276.0;
        Tue, 12 Sep 2023 01:23:48 -0700 (PDT)
X-Received: by 2002:a25:4d46:0:b0:d06:2494:ef77 with SMTP id
 a67-20020a254d46000000b00d062494ef77mr10820004ybb.16.1694507028362; Tue, 12
 Sep 2023 01:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
 <20230819004356.1454718-2-Liam.Howlett@oracle.com> <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
 <20230906152325.dblzauybyoq5kd35@revolver> <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
 <20230906172954.oq4vogeuco25zam7@revolver> <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver> <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
In-Reply-To: <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Sep 2023 10:23:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com>
Message-ID: <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
To:     paulmck@kernel.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Sep 12, 2023 at 10:14 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> On Mon, Sep 11, 2023 at 07:54:52PM -0400, Liam R. Howlett wrote:
> > * Paul E. McKenney <paulmck@kernel.org> [230906 14:03]:
> > > On Wed, Sep 06, 2023 at 01:29:54PM -0400, Liam R. Howlett wrote:
> > > > * Paul E. McKenney <paulmck@kernel.org> [230906 13:24]:
> > > > > On Wed, Sep 06, 2023 at 11:23:25AM -0400, Liam R. Howlett wrote:
> > > > > > (Adding Paul & Shanker to Cc list.. please see below for why)
> > > > > >
> > > > > > Apologies on the late response, I was away and have been struggling to
> > > > > > get a working PPC32 test environment.
> > > > > >
> > > > > > * Geert Uytterhoeven <geert@linux-m68k.org> [230829 12:42]:
> > > > > > >     Hi Liam,
> > > > > > >
> > > > > > > On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> > > > > > > > The current implementation of append may cause duplicate data and/or
> > > > > > > > incorrect ranges to be returned to a reader during an update.  Although
> > > > > > > > this has not been reported or seen, disable the append write operation
> > > > > > > > while the tree is in rcu mode out of an abundance of caution.
> > > > > >
> > > > > > ...
> > > > > > > >
> >
> > ...
> >
> > > > > > > RCU-related configs:
> > > > > > >
> > > > > > >     $ grep RCU .config
> > > > > > >     # RCU Subsystem
> > > > > > >     CONFIG_TINY_RCU=y
>
> I must have been asleep last time I looked at this.  I was looking at
> Tree RCU.  Please accept my apologies for my lapse.  :-/
>
> However, Tiny RCU's call_rcu() also avoids enabling IRQs, so I would
> have said the same thing, albeit after looking at a lot less RCU code.
>
> TL;DR:
>
> 1.      Try making the __setup_irq() function's call to mutex_lock()
>         instead be as follows:
>
>         if (!mutex_trylock(&desc->request_mutex))
>                 mutex_lock(&desc->request_mutex);
>
>         This might fail if __setup_irq() has other dependencies on a
>         fully operational scheduler.
>
> 2.      Move that ppc32 call to __setup_irq() much later, most definitely
>         after interrupts have been enabled and the scheduler is fully
>         operational.  Invoking mutex_lock() before that time is not a
>         good idea.  ;-)

There is no call to __setup_irq() from arch/powerpc/?

Note that there are (possibly different) issues seen on ppc32 and on arm32
(Renesas RZ/A in particular, but not on other Renesas ARM systems).

I saw an issue on arm32 with cfeb6ae8bcb96ccf, but not with cfeb6ae8bcb96ccf^.
Other people saw an issue on ppc32 with both cfeb6ae8bcb96ccf and
cfeb6ae8bcb96ccf^.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
