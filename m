Return-Path: <linux-kernel+bounces-132801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E50899A6C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19B01C217D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EA2161913;
	Fri,  5 Apr 2024 10:13:42 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FB2161339;
	Fri,  5 Apr 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312022; cv=none; b=cUKLR/pXXqTG6zJm4lPmjZFLLWyVPF0KUbgrKXZeH1AdOfRA/4kUgTqc1H4C+9m1O+7iPCIL8sC/nF104ne8dAKhW/dELhxGbfOSa8R9D3cxdsYB0AoD7i2I4Tos7wvYKIfb1iS38LWFdeX1DAFhQOQKT9JE8H7wpAaQvHVcANw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312022; c=relaxed/simple;
	bh=LwBk8Tg6gmrWwVs84PJrcHAHXc38aGhozruApm71iwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZBNyVRHfcWea3HeuHWpHjMEL/dFPokU8qya7/v9v8e5LQuDi46R2k885WcvgsxCBDuzI5IF2epom5zAKLC/yXGqTLsMtaI3QzFDDwfxJmVRJu/slWxTu1yvz/uqzXPl04QQ/K7+sT9vrvliweIal5SjWyMUvfHK4AJ2sYuSHWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-5f-660fcecfde3b
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: Honggyu Kim <honggyu.kim@sk.com>,
	damon@lists.linux.dev,
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
	42.hyeyoo@gmail.com
Subject: Re: [RFC PATCH v2 0/7] DAMON based 2-tier memory management for CXL memory
Date: Fri,  5 Apr 2024 19:13:12 +0900
Message-ID: <20240405101316.2890-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240326230309.47079-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsXC9ZZnke75c/xpBt1tVhYTewws5qxfw2ax
	60aIxf+9xxgtnvz/zWpx4mYjm0Xn96UsFpd3zWGzuLfmP6vFkfVnWSw2nz3DbLF4uZrFvo4H
	TBaHv75hsph8aQGbxYspZxgtTs6azGIx++g9dgchj6Wn37B5bGgCEjtn3WX3aNl3i91jwaZS
	j5Yjb1k9Fu95yeSxaVUnm8emT5PYPU7M+M3isfOhpceLzTMZPXqb37F5fN4kF8AXxWWTkpqT
	WZZapG+XwJXx43gHa8FdgYre7++YGhin8nYxcnJICJhI/DvRwA5jf97yiwXEZhNQk7jychIT
	iC0ioChx7vFF1i5GLg5mgYUsEr3fN4AlhAWCJeae/c8IYrMIqEpMv/EabBCvgJnEsovHWCCG
	ako83v4TLM4pYCzxZNtZNhBbSIBH4tWG/YwQ9YISJ2c+AatnFpCXaN46mxlkmYTAIXaJk20T
	mSAGSUocXHGDZQIj/ywkPbOQ9CxgZFrFKJSZV5abmJljopdRmZdZoZecn7uJERhvy2r/RO9g
	/HQh+BCjAAejEg+vx1y+NCHWxLLiytxDjBIczEoivN0OvGlCvCmJlVWpRfnxRaU5qcWHGKU5
	WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGD1tPp1nd9rGfHJH6sZfm5MTVj+c/PTzzpxX
	tkIX7k6xu7i4we3CGo48katL2c49YjS6+pD5v+uN+seTXyf9FhauWnLp1OSkmef+vM076Ztj
	wjVDKsG1c9oNQVPv/IuhXWz/giuUwiX7XkW72q98HFN0d9W2ZoE3RYGJ0j6TDbc/nnCg1vWg
	+34lluKMREMt5qLiRABjQ3agswIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsXCNUNLT/f8Of40g/vL1S0m9hhYzFm/hs1i
	140Qi/97jzFaPPn/m9XixM1GNovPz14zW3Q++c5ocXjuSVaLzu9LWSwu75rDZnFvzX9WiyPr
	z7JYbD57htli8XI1i0PXnrNa7Ot4wGRx+OsbJovJlxawWbyYcobR4uSsySwWs4/eY3cQ81h6
	+g2bx4YmILFz1l12j5Z9t9g9Fmwq9Wg58pbVY/Gel0wem1Z1snls+jSJ3ePEjN8sHjsfWnq8
	2DyT0aO3+R2bx7fbHh6LX3xg8vi8SS5AIIrLJiU1J7MstUjfLoEr48fxDtaCuwIVvd/fMTUw
	TuXtYuTkkBAwkfi85RcLiM0moCZx5eUkJhBbREBR4tzji6xdjFwczAILWSR6v28ASwgLBEvM
	PfufEcRmEVCVmH7jNTuIzStgJrHs4jEWiKGaEo+3/wSLcwoYSzzZdpYNxBYS4JF4tWE/I0S9
	oMTJmU/A6pkF5CWat85mnsDIMwtJahaS1AJGplWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiB
	Mbas9s/EHYxfLrsfYhTgYFTi4fWYy5cmxJpYVlyZe4hRgoNZSYS324E3TYg3JbGyKrUoP76o
	NCe1+BCjNAeLkjivV3hqgpBAemJJanZqakFqEUyWiYNTqoHRtXLTnQvWpu3XZG6fz58ebOTs
	0v/i7L8rem+YPm4MZQ1apjntbrBLr51DdusE/V2N8rtdWW/aVt1ZavFZ59gJEYWnm62zKvZ+
	vut93LNKk+1QWpBTXWOAi/6E2/wiizvdLjSt65yRtv2xvxFHh9obr8fXxGdeNePbFKtuOfmY
	gKzSiu0BqUFKLMUZiYZazEXFiQD3vveyrQIAAA==
X-CFilter-Loop: Reflected

Hi SeongJae,

On Tue, 26 Mar 2024 16:03:09 -0700 SeongJae Park <sj@kernel.org> wrote:
> On Mon, 25 Mar 2024 15:53:03 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Mon, 25 Mar 2024 21:01:04 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> [...]
> > > On Fri, 22 Mar 2024 09:32:23 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > > On Fri, 22 Mar 2024 18:02:23 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> [...]
> > >
> > > I would like to hear how you think about this.
> > 
> > So, to summarize my humble opinion,
> > 
> > 1. I like the idea of having two actions.  But I'd like to use names other than
> >    'promote' and 'demote'.
> > 2. I still prefer having a filter for the page granularity access re-check.
> > 
> [...]
> > > I will join the DAMON Beer/Coffee/Tea Chat tomorrow as scheduled so I
> > > can talk more about this issue.
> > 
> > Looking forward to chatting with you :)
> 
> We met and discussed about this topic in the chat series yesterday.  Sharing
> the summary for keeping the open discussion.
> 
> Honggyu thankfully accepted my humble suggestions on the last reply.  Honggyu
> will post the third version of this patchset soon.  The patchset will implement
> two new DAMOS actions, namely MIGRATE_HOT and MIGRATE_COLD.  Those will migrate
> the DAMOS target regions to a user-specified NUMA node, but will have different
> prioritization score function.  As name implies, they will prioritize more hot
> regions and cold regions, respectively.

It's a late answer but thanks very much for the summary.  It was really
helpful discussion in the chat series.

I'm leaving a message so that anyone can follow for the update.  The v3
is posted at https://lore.kernel.org/damon/20240405060858.2818-1-honggyu.kim@sk.com.

> Honggyu, please feel free to fix if there is anything wrong or missed.

I don't have anything to fix from your summary.

> And thanks to Honggyu again for patiently keeping this productive discussion
> and their awesome work.

I appreciate your persistent support and kind reviews. 

Thanks,
Honggyu

> 
> Thanks,
> SJ
> 
> [...]

