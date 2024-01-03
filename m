Return-Path: <linux-kernel+bounces-15268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC7D822968
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78EFD281C8C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E241805C;
	Wed,  3 Jan 2024 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zHFYnHDo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rv8GsTOQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zHFYnHDo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rv8GsTOQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862DB18050
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C13C1F79B;
	Wed,  3 Jan 2024 08:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704269836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0c8L09+ASNGdeweZZGc2435Rju4Eh2hqzG4gk5W9zvE=;
	b=zHFYnHDoutCbaHfrO3fhiBMuNgmPybkdDbW9TMdoiAyGmB7HbmBjPM11Ne7ry2QtmIIjam
	dKKJfPsBq/i2gV/20v2PFJocWAk3FdLtGn9ErDf9HNnuCr/y6u4AKjyB3sAwYPIvCJm94a
	UwR5IWJQgIzNVxetTKOmxvJ8otFfCMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704269836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0c8L09+ASNGdeweZZGc2435Rju4Eh2hqzG4gk5W9zvE=;
	b=rv8GsTOQgAzS0hvKQuR3Ob1TREQd3BleN7QWWRAV9kku07u9xHMNQvixoVtYyWnb59Cm8T
	p7029gX8oozVl7BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704269836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0c8L09+ASNGdeweZZGc2435Rju4Eh2hqzG4gk5W9zvE=;
	b=zHFYnHDoutCbaHfrO3fhiBMuNgmPybkdDbW9TMdoiAyGmB7HbmBjPM11Ne7ry2QtmIIjam
	dKKJfPsBq/i2gV/20v2PFJocWAk3FdLtGn9ErDf9HNnuCr/y6u4AKjyB3sAwYPIvCJm94a
	UwR5IWJQgIzNVxetTKOmxvJ8otFfCMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704269836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0c8L09+ASNGdeweZZGc2435Rju4Eh2hqzG4gk5W9zvE=;
	b=rv8GsTOQgAzS0hvKQuR3Ob1TREQd3BleN7QWWRAV9kku07u9xHMNQvixoVtYyWnb59Cm8T
	p7029gX8oozVl7BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C32251340C;
	Wed,  3 Jan 2024 08:17:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HuPaLAsYlWWGWwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 03 Jan 2024 08:17:15 +0000
Date: Wed, 3 Jan 2024 09:18:06 +0100
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
Subject: Re: [PATCH v4 02/22] lib/stackdepot: check disabled flag when
 fetching
Message-ID: <ZZUYPuk4dNG6f4Cc@localhost.localdomain>
References: <cover.1700502145.git.andreyknvl@google.com>
 <c3bfa3b7ab00b2e48ab75a3fbb9c67555777cb08.1700502145.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3bfa3b7ab00b2e48ab75a3fbb9c67555777cb08.1700502145.git.andreyknvl@google.com>
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-0.11 / 50.00];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,google.com,suse.cz,googlegroups.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[51.07%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -0.11
X-Spam-Flag: NO

On Mon, Nov 20, 2023 at 06:47:00PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Do not try fetching a stack trace from the stack depot if the
> stack_depot_disabled flag is enabled.
> 
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

