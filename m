Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2940081386D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444025AbjLNRYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLNRYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:24:09 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFF593
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:24:15 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-425c1d7d72eso294061cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702574654; x=1703179454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6qaAK6u0d98nEr7ylliI4pEhXdrFGU2M5INaU0c7rY=;
        b=Hu/tCLuMZea+GPFy5N6w3+gppz05ZUevnftdQnv6N810loh3XsbvYyjTMb438tIhMr
         UM6hwq4G3g2GuO0UT4WMBYzPRHxp/eE2v21gomNeoBe31RAab4r7YyVVwkH90tTSkFJU
         SkF4oh6TUvq+pT2oo1fmG1PB4PHfGsygJkQqWPSAIXG6KltbalNUQYGclAM7CSrZ+unH
         4Znj8+M9Tc2MW8+wgAZj9kw6zF79V6hSaQDG3SFaf/+f6vp8wJcnHxRlcM3STJz9iY9q
         51uDzyY5P/sx1WMdbnUM2SSXWoYOuvEq4i3DK1h1hvcSSh4OANVA+XodVWTtT/H//AeI
         zzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702574654; x=1703179454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6qaAK6u0d98nEr7ylliI4pEhXdrFGU2M5INaU0c7rY=;
        b=s3JTIXrR3a4A8paLire9wHIX/+ZHjTAC2Paui+RtGzVZCjn/xCQyrrYI/dFovrvYuu
         qXdT8+2WM6HpUz80iupbCP6X0Vg9rynm0gpLLXqLdgsFJexYmzy7kUxUdyPsG8AGbWqx
         Xd5tkLzOclNqOXu8iNyN6IzwOLMN71VNlgqINMcTspdnM4YvubL1gO6kkPFOgbRalmnN
         3fSY9jn6RiVsvpWsAm+BD/jqPCrW229Hdf7n2sm6IRzOVkEkCjvU8my/8SXsk67j1AbW
         03uODALDQMQQvgYxkv56RxQUAEHzESbLpc1HQNhi08ZWidTW/shGnrxXFNgaWPu+6nz4
         UEiA==
X-Gm-Message-State: AOJu0YwZS84MyL/xU6Nsdp+Mn592mN0soXu/kCliEt9lae6IvdCnD3l1
        AvW6ok78Q3gVvvDxeuJqBo3Oee+TZgWlCh9/JFV5AA==
X-Google-Smtp-Source: AGHT+IG49K+G0hF5YDmqcBZnIApfoSCRNfZeCZ8701dpihdpS0TAqBKIMdERLSvc0lxo/Rgp70qfwbomnZg71a6mGg0=
X-Received: by 2002:a05:622a:1486:b0:421:c3a9:1e47 with SMTP id
 t6-20020a05622a148600b00421c3a91e47mr1836477qtx.20.1702574654261; Thu, 14 Dec
 2023 09:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
 <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com>
 <20231209034229.GA1001962@cmpxchg.org> <ZXeTb_ACou7TEVsa@google.com> <20231214171137.GA261942@cmpxchg.org>
In-Reply-To: <20231214171137.GA261942@cmpxchg.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 14 Dec 2023 10:23:35 -0700
Message-ID: <CAOUHufbvafDiURT9qBjKPpRSNwc60S-bDg2yMH_m4bNSWQcV4g@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Minchan Kim <minchan@kernel.org>, Chris Li <chrisl@kernel.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        tj@kernel.org, lizefan.x@bytedance.com,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz, Kairui Song <kasong@tencent.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>,
        Fabian Deutsch <fdeutsch@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Dec 14, 2023 at 10:11=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Mon, Dec 11, 2023 at 02:55:43PM -0800, Minchan Kim wrote:
