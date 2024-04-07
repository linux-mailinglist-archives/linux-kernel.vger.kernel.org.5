Return-Path: <linux-kernel+bounces-134514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA37289B264
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75D41C20C81
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A196738396;
	Sun,  7 Apr 2024 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dwqVRZOq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BEieT5/h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qNuet+ns";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KYwzq6fD"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7012C19E;
	Sun,  7 Apr 2024 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712498188; cv=none; b=C8v9JxLda5M5JDZaL7LtyHbi3VMJE8d8I4kLfFgxhpF970hFL0G+6A0p+XKvnB/AvgWsHa0R7ScwOQpDr+QqpY0B6RHeiVGyuvMIXX2hacE10svhcqVy/eojYDklfKnDT42bHWqeT6CiyahMOAm8PNqti2e6MXBcUH53hATXPSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712498188; c=relaxed/simple;
	bh=SRDjBcQtGOHYJK4giJ7GIegGAOsI+2ghKkIazXAH/uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/qz5XpS75uuXXhXN9nGPo/KkVMVswsh3pnzeKboncErHsCc+OtyR2QtkYLW3pL6a+pQZiCjEgUu6gJleodIl6SJsfI8clB0qLQ7X+bfNMR/arzbA/qL1aRx8+Rato/kD0EalKwQRm2nPDTot0Zrkk9Zpti4HNFhl+8/d3nUqyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dwqVRZOq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BEieT5/h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qNuet+ns; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KYwzq6fD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3084421CC7;
	Sun,  7 Apr 2024 13:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712498185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Krg2wT5gUgUkRcgawSN6OzhRk8HtEQl5pgW8AbL+7wo=;
	b=dwqVRZOqpit7EvdXhsMlIu7O0fuLgYhojP3lgw8yFw3AqxAUmODQ9BhIOBt116BSzzXJQI
	xk5byZ9luukmauDyfNbEDc0ZmjrZQzLXEA0ucC/Dgrb+GnuiP8K0w11IiAR2/kaExzoJ2Z
	cBam4drDGIVQcvT6LVqXHq/uLbeDUAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712498185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Krg2wT5gUgUkRcgawSN6OzhRk8HtEQl5pgW8AbL+7wo=;
	b=BEieT5/hM33f2S7KJkhzEKTHzCRyN91vtiCwr4pPj809//oT/olGQ/tbFRdiaoV8b5MG+h
	pIjRDBrXCcnDHLDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712498184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Krg2wT5gUgUkRcgawSN6OzhRk8HtEQl5pgW8AbL+7wo=;
	b=qNuet+ns2hzQMppDZu1YGlhfZ9RYly/gssvUrPb10WEFb0tDA622QA/wqfwBnCRJp46K1O
	XandudbWXB1r+/RAOc1hoY907ZH49yoQd8BqkFappe01vP7g2bp4ikFEdYrqfUYZttjxdb
	iNJoolaL5j/DnJ/pSZ8XVaC9FE5hvuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712498184;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Krg2wT5gUgUkRcgawSN6OzhRk8HtEQl5pgW8AbL+7wo=;
	b=KYwzq6fDoYnRWOwicr8tsMFtbW4SBPG1IiBrRdw8cIqCwXrLRUsf/Vk9ClMc+x86HkjndM
	TRfrvkFfBdIIyaCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A5EEC13586;
	Sun,  7 Apr 2024 13:56:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4Kg+JQemEmbyGgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Sun, 07 Apr 2024 13:56:23 +0000
Date: Sun, 7 Apr 2024 15:56:17 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Miaohe Lin <linmiaohe@huawei.com>,
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
	stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] mm,swapops: Update check in is_pfn_swap_entry for
 hwpoison entries
Message-ID: <ZhKmAecilbb2oSD9@localhost.localdomain>
References: <20240407130537.16977-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407130537.16977-1-osalvador@suse.de>
X-Spam-Flag: NO
X-Spam-Score: -4.18
X-Spam-Level: 
X-Spamd-Result: default: False [-4.18 / 50.00];
	BAYES_HAM(-2.88)[99.50%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,intel.com:email]

On Sun, Apr 07, 2024 at 03:05:37PM +0200, Oscar Salvador wrote:
> Tony reported that the Machine check recovery was broken in v6.9-rc1,
> as he was hitting a VM_BUG_ON when injecting uncorrectable memory errors
> to DRAM.
> After some more digging and debugging on his side, he realized that this
> went back to v6.1, with the introduction of 'commit 0d206b5d2e0d ("mm/swap: add
> swp_offset_pfn() to fetch PFN from swap entry")'.
> That commit, among other things, introduced swp_offset_pfn(), replacing
> hwpoison_entry_to_pfn() in its favour.
> 
> The patch also introduced a VM_BUG_ON() check for is_pfn_swap_entry(),
> but is_pfn_swap_entry() never got updated to cover hwpoison entries, which
> means that we would hit the VM_BUG_ON whenever we would call
> swp_offset_pfn() for such entries on environments with CONFIG_DEBUG_VM set.
> Fix this by updating the check to cover hwpoison entries as well, and update
> the comment while we are it.
> 
> Reported-by: Tony Luck <tony.luck@intel.com>
> Closes: https://lore.kernel.org/all/Zg8kLSl2yAlA3o5D@agluck-desk3/
> Tested-by: Tony Luck <tony.luck@intel.com>
> Fixes: 0d206b5d2e0d ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")
> Cc: <stable@vger.kernel.org> # 6.1.x

I think I need to clarify why the stable.

It is my understanding that some distros ship their kernel with
CONFIG_DEBUG_VM set by default (I think Fedora comes to my mind?).
I am fine with backing down if people think that this is an
overreaction.


-- 
Oscar Salvador
SUSE Labs

