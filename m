Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC0180F985
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377609AbjLLVgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377195AbjLLVga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:36:30 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D090DC;
        Tue, 12 Dec 2023 13:36:36 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35da93ba227so22255695ab.0;
        Tue, 12 Dec 2023 13:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702416995; x=1703021795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqP0NZs3Xrf1lShIPhdYETxSBrVBzpiJjKpJblNh5Yc=;
        b=AYjQLFc1mWm7PsZVf+mTAK5HAKJH5Poe3QMyAHDIxYkbtkv+J4MDVuGgR0FErzujJW
         DJmboS3UaiwT5HeUUHSW7Mi7veWepqgiSn+HrTg6o4VXVTLslmzgCbdM1LIwRSWnvTIP
         mlzUTaF13btk/yk4E0LqjFlDiHqUqzH66AK4QgReh2YaiYzuXOuZRrF4xZvEpHv7rsg2
         XBYItqI3wTbOUhBWvI/7ceA8dCTad3fEQ1S0Z9MrJwWDQHJ/dUJ6v20pfG2rK0BLAnvH
         kRmUrO76zkvxw8vFeE7o1HBr2bVVC7mqemNnHoLQpkzGFgoMnHAGirim2KXr+08kYPl/
         FarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416995; x=1703021795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqP0NZs3Xrf1lShIPhdYETxSBrVBzpiJjKpJblNh5Yc=;
        b=dGStNsrYZOnZ4QmnKq+SwhazG2ccfOLI3X3knYzWl+yM37m8UN/i3GhSEIzlKY8Xes
         Tat2WrvruKSoSJ1Ea1lc53Vs9UHr3NogHD2+t3RCyHI7H7/Jw1GoeR7x2biXVA+/XbmD
         hmdK4gaC021qlV46qh7Ak1LTt7xIBCqwnXyTDzgICusBcwISTG4RCnNL2ca4NCkUtliz
         v6rzjHqczuH4+ZiTm6wRXEFwXyQ+fcS86z5BihJ/oJMsvG3XQPrAOgDymf24u/RmSGKy
         76mWlhda8BZ28p58ef8O2J88lixSSziPP7cnLeY1H/ZDcQ+Qnx1Gvq19zOJec3L4kqNj
         r6ig==
X-Gm-Message-State: AOJu0YykSIsb24nuSose2vY500n+4NGoNyQ3WURZKWCvV7hQZvz3XZeu
        f4CioT1pVi5KZ8DpoN3VrF2ERxjuUvJjZ5fklgg=
X-Google-Smtp-Source: AGHT+IGaXYEoLEr7Vl2t1G4tynNtJ16suiLjYiz3UnBB/rUz8+LCA+G682Aa3nkZfTqfgfl4TLs0wlZZOnzseTz//+8=
X-Received: by 2002:a05:6e02:1cab:b0:35d:59a2:bb5 with SMTP id
 x11-20020a056e021cab00b0035d59a20bb5mr6404771ill.75.1702416994943; Tue, 12
 Dec 2023 13:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
 <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com> <20231209034229.GA1001962@cmpxchg.org>
In-Reply-To: <20231209034229.GA1001962@cmpxchg.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 12 Dec 2023 13:36:23 -0800
Message-ID: <CAKEwX=OPQE3eTsfqwQa-bq3NE5YcqnkKfud84+FV4HF-Q_wcTg@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chris Li <chrisl@kernel.org>, akpm@linux-foundation.org,
        tj@kernel.org, lizefan.x@bytedance.com,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz, Kairui Song <kasong@tencent.com>,
        Minchan Kim <minchan@google.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 7:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Fri, Dec 08, 2023 at 03:55:59PM -0800, Chris Li wrote:
