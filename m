Return-Path: <linux-kernel+bounces-85789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FF286BAC7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A772829F2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8F2433A7;
	Wed, 28 Feb 2024 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="cTxhJwZ3"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189CC1361CC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159771; cv=none; b=dVSlPlfw/c57VtjdkcQEZrnBnHhhr/WmlGBFB6k+eSYFWtRIQ1LfHW/jfLcbkh8aCXsMRygJ3nsXvDLZj+8UPD3Fpdgczy5vvfoPUqc2jBuXKzusA8fV4EpRHjlsZ7vnfKU64nvZjVY24OBLuBSqyU9IjlEe/TAvIDmfwQiHX1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159771; c=relaxed/simple;
	bh=BoHahoXJhs1TzjrNZ32k0ny0ujQB/09pV8b3tiOHL0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWogXNl51JvwJ99urjSUKJxeNdi4AWlLbRZdf78frngSgZk0KyOoCoumVdxMJZwcxRgOZhVbNcwR/RnAFoLRXUpniGq+JnbP/oXyJLL35a98z+qabJ00OJFuJibIA4LtgCNPgyHhWSmeKzKrbhYlSHZZcHJE9onjA9834y8mKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=cTxhJwZ3; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c15b7b36bbso83082b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1709159767; x=1709764567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=syMwEHkL47bP4Zl9OiTuPEHWa+rdfzjECj4WhEn1mRk=;
        b=cTxhJwZ3fxe5gzCTJZ11x6yhpNAhPmf2xAWr/VuUOka/RMkUHXfUOjSAJprFEaytnJ
         IYyNBNSJv1qnfTiwCEK+V8wkC8/KRCFoh509lrHcnJqDQoZ1p6nAHREiztKTI54LRMwX
         AFdbAxEH/oeSM7Z5V4dX6R2iQcV3TdXtFbB59TzggWrxofFsB5szC7xiYvPrrphm1Zpg
         nxyOXLGvvPTaqarZWfvkKHhC3A7B2PUEsiU1GzoA5J6pknZsj2dA4FK61IYo/0RthCNY
         JS7AT7x/oAiqEGnBjOv8hw7ufcoy7MAVkjmHg7XvxEszhQTBooPyW2Zr4DLo5J7ONFqd
         vDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709159767; x=1709764567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syMwEHkL47bP4Zl9OiTuPEHWa+rdfzjECj4WhEn1mRk=;
        b=fby53cmL9JIqgwYrkHu2k62w30QetrNijmHm2An3NpvCnAz8ZRd/Qrq4ko6BVczJJQ
         CPHkJmxLxh9Ex4kNhh4WLV4ksLjMBCSZHkyZN+TkjLTiWvytU3COAp62cFOJxmZHlhEi
         Nm9UrIFGnTcIi4VBgnX7IOuLLs6qg9nwq4/Zbx25FBT7b92WBjO8w9TTNb7Kn1FOImMy
         wvkUHB0uAGQzx6oUpK32Nb9UhJ3Eqrrf619c1Tt5GAAg8vIszsnQ3tcn9XpqPX6q5M+C
         i0n1LeO2Dm2I8MKvfTG/8nTw/hzlMXw2SRM0DOj9kM20ji1ga8LeFt3f5PD3O0X/jbZ7
         uBVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU3zDPkmjaDZzrm2y19nAGz3TqXfa1P34lxNQPPUrnmuYpBUnwinTZkb8rppqyM05vhHCPtng32pM7ZUjdP/bLAMZjtkuTwlyAOWhN
X-Gm-Message-State: AOJu0YzfWzbxSF9AbII3ApxkLIlPkLrpqmNodC5HCC0EBXU/wTCrsLMN
	DoA43BRa01E7SuT2B3SdsQnXpnHWCoyw/FB9JHd6EydSGJx5gx7shIdywyqEeVIEqaOVl1U6O+n
	J
X-Google-Smtp-Source: AGHT+IExUcM840ET+bEdCk7f8mXQR796jT2WCTIOfn/XY++JShOyjlDzdn+e2qLuPH8qPePixihg8w==
X-Received: by 2002:aca:1c02:0:b0:3c1:c1ae:462b with SMTP id c2-20020aca1c02000000b003c1c1ae462bmr378528oic.19.1709159767002;
        Wed, 28 Feb 2024 14:36:07 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id q14-20020a0cfa0e000000b0068f920768a5sm35813qvn.140.2024.02.28.14.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 14:36:06 -0800 (PST)
