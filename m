Return-Path: <linux-kernel+bounces-15301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B928229E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A03CB219F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F37182AF;
	Wed,  3 Jan 2024 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OXxrEElr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eiUS5Rvv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OXxrEElr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eiUS5Rvv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1457818043
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0712821C64;
	Wed,  3 Jan 2024 09:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704272756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YHgEMpLm7folf5G8Ij+ZasKgK+9OLJsmoPBAUvLJ/8=;
	b=OXxrEElrNfC+/T5mY1izxFruu35404m0j3OipElyrHhk70EhEVSjlrTgu1vHsM7m2zzddg
	wfDLOFu0uHl2077tXTxU2DOG2tMOxxzwt6Ejg3BoTFg8fbvshfCghQeO5fMoiJP4SejDlv
	6bKYK1+hsT557oQjts72D0rfr15YI6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704272756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YHgEMpLm7folf5G8Ij+ZasKgK+9OLJsmoPBAUvLJ/8=;
	b=eiUS5Rvvpde2p9gy0tfi2VBTJMrDVIqjkFif9iFzaiZJR1Yf74nJIgN+sL4NhjL8LSRVN1
	J6Y5ZmX1tSoldzDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704272756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YHgEMpLm7folf5G8Ij+ZasKgK+9OLJsmoPBAUvLJ/8=;
	b=OXxrEElrNfC+/T5mY1izxFruu35404m0j3OipElyrHhk70EhEVSjlrTgu1vHsM7m2zzddg
	wfDLOFu0uHl2077tXTxU2DOG2tMOxxzwt6Ejg3BoTFg8fbvshfCghQeO5fMoiJP4SejDlv
	6bKYK1+hsT557oQjts72D0rfr15YI6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704272756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YHgEMpLm7folf5G8Ij+ZasKgK+9OLJsmoPBAUvLJ/8=;
	b=eiUS5Rvvpde2p9gy0tfi2VBTJMrDVIqjkFif9iFzaiZJR1Yf74nJIgN+sL4NhjL8LSRVN1
	J6Y5ZmX1tSoldzDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C2421340C;
	Wed,  3 Jan 2024 09:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2UebC3MjlWUEaQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 03 Jan 2024 09:05:55 +0000
Date: Wed, 3 Jan 2024 10:06:46 +0100
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
Subject: Re: [PATCH v4 10/22] lib/stackdepot: store next pool pointer in
 new_pool
Message-ID: <ZZUjptpWL8qBO5f3@localhost.localdomain>
References: <cover.1700502145.git.andreyknvl@google.com>
 <448bc18296c16bef95cb3167697be6583dcc8ce3.1700502145.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448bc18296c16bef95cb3167697be6583dcc8ce3.1700502145.git.andreyknvl@google.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.71
X-Spamd-Result: default: False [-3.71 / 50.00];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,google.com,suse.cz,googlegroups.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.41)[97.30%]
X-Spam-Flag: NO

On Mon, Nov 20, 2023 at 06:47:08PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Instead of using the last pointer in stack_pools for storing the pointer
> to a new pool (which does not yet store any stack records), use a new
> new_pool variable.
> 
> This a purely code readability change: it seems more logical to store
> the pointer to a pool with a special meaning in a dedicated variable.
> 
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

