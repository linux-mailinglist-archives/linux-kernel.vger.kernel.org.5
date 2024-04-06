Return-Path: <linux-kernel+bounces-133782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6454D89A899
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FCE1C21449
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA591171A1;
	Sat,  6 Apr 2024 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zi+vyXrZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lE5wQbyp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oXq0I/qM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YD+dZhTE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54563748A
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712373438; cv=none; b=L9KzaYJ+zvoBbWTkBpo0eXcSl/zoUuz7TmKqWfN7y2b2zbQS8FTLLu2R3ZaCqEpfDKmQLRKgUQ2d1X9h5dvC9hxT+xHT58gKUjM7AbM3ggGAVTsfio60IX7EbffSWQT5333tf6wGQ2UdFwVx4UbVEz2nOhBatsdhl6LN5WhRyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712373438; c=relaxed/simple;
	bh=ZDNTT4orWO+yGcBwhoilSh9QLGvwHLCJYmRjqkhpigc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilUab/ps74HVkdwlX7JCcRVZGI51qeDFqQ3Ujjv0Vn5X5qkOnwuW1C0XwizuY478Hy6hUzIkJzlRnDTrt+x3MfCOcuP16zcnimJgVuEVe5yvidKn6LJop4cFs2sV4N8iY/P0oX8W0O8NBnN6F7V1zF0oREf0zg1m7vb+6n9VfQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zi+vyXrZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lE5wQbyp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oXq0I/qM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YD+dZhTE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26DF921AE4;
	Sat,  6 Apr 2024 03:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712373434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpgaMd6orF9J6xhkgaKt5jg3h/PGv12uwnvhyGZ7p8k=;
	b=Zi+vyXrZcKUXPhYLhs6NjjEupufetEio2z0rovOHayByuScK/V6XPjhMJabwxwVCq/N9+i
	7iWN8eIbY8P1i3PieEKgsC/bk07FTVaH1ikjrg3w8gAgKOVaPEGvJv9X/GM0MaGJi4KAKP
	RAj8xxWohmrQ3ViCPZGFJZYrCJ3VlFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712373434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpgaMd6orF9J6xhkgaKt5jg3h/PGv12uwnvhyGZ7p8k=;
	b=lE5wQbypc1iCrLupM+R2njzT050wduDUqdAXzgHlVwLp32j1B7Ar6wP7jPSEFbUp8z2SQZ
	BqI/QvZC2KfZf4Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712373433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpgaMd6orF9J6xhkgaKt5jg3h/PGv12uwnvhyGZ7p8k=;
	b=oXq0I/qM9vxyE71iza/9g0JDrWrFkMeIzsNsNGZpQy+Y6CAr/RyrK0JanUB1ldtm0CX4PF
	n0SlKdSHKsikxd0X/XWcd7VSr8zM/IG3YSGPgJz40CfIJe/G2QR2a+j70OOdbkTWw0m63Z
	NGkrREBuPVkxukPkgR22mSEQLmT0LXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712373433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpgaMd6orF9J6xhkgaKt5jg3h/PGv12uwnvhyGZ7p8k=;
	b=YD+dZhTEof8CpPGLOcYKHTsURDB2mCklfBTLrnUCXaElr1QR33gAbJBVC0hIBGMBOP/tZR
	On30oixO6qWC/sBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 43880139E8;
	Sat,  6 Apr 2024 03:17:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9dQfNLe+EGaxHAAAn2gu4w
	(envelope-from <osalvador@suse.de>); Sat, 06 Apr 2024 03:17:11 +0000
Date: Sat, 6 Apr 2024 04:18:41 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Tony Luck <tony.luck@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Machine check recovery broken in v6.9-rc1
Message-ID: <ZhCxAZy-Iuz2XR7A@localhost.localdomain>
References: <Zg8kLSl2yAlA3o5D@agluck-desk3>
 <1e943439-6044-4aa4-8c41-747e9e4dca27@redhat.com>
 <SJ1PR11MB6083AB3E55B7DE0D3FBE185EFC032@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZhCQPwgMWo9w3LlO@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhCQPwgMWo9w3LlO@agluck-desk3>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.47 / 50.00];
	BAYES_HAM(-2.17)[96.02%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.47
X-Spam-Flag: NO

On Fri, Apr 05, 2024 at 04:58:55PM -0700, Tony Luck wrote:
> So a problem (not necessarily the current upstream problem given the
> amount of additional changes that happened) began way back in this
> commit from v6.1:
> 
> 0d206b5d2e0d ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")
> 
> This commit gives the "kernel BUG at include/linux/swapops.h:88!" while
> its predecessor runs without errors).

Tony, could you try the following patch, to see if that goes away?
It is against 6.1, but current kernel has the same problem AFAICS.


diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 578212fbf2be..575d428393c0 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -416,7 +416,7 @@ static inline bool is_pfn_swap_entry(swp_entry_t entry)
 	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);

 	return is_migration_entry(entry) || is_device_private_entry(entry) ||
-	       is_device_exclusive_entry(entry);
+	       is_device_exclusive_entry(entry) || is_hwpsoion_entry(entry);
 }

 struct page_vma_mapped_walk;


Thanks


-- 
Oscar Salvador
SUSE Labs

