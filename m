Return-Path: <linux-kernel+bounces-81440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0618675FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02181C23C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A9980037;
	Mon, 26 Feb 2024 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D7iciNee";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QuYbR2Nl"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067CC5B03B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952808; cv=none; b=eNaDOtM31hYaor83hMdkM21nnHHzRd6Zn1DZC48DG6rQ5r/IoiTBC9fHmItxvumYou/YumD5QP3lIk/k9VRmhJNow3yepthPEVbGu3LeICYppWxzPZsPa5MilidVh3bZETIfgIyE5nijnJ4UmaU+ZF+a20PCEkDCSP8MVIKE/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952808; c=relaxed/simple;
	bh=XBJjaxY29vsjHIvx7KbeSz6k8oTAy1xwg467THgSk5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmoR0adZxqQAFA3fW6rmqAd810PKB5Mhk1mvOFWm5h2omzcsLRtoINcsEAcp4W5afEH7bYJH7wLfkXZPAYGIUp2zLEd4bx2y4Up9fU92mHaB8SVflixqhBDBSb0XT9xZsf+eYu8/gBXYTDbftmlGz+EdBtCm+W4BdQGu2Z+yCxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D7iciNee; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QuYbR2Nl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFF1B1FD26;
	Mon, 26 Feb 2024 13:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708952803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SdjeURyEIiVj/ZjHRCqbFd6GFC1z8/tL8xhBYzMmpL8=;
	b=D7iciNeeD6AyEkBXOh2rkL7IYjOrbDloBLE4sHbMtmzcGsIfU9a0moxy79Nubsj8jkCEYF
	61rPP/mq/SYoDTQuQNROwvQuFENnwxntJkWTy1QNuoIImBapajo+DoD88/ydwcOqJFi3Th
	d8wzmLSArHD1G3vQJTB/D672UAWCvxA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708952802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SdjeURyEIiVj/ZjHRCqbFd6GFC1z8/tL8xhBYzMmpL8=;
	b=QuYbR2Nl7ARFM63tl4v7tptKOzTZd9Y+ImznsuGkcKCa37uDYuVTtx4XafCtHANd1kFxy8
	2541Y3gfnfwYmAqjN2vGbIlx+UAXcHAppMMZgTOwA64HbPFU0B1ijFL9ofcsphMLRcPAQS
	39Ze6kc0mTguKqF860/QqMRN1RRs6oI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9A3813A58;
	Mon, 26 Feb 2024 13:06:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5b8mMuKM3GWQWAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 26 Feb 2024 13:06:42 +0000
Date: Mon, 26 Feb 2024 14:06:30 +0100
From: Michal Hocko <mhocko@suse.com>
To: Byungchul Park <byungchul@sk.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, yuzhao@google.com,
	ying.huang@intel.com, Mel Gorman <mgorman@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it
 doesn't work
Message-ID: <ZdyM1nS8a8UR1dw_@tiehlicka>
References: <20240223054407.14829-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223054407.14829-1-byungchul@sk.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

[CC Mel, Vlastimil and Johannes for awareness]

