Return-Path: <linux-kernel+bounces-15264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F6982295B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528E0B21621
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB9182AB;
	Wed,  3 Jan 2024 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c6DUitPQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cCyZ7Ti8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HlW+xlJ2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L5gPJvUG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE9E182A2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C6341F798;
	Wed,  3 Jan 2024 08:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704269641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EHzT6aEuunaF8l957oLeyQUzYLU5v+V8f8tLm26sh6Q=;
	b=c6DUitPQDMRwF+0goNIS1n9Q0sr99l84uw2rTrxYLUZo4553qSO56Q41HlH0GbKdkhZJTW
	22mJpS+H/qKDYwIXq4K3gRk2ACrmx+/pVmT2qgyy9HNqPV4PPfHrCVBJMYwfLqg5heHr6D
	BOnBATflnsTYq51QctE/eIt9Z66sDMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704269641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EHzT6aEuunaF8l957oLeyQUzYLU5v+V8f8tLm26sh6Q=;
	b=cCyZ7Ti86IGLu4B9k6WFjJGXYPDYEwA0tSo34nnmEYMDnfOVvQg4gahtNBJUY/XwwOXb6W
	jihSN0D4Xwq8/QCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704269640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EHzT6aEuunaF8l957oLeyQUzYLU5v+V8f8tLm26sh6Q=;
	b=HlW+xlJ2flYs8Ie3LfqBXcZLLCXsPnlmeyNwYByRNLwgoM/NqpmqVOmOTW6EWgr0HgsGlE
	U/BGuf1rkvii764yUoymTTCYqRIz/dvsCiS/q6IwlvtN58Evu4ckpYClx2JK+u2i2O4+NQ
	JWQDEi0tdlBlblgJ6L5H63stSix/Kt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704269640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EHzT6aEuunaF8l957oLeyQUzYLU5v+V8f8tLm26sh6Q=;
	b=L5gPJvUGmCkrGVVkF3WH2nqdQl2bjBdu+Y7S8tPHLacvvIRiMeQCoTJdmpe5zD/a/aUD3d
	6cnsmAFtEUCM4BBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E2851340C;
	Wed,  3 Jan 2024 08:13:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SfDJD0cXlWWaWgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 03 Jan 2024 08:13:59 +0000
Date: Wed, 3 Jan 2024 09:14:49 +0100
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
Subject: Re: [PATCH v4 01/22] lib/stackdepot: print disabled message only if
 truly disabled
Message-ID: <ZZUXeSTWneflnRn6@localhost.localdomain>
References: <cover.1700502145.git.andreyknvl@google.com>
 <73a25c5fff29f3357cd7a9330e85e09bc8da2cbe.1700502145.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73a25c5fff29f3357cd7a9330e85e09bc8da2cbe.1700502145.git.andreyknvl@google.com>
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-0.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,google.com,suse.cz,googlegroups.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[40.46%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -0.10
X-Spam-Flag: NO

On Mon, Nov 20, 2023 at 06:46:59PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Currently, if stack_depot_disable=off is passed to the kernel
> command-line after stack_depot_disable=on, stack depot prints a message
> that it is disabled, while it is actually enabled.
> 
> Fix this by moving printing the disabled message to
> stack_depot_early_init. Place it before the
> __stack_depot_early_init_requested check, so that the message is printed
> even if early stack depot init has not been requested.
> 
> Also drop the stack_table = NULL assignment from disable_stack_depot,
> as stack_table is NULL by default.
> 
> Fixes: e1fdc403349c ("lib: stackdepot: add support to disable stack depot")
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs

