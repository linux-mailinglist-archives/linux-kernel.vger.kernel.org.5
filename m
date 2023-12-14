Return-Path: <linux-kernel+bounces-236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F9D813E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D674B223DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFA7224DF;
	Thu, 14 Dec 2023 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YK+haT9l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336236C6D7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9A7C433C8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702594524;
	bh=Grf7p7fPCkEqN65KUDfnN0gBmOwNPSpfdD7NmMiKon0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YK+haT9lDBRy48C8SkGaXc9Jt2QHWGOKKMsfh7BZyUXivV5EybgNW2KQfayWRTqmi
	 DezakAI3UDJBZYVWzUf5nH2GPxWBZDGZXn/x0Ynly3IoH4Jtznmdd8uwlB1nW6oPKn
	 8TrL5VFmF9RrRu+qr/bvugfAmoy0B3KwJy9E3ZmhnN1/eOyfPj25CNdvNtSCR0Gw7H
	 XFdP9jZekNF/VQUELtpTIbDwZuxFRng7IAqAI8IujYK/A+fD4IgTpRW4KAucySQNLf
	 RQhJ0/WJVbIRpEfUAtAdtR2Qz9ZSqa7ZnL/8gmP31biJKEhByrCgMFBikzYE8CU9CG
	 ZruD68G7+92mA==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3ba0dfc9001so38166b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 14:55:24 -0800 (PST)
X-Gm-Message-State: AOJu0YzSXmrhT+65lc74u3OMMhUy9sxVslzYp0CMbZJXr70yJr65OI/N
	a5svg258Bdhx8/RsqrFVsyW2lHZgLcBpaFm83Y6+zQ==
X-Google-Smtp-Source: AGHT+IG/TtHGU7JVw2TZsapT4A3vzYF0UL0RzdAkU+Dfl1UY00/kcl+wiH08OnNQ1vnM6rdLPBxBSvf2V30zZrft7aE=
X-Received: by 2002:a05:6a20:4ca2:b0:18f:c21d:7ec4 with SMTP id
 fq34-20020a056a204ca200b0018fc21d7ec4mr10153997pzb.40.1702594503804; Thu, 14
 Dec 2023 14:55:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
 <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com>
 <20231209034229.GA1001962@cmpxchg.org> <ZXeTb_ACou7TEVsa@google.com>
 <20231214171137.GA261942@cmpxchg.org> <CANeU7QnR+4Lgt8D9Z+Zo3Ydktx_7n45K0b=kVj+qSOzT=5GGQA@mail.gmail.com>
 <20231214221140.GA269753@cmpxchg.org>
In-Reply-To: <20231214221140.GA269753@cmpxchg.org>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 14 Dec 2023 14:54:52 -0800
X-Gmail-Original-Message-ID: <CAF8kJuN=6CfU2mXP4VFgCkngRGz6Ni67SSHLps8_A+ZScDckUw@mail.gmail.com>
Message-ID: <CAF8kJuN=6CfU2mXP4VFgCkngRGz6Ni67SSHLps8_A+ZScDckUw@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Minchan Kim <minchan@kernel.org>, Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, 
	tj@kernel.org, lizefan.x@bytedance.com, cerasuolodomenico@gmail.com, 
	yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeelb@google.com, muchun.song@linux.dev, hughd@google.com, corbet@lwn.net, 
	konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, david@ixit.cz, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 2:11=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Dec 14, 2023 at 09:34:06AM -0800, Christopher Li wrote:
> > On Thu, Dec 14, 2023 at 9:11=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> >
> > > > Hi Johannes,
> > > >
> > > > I haven't been following the thread closely, but I noticed the disc=
ussion
> > > > about potential use cases for zram with memcg.
> > > >
> > > > One interesting idea I have is to implement a swap controller per c=
group.
> > > > This would allow us to tailor the zram swap behavior to the specifi=
c needs of
> > > > different groups.
> > > >
> > > > For example, Group A, which is sensitive to swap latency, could use=
 zram swap
> > > > with a fast compression setting, even if it sacrifices some compres=
sion ratio.
> > > > This would prioritize quick access to swapped data, even if it take=
s up more space.
> > > >
> > > > On the other hand, Group B, which can tolerate higher swap latency,=
 could benefit
> > > > from a slower compression setting that achieves a higher compressio=
n ratio.
> > > > This would maximize memory efficiency at the cost of slightly slowe=
r data access.
> > > >
> > > > This approach could provide a more nuanced and flexible way to mana=
ge swap usage
> > > > within different cgroups.
> > >
> > > That makes sense to me.
> > >
> > > It sounds to me like per-cgroup swapfiles would be the easiest
> > > solution to this. Then you can create zram devices with different
> > > configurations and assign them to individual cgroups.
> >
> > Ideally you need zram then following swap file after the zram. That
> > would be a list of the swap files rather than just one swapfile per
> > cgroup.
> >
> > > This would also apply to Kairu's usecase: assign zrams and hdd backup=
s
> > > as needed on a per-cgroup basis.
> >
> > Same there, Kairui's request involves ZRAM and at least one extra swap
> > file. In other words, you really need a per cgroup swap file list.
>
> Why is that a problem?

It is not a problem. It is the necessary infrastructure to support the
requirement. I am merely saying just having one swap file is not
enough.

>
> swapon(zram, cgroup=3Dfoo)
> swapon(hdd, cgroup=3Dfoo)

Interesting idea. I assume you want to use swapon/swapoff to turn on
off a device for a specific cgroup.
That seems to implite each cgroup will have a private copy of the swap
device list.

I have considered the memory.swap.tiers for the same thing, with one
minor optimization. The list is system wide maintained with a name.
The per cgroup just has a pointer to that named list. There shouldn't
be too many such lists of swap back end combinations on the system.

We are getting into the weeds. The bottom line is, we need to have per
cgroup a swap file list. That is the necessary evil we can't get away
with.

>
> > > In addition, it would naturally solve scalability and isolation
> > > problems when multiple containers would otherwise be hammering on the
> > > same swap backends and locks.
> > >
> > > It would also only require one, relatively simple new interface, such
> > > as a cgroup parameter to swapon().
> > >
> > > That's highly preferable over a complex configuration file like
> > > memory.swap.tiers that needs to solve all sorts of visibility and
> > > namespace issues and duplicate the full configuration interface of
> > > every backend in some new, custom syntax.
> >
> > If you don't like the syntax of memory.swap.tiers, I am open to
> > suggestions of your preferred syntax as well. The essicents of the
> > swap.tiers is a per cgroup list of the swap back ends. The names imply
> > that. I am not married to any given syntax of how to specify the list.
> > Its goal matches the above requirement pretty well.
>
> Except Minchan said that he would also like different zram parameters
> depending on the cgroup.

Minchan's requirement is new. We will need to expand the original
"memory.swap.tiers" to support such usage.

> There is no way we'll add a memory.swap.tiers with a new configuration
> language for backend parameters.
>

I agree that we don't want a complicated configuration language for
"memory.swap.tiers".

Those backend parameters should be configured on the back end side.
The "memory.swap.tiers" just reference the already configured object.
Just brainstorming:
/dev/zram0 has compression algo1 for fast speed low compression ratio.
/dev/zram1 has compression algo2 for slow speed high compression ratio.

"memory.swap.tiers" point to zram0 or zram1 or a custom list has "zram0 + h=
dd"

Chris

