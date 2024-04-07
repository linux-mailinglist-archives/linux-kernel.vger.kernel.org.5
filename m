Return-Path: <linux-kernel+bounces-134641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0BF89B404
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE82B1C20A80
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959BC3BBE8;
	Sun,  7 Apr 2024 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="crU14iFP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bwZuR8US";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="crU14iFP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bwZuR8US"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD6848E;
	Sun,  7 Apr 2024 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712521929; cv=none; b=o2CLEBrUqL080ob/q0rJMf2STezb842eAAWJxLvHZVu1NtF+vtVrbKe+sgt05MZjBmjtJpkMAMQ+KrPh3hdEMK689h79cKHCyLh6SHN67skSoFs5q3bI5rnz9WHvqZpaHmXOl7SYX8tM8rIO4No9gM4Hiqt/WEvX/dzDQY3iA1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712521929; c=relaxed/simple;
	bh=Qjs1ELNGM7Bwo6LVpJstIXlB/+8JnBcs6oL5LtpbRqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZkqh/IrWWfgMAHKCZVoepeFqUAilwkLuM0Ua9VsA1PBysNaIOpeZomwXO3h+qeyH4XuqruR9USATAxz3MCuTi7SnPCTMO4jms6M/5AzCVgbsv0LSIP5Iyc9AOg35drCNon+9fLDSu5ntYkBjcciJdgcehzD3c98J99JXuZNO24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=crU14iFP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bwZuR8US; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=crU14iFP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bwZuR8US; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B16CD220CC;
	Sun,  7 Apr 2024 20:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712521925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7+MqK9GjxoPTsi874+SCYm6UKdPkhYnyEBVah2Xjt4=;
	b=crU14iFPQb6X0GNwS+THE+r7Db90av3f5JRE913jASbKBQ9X+ljvAv+ramOTdYn/NYB93N
	RiiJguUc3SM6j5+gW8BdUoydUOdFrqXyrwB/fo6dznEZok3k2JBd7qUEv0NQwUivUHb++g
	AXlJ9PX4c9Xu/c6trsF4/G1areoK5Pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712521925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7+MqK9GjxoPTsi874+SCYm6UKdPkhYnyEBVah2Xjt4=;
	b=bwZuR8US+aOkQh4AP6jE0jnMyQH5O+IlT+QlCBXjLTuKUVnZ6/hqGMnhGnycp37pKPYknq
	ZW1X5H1qW88JblDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=crU14iFP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bwZuR8US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712521925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7+MqK9GjxoPTsi874+SCYm6UKdPkhYnyEBVah2Xjt4=;
	b=crU14iFPQb6X0GNwS+THE+r7Db90av3f5JRE913jASbKBQ9X+ljvAv+ramOTdYn/NYB93N
	RiiJguUc3SM6j5+gW8BdUoydUOdFrqXyrwB/fo6dznEZok3k2JBd7qUEv0NQwUivUHb++g
	AXlJ9PX4c9Xu/c6trsF4/G1areoK5Pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712521925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7+MqK9GjxoPTsi874+SCYm6UKdPkhYnyEBVah2Xjt4=;
	b=bwZuR8US+aOkQh4AP6jE0jnMyQH5O+IlT+QlCBXjLTuKUVnZ6/hqGMnhGnycp37pKPYknq
	ZW1X5H1qW88JblDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2589713586;
	Sun,  7 Apr 2024 20:32:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +qNqBsUCE2YmCQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Sun, 07 Apr 2024 20:32:05 +0000
Date: Sun, 7 Apr 2024 22:31:59 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Miaohe Lin <linmiaohe@huawei.com>,
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH] mm,swapops: Update check in is_pfn_swap_entry for
 hwpoison entries
Message-ID: <ZhMCvynFUDr-8DpX@localhost.localdomain>
References: <20240407130537.16977-1-osalvador@suse.de>
 <ZhKmAecilbb2oSD9@localhost.localdomain>
 <ZhLx3fwzQNPDbBei@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhLx3fwzQNPDbBei@x1n>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B16CD220CC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.51

> Totally unexpected, as this commit even removed hwpoison_entry_to_pfn().
> Obviously even until now I assumed hwpoison is accounted as pfn swap entry
> but it's just missing..
> 
> Since this commit didn't really change is_pfn_swap_entry() itself, I was
> thinking maybe an older fix tag would apply, but then I noticed the old
> code indeed should work well even if hwpoison entry is missing.  For
> example, it's a grey area on whether a hwpoisoned page should be accounted
> in smaps.  So I think the Fixes tag is correct, and thanks for fixing this.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks Peter

> Fedora stopped having DEBUG_VM for some time, but not sure about when it's
> still in the 6.1 trees.  It looks like cc stable is still reasonable from
> that regard.

Good to know, thanks for the info.

> A side note is that when I'm looking at this, I went back and see why in
> some cases we need the pfn maintained for the poisoned, then I saw the only
> user is check_hwpoisoned_entry() who wants to do fast kills in some
> contexts and that includes a double check on the pfns in a poisoned entry.
> Then afaict this path is just too rarely used and buggy.

Yes, unfortunately memory-failure code does not get exercised that much,
and so there might be subtly bugs lurking in there for quite some time.

> A few things we may need fixing, maybe someone in the loop would have time
> to have a look:
> 
> - check_hwpoisoned_entry()
>   - pte_none check is missing
>   - all the rest swap types are missing (e.g., we want to kill the proc too
>     if the page is during migration)
> - check_hwpoisoned_pmd_entry()
>   - need similar care like above (pmd_none is covered not others)

I will have a look and see what needs fixing, thanks for bringing it up.


-- 
Oscar Salvador
SUSE Labs

