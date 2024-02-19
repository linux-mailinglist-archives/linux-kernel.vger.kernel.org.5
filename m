Return-Path: <linux-kernel+bounces-71853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12785ABCB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352F428526D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A6550255;
	Mon, 19 Feb 2024 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fealQsEe";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fealQsEe"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2550245
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708369951; cv=none; b=TSoLHMYU31DBSlfOmFO/cSSVlI2y7+2ocAaAM5WzIPOgnxHJhEfMmVoraCcS/3p5NbV1B+ztzf7a+uwchr3XDXYHoFQoVpdq+u1GRB6DCAynKOFDDRx8CTKxTXM43nkbpwbPPIBID745TqGNKzdK5i6jKotgwwPSuCD7KMciCek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708369951; c=relaxed/simple;
	bh=9kiuasnMYek7Mn1ZX+OUnE3Q44zuHcdIAQOH6BUUrTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ltom/xWsN8x6LSBAswJQ4A0qyh3ORrYeynWJt2kQl2mk33ZUfa744fv4G+16EjmCIJBilKN3YDlcH6uvXulvxbo2erNzhx79WIM055LuMDCI5wl2I21LAvFvExJ+9KbAX0wNYMitUDfLk7sT7PlQ4wwSuQwm6bIZSCFmKPTXgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fealQsEe; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fealQsEe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 23CA422169;
	Mon, 19 Feb 2024 19:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708369948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aMpEL2+e85GACA8bPRrOyB3E//c1GtaW/ql4XdXJNTs=;
	b=fealQsEeDhpJ42fpCFwqBjdw9eb9w++4RjoZChVaanOe5J6ic2qShPqXJ4SW/JWn4/iE4o
	U68mQ/XEf7sK553VpIQR5uJmZYTIahlXNyd9SicU/k0vhaIFKfLl4rmKOzNH/QLAfSWkPb
	P9nAdSppC/VuPfKi4zzP2U21N1OBRTg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708369948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aMpEL2+e85GACA8bPRrOyB3E//c1GtaW/ql4XdXJNTs=;
	b=fealQsEeDhpJ42fpCFwqBjdw9eb9w++4RjoZChVaanOe5J6ic2qShPqXJ4SW/JWn4/iE4o
	U68mQ/XEf7sK553VpIQR5uJmZYTIahlXNyd9SicU/k0vhaIFKfLl4rmKOzNH/QLAfSWkPb
	P9nAdSppC/VuPfKi4zzP2U21N1OBRTg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02CA113647;
	Mon, 19 Feb 2024 19:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rRzfORuo02XEJwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 19 Feb 2024 19:12:27 +0000
Date: Mon, 19 Feb 2024 20:12:23 +0100
From: Michal Hocko <mhocko@suse.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Aneesh Kumar <aneesh.kumar@kernel.org>,
	Huang Ying <ying.huang@intel.com>,
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
Message-ID: <ZdOoF_pMAa-FGN4m@tiehlicka>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
 <8d7737208bd24e754dc7a538a3f7f02de84f1f72.1708097962.git.donettom@linux.ibm.com>
 <ZdNjmOlkMqEOGci1@tiehlicka>
 <25b420aa-3fe6-40a4-8d60-a46ab61ee7b7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25b420aa-3fe6-40a4-8d60-a46ab61ee7b7@linux.ibm.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fealQsEe
X-Spamd-Result: default: False [-1.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[43.55%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 23CA422169
X-Spam-Level: 
X-Spam-Score: -1.81
X-Spam-Flag: NO

On Mon 19-02-24 20:37:17, Donet Tom wrote:
> 
> On 2/19/24 19:50, Michal Hocko wrote:
> > On Sat 17-02-24 01:31:35, Donet Tom wrote:
> > [...]
> > > +static inline bool mpol_preferred_should_numa_migrate(int exec_node, int folio_node,
> > > +					    struct mempolicy *pol)
> > > +{
> > > +	/* if the executing node is in the policy node mask, migrate */
> > > +	if (node_isset(exec_node, pol->nodes))
> > > +		return true;
> > > +
> > > +	/* If the folio node is in policy node mask, don't migrate */
> > > +	if (node_isset(folio_node, pol->nodes))
> > > +		return false;
> > > +	/*
> > > +	 * both the folio node and executing node are outside the policy nodemask,
> > > +	 * migrate as normal numa fault migration.
> > > +	 */
> > > +	return true;
> > > +}
> > I have looked at this again and only now noticed that this doesn't
> > really work as one would expected.
> > 
> >          case MPOL_PREFERRED_MANY:
> >                  /*
> >                   * use current page if in policy nodemask,
> >                   * else select nearest allowed node, if any.
> >                   * If no allowed nodes, use current [!misplaced].
> >                   */
> >                  if (node_isset(curnid, pol->nodes))
> >                          goto out;
> >                  z = first_zones_zonelist(
> >                                  node_zonelist(numa_node_id(), GFP_HIGHUSER),
> >                                  gfp_zone(GFP_HIGHUSER),
> >                                  &pol->nodes);
> >                  polnid = zone_to_nid(z->zone);
> >                  break;
> > 
> > Will collapse the whole MPOL_PREFERRED_MANY nodemask into the first
> > notde into that mask. Is that really what we want here? Shouldn't we use
> > the full nodemask as the migration target?
> 
> With this patch it will take full nodemask and find out the correct migration target. It will not collapse into first node.

Correct me if I am wrong, but mpol_misplaced will return the first node
of the preffered node mask and then migrate_misplaced_folio would use
it as a target node for alloc_misplaced_dst_folio which performs
__GFP_THISNODE allocation so it won't fall back to a different node.
-- 
Michal Hocko
SUSE Labs

