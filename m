Return-Path: <linux-kernel+bounces-695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 042468144C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86341F21070
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385941865A;
	Fri, 15 Dec 2023 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHhvqwen"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6E7182C3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25105C433CB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702633246;
	bh=vVpmxdeUmcOhDj8UvS9uojHcu7m53pDfJgItKw2MeOo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KHhvqwen/RLPuNr7ABccWxNkon+Qc3eIA3eWWTIFEDdt+p4s2TPl5UehB1jzPvSkt
	 LvAxBBuSG7gBt3IL73uYGw/lazeTUyF7xBBKdyH+WiXu+hS2JCqdEHQSoUoAEcx6Gq
	 qub5vDlyMwDe65hSDU60v6RIVUdSXcVrfTaXhF8UlGmcomUR/lGIaChWuCqxkIjx5N
	 hgjoRpbC32IvMjdmQKOZGnqDHygLrDridtpPDAkTjgGwVG8mMrCpTmZLqalC1QjtIY
	 lS11o6sQqNkFA4REuMVYMvNC8bZix0+nzd4+sMwgTFp/HOqmMVmzc1SJGdJnaypePY
	 Ju3gWJ66qpEXQ==
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ce72faf1e8so198648b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 01:40:46 -0800 (PST)
X-Gm-Message-State: AOJu0Yw/OrOuqYddyz52m0+IT4MUtyCyPrGHDRMFXo2MKYMQaiA0tb0s
	F/mFuSDRNZJcoV4AaiWWQ0MD/j8W082DTu5n8cuPcQ==
X-Google-Smtp-Source: AGHT+IGFpMfw5GVwdU1bv9gHE5DcEHMKFKSN1w+PyKECjS7he1nzY4esromMqlEbNOSnmh4B2nwnj3VlCNgz8AtqcNk=
X-Received: by 2002:a05:6a20:77a9:b0:18f:97c:8256 with SMTP id
 c41-20020a056a2077a900b0018f097c8256mr5200831pzg.96.1702633224789; Fri, 15
 Dec 2023 01:40:24 -0800 (PST)
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
 <20231214171137.GA261942@cmpxchg.org> <CAOUHufbvafDiURT9qBjKPpRSNwc60S-bDg2yMH_m4bNSWQcV4g@mail.gmail.com>
 <CA+PVUaR9EtUMke-K8mM0gmJXdOm9equ1JHqBjZ0T5V0tiHVc8Q@mail.gmail.com>
 <CAF8kJuMLDOaP6-Xyz-+hzLbDuYW7gfG9jA06j6t5v7XX2rPOdw@mail.gmail.com> <CA+PVUaRxXdndKCodgPKFcsCUQwO-8mGtU65OkkudoR-8rB=KaA@mail.gmail.com>
In-Reply-To: <CA+PVUaRxXdndKCodgPKFcsCUQwO-8mGtU65OkkudoR-8rB=KaA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 15 Dec 2023 01:40:12 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMKCu=Bf4K6RryFdGGgC+RhyanwaXc-ZGtURk7Wbckq6Q@mail.gmail.com>
Message-ID: <CAF8kJuMKCu=Bf4K6RryFdGGgC+RhyanwaXc-ZGtURk7Wbckq6Q@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To: Fabian Deutsch <fdeutsch@redhat.com>
Cc: Yu Zhao <yuzhao@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Minchan Kim <minchan@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "tj@kernel.org" <tj@kernel.org>, 
	"lizefan.x@bytedance.com" <lizefan.x@bytedance.com>, 
	"cerasuolodomenico@gmail.com" <cerasuolodomenico@gmail.com>, 
	"yosryahmed@google.com" <yosryahmed@google.com>, "sjenning@redhat.com" <sjenning@redhat.com>, 
	"ddstreet@ieee.org" <ddstreet@ieee.org>, "vitaly.wool@konsulko.com" <vitaly.wool@konsulko.com>, 
	"mhocko@kernel.org" <mhocko@kernel.org>, "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>, 
	"shakeelb@google.com" <shakeelb@google.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>, 
	"hughd@google.com" <hughd@google.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, 
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>, "rppt@kernel.org" <rppt@kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "kernel-team@meta.com" <kernel-team@meta.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "david@ixit.cz" <david@ixit.cz>, 
	Kairui Song <kasong@tencent.com>, Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 11:42=E2=80=AFPM Fabian Deutsch <fdeutsch@redhat.co=
m> wrote:.
> >
> > Just to clarify, the "node" you mean the "node" in kubernetes sense,
> > which is the whole machine. In the Linux kernel MM context, the node
> > often refers to the NUMA memory node, that is not what you mean here,
> > right?
>
> Correct, I was referring to a kubernetes node, not numa node.
>
> >
> >> - With todays node level swap, and setting memory.swap.max=3D0 for all=
 cgroups allows you toachieve a similar behavior (only opt-in cgroups will =
get swap).
> >> - the above approach however will still have a shared swap backend for=
 all cgroups.
> >
> > Yes, the "memory.swap.tires" idea is trying to allow cgroups to select
> > a subset of the swap backend in a specific order. It is still in the
> > early stage of discussion. If you have any suggestion or feedback in
> > that direction, I am looking forward to hearing that.
>
> Interesting. There have been concerns to leak confidential data accidenta=
lly when it's getting written to a swap device.

One common solution is to encrypt the data written to the device. If
someone gets hold of the swapped outed device without the key, they
can't get to the memory data without the key.

> The other less discussed item was QoS for swap io traffic.
>
> At a first glance it seems like tires could help with the second use-case=
.

The idea is that you can select the swap tiers list for each cgroup.
That way  you can assign different swap QoS to different cgroup.

Chris