> > On Fri, Dec 08, 2023 at 10:42:29PM -0500, Johannes Weiner wrote:
> > > On Fri, Dec 08, 2023 at 03:55:59PM -0800, Chris Li wrote:
> > > > I can give you three usage cases right now:
> > > > 1) Google producting kernel uses SSD only swap, it is currently on
> > > > pilot. This is not expressible by the memory.zswap.writeback. You c=
an
> > > > set the memory.zswap.max =3D 0 and memory.zswap.writeback =3D 1, th=
en SSD
> > > > backed swapfile. But the whole thing feels very clunky, especially
> > > > what you really want is SSD only swap, you need to do all this zswa=
p
> > > > config dance. Google has an internal memory.swapfile feature
> > > > implemented per cgroup swap file type by "zswap only", "real swap f=
ile
> > > > only", "both", "none" (the exact keyword might be different). runni=
ng
> > > > in the production for almost 10 years. The need for more than zswap
> > > > type of per cgroup control is really there.
> > >
> > > We use regular swap on SSD without zswap just fine. Of course it's
> > > expressible.
> > >
> > > On dedicated systems, zswap is disabled in sysfs. On shared hosts
> > > where it's determined based on which workload is scheduled, zswap is
> > > generally enabled through sysfs, and individual cgroup access is
> > > controlled via memory.zswap.max - which is what this knob is for.
> > >
> > > This is analogous to enabling swap globally, and then opting
> > > individual cgroups in and out with memory.swap.max.
> > >
> > > So this usecase is very much already supported, and it's expressed in
> > > a way that's pretty natural for how cgroups express access and lack o=
f
> > > access to certain resources.
> > >
> > > I don't see how memory.swap.type or memory.swap.tiers would improve
> > > this in any way. On the contrary, it would overlap and conflict with
> > > existing controls to manage swap and zswap on a per-cgroup basis.
> > >
> > > > 2) As indicated by this discussion, Tencent has a usage case for SS=
D
> > > > and hard disk swap as overflow.
> > > > https://lore.kernel.org/linux-mm/20231119194740.94101-9-ryncsn@gmai=
l.com/
> > > > +Kairui
> > >
> > > Multiple swap devices for round robin or with different priorities
> > > aren't new, they have been supported for a very, very long time. So
> > > far nobody has proposed to control the exact behavior on a per-cgroup
> > > basis, and I didn't see anybody in this thread asking for it either.
> > >
> > > So I don't see how this counts as an obvious and automatic usecase fo=
r
> > > memory.swap.tiers.
> > >
> > > > 3) Android has some fancy swap ideas led by those patches.
> > > > https://lore.kernel.org/linux-mm/20230710221659.2473460-1-minchan@k=
ernel.org/
> > > > It got shot down due to removal of frontswap. But the usage case an=
d
> > > > product requirement is there.
> > > > +Minchan
> > >
> > > This looks like an optimization for zram to bypass the block layer an=
d
> > > hook directly into the swap code. Correct me if I'm wrong, but this
> > > doesn't appear to have anything to do with per-cgroup backend control=
.
> >
> > Hi Johannes,
> >
> > I haven't been following the thread closely, but I noticed the discussi=
on
> > about potential use cases for zram with memcg.
> >
> > One interesting idea I have is to implement a swap controller per cgrou=
p.
> > This would allow us to tailor the zram swap behavior to the specific ne=
eds of
> > different groups.
> >
> > For example, Group A, which is sensitive to swap latency, could use zra=
m swap
> > with a fast compression setting, even if it sacrifices some compression=
 ratio.
> > This would prioritize quick access to swapped data, even if it takes up=
 more space.
> >
> > On the other hand, Group B, which can tolerate higher swap latency, cou=
ld benefit
> > from a slower compression setting that achieves a higher compression ra=
tio.
> > This would maximize memory efficiency at the cost of slightly slower da=
ta access.
> >
> > This approach could provide a more nuanced and flexible way to manage s=
wap usage
> > within different cgroups.
>
> That makes sense to me.
>
> It sounds to me like per-cgroup swapfiles would be the easiest
> solution to this.

Someone posted it about 10 years ago :)
https://lwn.net/Articles/592923/

+fdeutsch@redhat.com
Fabian recently asked me about its status.
