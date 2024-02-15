Return-Path: <linux-kernel+bounces-66413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F006855C78
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A45B2DB5B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E619413AE0;
	Thu, 15 Feb 2024 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gIzYjlVx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O9WKxATL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gIzYjlVx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O9WKxATL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A2134B2
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985293; cv=none; b=Pkh/cGj9KCk6KCE0Q8W8PsHkk22sSD1htNqqs9cbdEtRqRUY3dDGNNovBMrohptNOl12EcoEU0NUvRbGZ1m3JjWiiArV7aof7ytl8j3uLACXVkUTJKYpHtgoy8Z9X2XgIzwXlyRwQwygd2rNEuMLC86CRJtRaiabioW1w8tJKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985293; c=relaxed/simple;
	bh=mCZlRxTT3ks1o0Wxlc471j56Zg3OmY8+rRjiEwgE9kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rac82YYK0ymhiuWYgPyJnmBh73VftTK6XfdXw1hFFYza3IoWIUceUgNoX7zA1fcYpe3rLBqn2tUVuu1jHAsbizJBTx2ZR0A9Z/JefkOFV2B7XOoW8WKkoX5HW+LkVwMRhJ+ynwbGSEE4U+BEHKGfHN9LH6rv3hWO++scV88mnjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gIzYjlVx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O9WKxATL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gIzYjlVx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O9WKxATL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 348732200E;
	Thu, 15 Feb 2024 08:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707985289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62OqNxQVqlW6gW3Iult+OUncmOSdQUww1KVBTXtKUrg=;
	b=gIzYjlVxxPEDp7gUbJqZKTbVHz/ot8Wr10BiVCY9N+Cjwx8Eli/umrarcIrqV0tRWEmDs/
	CtSAAfcGlQkOj2AdRQC4Y0XVIY2zrL54RHHCriLZCHJ0qoSLa8qbL38rmZu51WkiDy8BIT
	4LHqmc/w4qVO4a9rXsi6n7Qlg3AO48M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707985289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62OqNxQVqlW6gW3Iult+OUncmOSdQUww1KVBTXtKUrg=;
	b=O9WKxATL/TWLOiCB0s/HXQm5wRCnL5NEybp9bVw18Cz1n6dE6mYGwUqJ78FfeEKyAphcDF
	K/KEAaLmgTG1WlAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707985289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62OqNxQVqlW6gW3Iult+OUncmOSdQUww1KVBTXtKUrg=;
	b=gIzYjlVxxPEDp7gUbJqZKTbVHz/ot8Wr10BiVCY9N+Cjwx8Eli/umrarcIrqV0tRWEmDs/
	CtSAAfcGlQkOj2AdRQC4Y0XVIY2zrL54RHHCriLZCHJ0qoSLa8qbL38rmZu51WkiDy8BIT
	4LHqmc/w4qVO4a9rXsi6n7Qlg3AO48M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707985289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62OqNxQVqlW6gW3Iult+OUncmOSdQUww1KVBTXtKUrg=;
	b=O9WKxATL/TWLOiCB0s/HXQm5wRCnL5NEybp9bVw18Cz1n6dE6mYGwUqJ78FfeEKyAphcDF
	K/KEAaLmgTG1WlAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9225A139D0;
	Thu, 15 Feb 2024 08:21:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YC7OIIjJzWUsWQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Thu, 15 Feb 2024 08:21:28 +0000
Date: Thu, 15 Feb 2024 09:22:39 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v9 2/7] lib/stackdepot: Move stack_record struct
 definition into the header
Message-ID: <Zc3Jz_eJaZ8MdnWV@localhost.localdomain>
References: <20240214170157.17530-1-osalvador@suse.de>
 <20240214170157.17530-3-osalvador@suse.de>
 <CANpmjNPypJM5icG9M5yP5-psSofbA7D35eaKx+E6NyCsHMa=qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPypJM5icG9M5yP5-psSofbA7D35eaKx+E6NyCsHMa=qg@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,gmail.com,google.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.19)[70.93%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.29

On Thu, Feb 15, 2024 at 09:16:58AM +0100, Marco Elver wrote:
> On Wed, 14 Feb 2024 at 18:00, Oscar Salvador <osalvador@suse.de> wrote:
> > -/* The pool_index is offset by 1 so the first record does not have a 0 handle. */
> > +/* The pool_index is offset by 1 so the first record does not have a 0 handle */
> 
> Why this comment change? We lost the '.' -- for future reference, it'd
> be good to ensure unnecessary changes don't creep into the diff. This
> is just nitpicking, and I've already reviewed this change, so no need
> to send a v+1.

Right, this was an oversight.

Andrew, please fold the following into the patch, thanks:

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 4a661a6777da..514b8d40ff57 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -37,7 +37,7 @@
 #include <linux/kasan-enabled.h>

 #define DEPOT_POOLS_CAP 8192
-/* The pool_index is offset by 1 so the first record does not have a 0 handle */
+/* The pool_index is offset by 1 so the first record does not have a 0 handle. */
 #define DEPOT_MAX_POOLS \
 	(((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
 	 (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)

-- 
Oscar Salvador
SUSE Labs

