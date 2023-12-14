Return-Path: <linux-kernel+bounces-175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA507813D14
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7271F22680
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F06720F;
	Thu, 14 Dec 2023 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="c9Smu2Ty"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F43671F0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-77f35b70944so3618285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 14:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1702591910; x=1703196710; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kjwv3SJYpxnhyyliVohhGYpPw4WBD1Rbfb+MQW+rnxI=;
        b=c9Smu2TyHybC9NOCYsUKjdGLXnEbUoyxwh7cvwC2fzsAlLYfbsJ8C6qRUQF4BIiX/P
         Evmq/fB3uvTCTIn/fIGDDnlNi/0JmqBxz7G+IRQo7492DOlzJ1CBUQfFtH8k7cxsjJRK
         q/gBjrBAt6i12yZoioi4Xr7glzfZcExr0SnI1RM63SB/w588PNc3smcpbTPScVcqObsz
         2XttILSKIxbR/VAuOBdAwv3p2VUz56VAs9O5lgn2QG+4QOqQwscURgYsVP/qtU6ruqip
         f6q/0hjsp7rjvN1fCwBLG98zmH8AgS5+SKyw2GkzpPqLXyL2SGiRkTHbOtggiyCJftBM
         /Xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702591910; x=1703196710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjwv3SJYpxnhyyliVohhGYpPw4WBD1Rbfb+MQW+rnxI=;
        b=mGQ8fKBqySBYqKHqD/jwEzmxxxvwz0HqJsLIhxWAMpaMbvIBWoGM/VjUCusLYDmtEv
         CUOJx8gW/PMNru7EyNm+jo+OAbWdsO9FJP3siip1Jb9pXiaWC7dSv8MKoD6kN0x0/iyw
         29ZNjUb5kTvKVIDtulBdmkIYgRNNOj3xMeFeL8in5qLo1cGbvQTF6BN02KjYe8HKD3pD
         BWwUaTr7ElFtVLjv+VjJN6o+zE7hqbvo4lEX9YFI5d/hJ3IE1Nh2fHyGkEHR1bzak3vr
         Zdw8uI0s5ZQUHQ2qRKhRRGUl4v/s14hwdR4hLHXzONESISWoKG3nw7GQ2qHUaVNEdQKJ
         rfGw==
X-Gm-Message-State: AOJu0YyTSTXtn1KD+BqlFPlbJkmfHxCHZTgj29Cs4Ztqcab07iqWftXt
	wEZlpBp7m3sooXuW2ON+wfMyjQ==
X-Google-Smtp-Source: AGHT+IH8MEU6gyt/5zMK0G9MuFTf5ejKeS/GhVs9rnBbhhJ/HrYy6VGWyrA6SqrFUQ2kzJV6LwpxRA==
X-Received: by 2002:a05:620a:1a91:b0:77f:36a7:1437 with SMTP id bl17-20020a05620a1a9100b0077f36a71437mr15760905qkb.114.1702591910653;
        Thu, 14 Dec 2023 14:11:50 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:a0a6])
        by smtp.gmail.com with ESMTPSA id dv8-20020a05620a1b8800b0077dbdc40458sm5660153qkb.1.2023.12.14.14.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:11:50 -0800 (PST)
Date: Thu, 14 Dec 2023 17:11:40 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christopher Li <chrisl@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	akpm@linux-foundation.org, tj@kernel.org, lizefan.x@bytedance.com,
	cerasuolodomenico@gmail.com, yosryahmed@google.com,
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
	konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	david@ixit.cz, Kairui Song <kasong@tencent.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
Message-ID: <20231214221140.GA269753@cmpxchg.org>
References: <20231207192406.3809579-1-nphamcs@gmail.com>
 <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
 <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com>
 <20231209034229.GA1001962@cmpxchg.org>
 <ZXeTb_ACou7TEVsa@google.com>
 <20231214171137.GA261942@cmpxchg.org>
 <CANeU7QnR+4Lgt8D9Z+Zo3Ydktx_7n45K0b=kVj+qSOzT=5GGQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANeU7QnR+4Lgt8D9Z+Zo3Ydktx_7n45K0b=kVj+qSOzT=5GGQA@mail.gmail.com>

On Thu, Dec 14, 2023 at 09:34:06AM -0800, Christopher Li wrote:
> On Thu, Dec 14, 2023 at 9:11 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > > Hi Johannes,
> > >
> > > I haven't been following the thread closely, but I noticed the discussion
> > > about potential use cases for zram with memcg.
> > >
> > > One interesting idea I have is to implement a swap controller per cgroup.
> > > This would allow us to tailor the zram swap behavior to the specific needs of
> > > different groups.
> > >
> > > For example, Group A, which is sensitive to swap latency, could use zram swap
> > > with a fast compression setting, even if it sacrifices some compression ratio.
> > > This would prioritize quick access to swapped data, even if it takes up more space.
> > >
> > > On the other hand, Group B, which can tolerate higher swap latency, could benefit
> > > from a slower compression setting that achieves a higher compression ratio.
> > > This would maximize memory efficiency at the cost of slightly slower data access.
> > >
> > > This approach could provide a more nuanced and flexible way to manage swap usage
> > > within different cgroups.
> >
> > That makes sense to me.
> >
> > It sounds to me like per-cgroup swapfiles would be the easiest
> > solution to this. Then you can create zram devices with different
> > configurations and assign them to individual cgroups.
> 
> Ideally you need zram then following swap file after the zram. That
> would be a list of the swap files rather than just one swapfile per
> cgroup.
>
> > This would also apply to Kairu's usecase: assign zrams and hdd backups
> > as needed on a per-cgroup basis.
> 
> Same there, Kairui's request involves ZRAM and at least one extra swap
> file. In other words, you really need a per cgroup swap file list.

Why is that a problem?

swapon(zram, cgroup=foo)
swapon(hdd, cgroup=foo)

> > In addition, it would naturally solve scalability and isolation
> > problems when multiple containers would otherwise be hammering on the
> > same swap backends and locks.
> >
> > It would also only require one, relatively simple new interface, such
> > as a cgroup parameter to swapon().
> >
> > That's highly preferable over a complex configuration file like
> > memory.swap.tiers that needs to solve all sorts of visibility and
> > namespace issues and duplicate the full configuration interface of
> > every backend in some new, custom syntax.
> 
> If you don't like the syntax of memory.swap.tiers, I am open to
> suggestions of your preferred syntax as well. The essicents of the
> swap.tiers is a per cgroup list of the swap back ends. The names imply
> that. I am not married to any given syntax of how to specify the list.
> Its goal matches the above requirement pretty well.

Except Minchan said that he would also like different zram parameters
depending on the cgroup.

There is no way we'll add a memory.swap.tiers with a new configuration
language for backend parameters.

