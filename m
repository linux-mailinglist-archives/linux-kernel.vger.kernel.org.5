Return-Path: <linux-kernel+bounces-338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECE6813FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A021C2217F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D80815;
	Fri, 15 Dec 2023 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTR3jTQQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8357E4;
	Fri, 15 Dec 2023 02:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-35e70495835so1038005ab.3;
        Thu, 14 Dec 2023 18:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702606757; x=1703211557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8gS/q427oPS6HKGW6tQx+fntDpi2+l983j1qfuY/o0=;
        b=MTR3jTQQT4lhVkbHwfFhbJoN27Ao8Z/7LOQ6f5Vb96BOJTXokcynoJoy0eJowg7aEJ
         96zflMPz2GNMARgyR/qFHDr/yW7F0KR/Y8RUBWukiQEDa/Fo6q7fuU5VUGA4zc5EK813
         bq7d0VpoIsf/VybjTO32yemHyDwtK/BTVC++n59dFIbLbiMjRfdlG54fcGwRa8n+9nSe
         KFYjidigE6+U0XZxS59tb9Daq+ilSLjQ05iQi9KhZc1qNEIBc+VldV44AHHOzHBno5df
         LwVb0I396GjatvqaJA3kQ151540dvoVzxRkR61VzL0RcGTb6yequV2f787YeV8aArGR8
         KqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702606757; x=1703211557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8gS/q427oPS6HKGW6tQx+fntDpi2+l983j1qfuY/o0=;
        b=e/McUk4BWbBClw9tADUgO9Js7g3zt/h/cSKdZyFrjw9iUDugfx3Vngg7sf4MKJe1Rb
         oIJQBjk78SS/d7fJLVba24dgOqqfS3quhO2GS+HJ/jCSumGthh97PuWvAWJ8f2ygXSQa
         OdT8qAebO5Mc82rXqgUUmB70sj5VKGVdG90sDQwGcGPzEtjghXhUivLwwqXssIqJ691a
         KQQVWr2IQi/8z1ieRoWqq1WoRFz3jCf95Q7sOpeZ7MqSWKC0XY3GbOzkrdWYfB4QoUpd
         gxzKmAR/4VA5kKTZzqhhs73DBRLzv2WJQYyoHwtrtC11FIPSbPU0gX7psT6oIfUeIKkP
         XN3Q==
X-Gm-Message-State: AOJu0Ywn7jIZHJjTZxp5j7T8ln92FNPoqi+GiXVudsQKTb0EXZ/cMFtu
	wqhPM5zFA+ATv/R86B+yiTGd8glECrPnnDfzQsM=
X-Google-Smtp-Source: AGHT+IG9KGChwrAb21xlqEK6g1rzWiKGGpdS0P+T0yaZowCVMAnp2upHHz6T9hUDQKZI/B0LedbnBo9mjXgr9ywQV6s=
X-Received: by 2002:a05:6e02:1a2d:b0:35d:5995:1d5c with SMTP id
 g13-20020a056e021a2d00b0035d59951d5cmr16322485ile.33.1702606756802; Thu, 14
 Dec 2023 18:19:16 -0800 (PST)
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
 <20231214221140.GA269753@cmpxchg.org> <CAF8kJuN=6CfU2mXP4VFgCkngRGz6Ni67SSHLps8_A+ZScDckUw@mail.gmail.com>
In-Reply-To: <CAF8kJuN=6CfU2mXP4VFgCkngRGz6Ni67SSHLps8_A+ZScDckUw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 14 Dec 2023 18:19:05 -0800
Message-ID: <CAKEwX=PLW=oj2DmsgaynXhY_SYb0VOw9i64K=RrZxhGySxdtvQ@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To: Chris Li <chrisl@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, akpm@linux-foundation.org, 
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

On Thu, Dec 14, 2023 at 2:55=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Thu, Dec 14, 2023 at 2:11=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Thu, Dec 14, 2023 at 09:34:06AM -0800, Christopher Li wrote:
> > > On Thu, Dec 14, 2023 at 9:11=E2=80=AFAM Johannes Weiner <hannes@cmpxc=
hg.org> wrote:
> > >
> > > > > Hi Johannes,
> > > > >
> > > > > I haven't been following the thread closely, but I noticed the di=
scussion
> > > > > about potential use cases for zram with memcg.
> > > > >
> > > > > One interesting idea I have is to implement a swap controller per=
 cgroup.
