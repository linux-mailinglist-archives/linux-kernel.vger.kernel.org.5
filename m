Return-Path: <linux-kernel+bounces-76206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C384B85F426
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390111F22005
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C9B37166;
	Thu, 22 Feb 2024 09:21:02 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F8723747
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593661; cv=none; b=lNUtZVm1GVxFtUX6giPNnjlOQjgSDM0iNjnbr7xR0ERBgvrWaNkIh/3OSFOszJe9IhQZQyN4IxN3m/YL//smmM8G1DFEPReujZ/b+wuSMmvYzibWdi2wXY+Q64CYimcxE83z6MKsP87nht/+Ri63an2X0O9ySD9jMuowPFrcnd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593661; c=relaxed/simple;
	bh=Y8caMj8pa0Cn3+eu3yvIjlG6TljW4ALR+A9Q+LVMauE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhOKSRtQtKN5rF3E7eb/tpnSIrnrcKYdET1tTF/xjBJfEIfbSAZSG2WGGVttQ+I1bqCQa2YdYakeDNWr66okYT92MMC5T9BBkDAwQkw8qvJOaa6q0huykRJ/pRhyiVs3VtKVnyLJKhEDr59DZMJAAbL4VQobGF9xZR4vdZBYZa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-cc-65d711ef9143
Date: Thu, 22 Feb 2024 18:20:42 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, yuzhao@google.com
Subject: Re: [PATCH v2] mm, vmscan: don't turn on cache_trim_mode at high
 scan priorities
Message-ID: <20240222092042.GA33967@system.software.com>
References: <20240222070817.70515-1-byungchul@sk.com>
 <87sf1kj3nn.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf1kj3nn.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC9ZZnoe57weupBg17jSzmrF/DZnF51xw2
	i3tr/rNanJw1mcXi3YQvrA6sHgs2lXos3vOSyWPTp0nsHidm/Gbx+LxJLoA1issmJTUnsyy1
	SN8ugSujuX8iS8Eh/YpFax8xNTBuU+li5OSQEDCROPZ6LTuMfeDUAjYQm0VAVeJw03xGEJtN
	QF3ixo2fzCC2iICGxKeFy8HqmQVqJR7fmQlWLywQLdHy7SNYnFfAQuLWQYiZQgKZEqumdkLF
	BSVOznzCAtGrJXHj30umLkYOIFtaYvk/DpAwp4CdxLflu8HWigooSxzYdhyohAvotBlsEr+3
	3GGGuFNS4uCKGywTGAVmIRk7C8nYWQhjFzAyr2IUyswry03MzDHRy6jMy6zQS87P3cQIDOJl
	tX+idzB+uhB8iFGAg1GJh/cB47VUIdbEsuLK3EOMEhzMSiK8LOVXUoV4UxIrq1KL8uOLSnNS
	iw8xSnOwKInzGn0rTxESSE8sSc1OTS1ILYLJMnFwSjUwBu287F+wqrUtSsts6+c7KxP7537i
	vVTP+nZfgd7Raax7rIyyRPx6mKcvTEyTe9Z+VuZxueeS0zMMebUCHU67uLN1frITPzRVj+EO
	U/ONXz/4nE4L6M6q3qBkbbq32vH7pi9TAw+xxy85LpVS3Lfii1JE7/7VZ2/07BNt40i7/aX9
	4S3lPLazSizFGYmGWsxFxYkAXfz3CV4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsXC5WfdrPte8Hqqwfq3ChZz1q9hszg89ySr
	xeVdc9gs7q35z2pxctZkFot3E76wOrB5LNhU6rF4z0smj02fJrF7nJjxm8Vj8YsPTB6fN8kF
	sEVx2aSk5mSWpRbp2yVwZTT3T2QpOKRfsWjtI6YGxm0qXYycHBICJhIHTi1gA7FZBFQlDjfN
	ZwSx2QTUJW7c+MkMYosIaEh8WricHcRmFqiVeHxnJli9sEC0RMu3j2BxXgELiVsH14LZQgKZ
	EqumdkLFBSVOznzCAtGrJXHj30umLkYOIFtaYvk/DpAwp4CdxLflu8HWigooSxzYdpxpAiPv
	LCTds5B0z0LoXsDIvIpRJDOvLDcxM8dUrzg7ozIvs0IvOT93EyMwJJfV/pm4g/HLZfdDjAIc
	jEo8vA8Yr6UKsSaWFVfmHmKU4GBWEuFlKb+SKsSbklhZlVqUH19UmpNafIhRmoNFSZzXKzw1
	QUggPbEkNTs1tSC1CCbLxMEp1cCY7slX82dCxdwLBtvWlaaYsT6TZHvz1W1htMNdx13b55yL
	rtym/1Tg7dEYhn+z+q74pFaGCja8U/tT0mu11I6XLdE36jWT8vT2xSEHAnSqOSJOa2xmV/0x
	26zENmImZ1bT3l8sE0SL5uw7EX73yYZb74Q//H+3TTylgb2v8HbhfenmgARn3vtKLMUZiYZa
	zEXFiQC80ndvRQIAAA==
X-CFilter-Loop: Reflected