> > I can give you three usage cases right now:
> > 1) Google producting kernel uses SSD only swap, it is currently on
> > pilot. This is not expressible by the memory.zswap.writeback. You can
> > set the memory.zswap.max =3D 0 and memory.zswap.writeback =3D 1, then S=
SD
> > backed swapfile. But the whole thing feels very clunky, especially
> > what you really want is SSD only swap, you need to do all this zswap
> > config dance. Google has an internal memory.swapfile feature
> > implemented per cgroup swap file type by "zswap only", "real swap file
> > only", "both", "none" (the exact keyword might be different). running
> > in the production for almost 10 years. The need for more than zswap
> > type of per cgroup control is really there.
>
> We use regular swap on SSD without zswap just fine. Of course it's
> expressible.
>
> On dedicated systems, zswap is disabled in sysfs. On shared hosts
> where it's determined based on which workload is scheduled, zswap is
> generally enabled through sysfs, and individual cgroup access is
> controlled via memory.zswap.max - which is what this knob is for.
>
> This is analogous to enabling swap globally, and then opting
> individual cgroups in and out with memory.swap.max.
>
> So this usecase is very much already supported, and it's expressed in
> a way that's pretty natural for how cgroups express access and lack of
> access to certain resources.
>
> I don't see how memory.swap.type or memory.swap.tiers would improve
> this in any way. On the contrary, it would overlap and conflict with
> existing controls to manage swap and zswap on a per-cgroup basis.
>
> > 2) As indicated by this discussion, Tencent has a usage case for SSD
> > and hard disk swap as overflow.
> > https://lore.kernel.org/linux-mm/20231119194740.94101-9-ryncsn@gmail.co=
m/
> > +Kairui
>
> Multiple swap devices for round robin or with different priorities
> aren't new, they have been supported for a very, very long time. So
> far nobody has proposed to control the exact behavior on a per-cgroup
> basis, and I didn't see anybody in this thread asking for it either.
>
> So I don't see how this counts as an obvious and automatic usecase for
> memory.swap.tiers.
>
> > 3) Android has some fancy swap ideas led by those patches.
> > https://lore.kernel.org/linux-mm/20230710221659.2473460-1-minchan@kerne=
l.org/
> > It got shot down due to removal of frontswap. But the usage case and
> > product requirement is there.
> > +Minchan
>
> This looks like an optimization for zram to bypass the block layer and
> hook directly into the swap code. Correct me if I'm wrong, but this
> doesn't appear to have anything to do with per-cgroup backend control.
>
> > > zswap.writeback is a more urgent need, and does not prevent swap.tier=
s
> > > if we do decide to implement it.
> >
> > I respect that urgent need, that is why I Ack on the V5 path, under
> > the understanding that this zswap.writeback is not carved into stones.
> > When a better interface comes alone, that interface can be obsolete.
> > Frankly speaking I would much prefer not introducing the cgroup API
> > which will be obsolete soon.
> >
> > If you think zswap.writeback is not removable when another better
> > alternative is available, please voice it now.
> >
> > If you squash my minimal memory.swap.tiers patch, it will also address
> > your urgent need for merging the "zswap.writeback", no?
>
> We can always deprecate ABI if something better comes along.
>
> However, it's quite bold to claim that memory.swap.tiers is the best
> way to implement backend control on a per-cgroup basis, and that it'll
> definitely be needed in the future. You might see this as a foregone
> conclusion, but I very much doubt this.
>
> Even if such a file were to show up, I'm not convinced it should even
> include zswap as one of the tiers. Zswap isn't a regular swap backend,
> it doesn't show up in /proc/swaps, it can't be a second tier, the way
> it interacts with its backend file is very different than how two
> swapfiles of different priorities interact with each other, it's
> already controllable with memory.zswap.max, etc.

This is honestly the thing I was originally most iffy about :) zswap
is architecturally and semantically separate from other swap options.
It gets really confusing to lump it as part of the swap tiers.

>
> I'm open to discussing usecases and proposals for more fine-grained
> per-cgroup backend control. We've had discussions about per-cgroup
> swapfiles in the past. Cgroup parameters for swapon are another
> thought. There are several options and many considerations. The
> memory.swap.tiers idea is the newest, has probably had the least
> amount of discussion among them, and looks the least convincing to me.

Definitely. zswap.writeback is a really concrete feature, with
immediate use-case, whereas swap.tiers seem a bit nebulous to me now,
the more we discuss it. I'm not against the inclusion of something
along its line though, and I'm definitely not trying to limit the use
case of other folks - I'd be happy to contribute my engineering hours
towards the discussion of the multi-tier swapping design (both
internal implementation and and public interface), as well as actual
code, when that design is fully fleshed out :)

>
> Let's work out the requirements first.
>
> The "conflict" with memory.zswap.writeback is a red herring - it's no
> more of a conflict than setting memory.swap.tiers to "zswap" or "all"
> and then setting memory.zswap.max or memory.swap.max to 0.

Yup.

>
> So the notion that we have to rush in a minimal version of a MUCH
> bigger concept, just to support zswap writeback disabling is
> misguided. And then hope that this format works as the concept evolves
> and real usecases materialize... There is no reason to take that risk.