On Fri 23-02-24 14:44:07, Byungchul Park wrote:
> Changes from v2:
> 	1. Change the condition to stop cache_trim_mode.
> 
> 	   From - Stop it if it's at high scan priorities, 0 or 1.
> 	   To   - Stop it if it's at high scan priorities, 0 or 1, and
> 	          the mode didn't work in the previous turn.
> 
> 	   (feedbacked by Huang Ying)
> 
> 	2. Change the test result in the commit message after testing
> 	   with the new logic.
> 
> Changes from v1:
> 	1. Add a comment describing why this change is necessary in code
> 	   and rewrite the commit message with how to reproduce and what
> 	   the result is using vmstat. (feedbacked by Andrew Morton and
> 	   Yu Zhao)
> 	2. Change the condition to avoid cache_trim_mode from
> 	   'sc->priority != 1' to 'sc->priority > 1' to reflect cases
> 	   where the priority goes to zero all the way. (feedbacked by
> 	   Yu Zhao)
> 
> --->8---
> >From 05846e34bf02ac9b3e254324dc2d7afd97a025d9 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Fri, 23 Feb 2024 13:47:16 +0900
> Subject: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it doesn't work
> 
> With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> pages.  However, it should be more careful to turn on the mode because
> it's going to prevent anon pages from being reclaimed even if there are
> a huge number of anon pages that are cold and should be reclaimed.  Even
> worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
> stopping kswapd from functioning until direct reclaim eventually works
> to resume kswapd.
> 
> So do not turn on cache_trim_mode if the mode doesn't work, especially
> while the sytem is struggling against reclaim.
> 
> The problematic behavior can be reproduced by:
> 
>    CONFIG_NUMA_BALANCING enabled
>    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
>    numa node0 (8GB local memory, 16 CPUs)
>    numa node1 (8GB slow tier memory, no CPUs)
> 
>    Sequence:
> 
>    1) echo 3 > /proc/sys/vm/drop_caches
>    2) To emulate the system with full of cold memory in local DRAM, run
>       the following dummy program and never touch the region:
> 
>          mmap(0, 8 * 1024 * 1024 * 1024, PROT_READ | PROT_WRITE,
> 	      MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
> 
>    3) Run any memory intensive work e.g. XSBench.
>    4) Check if numa balancing is working e.i. promotion/demotion.
>    5) Iterate 1) ~ 4) until numa balancing stops.
> 
> With this, you could see that promotion/demotion are not working because
> kswapd has stopped due to ->kswapd_failures >= MAX_RECLAIM_RETRIES.
> 
> Interesting vmstat delta's differences between before and after are like:
> 
>    +-----------------------+-------------------------------+
>    | interesting vmstat	   | before	   | after	   |
>    +-----------------------+-------------------------------+
>    | nr_inactive_anon	   | 321935	   | 1636737	   |
>    | nr_active_anon	   | 1780700	   | 465913	   |
>    | nr_inactive_file	   | 30425	   | 35711	   |
>    | nr_active_file	   | 14961	   | 8698	   |
>    | pgpromote_success	   | 356	   | 1267785	   |
>    | pgpromote_candidate   | 21953245	   | 1745631	   |
>    | pgactivate		   | 1844523	   | 3309867	   |
>    | pgdeactivate	   | 50634	   | 1545041	   |
>    | pgfault		   | 31100294	   | 6411036	   |
>    | pgdemote_kswapd	   | 30856	   | 2267467	   |
>    | pgscan_kswapd	   | 1861981	   | 7729231	   |
>    | pgscan_anon	   | 1822930	   | 7667544	   |
>    | pgscan_file	   | 39051	   | 61687	   |
>    | pgsteal_anon	   | 386	   | 2227217	   |
>    | pgsteal_file	   | 30470	   | 40250	   |
>    | pageoutrun		   | 30		   | 457	   |
>    | numa_hint_faults	   | 27418279	   | 2752289	   |
>    | numa_pages_migrated   | 356	   | 1267785 	   |
>    +-----------------------+-------------------------------+
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  mm/vmscan.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bba207f41b14..f7312d831fed 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -127,6 +127,9 @@ struct scan_control {
>  	/* One of the zones is ready for compaction */
>  	unsigned int compaction_ready:1;
>  
> +	/* If the last try was reclaimable */
> +	unsigned int reclaimable:1;
> +
>  	/* There is easily reclaimable cold cache in the current node */
>  	unsigned int cache_trim_mode:1;
>  
> @@ -2266,9 +2269,14 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
>  	 * If we have plenty of inactive file pages that aren't
>  	 * thrashing, try to reclaim those first before touching
>  	 * anonymous pages.
> +	 *
> +	 * It doesn't make sense to keep cache_trim_mode on if the mode
> +	 * is not working while struggling against reclaim. So do not
> +	 * turn it on if so. Note the highest priority of kswapd is 1.
>  	 */
>  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> +	    !(sc->cache_trim_mode && !sc->reclaimable && sc->priority <= 1))
>  		sc->cache_trim_mode = 1;
>  	else
>  		sc->cache_trim_mode = 0;
> @@ -5862,7 +5870,6 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  {
>  	unsigned long nr_reclaimed, nr_scanned, nr_node_reclaimed;
>  	struct lruvec *target_lruvec;
> -	bool reclaimable = false;
>  
>  	if (lru_gen_enabled() && root_reclaim(sc)) {
>  		lru_gen_shrink_node(pgdat, sc);
> @@ -5877,6 +5884,14 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	nr_reclaimed = sc->nr_reclaimed;
>  	nr_scanned = sc->nr_scanned;
>  
> +	/*
> +	 * Reset to the default values at the start.
> +	 */
> +	if (sc->priority == DEF_PRIORITY) {
> +		sc->reclaimable = 1;
> +		sc->cache_trim_mode = 0;
> +	}
> +
>  	prepare_scan_control(pgdat, sc);
>  
>  	shrink_node_memcgs(pgdat, sc);
> @@ -5890,8 +5905,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
>  			   sc->nr_scanned - nr_scanned, nr_node_reclaimed);
>  
> -	if (nr_node_reclaimed)
> -		reclaimable = true;
> +	sc->reclaimable = !!nr_node_reclaimed;
>  
>  	if (current_is_kswapd()) {
>  		/*
> @@ -5965,7 +5979,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	 * sleep. On reclaim progress, reset the failure counter. A
>  	 * successful direct reclaim run will revive a dormant kswapd.
>  	 */
> -	if (reclaimable)
> +	if (sc->reclaimable)
>  		pgdat->kswapd_failures = 0;
>  }
>  
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs

