Return-Path: <linux-kernel+bounces-15280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3300822992
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8427C284E84
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360AC1804D;
	Wed,  3 Jan 2024 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ucZdsDp3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fXGtwbL3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ma2sj/R5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oATMvH08"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E6618032
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2005621EE8;
	Wed,  3 Jan 2024 08:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704271284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSXZ40//AYfGpTVhrABXJB2R3UQrzV4ODHYRuNkyzfE=;
	b=ucZdsDp3G1QU7wyS1tbCWPGDbrEp7jfi56NtxE/7NjYHEgIB0KSyULh3P0bak9qRvoxHR6
	nUGAwL885ROXJU/ftF6qVzJeP2XNRoVPY92S69Re3iPYBJIFNMWWm+hph+TeR836CRNJ96
	VjX3v6OZjo/F6s7iF+TahLab4s712Co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704271284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSXZ40//AYfGpTVhrABXJB2R3UQrzV4ODHYRuNkyzfE=;
	b=fXGtwbL3BZedIp558ARok3Nn5QbLfN2sWkY81UyZkX3cqr8rWOM5vumUXP3V5NM0LTSJHI
	g1D2eQV3EVgK4LDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704271282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSXZ40//AYfGpTVhrABXJB2R3UQrzV4ODHYRuNkyzfE=;
	b=Ma2sj/R5kscROfb0lAuySLyH3RgAXkMVyFs6dpgYZjRU45RpV7q/tSaB4hmdBIi+3iJFA0
	uovt8nLZxWsFGEib9oW2wHMVbt6CxA0n7pZi1omoXZxB8Z+HcH4w2lcyGTBWXEZ7ZWiVQv
	UjFrHkJ0hqTP1LjHEl8WpkS4Q6VzKAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704271282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSXZ40//AYfGpTVhrABXJB2R3UQrzV4ODHYRuNkyzfE=;
	b=oATMvH08SKXWT0vGQHEaYzKss9g1/fLGspZnuxEw/hYlfPEacwbnvC3wSQWNr78+FT1Js9
	OuehUQ/Ja9OyM1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 674AC1340C;
	Wed,  3 Jan 2024 08:41:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8W8DFrEdlWXVYQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 03 Jan 2024 08:41:21 +0000
Date: Wed, 3 Jan 2024 09:42:12 +0100
From: Oscar Salvador <osalvador@suse.de>
To: andrey.konovalov@linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v4 08/22] lib/stackdepot: rework helpers for
 depot_alloc_stack
Message-ID: <ZZUd5HWJONcLKRzJ@localhost.localdomain>
References: <cover.1700502145.git.andreyknvl@google.com>
 <71fb144d42b701fcb46708d7f4be6801a4a8270e.1700502145.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71fb144d42b701fcb46708d7f4be6801a4a8270e.1700502145.git.andreyknvl@google.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,google.com,suse.cz,googlegroups.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Ma2sj/R5";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oATMvH08
X-Spam-Score: -0.31
X-Rspamd-Queue-Id: 2005621EE8

On Mon, Nov 20, 2023 at 06:47:06PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Split code in depot_alloc_stack and depot_init_pool into 3 functions:
> 
> 1. depot_keep_next_pool that keeps preallocated memory for the next pool
>    if required.
> 
> 2. depot_update_pools that moves on to the next pool if there's no space
>    left in the current pool, uses preallocated memory for the new current
>    pool if required, and calls depot_keep_next_pool otherwise.
> 
> 3. depot_alloc_stack that calls depot_update_pools and then allocates
>    a stack record as before.
> 
> This makes it somewhat easier to follow the logic of depot_alloc_stack
> and also serves as a preparation for implementing the eviction of stack
> records from the stack depot.
> 
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

I have to say this simplifies the reading quite a lot.

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

