Return-Path: <linux-kernel+bounces-30874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB72832559
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2663C1F24BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C469AD53F;
	Fri, 19 Jan 2024 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Tl/co0SH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Tl/co0SH"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8E0D52A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651250; cv=none; b=ZVTu3wqofvonfz/A56TVi+U/wviUEM1pP1CakTFnacoFOqxTUeAjlCI2ChkMt5YQ+sHGpoyfrwWZZLN2sz7nrEtxmpi1cDJwJwK1ptqIU7vUjJtHgX95FC77oiU6wE3M9q2LxGsfPk2q4MYySEEGwcqp7DKI4uywsPsveuPLG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651250; c=relaxed/simple;
	bh=lCFwSt1h+0zZ+bhtWR1K6DgWMDUvThVRcpsKI+6zjvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fj6MCTcd7SBAWWROzyB309RU+BXP/q9dw7Pimlc8lprseHjDjjwcjLvlAjWgxxx0p8bM8kjO7liA00oQJ2RdEXEmhAeQ5aL9XiGPL/CkrtClabqhrqK4IqHoQHOIQGNiWGtS4Efs6lS65FwrKyYc7ZPdsXo5UM8k9Q/cQgygW18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Tl/co0SH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Tl/co0SH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A6A802203C;
	Fri, 19 Jan 2024 08:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705651244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bn5ufnHpA6Z9dfznXpVhdImFXiNotqxspeRNBGa/t/s=;
	b=Tl/co0SHQk5Ek/hRvLDHlUdr7CyoF1wFwgMIQoYkkEHLVCPtFcCVdSxgvyJzgue3nf2WwE
	n2VTmEXZWd19esIA+6d6l+IuZ68tHGqH0N3Q2LvsEHMgOD4u1pRaSoYfIfzzGqIG0Z7kTM
	NbcHHeQVGPOMxTf2Wx0/w2v7NQqO9xs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705651244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bn5ufnHpA6Z9dfznXpVhdImFXiNotqxspeRNBGa/t/s=;
	b=Tl/co0SHQk5Ek/hRvLDHlUdr7CyoF1wFwgMIQoYkkEHLVCPtFcCVdSxgvyJzgue3nf2WwE
	n2VTmEXZWd19esIA+6d6l+IuZ68tHGqH0N3Q2LvsEHMgOD4u1pRaSoYfIfzzGqIG0Z7kTM
	NbcHHeQVGPOMxTf2Wx0/w2v7NQqO9xs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8430E1388C;
	Fri, 19 Jan 2024 08:00:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mMZMHSwsqmVaOQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 19 Jan 2024 08:00:44 +0000
Date: Fri, 19 Jan 2024 09:00:43 +0100
From: Michal Hocko <mhocko@suse.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: memory: move mem_cgroup_charge() into
 alloc_anon_folio()
Message-ID: <ZaosK59cRa27K9zW@tiehlicka>
References: <20240117103954.2756050-1-wangkefeng.wang@huawei.com>
 <ZalK3suIskEyaR7m@tiehlicka>
 <c7b1cc8e-c434-4c86-972e-4a105524646c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7b1cc8e-c434-4c86-972e-4a105524646c@huawei.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.43 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(2.03)[89.10%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: **
X-Spam-Score: 2.43
X-Spam-Flag: NO

On Fri 19-01-24 10:05:15, Kefeng Wang wrote:
> 
> 
> On 2024/1/18 23:59, Michal Hocko wrote:
> > On Wed 17-01-24 18:39:54, Kefeng Wang wrote:
> > > mem_cgroup_charge() uses the GFP flags in a fairly sophisticated way.
> > > In addition to checking gfpflags_allow_blocking(), it pays attention
> > > to __GFP_NORETRY and __GFP_RETRY_MAYFAIL to ensure that processes within
> > > this memcg do not exceed their quotas. Using the same GFP flags ensures
> > > that we handle large anonymous folios correctly, including falling back
> > > to smaller orders when there is plenty of memory available in the system
> > > but this memcg is close to its limits.
> > 
> > The changelog is not really clear in the actual problem you are trying
> > to fix. Is this pure consistency fix or have you actually seen any
> > misbehavior. From the patch I suspect you are interested in THPs much
> > more than regular order-0 pages because those are GFP_KERNEL like when
> > it comes to charging. THPs have a variety of options on how aggressive
> > the allocation should try. From that perspective NORETRY and
> > RETRY_MAYFAIL are not all that interesting because costly allocations
> > (which THPs are) already do imply MAYFAIL and NORETRY.
> 
> I don't meet actual issue, it founds from code inspection.
> 
> mTHP is introduced by Ryan（19eaf44954df "mm: thp: support allocation of
> anonymous multi-size THP")，so we have similar check for mTHP like PMD THP
> in alloc_anon_folio(), it will try to allocate large order folio below
> PMD_ORDER, and fallback to order-0 folio if fails, meanwhile,
> it get GFP flags from vma_thp_gfp_mask() according to user configuration
> like PMD THP allocation, so
> 
> 1) the memory charge failure check should be moved into fallback
> logical, because it will make us to allocated as much as possible large
> order folio, although the memcg's memory usage is close to its limits.
> 
> 2) using seem GFP flags for allocate/mem charge, be consistent with PMD
> THP firstly, in addition, according to GFP flag returned for
> vma_thp_gfp_mask(), GFP_TRANSHUGE_LIGHT could make us skip direct reclaim,
> _GFP_NORETRY will make us skip mem_cgroup_oom and won't kill
> any progress from large order folio charging.

OK, makes sense. Please turn that into the changelog.

> > GFP_TRANSHUGE_LIGHT is more interesting though because those do not dive
> > into the direct reclaim at all. With the current code they will reclaim
> > charges to free up the space for the allocated THP page and that defeats
> > the light mode. I have a vague recollection of preparing a patch to
> 
> We are interesting to GFP_TRANSHUGE_LIGHT and _GFP_NORETRY as mentioned
> above.

if mTHP can be smaller than COSTLY_ORDER then you are correct and
NORETRY makes a difference. Please mention that in the changelog as
well.

Thanks!
-- 
Michal Hocko
SUSE Labs

