Return-Path: <linux-kernel+bounces-179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA8813D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449931F22852
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED5B67209;
	Thu, 14 Dec 2023 22:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WX7H+Zrw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60683671E8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F662C433C8;
	Thu, 14 Dec 2023 22:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702592222;
	bh=2D9nG2KNudL+10rZMcKkKt/VtIVyh9wWPQJtsj2OmR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WX7H+ZrwBVrU3L1JS5De2zQh+c0BePlKvIWJc5LefMj36TYdyIPyIw3K38DgoEEWG
	 jYwV2WvZdxeUat7eT0WhN8zQgD6v9xD/u3ern3xb7nSLxsDB09A3d7PKyyJPtJBmVA
	 S4g5xo9qcSqYFX6zN/b7RpYjvP7M4VPQ73X3aRZc=
Date: Thu, 14 Dec 2023 14:17:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Mel Gorman <mgorman@techsingularity.net>, baolin.wang@linux.alibaba.com,
 linux-mm@kvack.org, david@redhat.com, hannes@cmpxchg.org,
 huzhanyuan@oppo.com, linux-kernel@vger.kernel.org,
 shikemeng@huaweicloud.com, v-songbaohua@oppo.com, willy@infradead.org
Subject: Re: [PATCH] mm: compaction: avoid fast_isolate_freepages blindly
 choose improper pageblock
Message-Id: <20231214141701.29aef9815d3e743645786c1e@linux-foundation.org>
In-Reply-To: <CAGsJ_4zYq2d757BBeQ=2HhksdChvK_i+Srp_Rxw3tcu4YWEcNQ@mail.gmail.com>
References: <20231206110054.61617-1-v-songbaohua@oppo.com>
	<20231213130231.ksban2ovad4q4rxj@techsingularity.net>
	<CAGsJ_4zYq2d757BBeQ=2HhksdChvK_i+Srp_Rxw3tcu4YWEcNQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 14 Dec 2023 09:34:35 +0800 Barry Song <21cnbao@gmail.com> wrote:

> > > Reported-by: Zhanyuan Hu <huzhanyuan@oppo.com>
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >
> > Acked-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Hi Mel,
> Thanks!
> 
> Hi Andrew,
> Given this patch has been in mm-stable,
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-stable&id=d19b1a1797
> does it still have a chance to collect Mel's tag？

That would require a rebuild of mm-stable, which is also a rebase.  I
don't think I've had to do that before - I'll occasionally rebase, but
just to drop things - not a full rebuild from the quilt patches.

If I end up having to do that then I'll somehow try to remember to make
this change.