> > > > > This would allow us to tailor the zram swap behavior to the speci=
fic needs of
> > > > > different groups.
> > > > >
> > > > > For example, Group A, which is sensitive to swap latency, could u=
se zram swap
> > > > > with a fast compression setting, even if it sacrifices some compr=
ession ratio.
> > > > > This would prioritize quick access to swapped data, even if it ta=
kes up more space.
> > > > >
> > > > > On the other hand, Group B, which can tolerate higher swap latenc=
y, could benefit
> > > > > from a slower compression setting that achieves a higher compress=
ion ratio.
> > > > > This would maximize memory efficiency at the cost of slightly slo=
wer data access.
> > > > >
> > > > > This approach could provide a more nuanced and flexible way to ma=
nage swap usage
> > > > > within different cgroups.
> > > >
> > > > That makes sense to me.
> > > >
> > > > It sounds to me like per-cgroup swapfiles would be the easiest
> > > > solution to this. Then you can create zram devices with different
> > > > configurations and assign them to individual cgroups.
> > >
> > > Ideally you need zram then following swap file after the zram. That
> > > would be a list of the swap files rather than just one swapfile per
> > > cgroup.
> > >
> > > > This would also apply to Kairu's usecase: assign zrams and hdd back=
ups
> > > > as needed on a per-cgroup basis.
> > >
> > > Same there, Kairui's request involves ZRAM and at least one extra swa=
p
> > > file. In other words, you really need a per cgroup swap file list.
> >
> > Why is that a problem?
>
> It is not a problem. It is the necessary infrastructure to support the
> requirement. I am merely saying just having one swap file is not
> enough.
>
> >
> > swapon(zram, cgroup=3Dfoo)
> > swapon(hdd, cgroup=3Dfoo)
>
> Interesting idea. I assume you want to use swapon/swapoff to turn on
> off a device for a specific cgroup.
> That seems to implite each cgroup will have a private copy of the swap
> device list.
>
> I have considered the memory.swap.tiers for the same thing, with one
> minor optimization. The list is system wide maintained with a name.
> The per cgroup just has a pointer to that named list. There shouldn't
> be too many such lists of swap back end combinations on the system.
>
> We are getting into the weeds. The bottom line is, we need to have per
> cgroup a swap file list. That is the necessary evil we can't get away
> with.

Highly agree. This is getting waaayyyy too deep into the weeds, and
the conversation has practically spiralled out of the original
intention of this patch - its purported problem and proposed solution.

Not to say that none of this is useful, but I sense that we first need
to do the following:

a) List out the requirements that the new interface has to support:
the tiers made available to the cgroup, hierarchical structure (i.e do
we want a tier list to have more than 1 non-zswap level? Maybe we
won't need it after all, in which case the swapon solution is perhaps
sufficient).
b) Carefully evaluate the proposed candidates. It could be an altered
memory.swap.tiers, or an extended swapon/swapoff.

Perhaps we should organize a separate meeting or email thread to
discuss this in detail, and write out proposed solutions for everyone
to evaluate. In the meantime, I think that we should merge this new
knob as-is.

>
> >
> > > > In addition, it would naturally solve scalability and isolation
> > > > problems when multiple containers would otherwise be hammering on t=
he
> > > > same swap backends and locks.
> > > >
> > > > It would also only require one, relatively simple new interface, su=
ch
> > > > as a cgroup parameter to swapon().
> > > >
> > > > That's highly preferable over a complex configuration file like
> > > > memory.swap.tiers that needs to solve all sorts of visibility and
> > > > namespace issues and duplicate the full configuration interface of
> > > > every backend in some new, custom syntax.
> > >
> > > If you don't like the syntax of memory.swap.tiers, I am open to
> > > suggestions of your preferred syntax as well. The essicents of the
> > > swap.tiers is a per cgroup list of the swap back ends. The names impl=
y
> > > that. I am not married to any given syntax of how to specify the list=
.
> > > Its goal matches the above requirement pretty well.
> >
> > Except Minchan said that he would also like different zram parameters
> > depending on the cgroup.
>
> Minchan's requirement is new. We will need to expand the original
> "memory.swap.tiers" to support such usage.
>
> > There is no way we'll add a memory.swap.tiers with a new configuration
> > language for backend parameters.
> >
>
> I agree that we don't want a complicated configuration language for
> "memory.swap.tiers".
>
> Those backend parameters should be configured on the back end side.
> The "memory.swap.tiers" just reference the already configured object.
> Just brainstorming:
> /dev/zram0 has compression algo1 for fast speed low compression ratio.
> /dev/zram1 has compression algo2 for slow speed high compression ratio.
>
> "memory.swap.tiers" point to zram0 or zram1 or a custom list has "zram0 +=
 hdd"
>
> Chris

