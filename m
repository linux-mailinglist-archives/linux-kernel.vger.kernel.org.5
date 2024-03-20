Return-Path: <linux-kernel+bounces-108728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935BF880F42
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2C12835EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254F13D0C4;
	Wed, 20 Mar 2024 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k8CTDhkj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="49Z7V1Iw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k8CTDhkj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="49Z7V1Iw"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC543D0A3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929123; cv=none; b=px5m/zChEVuBJPDsnnP7o5e+qE5zsORKid2b8yg2m4HZVWNBRhEjFF1VVsRXD6ElVCXCd9TwDLTDlBet59cx7B0M/6qS1UVgJTMBH4zxNoZEAeXY3f6PZV8gTOGWm8CG1g/yErJ9ZZLoDWVANkeOmDiT8RvWbtayoE/l1AX3X60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929123; c=relaxed/simple;
	bh=ampqtZJ9sdTSmxetGEn62AScMj1zcyP3XMQFIM/bIBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXQqsg+lEEHtRKUJospTnkRxUwAjBj4F4YCTe/k2m+p7X5Fqml91zzof/M7/INeWghKjy0z5p0iiCD64BI+fSTdHyZxjV2zKngW3NU60yqSwajn9js2t0lcIacS/FXm0vgjlv14OCpTKNbgLEGOW7g1oYcmJBwPdTfiZgtaffXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k8CTDhkj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=49Z7V1Iw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k8CTDhkj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=49Z7V1Iw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B95DB20C45;
	Wed, 20 Mar 2024 10:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710929119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VIZ0ATeO8q/WMl7Af2C8a25lhQGxqN2RZQIjxOdVzdI=;
	b=k8CTDhkj7YUVNHoYJMZ8PUJbKLS9q30k0VgnRwLxmxX5XbdpAbbs+HRq10Y7P8z/zLfYmm
	zC5ROqpZDfgY/3zzXaUrQt4aaYrCNiV3m/g0xSOWQS7zqhoohN5bCwL0tM6uf5TnO33eqp
	NpKMGO6vZd9bYp/8zd1+uNnjUOPoHGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710929119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VIZ0ATeO8q/WMl7Af2C8a25lhQGxqN2RZQIjxOdVzdI=;
	b=49Z7V1Iw/3iaiVhZqvpFjnczVJ3t2h6XI4E/eSa/Az1tM1dYi20UxTJl7hWi9nH4/o4Kaz
	iFPhxaZ7mzupH4Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710929119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VIZ0ATeO8q/WMl7Af2C8a25lhQGxqN2RZQIjxOdVzdI=;
	b=k8CTDhkj7YUVNHoYJMZ8PUJbKLS9q30k0VgnRwLxmxX5XbdpAbbs+HRq10Y7P8z/zLfYmm
	zC5ROqpZDfgY/3zzXaUrQt4aaYrCNiV3m/g0xSOWQS7zqhoohN5bCwL0tM6uf5TnO33eqp
	NpKMGO6vZd9bYp/8zd1+uNnjUOPoHGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710929119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VIZ0ATeO8q/WMl7Af2C8a25lhQGxqN2RZQIjxOdVzdI=;
	b=49Z7V1Iw/3iaiVhZqvpFjnczVJ3t2h6XI4E/eSa/Az1tM1dYi20UxTJl7hWi9nH4/o4Kaz
	iFPhxaZ7mzupH4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A35A136D6;
	Wed, 20 Mar 2024 10:05:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cw/GA9+0+mWBYgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 20 Mar 2024 10:05:19 +0000
Date: Wed, 20 Mar 2024 11:06:45 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, david@redhat.com,
	linmiaohe@huawei.com, naoya.horiguchi@nec.com, mhocko@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm: hugetlb: make the hugetlb migration strategy
 consistent
Message-ID: <Zfq1NWzgpR-msYlg@localhost.localdomain>
References: <cover.1709719720.git.baolin.wang@linux.alibaba.com>
 <3519fcd41522817307a05b40fb551e2e17e68101.1709719720.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3519fcd41522817307a05b40fb551e2e17e68101.1709719720.git.baolin.wang@linux.alibaba.com>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Wed, Mar 06, 2024 at 06:13:27PM +0800, Baolin Wang wrote:
> As discussed in previous thread [1], there is an inconsistency when handing
> hugetlb migration. When handling the migration of freed hugetlb, it prevents
> fallback to other NUMA nodes in alloc_and_dissolve_hugetlb_folio(). However,
> when dealing with in-use hugetlb, it allows fallback to other NUMA nodes in
> alloc_hugetlb_folio_nodemask(), which can break the per-node hugetlb pool
> and might result in unexpected failures when node bound workloads doesn't get
> what is asssumed available.
> 
> To make hugetlb migration strategy more clear, we should list all the scenarios
> of hugetlb migration and analyze whether allocation fallback is permitted:
> 1) Memory offline: will call dissolve_free_huge_pages() to free the freed hugetlb,
> and call do_migrate_range() to migrate the in-use hugetlb. Both can break the
> per-node hugetlb pool, but as this is an explicit offlining operation, no better
> choice. So should allow the hugetlb allocation fallback.
> 2) Memory failure: same as memory offline. Should allow fallback to a different node
> might be the only option to handle it, otherwise the impact of poisoned memory can
> be amplified.
> 3) Longterm pinning: will call migrate_longterm_unpinnable_pages() to migrate in-use
> and not-longterm-pinnable hugetlb, which can break the per-node pool. But we should
> fail to longterm pinning if can not allocate on current node to avoid breaking the
> per-node pool.
> 4) Syscalls (mbind, migrate_pages, move_pages): these are explicit users operation
> to move pages to other nodes, so fallback to other nodes should not be prohibited.
> 5) alloc_contig_range: used by CMA allocation and virtio-mem fake-offline to allocate
> given range of pages. Now the freed hugetlb migration is not allowed to fallback, to
> keep consistency, the in-use hugetlb migration should be also not allowed to fallback.
> 6) alloc_contig_pages: used by kfence, pgtable_debug etc. The strategy should be
> consistent with that of alloc_contig_range().
> 
> Based on the analysis of the various scenarios above, introducing a new helper to
> determine whether fallback is permitted according to the migration reason..
> 
> [1] https://lore.kernel.org/all/6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com/
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> +static inline bool htlb_allow_alloc_fallback(int reason)
> +{
> +	bool allowed_fallback = false;
> +
> +	/*
> +	 * Note: the memory offline, memory failure and migration syscalls will
> +	 * be allowed to fallback to other nodes due to lack of a better chioce,
                                                                         ^
									 choice
-- 
Oscar Salvador
SUSE Labs

