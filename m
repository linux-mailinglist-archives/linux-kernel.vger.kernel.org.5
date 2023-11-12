Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDA87E8D9F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 01:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjKLAHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 19:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKLAHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 19:07:13 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855643253;
        Sat, 11 Nov 2023 16:07:10 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7ac61c58d85so135769039f.2;
        Sat, 11 Nov 2023 16:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699747630; x=1700352430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIq6EzjNebTJSLRL1CT61ONPXQE/G9+uZ3pGYRIYVRQ=;
        b=KhWyhN8+bcTfOVJtTNep3lEiPksZPPR9Ut0HKGBSy4Jd+gFqP2DfC9JjKQmhzSsIPM
         GLUK3HdlUTLh8EGOpNPBFZDR0CFGLAsQ52BaSpO2K2bBbtST7dNWT+0HY3qIgYGvJaJN
         KZbII1j0+v6Mbq9ivt3gohOTxKB5oGS/vvdjX1wvGsTBvoTGo82u0zF6ftuE7FPlXbY+
         VivZCP1V/2dXpqbjOjwwVK1E3w22wRPryhQaWgAVY/CcmTutLCwm2+HHBeowIpEpz+9k
         0PomXMocr6Lb5auKhTphknNjhhVzQwT8q9WHPstDe5224TmjCieJTyTKpL+WY503cj5q
         DAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699747630; x=1700352430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIq6EzjNebTJSLRL1CT61ONPXQE/G9+uZ3pGYRIYVRQ=;
        b=JeH9ZK2uCDnJpQfITvG7ej/ECOmL6LSdCZzWINY91mQGpqPm04mSHiIX3iriqpp69a
         P+oCKiZQFqMQBJgLXAIp6Biyo4RNgusOG8zJfZRiImU5zmcVH+0eXJDi7sq2t4OkeMM5
         rxajH8AjzsG1ade+WTjjssAQ+HD7cXhFF15QGUa3LMhUrG5Zp09ZgHeyD+0Vwpa8ATf0
         RW+q4686K5HZUrPn9Pp6cizd4vhizBLAt2rv703t65T2pd6O4/qqmIHK1+nQVnZYNiAg
         VS/aL/HnnG1h4iGJYI6cZdqZ4QO2EvlH+n0RvVgrz/rVcb3tPjwQBUbQBBasFXryiihq
         5X7g==
X-Gm-Message-State: AOJu0YxJxi4VOcDM9aPj8R9OCJCSy1L2wvxGwGeF+nUAVwXCZjdmlpt9
        T4/Do5Ax41qx4VQficdGf2xrdX6AoZTZ3MNrwlA=
X-Google-Smtp-Source: AGHT+IGFQmTQBtABTIDx9JT7gq+afKVZZrIts5BpiQWRUEpwTHxC0AiBWp54Bi/ZiGbPnv3gbTAlTDyug+hkn7Fc3Ng=
X-Received: by 2002:a05:6602:3799:b0:7a9:984c:1427 with SMTP id
 be25-20020a056602379900b007a9984c1427mr4353142iob.21.1699747629734; Sat, 11
 Nov 2023 16:07:09 -0800 (PST)
MIME-Version: 1.0
References: <20231106231158.380730-1-nphamcs@gmail.com> <CAF8kJuPXBLpG2d4sje6ntrA+U-AnLzu3sNpJK02YxNcg04YNng@mail.gmail.com>
 <CAKEwX=OgN_xQWrp_OYkK1BRq3DFW4he9OSycdjBm0BNy+vpPAg@mail.gmail.com> <CAF8kJuN--EUY95O1jpV39yv5FDu0OYanY6SZeBPk5ng4kRyrjA@mail.gmail.com>
