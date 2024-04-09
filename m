Return-Path: <linux-kernel+bounces-136550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C71BB89D579
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0F81F239A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9587F7CF;
	Tue,  9 Apr 2024 09:24:59 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE5B7F482
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654698; cv=none; b=eKcmeBEh5q5ieQROeCUBDeOVY2Cu8lxbliE+KtgF92ws+MBE2a55WWFdfxCjnxmn1jFZn0wVLUO4HtjjnE08DcAbia2G3XC73ygX+QJXuieE3x/kPHBZuAk3zAbBTLdDPfLZrhx0fgNC8yBhpjgNcbtrPHtjWNPF9LYNTxxf3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654698; c=relaxed/simple;
	bh=fVzMBpVHDCYnJyjVzpHAN3PRUyFt/fDMP73sAiKyMqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c94yi1Qu6X16I89PyyK2OVjpAcnXTixBQADCrd1Eu5pLOcx06nnz4xB+AuX/OfHlVgKZgm8I5OHEj6pJOaxh84BApstza/CJNaUInLUndAsyGbmr8/Z1FQ4lClB6HgNJaUbojG9xz6zgXCTNB49HW6cfRlSmVOEoSu0Gkg9EW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-7f-661509649d67
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] mm/damon: add a DAMOS filter type for page granularity access recheck
Date: Tue,  9 Apr 2024 18:24:31 +0900
Message-ID: <20240409092434.3031-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240311204545.47097-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsXC9ZZnoW4Kp2iaweJDZhZP/v9mtbi8aw6b
	xb01/1ktDn99w+TA4rFpVSebx6ZPk9g9XmyeyejxeZNcAEsUl01Kak5mWWqRvl0CV8aliX+Z
	ClYIVTRcPs7WwPiZr4uRk0NCwESi581Xti5GDjB78v4gkDCbgJrElZeTmEBsEQFFiXOPL7J2
	MXJxMAtMZ5TYeGIzK0hCWCBV4sbcPrAiFgFVid8v37CD2LwCZhLrp11lh5ivKfF4+08wm1PA
	WOL465NgvUICPBKvNuxnhKgXlDg58wkLiM0sIC/RvHU2M8gyCYEZbBKd698yQQySlDi44gbL
	BEb+WUh6ZiHpWcDItIpRKDOvLDcxM8dEL6MyL7NCLzk/dxMjMAyX1f6J3sH46ULwIUYBDkYl
	Hl6Lq8JpQqyJZcWVuYcYJTiYlUR4g00F04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxES
	SE8sSc1OTS1ILYLJMnFwSjUwTov7HcNzQTlqjxmne+ApsVcGnCEvhHxeB0UxOe+tsuDtnq3M
	pNRcPitlmrud5oGItJsvn6cFvMw7L/yWVXyOpIOI7hOTDXKOm57dvycRYHLkHbdQkIzi94tv
	rxjzfNFp23/yxJ4a3V0cOUdL4g2D7sydnCKp83ASG/ejwp4b65rCys38fwcqsRRnJBpqMRcV
	JwIAHN1XZT8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsXCNUNLTzeFUzTN4O42I4sn/3+zWnx+9prZ
	ovPJd0aLw3NPslpc3jWHzeLemv+sFoe/vmFyYPfYtKqTzWPTp0nsHi82z2T0+Hbbw2Pxiw9M
	Hp83yQWwRXHZpKTmZJalFunbJXBlXJr4l6lghVBFw+XjbA2Mn/m6GDk4JARMJCbvD+pi5ORg
	E1CTuPJyEhOILSKgKHHu8UXWLkYuDmaB6YwSG09sZgVJCAukStyY2wdWxCKgKvH75Rt2EJtX
	wExi/bSrYLaEgKbE4+0/wWxOAWOJ469PgvUKCfBIvNqwnxGiXlDi5MwnLCA2s4C8RPPW2cwT
	GHlmIUnNQpJawMi0ilEkM68sNzEzx1SvODujMi+zQi85P3cTIzDgltX+mbiD8ctl90OMAhyM
	Sjy8DneE04RYE8uKK3MPMUpwMCuJ8AabCqYJ8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00Q
	EkhPLEnNTk0tSC2CyTJxcEo1MOYLVq/J+B4XG6S5R8f8SNmatP3GMp0zlpmJNt+XtOZaIrz7
	aT97xs7C97fqA8xZD79miZ6UspaldXmFesKE69PvTrfa+HDnrQiOJNMrt0QmphmaHfKZ6WRR
	PXdfheOOUzGKJhKuxZ1b+D4ufnA5xHTbVu1pN/v+Tby3bYnXr+PH1srffW6bwabEUpyRaKjF
	XFScCAAwE2uBNAIAAA==
X-CFilter-Loop: Reflected

Hi SeongJae,

On Mon, 11 Mar 2024 13:45:41 -0700 SeongJae Park <sj@kernel.org> wrote:
> Changes from RFC v1
> (https://lore.kernel.org/r/20240307030013.47041-1-sj@kernel.org)
> - Rename __damon_pa_young() to damon_folio_young_one()
> - Mark the folio as old from the filter for the next check
> 
> DAMON allows users to specify desired ranges of overhead and accuracy of
> the monitoring, and do its best effort to make most lightweight and
> accurate results.  A recent discussion for tiered memory management
> support from DAMON[1] revealed that the best effort accuracy may not
> suffice in some use cases, while increasing the minimum accuracy can
> incur too high overhead.  The discussion further concluded finding
> memory regions of specific access pattern via DAMON first, and then
> double checking the access of the region again in finer granularity
> could help increasing the accuracy while keeping the low overhead.
> 
> Add a new type of DAMOS filter, namely YOUNG for such a case.  Like anon
> and memcg, the type of filter is applied to each page of the memory
> region of DAMOS target memory region, and check if the page is accessed
> since the last check.  Because this is a filter type that applied in
> page granularity, the support depends on DAMON operations set.  Because
> there are expected usages of this filter for physical address space
> based DAMOS usage[1], implement the support for only DAMON operations
> set for the physical address space, paddr.
> 
> [1] https://lore.kernel.org/r/20240227235121.153277-1-sj@kernel.org
> 
> 
> SeongJae Park (4):
>   mm/damon/paddr: implement damon_folio_young()
>   mm/damon/paddr: implement damon_folio_mkold()
>   mm/damon: add DAMOS filter type YOUNG
>   mm/damon/paddr: support DAMOS filter type YOUNG

I have tested your patches for evaluation of [1] and it all works fine.
Thanks very much for doing this work!

Tested-by: Honggyu Kim <honggyu.kim@sk.com>

[1] https://lore.kernel.org/damon/20240405060858.2818-1-honggyu.kim@sk.com

>  include/linux/damon.h    |  2 ++
>  mm/damon/paddr.c         | 64 +++++++++++++++++++++++++---------------
>  mm/damon/sysfs-schemes.c |  1 +
>  3 files changed, 43 insertions(+), 24 deletions(-)
> 
> 
> base-commit: 13043cde46a19e72d37965b67b74e564623f65e7
> -- 
> 2.39.2
> 

