Return-Path: <linux-kernel+bounces-15273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB5482297A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE8BB2286E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDB6154B8;
	Wed,  3 Jan 2024 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q2/SuwAm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+WwTfcZ1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q2/SuwAm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+WwTfcZ1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FCED313
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CE3B1FD0B;
	Wed,  3 Jan 2024 08:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704270610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XqOr95siHnywoD7/KUJ+ty+J9r6iy/sRySCRnI6kD0E=;
	b=Q2/SuwAm1Eb8k0Kz7EA7hWXRextYholBQCxjAvSsmmaEZqdpMd01zZGlGaw7DZ5oaJDYwp
	W9V3oWm6fUVOurrG/ygL+F4VBs4ZMe2Sd7+1Pwhbd/7g+78pOx9AEiiDEFp0eq5zj3YhyO
	3k/p3iWgTVYeozldS578T8Vtti5ROHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704270610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XqOr95siHnywoD7/KUJ+ty+J9r6iy/sRySCRnI6kD0E=;
	b=+WwTfcZ1LOcXJa24SVdLbjO468sU3uEK/j3Bw/CchAnb4PU27CyI8jl2BlxaEev6NjlQUO
	VUzPQhRrLQ7SVZBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704270610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XqOr95siHnywoD7/KUJ+ty+J9r6iy/sRySCRnI6kD0E=;
	b=Q2/SuwAm1Eb8k0Kz7EA7hWXRextYholBQCxjAvSsmmaEZqdpMd01zZGlGaw7DZ5oaJDYwp
	W9V3oWm6fUVOurrG/ygL+F4VBs4ZMe2Sd7+1Pwhbd/7g+78pOx9AEiiDEFp0eq5zj3YhyO
	3k/p3iWgTVYeozldS578T8Vtti5ROHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704270610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XqOr95siHnywoD7/KUJ+ty+J9r6iy/sRySCRnI6kD0E=;
	b=+WwTfcZ1LOcXJa24SVdLbjO468sU3uEK/j3Bw/CchAnb4PU27CyI8jl2BlxaEev6NjlQUO
	VUzPQhRrLQ7SVZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E614D1340C;
	Wed,  3 Jan 2024 08:30:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fP9iNREblWX4XgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 03 Jan 2024 08:30:09 +0000
Date: Wed, 3 Jan 2024 09:30:56 +0100
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
Subject: Re: [PATCH v4 06/22] lib/stackdepot: use fixed-sized slots for stack
 records
Message-ID: <ZZUbQOqDGUWmkFFx@localhost.localdomain>
References: <cover.1700502145.git.andreyknvl@google.com>
 <dce7d030a99ff61022509665187fac45b0827298.1700502145.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dce7d030a99ff61022509665187fac45b0827298.1700502145.git.andreyknvl@google.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,google.com,suse.cz,googlegroups.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Mon, Nov 20, 2023 at 06:47:04PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Instead of storing stack records in stack depot pools one right after
> another, use fixed-sized slots.
> 
> Add a new Kconfig option STACKDEPOT_MAX_FRAMES that allows to select
> the size of the slot in frames. Use 64 as the default value, which is
> the maximum stack trace size both KASAN and KMSAN use right now.
> 
> Also add descriptions for other stack depot Kconfig options.
> 
> This is preparatory patch for implementing the eviction of stack records
> from the stack depot.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