In-Reply-To: <CAF8kJuN--EUY95O1jpV39yv5FDu0OYanY6SZeBPk5ng4kRyrjA@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Sat, 11 Nov 2023 16:06:58 -0800
Message-ID: <CAKEwX=PT=5nvLhUyMmi=hq0_2H-4kmO9tOdqFvHEtaWF+e8M1Q@mail.gmail.com>
Subject: Re: [PATCH v4] zswap: memcontrol: implement zswap writeback disabling
To:     Chris Li <chrisl@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org,
        lizefan.x@bytedance.com, Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, mhocko@kernel.org,
        roman.gushchin@linux.dev, Shakeel Butt <shakeelb@google.com>,
        muchun.song@linux.dev, Hugh Dickins <hughd@google.com>,
        corbet@lwn.net, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm <linux-mm@kvack.org>, kernel-team@meta.com,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 10:22=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Fri, Nov 10, 2023 at 4:10=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> > > I notice the bool is between two integers.
> > > mem_cgroup structure has a few bool sprinkle in different locations.
> > > Arrange them together might save a few padding bytes. We can also
> > > consider using bit fields.
> > > It is a very minor point, the condition also exists before your chang=
e.
> >
> > This sounds like an optimization worthy of its own patch. Two random
> > thoughts however:
>
> Sure. I consider this a very minor point as well.
>
> >
> > a) Can this be done at the compiler level? I believe you can reduce
> > the padding required by sorting the fields of a struct by its size, cor=
rect?
> > That sounds like a job that a compiler should do for us...
>
> According to the C standard, the struct member should be layered out
> in the order it was declared. There are too many codes that assume the
> first member has the same address of the struct. Consider we use
> struct for DMA descriptor as well, where the memory layout needs to
> match the underlying hardware. Re-ordering the members will be really
> bad there. There are gcc extensions to do structure member
> randomization. But the randomization layout is determined by the
> randomization seed. The compiler actually doesn't have the flexibility
> to rearrange the member orders to reduce the padding either.
>

Ah I see. Yeah then it might be worth tweaking around manually.
But yeah, we should do this separately from this patch.

> >
> > b) Re: the bitfield idea, some of the fields are CONFIG-dependent (well
> > like this one). Might be a bit hairier to do it...
>
> You can declare the bit field under preprocessor condition as well,
> just like a normal declare. Can you clarify why it is more hairier?
> The bitfield does not have a pointer address associated with it, the
> compiler can actually move the bit field bits around. You get the
> compiler to do it for you in this case.

I see hmmm.

>
> >
> > >
> > > >  #endif /* _LINUX_ZSWAP_H */
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index e43b5aba8efc..9cb3ea912cbe 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -5545,6 +5545,11 @@ mem_cgroup_css_alloc(struct cgroup_subsys_st=
ate *parent_css)
> > > >         WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
> > > >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> > > >         memcg->zswap_max =3D PAGE_COUNTER_MAX;
> > > > +
> > > > +       if (parent)
> > > > +               WRITE_ONCE(memcg->zswap_writeback, READ_ONCE(parent=
->zswap_writeback));
> > > > +       else
> > > > +               WRITE_ONCE(memcg->zswap_writeback, true);
> > >
> > > You can combine this two WRITE_ONCE to one
> > >
> > > bool writeback =3D !parent ||   READ_ONCE(parent->zswap_writeback);
> > > WRITE_ONCE(memcg->zswap_writeback, writeback);
> > >
> >
> > Yeah I originally did something similar, but then decided to do the if-=
else
> > instead. Honest no strong preference here - just felt that the if-else =
was
> > cleaner at that moment.
>
> One WRITE_ONCE will produce slightly better machine code as less
> memory store instructions. Normally the compiler is allowed to do the
> common expression elimination to merge the write. However here it has
> explicite WRITE_ONCE, so the compiler has to place two memory stores
> instructions, because you have two WRITE_ONCE. My suggestion will only
> have one memory store instruction. I agree it is micro optimization.
>

Ohh I did not think about this. Seems like my original version was more
than just a clever one-liner haha.

It's a bit of a micro-optimization indeed. But if for some reason I need
to send v5 or a fixlet, I'll keep this in mind!

Thanks for the explanation, Chris!

> Chris