Date: Wed, 28 Feb 2024 17:36:01 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Byungchul Park <byungchul@sk.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, yuzhao@google.com, ying.huang@intel.com,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it
 doesn't work
Message-ID: <20240228223601.GA53666@cmpxchg.org>
References: <20240223054407.14829-1-byungchul@sk.com>
 <ZdyM1nS8a8UR1dw_@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdyM1nS8a8UR1dw_@tiehlicka>

On Mon, Feb 26, 2024 at 02:06:30PM +0100, Michal Hocko wrote:
> [CC Mel, Vlastimil and Johannes for awareness]
> 
> On Fri 23-02-24 14:44:07, Byungchul Park wrote:
> > Changes from v2:
> > 	1. Change the condition to stop cache_trim_mode.
> > 
> > 	   From - Stop it if it's at high scan priorities, 0 or 1.
> > 	   To   - Stop it if it's at high scan priorities, 0 or 1, and
> > 	          the mode didn't work in the previous turn.
> > 
> > 	   (feedbacked by Huang Ying)
> > 
> > 	2. Change the test result in the commit message after testing
> > 	   with the new logic.
> > 
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
> > >From 05846e34bf02ac9b3e254324dc2d7afd97a025d9 Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul@sk.com>
> > Date: Fri, 23 Feb 2024 13:47:16 +0900
> > Subject: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it doesn't work
> > 
> > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> > pages.  However, it should be more careful to turn on the mode because
> > it's going to prevent anon pages from being reclaimed even if there are
> > a huge number of anon pages that are cold and should be reclaimed.  Even
> > worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
> > stopping kswapd from functioning until direct reclaim eventually works
> > to resume kswapd.
> > 
> > So do not turn on cache_trim_mode if the mode doesn't work, especially
> > while the sytem is struggling against reclaim.
> > 
> > The problematic behavior can be reproduced by:
> > 
> >    CONFIG_NUMA_BALANCING enabled
> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
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
> >    5) Iterate 1) ~ 4) until numa balancing stops.
> > 
> > With this, you could see that promotion/demotion are not working because
> > kswapd has stopped due to ->kswapd_failures >= MAX_RECLAIM_RETRIES.
> > 
> > Interesting vmstat delta's differences between before and after are like:
> > 
> >    +-----------------------+-------------------------------+
> >    | interesting vmstat	   | before	   | after	   |
> >    +-----------------------+-------------------------------+
> >    | nr_inactive_anon	   | 321935	   | 1636737	   |
> >    | nr_active_anon	   | 1780700	   | 465913	   |
> >    | nr_inactive_file	   | 30425	   | 35711	   |
> >    | nr_active_file	   | 14961	   | 8698	   |
> >    | pgpromote_success	   | 356	   | 1267785	   |
> >    | pgpromote_candidate   | 21953245	   | 1745631	   |
> >    | pgactivate		   | 1844523	   | 3309867	   |
> >    | pgdeactivate	   | 50634	   | 1545041	   |
> >    | pgfault		   | 31100294	   | 6411036	   |
> >    | pgdemote_kswapd	   | 30856	   | 2267467	   |
> >    | pgscan_kswapd	   | 1861981	   | 7729231	   |
> >    | pgscan_anon	   | 1822930	   | 7667544	   |
> >    | pgscan_file	   | 39051	   | 61687	   |
> >    | pgsteal_anon	   | 386	   | 2227217	   |
> >    | pgsteal_file	   | 30470	   | 40250	   |
> >    | pageoutrun		   | 30		   | 457	   |
> >    | numa_hint_faults	   | 27418279	   | 2752289	   |
> >    | numa_pages_migrated   | 356	   | 1267785 	   |
> >    +-----------------------+-------------------------------+
> > 
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  mm/vmscan.c | 24 +++++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bba207f41b14..f7312d831fed 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -127,6 +127,9 @@ struct scan_control {
> >  	/* One of the zones is ready for compaction */
> >  	unsigned int compaction_ready:1;
> >  
> > +	/* If the last try was reclaimable */
> > +	unsigned int reclaimable:1;
> > +
> >  	/* There is easily reclaimable cold cache in the current node */
> >  	unsigned int cache_trim_mode:1;
> >  
> > @@ -2266,9 +2269,14 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
> >  	 * If we have plenty of inactive file pages that aren't
> >  	 * thrashing, try to reclaim those first before touching
> >  	 * anonymous pages.
> > +	 *
> > +	 * It doesn't make sense to keep cache_trim_mode on if the mode
> > +	 * is not working while struggling against reclaim. So do not
> > +	 * turn it on if so. Note the highest priority of kswapd is 1.
> >  	 */
> >  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> > -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> > +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> > +	    !(sc->cache_trim_mode && !sc->reclaimable && sc->priority <= 1))
> >  		sc->cache_trim_mode = 1;
> >  	else
> >  		sc->cache_trim_mode = 0;

