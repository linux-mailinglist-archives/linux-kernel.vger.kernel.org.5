Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040C87F96CE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 01:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjK0A05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 19:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjK0A04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 19:26:56 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C4410F;
        Sun, 26 Nov 2023 16:27:02 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-462f139ae8bso216415137.3;
        Sun, 26 Nov 2023 16:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701044821; x=1701649621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hy/ENHor4F15xijuhqLOiJEFPoW/G6S/ww33a/cC+1M=;
        b=nNkhHwFqGvcUEZ7CNF432afRtwuWQyqEkqfyWnW9WipGGTlVZt1SKtxdsGJW3Mw9Tt
         qleVBxoLIm0Lm1mYDwFoetAioAMtk6Wnz/4kVpj+9lj9Vp01xCdZXRPSZiktz0Px2Df2
         jMaymjLXVN2uZjW6lUvsNyREsJSb423/TTMvnO8otmFG+zvirax3T7RvduzrLdigN2y6
         bc5xLrB7Ab0NdnHKFAXsrRzGpsJexOupo3BwhxK6mRFYn5p/OsHCx3Kh/6LvTddJbetp
         FvH+ZkLDcs8mpUrwjPrqFcUbvpt6/8r94Yip/6/8az4Wwg9otUZzV2s8IOCdVHtMv0fS
         sYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701044821; x=1701649621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hy/ENHor4F15xijuhqLOiJEFPoW/G6S/ww33a/cC+1M=;
        b=s2PDZtyoiwK0zOdGKNMTZq4sBqzmllyVbVDDHXp/wxzgMnlcyt0txDQRNGmqb9Y8X4
         bj+5nb4lDveSJ99eMmPOo6SFaiQwloVAiw/K2hh7E6zrAFWrCDEFl97GFr02goHTCkry
         4o6nHmj2tb23+5DxRa5hYtSgsSaA+JJah8GA3lzUWYqSRE/RRXaO/2lyJNCMJ3zo/6Jg
         9LEtTgtihqQW8g8VXaMMukhOjuhm8kwsQYFyi6KLDjIvtyZynox0wHye0kQzSDQgsN5l
         49LrgpxvF3eKL9ZsCZPtA0gLH0lNSvwkVIIanU5h5m/sF4VZEOATZWQXZHvoTJ5iXna1
         92mA==
X-Gm-Message-State: AOJu0YwaLBiRWY1yxCcHjQ7FMworhNvcPeKpD23PVEWD+JHWXh7txjB1
        Vapm6KikEDED3ZE2K7QgfrYITP+UPhXvHDEROow=
X-Google-Smtp-Source: AGHT+IFk0G48eLp0w2WCnyNsF9N/JMyM6eZ/+Pb0gFe5OD/imxQTwdyb4Hpc+PrmBHn9zbM5NDSKaDg8xWNcAXHWO1c=
X-Received: by 2002:a05:6102:17d1:b0:45f:a41:b405 with SMTP id
 jf17-20020a05610217d100b0045f0a41b405mr9678005vsb.21.1701044820765; Sun, 26
 Nov 2023 16:27:00 -0800 (PST)
MIME-Version: 1.0
References: <20231122143603.85297-1-sxwjean@me.com> <7512b350-4317-21a0-fab3-4101bc4d8f7a@suse.cz>
In-Reply-To: <7512b350-4317-21a0-fab3-4101bc4d8f7a@suse.cz>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Mon, 27 Nov 2023 09:26:55 +0900
Message-ID: <CAB=+i9Rw2Cm1SEYJu8oLBBxy-gaTLty64buma+FHs81pkSQz6w@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kernel-parameters: remove
 slab_max_order and noaliencache
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     sxwjean@me.com, linux-mm@kvack.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 8:24=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 11/22/23 15:36, sxwjean@me.com wrote:
> > From: Xiongwei Song <xiongwei.song@windriver.com>
> >
> > Since slab allocator has already been removed. There is no users about
> > slab_max_order and noaliencache, so let's remove them.
> >
> > Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> > ---
> > v2: Hyeonggon Yoo <42.hyeyoo@gmail.com> suggested that noaliencache sho=
uld be
> > removed too. Here adding this change. The patch is based on [1].
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/lo=
g/?h=3Dslab-remove-slab-v2r1
> >
> > v1: https://lore.kernel.org/linux-mm/20231120091214.150502-1-sxwjean@me=
.com/T/#m55ebb45851bc86d650baf65dfe8296d33c5b1126
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 10 ----------
> >  1 file changed, 10 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index 65731b060e3f..d56a5beefe24 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3740,10 +3740,6 @@
> >       no5lvl          [X86-64,RISCV] Disable 5-level paging mode. Force=
s
> >                       kernel to use 4-level paging instead.
> >
> > -     noaliencache    [MM, NUMA, SLAB] Disables the allocation of alien
> > -                     caches in the slab allocator.  Saves per-node mem=
ory,
> > -                     but will impact performance.
>
> No question about this one, can be deleted.
>
> > -
> >       noalign         [KNL,ARM]
> >
> >       noaltinstr      [S390] Disables alternative instructions patching
> > @@ -5887,12 +5883,6 @@
> >                       own.
> >                       For more information see Documentation/mm/slub.rs=
t.
> >
> > -     slab_max_order=3D [MM, SLAB]
> > -                     Determines the maximum allowed order for slabs.
> > -                     A high setting may cause OOMs due to memory
> > -                     fragmentation.  Defaults to 1 for systems with
> > -                     more than 32MB of RAM, 0 otherwise.
>
> I think here we should consider the long-term plan first. It's a bit
> unfortunate (in hindsight) SLUB brought its own prefix of parameters, eve=
n
> if some became interchangeable aliases later (slab/slub_nomerge), some no=
t.

Good point, thank you for pointing them out!

> I think it would be best to unify them, and consider the string "slub" an
> implementation detail of the general "slab allocator" term going forward.

So slab_{nomerge,min_objects,min_order, ...etc} are common to the
concept of slab so slab_$param will be appropriate.

But if we add something like slub_nocmpxchg later, it would be slub_nocmpxc=
hg
as it's an implementation-specific feature.

> So what I'd propose is that we change all parameters to accept a
> "slab_$param" as a primary and documented name (and the description can
> contain just [MM] tag, no [SLAB] or [SLUB] needed), with "slub_$param" is
> also accepted as an alias where it exists today, and there's just a note
> that the slub_$param name is also accepted in the description of the
> canonical parameter, not in a separate description.

No reason not to do it.

> Then maybe in a few
> years we can mark the old names as deprecated and start issuing low-key
> warnings (while still accepting them), and in 10 years maybe remove them
> completely. Thoughts?

That might be the safest way to remove a kernel parameter but should
we remove them?
Probably 1) allowing both slub_$param and slab_$param for general
parameters (forever)
and 2) only using slub_$param for slub-specific params would be enough?

> > -
> >       slub_debug[=3Doptions[,slabs][;[options[,slabs]]...]      [MM, SL=
UB]
> >                       Enabling slub_debug allows one to determine the
> >                       culprit if slab objects become corrupted. Enablin=
g
>
