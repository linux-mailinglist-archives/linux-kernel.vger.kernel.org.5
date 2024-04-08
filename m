Return-Path: <linux-kernel+bounces-135242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 430BC89BDA1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55E8284906
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BD6612F5;
	Mon,  8 Apr 2024 10:57:08 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065AF5F861;
	Mon,  8 Apr 2024 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573827; cv=none; b=tVCwlnx1yVlevo93RN95oUtPPq/5/t3xnNB+mNaK0byDpeuG+/QlmZoQgZKA9AJvUJjbgwd2fAItMkOcVrUV0hJOkrc3p68is40yweeNPVr8ZTQy7W49uhdvMT1hWfcKCy8C0MwOJFmG0rNJyJaSfmGFtGVMrLNwTP9jcSJOsuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573827; c=relaxed/simple;
	bh=f6NiEl26Ym6V484daiGIUK9s0ZRs8CyTVr6wQNiEtys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUKmFVPo29W04v/Wm7v3NEvvnhZNhP9J9KzamRWYRgEqwDOj5KdeEKBh6Qidm+WiiXVxUDYqwp+109FCj3TO44BQRx8eiaK1MYmd8/dXkYBnkKfWrVGAeZDgsAhJNRwdwaeQsQKBOyIMBGEvMRUKPuTFxns9+EAASKA928CLKfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-0c-6613cd78f8c3
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com
Subject: Re: [RFC PATCH v3 0/7] DAMON based tiered memory management for CXL memory
Date: Mon,  8 Apr 2024 19:56:30 +0900
Message-ID: <20240408105635.2927-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240405192800.67163-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsXC9ZZnkW7FWeE0g2VT+C0m9hhYzFm/hs1i
	140Qi/sPXrNb/N97jNHiyf/frBYnbjayWXR+X8picXnXHDaLe2v+s1ocWX+WxWLz2TPMFouX
	q1ns63jAZHH46xsmi8mXFrBZvJhyhtHi5KzJLBazj95jdxD2WHr6DZvHhiYgsXPWXXaPln23
	2D0WbCr1aDnyltVj8Z6XTB6bVnWyeWz6NInd48SM3yweOx9aerzYPJPRo7f5HZvH501yAXxR
	XDYpqTmZZalF+nYJXBmbpj1kLFjFX3H+dxtTA+N37i5GTg4JAROJQ2c3ssDYR04tYAax2QTU
	JK68nMQEYosIKEqce3yRtYuRi4NZYAaLxOGFXYwgCWGBYInFf2ezg9gsAqoSOyf9B2vmFTCT
	OL7qFxvEUE2Jx9t/gtVwChhLvH70DKxXSIBH4tWG/YwQ9YISJ2c+ATuCWUBeonnrbGaQZRIC
	h9gldnzuYoIYJClxcMUNlgmM/LOQ9MxC0rOAkWkVo1BmXlluYmaOiV5GZV5mhV5yfu4mRmDk
	Lav9E72D8dOF4EOMAhyMSjy8JyYKpQmxJpYVV+YeYpTgYFYS4Q02FUwT4k1JrKxKLcqPLyrN
	SS0+xCjNwaIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwGgZ9SLjuEaultkknrsOmSE+Vp6t
	m4rYo6tNJjsGvZJb/cbgzJUfeQKL3d49PVs+Q3NaoX/06pZ4vWvzw593rPQ5uWFa5senGyPW
	5nxQd5S9KFo2+Y/+cc6K9BXrud/fE5z93fPl0ZL4RMYD6TsDVOYv2XX1dntk+qcoBUfz9U+1
	ZdYlZfzSnajEUpyRaKjFXFScCACIMt/NuAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsXCNUNLT7f8rHCawZMGS4uJPQYWc9avYbPY
	dSPE4v6D1+wW//ceY7R48v83q8WJm41sFp1PvjNaHJ57ktWi8/tSFovLu+awWdxb85/V4sj6
	sywWm8+eYbZYvFzN4tC156wW+zoeMFkc/vqGyWLypQVsFi+mnGG0ODlrMovF7KP32B3EPJae
	fsPmsaEJSOycdZfdo2XfLXaPBZtKPVqOvGX1WLznJZPHplWdbB6bPk1i9zgx4zeLx86Hlh4v
	Ns9k9Ohtfsfm8e22h8fiFx+YPD5vkgsQiOKySUnNySxLLdK3S+DK2DTtIWPBKv6K87/bmBoY
	v3N3MXJySAiYSBw5tYAZxGYTUJO48nISE4gtIqAoce7xRdYuRi4OZoEZLBKHF3YxgiSEBYIl
	Fv+dzQ5iswioSuyc9B+smVfATOL4ql9sEEM1JR5v/wlWwylgLPH60TOwXiEBHolXG/YzQtQL
	Spyc+YQFxGYWkJdo3jqbeQIjzywkqVlIUgsYmVYximTmleUmZuaY6hVnZ1TmZVboJefnbmIE
	xtiy2j8TdzB+uex+iFGAg1GJh9eDSThNiDWxrLgy9xCjBAezkghvsKlgmhBvSmJlVWpRfnxR
	aU5q8SFGaQ4WJXFer/DUBCGB9MSS1OzU1ILUIpgsEwenVAOjXLWr9sYjr+SX3vyh7eooebUv
	Q/xfgfV9rWwWxoNMr9iiznROvBC9e8p6WU65V9fOb24W22NieI/x4ewny5007JbumzxDSmuq
	pmn2HLPKKQpX95yLM/OYeXIqm8TviYEKYTNnpf3rlH18zNupUU5kf5Ly1rsiy9yUY5tTwm/5
	3ZRnT82SWPVAiaU4I9FQi7moOBEAzndwPa0CAAA=
X-CFilter-Loop: Reflected

Hi SeongJae,

On Fri,  5 Apr 2024 12:28:00 -0700 SeongJae Park <sj@kernel.org> wrote:
> Hello Honggyu,
> 
> On Fri,  5 Apr 2024 15:08:49 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> > posted at [1].
> > 
> > It says there is no implementation of the demote/promote DAMOS action
> > are made.  This RFC is about its implementation for physical address
> > space.
> > 
> > 
> > Changes from RFC v2:
> >   1. Rename DAMOS_{PROMOTE,DEMOTE} actions to DAMOS_MIGRATE_{HOT,COLD}.
> >   2. Create 'target_nid' to set the migration target node instead of
> >      depending on node distance based information.
> >   3. Instead of having page level access check in this patch series,
> >      delegate the job to a new DAMOS filter type YOUNG[2].
> >   4. Introduce vmstat counters "damon_migrate_{hot,cold}".
> >   5. Rebase from v6.7 to v6.8.
> 
> Thank you for patiently keeping discussion and making this great version!  I
> left comments on each patch, but found no special concerns.  Per-page access
> recheck for MIGRATE_HOT and vmstat change are taking my eyes, though.  I doubt
> if those really needed.  It would be nice if you could answer to the comments.

I will answer them where you made the comments.

> Once my comments on this version are addressed, I would have no reason to
> object at dropping the RFC tag from this patchset.

Thanks.  I will drop the RFC after addressing your comments.

> Nonetheless, I show some warnings and errors from checkpatch.pl.  I don't
> really care about those for RFC patches, so no problem at all.  But if you
> agree to my opinion about RFC tag dropping, and therefore if you will send next
> version without RFC tag, please make sure you also run checkpatch.pl before
> posting.

Sure.  I will run checkpatch.pl from the next revision.

Thanks,
Honggyu

> 
> Thanks,
> SJ
> 
> [...]

