Return-Path: <linux-kernel+bounces-15283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C3B8229A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7ECE1F23DCD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AF6182AA;
	Wed,  3 Jan 2024 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="efssd6kr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1i5Jx7Xl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KCLEnSxJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U9D7U0Ou"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A04A182A8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A91D21EE8;
	Wed,  3 Jan 2024 08:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704271426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zux5DXsqyH6BF4yrGNwF3g4Ah5PlzMOsxiJLSpjUelg=;
	b=efssd6krmufO7s7BjYjX4kXIlfTggXLqaDwm2EEtHHIGJy9RBx/FZhjbSFQ4510jtq7W3C
	+YrIKyBfdYdPOcWB8yJ9DwEAFCIB7fBUAdZNnCeusgA+ra424PrMqqYbRkza/4MJZnIKbC
	T+BWIhfSgGbZpgE+EbtgLjE39562/Wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704271426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zux5DXsqyH6BF4yrGNwF3g4Ah5PlzMOsxiJLSpjUelg=;
	b=1i5Jx7XlEQ6CgdWbMeSsPaJfLfpQ+y2pAfMAvNLaFotoBzvvWe0vo/uQ8s1mESthZuqGIv
	td867vohbcdyxEBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704271424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zux5DXsqyH6BF4yrGNwF3g4Ah5PlzMOsxiJLSpjUelg=;
	b=KCLEnSxJDdHL+1zfH5kPI2i9MFu6eHwSXdi7MnxUgy/pA7AEWfF8U35FjjyD4mBun2VWHd
	M9jXU3xSbJmGg5ojWRjSKClkPYvAp+y/ZWWFK8A4irJqBL26WYtF6isRofmXUKNFBNVJmu
	olQbBtGISb+mG+ncVHgbM8hpbGAtZEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704271424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zux5DXsqyH6BF4yrGNwF3g4Ah5PlzMOsxiJLSpjUelg=;
	b=U9D7U0Oul2hs+oq90oM9rH0a2xmkJ3+1oT1FRlV+W3bqfDobEuXpuJABa9GSPZYtun3XN+
	VwWLOxiL/SluEuDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E44B31340C;
	Wed,  3 Jan 2024 08:43:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uGD7ND8elWV2YgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 03 Jan 2024 08:43:43 +0000
Date: Wed, 3 Jan 2024 09:44:30 +0100
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
Subject: Re: [PATCH v4 09/22] lib/stackdepot: rename next_pool_required to
 new_pool_required
Message-ID: <ZZUebp1YZKzIN0VN@localhost.localdomain>
References: <cover.1700502145.git.andreyknvl@google.com>
 <fd7cd6c6eb250c13ec5d2009d75bb4ddd1470db9.1700502145.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd7cd6c6eb250c13ec5d2009d75bb4ddd1470db9.1700502145.git.andreyknvl@google.com>
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KCLEnSxJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=U9D7U0Ou
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.36 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.85)[99.38%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,linux.dev:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,google.com,suse.cz,googlegroups.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.36
X-Rspamd-Queue-Id: 9A91D21EE8
X-Spam-Flag: NO

On Mon, Nov 20, 2023 at 06:47:07PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Rename next_pool_required to new_pool_required.
> 
> This a purely code readability change: the following patch will change
> stack depot to store the pointer to the new pool in a separate variable,
> and "new" seems like a more logical name.
> 
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

