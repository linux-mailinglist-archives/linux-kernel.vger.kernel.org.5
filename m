Return-Path: <linux-kernel+bounces-65965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F14855484
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2811C2209D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A1413DBA4;
	Wed, 14 Feb 2024 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZRTIFXNw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="arGAyaHT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZRTIFXNw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="arGAyaHT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CFB41C71
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945173; cv=none; b=nnnWrpp5sYmIXJotyL5g3tN3LA1VkFZorgw6bBL4Dj0vqg1GezH14aeZgsbuubFaeb4h2wGqSfQvOh00COdjWSZ2i/sM8y0/KTNph8H7wcahB3fdRzHo0oYULGHfk6O7NawN9uzZb/o/hSNJMlo6eOktq8MUsgSeQTO+9c19IoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945173; c=relaxed/simple;
	bh=ju41AawBSluKveCx1Sf0/H8XnWiSATiSu3EkXgRrEOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmUxiEX74I+Uqyu3UYRZplfJ+4b4/bofa0retQV58+uav2qiTgtnfWjqsYoulvX05x4ozTTm1dJDDXPVMw/HQgM7kng1emIsV1XFB/zYm6NSzssaIKNDhIP0VIQVmIZNF27hXpYIc01g99s4U+Bhr2GDJ3YYA/OuPdMT9baHys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZRTIFXNw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=arGAyaHT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZRTIFXNw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=arGAyaHT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0853F2200E;
	Wed, 14 Feb 2024 21:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707945169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8wdY0YFKaKjOV8Tnp1nu+NBL4FYahcJXwydnW14Moc=;
	b=ZRTIFXNwfOtwTZdKWQt1m+4Gej5esIMZqFEblSo3iUXIWBGnBUgcoxmq1V54hJPeOF8IiH
	+8WdmSNY9K6CelvrLRKw9RN1CoSGivKF8xkyxWC7dvboMMTmQWTYhjELxC2mRZg3BboEeD
	j7L0AWA3KTeS+C1lX7jOWnAK2q2xP0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707945169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8wdY0YFKaKjOV8Tnp1nu+NBL4FYahcJXwydnW14Moc=;
	b=arGAyaHTPZWmvDdFeT/H33P/RCAeChCOGvezGpqce3gLz6KWz85yaZ1Fu9dMaEwJ0T1EU+
	ZBPgxwPK6dFPqgAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707945169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8wdY0YFKaKjOV8Tnp1nu+NBL4FYahcJXwydnW14Moc=;
	b=ZRTIFXNwfOtwTZdKWQt1m+4Gej5esIMZqFEblSo3iUXIWBGnBUgcoxmq1V54hJPeOF8IiH
	+8WdmSNY9K6CelvrLRKw9RN1CoSGivKF8xkyxWC7dvboMMTmQWTYhjELxC2mRZg3BboEeD
	j7L0AWA3KTeS+C1lX7jOWnAK2q2xP0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707945169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8wdY0YFKaKjOV8Tnp1nu+NBL4FYahcJXwydnW14Moc=;
	b=arGAyaHTPZWmvDdFeT/H33P/RCAeChCOGvezGpqce3gLz6KWz85yaZ1Fu9dMaEwJ0T1EU+
	ZBPgxwPK6dFPqgAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2722513A0B;
	Wed, 14 Feb 2024 21:12:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6chtBtAszWXmYgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Wed, 14 Feb 2024 21:12:48 +0000
Date: Wed, 14 Feb 2024 22:13:57 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Byungchul Park <byungchul@sk.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org
Subject: Re: [PATCH] sched/numa, mm: do not promote folios to nodes not set
 N_MEMORY
Message-ID: <Zc0tFdGAzD9sCzZN@localhost.localdomain>
References: <20240214035355.18335-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214035355.18335-1-byungchul@sk.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZRTIFXNw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=arGAyaHT
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.96 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.45)[78.84%]
X-Spam-Score: -2.96
X-Rspamd-Queue-Id: 0853F2200E
X-Spam-Flag: NO

On Wed, Feb 14, 2024 at 12:53:55PM +0900, Byungchul Park wrote:
> While running qemu with a configuration where some CPUs don't have their
> local memory and with a kernel numa balancing on, the following oops has
> been observed. It's because of null pointers of ->zone_pgdat of zones of
> those nodes that are not initialized at booting time. So should avoid
> nodes not set N_MEMORY from getting promoted.

Looking at free_area_init(), we call free_area_init_node() for each node
found on the system.
And free_area_init_node()->free_area_init_core() inits all zones
belonging to the system via zone_init_internals().
Now, I am not saying the check is wrong because we obviously do not want
migrate memory to a memoryless node, but I am confused as to where
we are crashing.


-- 
Oscar Salvador
SUSE Labs

