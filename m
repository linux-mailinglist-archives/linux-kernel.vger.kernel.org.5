Return-Path: <linux-kernel+bounces-136535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AB689D545
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4605B1F21C3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA79F7F489;
	Tue,  9 Apr 2024 09:19:45 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8903B7E792
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654385; cv=none; b=JKZOkTBVjBSZZdFw/V6RkCCecnrCMg+TtZvR9GnZxwgwzHuX4wjJ94HxnnWpD4q+v3dISDEDSN09G8ymzgm4QrIvLzKLRuAmqZJ8oEtOWN2uL8W3PCBV40/nmkpXEJeVs9dGYVRCgqwTouS987g1Hl4kDT7KnaEp/4A0EZGjK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654385; c=relaxed/simple;
	bh=+QH8pQ8pxmAzwSQ6qHfXOk91jAy/6zzv7tELaUaMvE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqri8oAdPK+ZP2XBuuwoS1F55loUr7dpxw/7szTXdcr4CZ+YwdjiQ+yMSyYd3bfuxYM8WQNmUuqEdYovs0xgaByqOgxCPrPHF997Wz+xW53QlCSFRlMthqUc9Wjw++1TxF1wa5OWgCBTeXY0y4l93+dqUDS3PSR7qhoXlQGEaIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-25-6615082a1610
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: 
Date: Tue,  9 Apr 2024 18:18:09 +0900
Message-ID: <20240409091812.3003-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsXC9ZZnoa4Wh2iawdlflhZP/v9mtbi8aw6b
	xb01/1ktDn99w+TA4rFpVSebx6ZPk9g9XmyeyejxeZNcAEsUl01Kak5mWWqRvl0CV8biqV8Y
	C44JV6w/WNzA+Iu/i5GDQ0LARGLpjtwuRk4w8/Llr2wgNpuAmsSVl5OYQGwRAUWJc48vsnYx
	cnEwC0xnlNh4YjMrSEJYgFNiU/d5dhCbRUBVYsHjjWA2r4CZxNv2g+wQQzUlHm//CRUXlDg5
	8wkLiM0sIC/RvHU2M8hQCYGvrBJLl06HapCUOLjiBssERt5ZSHpmIelZwMi0ilEoM68sNzEz
	x0QvozIvs0IvOT93EyMwqJbV/onewfjpQvAhRgEORiUeXourwmlCrIllxZW5hxglOJiVRHiD
	TQXThHhTEiurUovy44tKc1KLDzFKc7AoifMafStPERJITyxJzU5NLUgtgskycXBKNTDqWnD5
	/FVb/SBf/ND211Nkr7+ZXuLv7303r449s82OtcDp7keGCsX85cnb79zZeP624oXr7f++705a
	1i1uEShluzLvyALGJBF+g65fX+MC1EU35Rzh6ghOeMW079rJNZJsVQukYt0i9qTyn4xNizvg
	4L/jw60nK0K2Hrx3bc5+2Xu9pXsPSNsosRRnJBpqMRcVJwIA7V/FaiYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkluLIzCtJLcpLzFFi42LhmqGlp6vFIZpm8Ou/nsWT/79ZLT4/e81s
	0fnkO6PF4bknWS0u75rDZnFvzX9Wi8Nf3zA5sHtsWtXJ5rHp0yR2jxebZzJ6fLvt4bH4xQcm
	j8+b5ALYorhsUlJzMstSi/TtErgyFk/9wlhwTLhi/cHiBsZf/F2MnBwSAiYSly9/ZQOx2QTU
	JK68nMQEYosIKEqce3yRtYuRi4NZYDqjxMYTm1lBEsICnBKbus+zg9gsAqoSCx5vBLN5Bcwk
	3rYfZIcYqinxePtPqLigxMmZT1hAbGYBeYnmrbOZJzByzUKSmoUktYCRaRWjSGZeWW5iZo6p
	XnF2RmVeZoVecn7uJkZgAC2r/TNxB+OXy+6HGAU4GJV4eB3uCKcJsSaWFVfmHmKU4GBWEuEN
	NhVME+JNSaysSi3Kjy8qzUktPsQozcGiJM7rFZ6aICSQnliSmp2aWpBaBJNl4uCUamDcX7Op
	iD30Q93GCaJXp7I0pTNXN3D4Ru0SN/V9/bTdZZ/sn68+evdj/3/W/t8qpPv73UP+A8rtjxYv
	8J6TfkS+b7nu9cmSD32tg89bZ29kSZ3Ycrbeiv3e+WnXDk47FZO/ssg4ZyV3vEWEmGw3t+m8
	9x8jGKa8Oaw/Z/fTiKwXkQbcZ4/POzdLiaU4I9FQi7moOBEAhApk3RwCAAA=
X-CFilter-Loop: Reflected

Subject: Re: [RFC PATCH v2 0/4] mm/damon: add a DAMOS filter type for page granularity access recheck
In-Reply-To: <20240311204545.47097-1-sj@kernel.org>

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

