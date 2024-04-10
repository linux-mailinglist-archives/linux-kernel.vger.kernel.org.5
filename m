Return-Path: <linux-kernel+bounces-138204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C0389EE05
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8261F22572
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0945154BFF;
	Wed, 10 Apr 2024 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jPGHdLkF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MO178eB9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jPGHdLkF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MO178eB9"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA3113D51C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712739180; cv=none; b=uOdzmMTelH43Gu4p+bpm5ahSVyQWlkR71aGtD/zPQ2peAmWySZQJDLOAyX45hjftIlxDcKBrP6qcbKyFkrmNhbFPJaR46fh0d2DXt/9A0l09bon07cQgNdghr2p7hV2FCAvw30IXlB3QNUgGcioYggP2R1SKyo59FjEv9XfUiKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712739180; c=relaxed/simple;
	bh=NOqyjJWsjrdxDG8MZMYxjXVWFooGfAjTrCWU5XEubeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4WU9VUB5TracVSl2odZZo3Ye+MUzmZkB41khhmLVflQMzXH4Up8sq9PsuGX+zYz0AgQZZvQUqRmj7grP6mEM2Op/MYAGqRboFI+X0s1yL4mnFl4pJ6GBj5EYym91YAjgGvol+EtSQ/k4/kkWYiTrkTZhrfPJESAJ05qI0URi98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jPGHdLkF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MO178eB9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jPGHdLkF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MO178eB9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3281A5C8C1;
	Wed, 10 Apr 2024 08:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712739176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a4/3Q4DJ9o/sc+7kC2HhXGX78ya0FrJXHzbJCF/H0r8=;
	b=jPGHdLkFAW9b9GD4dsBdDAaVAWrr3d7nadyMQlBfXlDj6j6x7p6Jx4JSl47UkEV77fYEmy
	G3hqNvrzH3Yc6UIqJqRee1+zjqhz21bzolVKxhBvBhofJw2IlAcc8nagCFOZT3blHLRSJC
	nq64WvUf4uVyForMkjt6AlLr7vegrVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712739176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a4/3Q4DJ9o/sc+7kC2HhXGX78ya0FrJXHzbJCF/H0r8=;
	b=MO178eB9uPnWzO2/WxY/xl4HlULtieXGKwMjyrsNF5sggJA1ozfvLh6yxatquurgq8zwON
	5dx5rShwTg0411DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712739176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a4/3Q4DJ9o/sc+7kC2HhXGX78ya0FrJXHzbJCF/H0r8=;
	b=jPGHdLkFAW9b9GD4dsBdDAaVAWrr3d7nadyMQlBfXlDj6j6x7p6Jx4JSl47UkEV77fYEmy
	G3hqNvrzH3Yc6UIqJqRee1+zjqhz21bzolVKxhBvBhofJw2IlAcc8nagCFOZT3blHLRSJC
	nq64WvUf4uVyForMkjt6AlLr7vegrVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712739176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a4/3Q4DJ9o/sc+7kC2HhXGX78ya0FrJXHzbJCF/H0r8=;
	b=MO178eB9uPnWzO2/WxY/xl4HlULtieXGKwMjyrsNF5sggJA1ozfvLh6yxatquurgq8zwON
	5dx5rShwTg0411DQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CB17E1390D;
	Wed, 10 Apr 2024 08:52:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id RwnqLmdTFmZwVwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Wed, 10 Apr 2024 08:52:55 +0000
Date: Wed, 10 Apr 2024 10:52:54 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: akpm@linux-foundation.org, naoya.horiguchi@nec.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory-failure: fix deadlock when
 hugetlb_optimize_vmemmap is enabled
Message-ID: <ZhZTZtzyMpMMowoD@localhost.localdomain>
References: <20240407085456.2798193-1-linmiaohe@huawei.com>
 <ZhVMThr9TNeP6SWj@localhost.localdomain>
 <ZhVoatdJZ1RWu2r3@localhost.localdomain>
 <13aa38af-46a1-3894-32bd-c3eb6ef67359@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13aa38af-46a1-3894-32bd-c3eb6ef67359@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]

On Wed, Apr 10, 2024 at 03:52:14PM +0800, Miaohe Lin wrote:
> AFAICS, iff check_pages_enabled static key is enabled and in hard offline mode,
> check_new_pages() will prevent those pages from ending up in a PCP queue again
> when refilling PCP list. Because PageHWPoison pages will be taken as 'bad' pages
> and skipped when refill PCP list.

Yes, but check_pages_enabled static key is only enabled when
either CONFIG_DEBUG_PAGEALLOC or CONFIG_DEBUG_VM are set, which means
that under most of the systems that protection will not take place.

Which takes me to a problem we had in the past where we were handing
over hwpoisoned pages from PCP lists happily.
Now, with for soft-offline mode, we worked hard to stop doing that
because soft-offline is a non-disruptive operation and no one should get 
killed.
hard-offline is another story, but still I think that extending the
comment to include the following would be a good idea:

"Disabling pcp before dissolving the page was a deterministic approach
 because we made sure that those pages cannot end up in any PCP list.
 Draining PCP lists expels those pages to the buddy system, but nothing
 guarantees that those pages do not get back to a PCP queue if we need
 to refill those."

 Just to remind ourselves of the dangers of a non-deterministic
 approach.


Thanks


-- 
Oscar Salvador
SUSE Labs

