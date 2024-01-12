Return-Path: <linux-kernel+bounces-25049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D7D82C6DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B701F24188
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5D5171DC;
	Fri, 12 Jan 2024 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUdXMClq"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0781641A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 21:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cf2306c1b4so2113706a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705095786; x=1705700586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IJygVZYI1Js+sT6W/6Wc737k3az8hHGREjNmyKNJOw=;
        b=mUdXMClqHxlqgqnKPEnEBWHytO003oLuhC6NOoC5h9QKdXuecan2+SQ6gdGNM49mCE
         Q6mgm70OASxTt7G/oMrnXLgMjVF5BGqdAxa8nrVNl/cvnr3/RgDCPU6cgmIbnOVXmeDW
         ToXEO5fHys4qpFGBzXkQgBtV+msSbrMDL+jQ0k3cND/BtiAGMq3p2e02gNCpwhFlQWvp
         DFFgp3tjNsF/blw/FYMaJnpThSLvn7bVV7mDKaC2HD0peAi15tvcKrXXaqHkfYDYIo7K
         I7MYN2F3kjm2T8v2MJ1hqhmmOO3xGSoj07zFQjl5p4pkmNfSmwdpMkW+SJfgXhokERmO
         bZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705095786; x=1705700586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IJygVZYI1Js+sT6W/6Wc737k3az8hHGREjNmyKNJOw=;
        b=XQz7JiQE3nntn2juiX9aiqbiJJaPRsEaTzkNbvI8RtDKRMzDD+AZtcQDdvsj7AP21N
         Bgj6gcZobgRxoX9SpR8ZVQOCHX0dvqU20YOxJGvDh1Uf0nnsoafvYl2w6iWXDd9aiFg5
         Nqw/3mDFkjBMkeS84GGfqvT9rSEKJT8OLpkmnmVtfUjfPpWHCT+n+a1JU8QYiEGQCGA+
         gDuPTU8YsonCP/mNQbwapN3PZhdiqHm4v6RU29Rv20AgvjlKXWA6KFs2D+1cjrkukqzs
         CTNJd9bIvq+WUVmGN29dGSazL9cx07Zh8tAdqDXFcKPtXP3WMgIyOLgC6dEc6aBTd6MF
         gOjQ==
X-Gm-Message-State: AOJu0Ywgn9Ul4xifFH+CyoEKgXm7N+L+9u4FImBwxJBOkDC6A+B6plAM
	L8KHcpZvPa6VJvWCX6xIvq8=
X-Google-Smtp-Source: AGHT+IEu/6D9/IECCFtd0+cthRTD6E49U6rFlv9D8sN+iSSPSGoLHxVxTE5nYF++KHkDe/hR3vxp1Q==
X-Received: by 2002:a05:6a20:8887:b0:199:de70:4786 with SMTP id d7-20020a056a20888700b00199de704786mr1334227pzf.82.1705095785734;
        Fri, 12 Jan 2024 13:43:05 -0800 (PST)
Received: from google.com ([2620:0:1000:8411:c5fc:b560:2bcb:b410])
        by smtp.gmail.com with ESMTPSA id so8-20020a17090b1f8800b0028e01fcf1f2sm2748206pjb.40.2024.01.12.13.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 13:43:04 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Fri, 12 Jan 2024 13:43:02 -0800
From: Minchan Kim <minchan@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Jianfeng Wang <jianfeng.w.wang@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [External] : Re: [PATCH] mm, oom: Add lru_add_drain() in
 __oom_reap_task_mm()
Message-ID: <ZaGyZgWbrxrsuymu@google.com>
References: <20240109091511.8299-1-jianfeng.w.wang@oracle.com>
 <ZZ5Zb3FYqY8FZgB3@tiehlicka>
 <1d866f1b-94b3-43ec-8f4c-2de31b82d3d1@oracle.com>
 <ZZ-q0PZ-XCDwA4oG@tiehlicka>
 <b2096bcb-bda6-4831-85a2-67759e783e4d@oracle.com>
 <20240111135404.609af4a26d0118c0d290f11c@linux-foundation.org>
 <897538a0-5ce6-484e-a9bc-4e61b3be2265@oracle.com>
 <ZaD9BNtXZfY2UtVI@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaD9BNtXZfY2UtVI@tiehlicka>

On Fri, Jan 12, 2024 at 09:49:08AM +0100, Michal Hocko wrote:
> On Thu 11-01-24 16:08:57, Jianfeng Wang wrote:
> > 
> > 
> > On 1/11/24 1:54 PM, Andrew Morton wrote:
> > > On Thu, 11 Jan 2024 10:54:45 -0800 Jianfeng Wang <jianfeng.w.wang@oracle.com> wrote:
> > > 
> > >>
> > >>> Unless you can show any actual runtime effect of this patch then I think
> > >>> it shouldn't be merged.
> > >>>
> > >>
> > >> Thanks for raising your concern.
> > >> I'd call it a trade-off rather than "not really correct". Look at
> > >> unmap_region() / free_pages_and_swap_cache() written by Linus. These are in
> > >> favor of this pattern, which indicates that the trade-off (i.e. draining
> > >> local CPU or draining all CPUs or no draining at all) had been made in the
> > >> same way in the past. I don't have a specific runtime effect to provide,
> > >> except that it will free 10s kB pages immediately during OOM.
> 
> You are missing an important point. Those two calls are quite different.
> oom_reaper unmaps memory after all the reclaim attempts have failed.
> That includes draining all sorts of caches on the way. Including
> draining LRU pcp cache (look for lru_add_drain_all in the reclaim path). 
>  
> > > I don't think it's necessary to run lru_add_drain() for each vma.  Once
> > > we've done it it once, it can be skipped for additional vmas.
> > > 
> > Agreed.
> > 
> > > That's pretty minor because the second and successive calls will be
> > > cheap.  But it becomes much more significant if we switch to
> > > lru_add_drain_all(), which sounds like what we should be doing here. 
> > > Is it possible?
> > >
> > What do you both think of adding lru_add_drain_all() prior to the for loop?
> 
> lru_add_drain_all relies on WQs. And we absolutely do not want to get
> oom_reaper stuck just because all the WQ is jammed. So no, this is
> actually actively harmful!

I completely agree. The oom_reap_task_mm function is also used for process_mrelease,
which is a critical path for releasing memory in Android and is typically used
under system pressure(not only for memory pressure but also CPU pressured at the
same time). The lru_add_drain_all function can take a long time to finish because
Android is susceptible to priority inversion among processes.

The better idea may enable remote draining with lru_add_drain_all, analogous to
the recent PCP modifications.