The overall goal makes sense to me.

file >> priority is just a heuristic that there are enough potential
candidate pages, not a guarantee that any forward progress will
happen. So it makes sense to retry without before failing.

The way you wrote this conditional kind of hurts my head,
though. Please don't write negations of complex terms like this.

It expands to this:

	!sc->cache_trim_mode || sc->reclaimable || sc->priority > 1

which I'm not sure makes sense. Surely it should be something like

	!sc->cache_trim_mode && sc->reclaimable && sc->priority > 1

instead?

Also

	if (!sc->cache_trim_mode)
		sc->cache_trim_mode = 1
	else
		sc->cache_trim_mode = 0

will toggle on every loop. So if direct reclaim runs through a
zonelist, it'll cache trim every other numa node...?

> > @@ -5862,7 +5870,6 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  {
> >  	unsigned long nr_reclaimed, nr_scanned, nr_node_reclaimed;
> >  	struct lruvec *target_lruvec;
> > -	bool reclaimable = false;
> >  
> >  	if (lru_gen_enabled() && root_reclaim(sc)) {
> >  		lru_gen_shrink_node(pgdat, sc);
> > @@ -5877,6 +5884,14 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  	nr_reclaimed = sc->nr_reclaimed;
> >  	nr_scanned = sc->nr_scanned;
> >  
> > +	/*
> > +	 * Reset to the default values at the start.
> > +	 */
> > +	if (sc->priority == DEF_PRIORITY) {
> > +		sc->reclaimable = 1;
> > +		sc->cache_trim_mode = 0;
> > +	}
> > +
> >  	prepare_scan_control(pgdat, sc);
> >  
> >  	shrink_node_memcgs(pgdat, sc);
> > @@ -5890,8 +5905,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> >  			   sc->nr_scanned - nr_scanned, nr_node_reclaimed);
> >  
> > -	if (nr_node_reclaimed)
> > -		reclaimable = true;
> > +	sc->reclaimable = !!nr_node_reclaimed;

The scope of this doesn't quite make sense. If direct reclaim scans
multiple nodes, reclaim failure on the first node would disable cache
trim mode on the second node, which is totally unrelated.

I think it needs separate paths for direct reclaim and kswapd. For
direct reclaim, the retry should be before these similar retry catches
in do_try_to_free_pages(), after all zones have been considered:

	/*
	 * We make inactive:active ratio decisions based on the node's
	 * composition of memory, but a restrictive reclaim_idx or a
	 * memory.low cgroup setting can exempt large amounts of
	 * memory from reclaim. Neither of which are very common, so
	 * instead of doing costly eligibility calculations of the
	 * entire cgroup subtree up front, we assume the estimates are
	 * good, and retry with forcible deactivation if that fails.
	 */
	if (sc->skipped_deactivate) {
		sc->priority = initial_priority;
		sc->force_deactivate = 1;
		sc->skipped_deactivate = 0;
		goto retry;
	}

	/* Untapped cgroup reserves?  Don't OOM, retry. */
	if (sc->memcg_low_skipped) {
		sc->priority = initial_priority;
		sc->force_deactivate = 0;
		sc->memcg_low_reclaim = 1;
		sc->memcg_low_skipped = 0;
		goto retry;
	}

and for kswapd it looks like it should be in balance_pgdat(), after
the priority loop, before increasing kswapd_failures.

Instead of sc->reclaimable, which is very broad, it would be better to
call it sc->may_cache_trim_mode. This is in line with a bunch of other
such mechanisms in scan_control.

