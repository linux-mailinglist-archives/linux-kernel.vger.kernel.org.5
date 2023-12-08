Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600CA809870
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444217AbjLHBMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHBMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:12:48 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBA91708
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:12:54 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c0fc1cf3dso16086655e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 17:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701997973; x=1702602773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sCOupMGNpi2gKf6EtIYblzAwxIouOwC3n4C1JZz198=;
        b=PW0d+ZFvtA9ZuFZDWRnAJaXYWe96NPhYZh6fR9VW+NyWIAUYNGku9T/2GvpopNqyqm
         9kKV6a3Jfbew/v+jm6ub12OFWAK6FnDeaC4XW+AW6yzXrv2c69J3UFsGbWtvfahu96dE
         iPX/rFr0E4wx8P22bjELJ1G79odxdTHFOLQH+4GtUgYWi/Lute+8ZwYkUcaADh642xa0
         WeLHSMASlWY2indc9u5if7wNsl2pIojv4PR1cn+9Hwi/j5uIRADogeSCxqRYSzblDVz9
         4BxUUJ78hkcAVuLoMVrVcNc3y9apLj9dvY2fb0iH9oW8abaaRzg5kfzBbacONXwKLCCG
         Oe/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701997973; x=1702602773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sCOupMGNpi2gKf6EtIYblzAwxIouOwC3n4C1JZz198=;
        b=CvdWCpHAMao0pWio82iSvlLN5YQi3BD4qSJitw+LglpX8yigpCYrp/ugydQiSSlk8p
         M1vO3KLR8F36MZqc5a2NclWBp8SxVKAlKVobBNOf8L+rrrbWKbSmZNrTtBVNthsek8jA
         OPBRyNNARX+5CpQ1w5BstrZZ7DJDjqQlhLW7L6boG7n/H14k64FIImYur28/4mfVWhNu
         kMmwv/e6ehu+G5TokDdBTQi0CI8WE+SL4+7QsFYPJDEI6u5ByG1oDbySWo48IRxzusHX
         Q1+h01QkV1i3URFP+Lr0a24fXt+QucmFy+Q3BFRcdN5cBB0tfORg5tp58GyVPKuEysuy
         OBhQ==
X-Gm-Message-State: AOJu0YxTr3CD0vcSaEzXZuPNmQ0QrHMMqXy3VMSfXM9ZV59q7bUM5jTW
        jpymuojUEV5DcXIsiJ8mjgDqmvMLp7SkMd2Dq/QONw==
X-Google-Smtp-Source: AGHT+IENlQpeWxB91Wsx6O6qERN9474H5YvgjoHd40vy2RadPk90rlVwfy/Uat+QIru5TTcAoCcXwQ/1KNYq19dxYSE=
X-Received: by 2002:a05:600c:4453:b0:40b:5e21:d350 with SMTP id
 v19-20020a05600c445300b0040b5e21d350mr2123625wmn.89.1701997972737; Thu, 07
 Dec 2023 17:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
In-Reply-To: <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 7 Dec 2023 17:12:13 -0800
Message-ID: <CAJD7tkaHaji=0sVobJKajc4hOmOui2U+bZK+1DQ6gbAsQgGLRw@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Chris Li <chrisl@kernel.org>, akpm@linux-foundation.org,
        tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 5:03=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Thu, Dec 7, 2023 at 4:19=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
> >
> > Hi Nhat,
> >
> >
> > On Thu, Dec 7, 2023 at 11:24=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > >
> > > During our experiment with zswap, we sometimes observe swap IOs due t=
o
> > > occasional zswap store failures and writebacks-to-swap. These swappin=
g
> > > IOs prevent many users who cannot tolerate swapping from adopting zsw=
ap
> > > to save memory and improve performance where possible.
> > >
> > > This patch adds the option to disable this behavior entirely: do not
> > > writeback to backing swapping device when a zswap store attempt fail,
> > > and do not write pages in the zswap pool back to the backing swap
> > > device (both when the pool is full, and when the new zswap shrinker i=
s
> > > called).
> > >
> > > This new behavior can be opted-in/out on a per-cgroup basis via a new
> > > cgroup file. By default, writebacks to swap device is enabled, which =
is
> > > the previous behavior. Initially, writeback is enabled for the root
> > > cgroup, and a newly created cgroup will inherit the current setting o=
f
> > > its parent.
> > >
> > > Note that this is subtly different from setting memory.swap.max to 0,=
 as
> > > it still allows for pages to be stored in the zswap pool (which itsel=
f
> > > consumes swap space in its current form).
> > >
> > > This patch should be applied on top of the zswap shrinker series:
> > >
> > > https://lore.kernel.org/linux-mm/20231130194023.4102148-1-nphamcs@gma=
il.com/
> > >
> > > as it also disables the zswap shrinker, a major source of zswap
> > > writebacks.
> >
> > I am wondering about the status of "memory.swap.tiers" proof of concept=
 patch?
> > Are we still on board to have this two patch merge together somehow so
> > we can have
> > "memory.swap.tiers" =3D=3D "all" and "memory.swap.tiers" =3D=3D "zswap"=
 cover the
> > memory.zswap.writeback =3D=3D 1 and memory.zswap.writeback =3D=3D 0 cas=
e?
> >
> > Thanks
> >
> > Chris
> >
>
> Hi Chris,
>
> I briefly summarized my recent discussion with Johannes here:
>
> https://lore.kernel.org/all/CAKEwX=3DNwGGRAtXoNPfq63YnNLBCF0ZDOdLVRsvzUmY=
hK4jxzHA@mail.gmail.com/
>
> TL;DR is we acknowledge the potential usefulness of swap.tiers
> interface, but the use case is not quite there yet, so it does not
> make too much sense to build up that heavy machinery now.
> zswap.writeback is a more urgent need, and does not prevent swap.tiers
> if we do decide to implement it.

I am honestly not convinced by this. There is no heavy machinery here.
The interface is more generic and extensible, but the implementation
is roughly the same. Unless we have a reason to think a swap.tiers
interface may make it difficult to extend this later or will not
support some use cases, I think we should go ahead with it. If we are
worried that "tiers" may not accurately describe future use cases, we
can be more generic and call it swap.types or something.
