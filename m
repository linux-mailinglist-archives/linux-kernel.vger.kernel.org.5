Return-Path: <linux-kernel+bounces-72598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA6285B5C1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0146B2831EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E564A5D752;
	Tue, 20 Feb 2024 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JoYKdNM3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JoYKdNM3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA6F5D743
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418942; cv=none; b=GzeP+q2E/vO6uncyBKUwM/ws0aM5qq1rlawEb/4+lSp0s0tudRliYEGnLzP/86zZgF3gIz4bxPHjB86M5TfL2VHuZJKJZtAGNvA8djuwe6SqQolk2uQtheHUil39vuLABa5kE19euGkHDP2bgXcn1iNJkKbJu+3JV5PMikJmERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418942; c=relaxed/simple;
	bh=zDKctsX4v6uMhmZSqwb6usrdrAhg4DRpu0tYJotpcZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2010TeLQOtWqL7HRnYB0pvLnCphHFL9jiGEmj1jkCrUw1u5R8BPDfiFcfaDqQEX4whjm6qnTzHFCZlbFks/CDm82aFhIxNa05lRo9xgAL/nQAIAqR/i8NT7IgchjOOjXKZcADe2FaD9Nzhd8UwTuHdVlZOWFse5OzKgMUiwMUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JoYKdNM3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JoYKdNM3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA372221D8;
	Tue, 20 Feb 2024 08:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708418938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NA7J3Y3vhZLjDH51M6OXG8PWjFrYhMMpO51KFvCjoVI=;
	b=JoYKdNM39nCYsRL0sZvp0+yzB+eKDHNkGApRiibylMOLY+9lgckn/wRgWhJoDOkPEs0Ag8
	CrpKTbxfTeT9duaneRdiu33rxOsgseILo2iP8yNQbxMZ8TyVJxu9vROWim49h/aKRyEetO
	PuUN6cM1ysURTQtKuiz9t7n890GT7Bs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708418938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NA7J3Y3vhZLjDH51M6OXG8PWjFrYhMMpO51KFvCjoVI=;
	b=JoYKdNM39nCYsRL0sZvp0+yzB+eKDHNkGApRiibylMOLY+9lgckn/wRgWhJoDOkPEs0Ag8
	CrpKTbxfTeT9duaneRdiu33rxOsgseILo2iP8yNQbxMZ8TyVJxu9vROWim49h/aKRyEetO
	PuUN6cM1ysURTQtKuiz9t7n890GT7Bs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97C7C139D0;
	Tue, 20 Feb 2024 08:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A7cCInpn1GUeXQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 20 Feb 2024 08:48:58 +0000
Date: Tue, 20 Feb 2024 09:48:57 +0100
From: Michal Hocko <mhocko@suse.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Donet Tom <donettom@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mel Gorman <mgorman@suse.de>, Ben Widawsky <ben.widawsky@intel.com>,
	Feng Tang <feng.tang@intel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 3/3] mm/numa_balancing:Allow migrate on protnone
 reference with MPOL_PREFERRED_MANY policy
Message-ID: <ZdRneVbsts8t3VAW@tiehlicka>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
 <8d7737208bd24e754dc7a538a3f7f02de84f1f72.1708097962.git.donettom@linux.ibm.com>
 <ZdNjmOlkMqEOGci1@tiehlicka>
 <25b420aa-3fe6-40a4-8d60-a46ab61ee7b7@linux.ibm.com>
 <ZdOoF_pMAa-FGN4m@tiehlicka>
 <0f0fd8e3-98b2-4001-ba6a-6a8a26a5393f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f0fd8e3-98b2-4001-ba6a-6a8a26a5393f@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.03 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.37)[76.85%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.03

On Tue 20-02-24 09:27:25, Aneesh Kumar K.V wrote:
[...]
> 	case MPOL_PREFERRED_MANY:
> 		if (pol->flags & MPOL_F_MORON) {
> 			if (!mpol_preferred_should_numa_migrate(thisnid, curnid, pol))
> 				goto out;
> 			break;
> 		}
> 
> 		/*
> 		 * use current page if in policy nodemask,
> 		 * else select nearest allowed node, if any.
> 		 * If no allowed nodes, use current [!misplaced].
> 		 */
> 		if (node_isset(curnid, pol->nodes))
> 			goto out;
> 		z = first_zones_zonelist(
> 				node_zonelist(thisnid, GFP_HIGHUSER),
> 				gfp_zone(GFP_HIGHUSER),
> 				&pol->nodes);
> 		polnid = zone_to_nid(z->zone);
> 		break;
>  ....
> ..
>        }
> 
> 	/* Migrate the folio towards the node whose CPU is referencing it */
> 	if (pol->flags & MPOL_F_MORON) {
> 		polnid = thisnid;
> 
> 		if (!should_numa_migrate_memory(current, folio, curnid,
> 						thiscpu))
> 			goto out;
> 	}
> 
> 	if (curnid != polnid)
> 		ret = polnid;
> out:
> 	mpol_cond_put(pol);
> 
> 	return ret;
> }

Ohh, right this code is confusing as hell. Thanks for the clarification.
With this in mind. There should be a comment warning about MPOL_F_MOF
always being unset as the userspace cannot really set it up.

Thanks!

-- 
Michal Hocko
SUSE Labs