On Thu, Feb 22, 2024 at 04:37:16PM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > Changes from v1:
> > 	1. Add a comment describing why this change is necessary in code
> > 	   and rewrite the commit message with how to reproduce and what
> > 	   the result is using vmstat. (feedbacked by Andrew Morton and
> > 	   Yu Zhao)
> > 	2. Change the condition to avoid cache_trim_mode from
> > 	   'sc->priority != 1' to 'sc->priority > 1' to reflect cases
> > 	   where the priority goes to zero all the way. (feedbacked by
> > 	   Yu Zhao)
> >
> > --->8---
> > From 07e0baab368160e50b6ca35d95745168aa60e217 Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul@sk.com>
> > Date: Thu, 22 Feb 2024 14:50:17 +0900
> > Subject: [PATCH v2] mm, vmscan: don't turn on cache_trim_mode at high scan priorities
> >
> > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> > pages.  However, it should be more careful to turn on the mode because
> > it's going to prevent anon pages from being reclaimed even if there are
> > a huge number of anon pages that are cold and should be reclaimed.  Even
> > worse, that can lead kswapd_failures to reach MAX_RECLAIM_RETRIES and
> > stopping kswapd until direct reclaim eventually works to resume kswapd.
> > So this is more like a bug fix than a performance improvement.
> >
> > The problematic behavior can be reproduced by:
> >
> >    CONFIG_NUMA_BALANCING enabled
> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> >
> >    numa node0 (8GB local memory, 16 CPUs)
> >    numa node1 (8GB slow tier memory, no CPUs)
> >
> >    Sequence:
> >
> >    1) echo 3 > /proc/sys/vm/drop_caches
> >    2) To emulate the system with full of cold memory in local DRAM, run
> >       the following dummy program and never touch the region:
> >
> >          mmap(0, 8 * 1024 * 1024 * 1024, PROT_READ | PROT_WRITE,
> > 	      MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
> >
> >    3) Run any memory intensive work e.g. XSBench.
> >    4) Check if numa balancing is working e.i. promotion/demotion.
> >    5) Iterate 1) ~ 4) until kswapd stops.
> >
> > With this, you could eventually see that promotion/demotion are not
> > working because kswapd has stopped due to ->kswapd_failures >=
> > MAX_RECLAIM_RETRIES.
> >
> > Interesting vmstat delta's differences between before and after are like:
> >
> >    -nr_inactive_anon 321935
> >    -nr_active_anon 1780700
> >    -nr_inactive_file 30425
> >    -nr_active_file 14961
> >    -pgpromote_success 356
> >    -pgpromote_candidate 21953245
> >    -pgactivate 1844523
> >    -pgdeactivate 50634
> >    -pgfault 31100294
> >    -pgdemote_kswapd 30856
> >    -pgscan_kswapd 1861981
> >    -pgscan_anon 1822930
> >    -pgscan_file 39051
> >    -pgsteal_anon 386
> >    -pgsteal_file 30470
> >    -pageoutrun 30
> >    -numa_hint_faults 27418279
> >    -numa_pages_migrated 356
> >
> >    +nr_inactive_anon 1662306
> >    +nr_active_anon 440303
> >    +nr_inactive_file 27669
> >    +nr_active_file 1654
> >    +pgpromote_success 1314102
> >    +pgpromote_candidate 1892525
> >    +pgactivate 3284457
> >    +pgdeactivate 1527504
> >    +pgfault 6847775
> >    +pgdemote_kswapd 2142047
> >    +pgscan_kswapd 7496588
> >    +pgscan_anon 7462488
> >    +pgscan_file 34100
> >    +pgsteal_anon 2115661
> >    +pgsteal_file 26386
> >    +pageoutrun 378
> >    +numa_hint_faults 3220891
> >    +numa_pages_migrated 1314102
> >
> >    where -: before this patch, +: after this patch
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  mm/vmscan.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bba207f41b14..6eda59fce5ee 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2266,9 +2266,17 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
> >  	 * If we have plenty of inactive file pages that aren't
> >  	 * thrashing, try to reclaim those first before touching
> >  	 * anonymous pages.
> > +	 *
> > +	 * However, the condition 'sc->cache_trim_mode == 1' all through
> > +	 * the scan priorties might lead reclaim failure. If it keeps
> > +	 * MAX_RECLAIM_RETRIES times, then kswapd would get stopped even
> > +	 * if there are still plenty anon pages to reclaim, which is not
> > +	 * desirable. So do not use cache_trim_mode when reclaim is not
> > +	 * smooth e.i. high scan priority.
> >  	 */
> >  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> > -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> > +	if (sc->priority > 1 && file >> sc->priority &&
> > +	    !(sc->may_deactivate & DEACTIVATE_FILE))
> >  		sc->cache_trim_mode = 1;
> >  	else
> >  		sc->cache_trim_mode = 0;
> 
> In get_scan_count(), there's following code,
> 
> 	/*
> 	 * Do not apply any pressure balancing cleverness when the
> 	 * system is close to OOM, scan both anon and file equally
> 	 * (unless the swappiness setting disagrees with swapping).
> 	 */
> 	if (!sc->priority && swappiness) {
> 		scan_balance = SCAN_EQUAL;
> 		goto out;
> 	}
> 
> So, swappiness is 0 in you system?  Please check it.  If it's not 0,
> please check why this doesn't help.

Nice information! Then the change should be:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bba207f41b14..91f9bab86e92 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2357,7 +2357,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	 * system is close to OOM, scan both anon and file equally
 	 * (unless the swappiness setting disagrees with swapping).
 	 */
-	if (!sc->priority && swappiness) {
+	if (sc->priority <= 1 && swappiness) {
 		scan_balance = SCAN_EQUAL;
 		goto out;
 	}

Worth noting that the priority goes from DEF_PRIORITY to 1 in
balance_pgdat() of kswapd. I will change how to fix to this if this
looks more reasonable.

	Byungchul

