Return-Path: <linux-kernel+bounces-137061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3C889DBD1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642611F23183
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0963512FF6B;
	Tue,  9 Apr 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bAJDz4o5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qHgBKUin";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bAJDz4o5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qHgBKUin"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A448F12F5A7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671828; cv=none; b=qkcMZjnHjbzA/Hta+Z9etVTNr02l8isDhKz8T7wtuLS3sP59sEzPv981WyzxguTFdkeYcQ1g5/maoewg1Mvqs4t+tOmPMVXuqCagORFOE10BvwTDdbW+iYkRdAJgQbhhqFNSBttWWvAZqr/4/WOBGc9NZ/QT1XhhAepJlt0S4ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671828; c=relaxed/simple;
	bh=w3fh94FjM8PaoPy+tTe2R4prJdTSl2maBVnpHh+lEJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDAl3neigdbZb0t2OMYrO5tucFAGBoUJtWcibhU0naeCuRE8yXzf7TsR1ETIKJvhUdEvRgchJcC31fl2zAcX+g3lDajhfvHQ6JQnMQGEbCyXGaT905gIj1PUUhOu8lQeMio85SG13UrsKxsRtbK+07jqrR/XqDNiyutx0ujiCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bAJDz4o5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qHgBKUin; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bAJDz4o5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qHgBKUin; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B986033A22;
	Tue,  9 Apr 2024 14:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712671824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g5EGKPwkjwjC7/2V5eZgVJUDYhN24KSQzqGl9F+xdpE=;
	b=bAJDz4o5gJ8nuym0JcOaYLtPXS3BrX8EFKlqYRyZOa/l+Y7oLyUynscQ85ZfxC7rH6vCan
	C1H+4yukjkNba2fFtUZUD5tsRhgNOj4fytk2mnrW8zr79DJ+encWReiPcRbXlaMT6G0ncB
	SVAWf+5a1t2JhLOSzGGapOvikKStVY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712671824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g5EGKPwkjwjC7/2V5eZgVJUDYhN24KSQzqGl9F+xdpE=;
	b=qHgBKUinOs/RCSj+mJalvLvQWP/b5U9KID8WpNJStbmYCSo2o3baSo29ZMrNtbez4uzZwf
	npt+RGngFuNJxeCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bAJDz4o5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qHgBKUin
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712671824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g5EGKPwkjwjC7/2V5eZgVJUDYhN24KSQzqGl9F+xdpE=;
	b=bAJDz4o5gJ8nuym0JcOaYLtPXS3BrX8EFKlqYRyZOa/l+Y7oLyUynscQ85ZfxC7rH6vCan
	C1H+4yukjkNba2fFtUZUD5tsRhgNOj4fytk2mnrW8zr79DJ+encWReiPcRbXlaMT6G0ncB
	SVAWf+5a1t2JhLOSzGGapOvikKStVY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712671824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g5EGKPwkjwjC7/2V5eZgVJUDYhN24KSQzqGl9F+xdpE=;
	b=qHgBKUinOs/RCSj+mJalvLvQWP/b5U9KID8WpNJStbmYCSo2o3baSo29ZMrNtbez4uzZwf
	npt+RGngFuNJxeCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 621451332F;
	Tue,  9 Apr 2024 14:10:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id R3kAFVBMFWb6BwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 09 Apr 2024 14:10:24 +0000
Date: Tue, 9 Apr 2024 16:10:22 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: akpm@linux-foundation.org, naoya.horiguchi@nec.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory-failure: fix deadlock when
 hugetlb_optimize_vmemmap is enabled
Message-ID: <ZhVMThr9TNeP6SWj@localhost.localdomain>
References: <20240407085456.2798193-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407085456.2798193-1-linmiaohe@huawei.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B986033A22
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.51

On Sun, Apr 07, 2024 at 04:54:56PM +0800, Miaohe Lin wrote:
> In short, below scene breaks the lock dependency chain:
> 
>  memory_failure
>   __page_handle_poison
>    zone_pcp_disable -- lock(pcp_batch_high_lock)
>    dissolve_free_huge_page
>     __hugetlb_vmemmap_restore_folio
>      static_key_slow_dec
>       cpus_read_lock -- rlock(cpu_hotplug_lock)
> 
> Fix this by calling drain_all_pages() instead.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

Thanks!


-- 
Oscar Salvador
SUSE Labs

