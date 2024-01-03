Return-Path: <linux-kernel+bounces-15271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6A1822972
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929291F23CB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C81F182AF;
	Wed,  3 Jan 2024 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iHCQVP8Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z70Db0bU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j8E1+H/D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="85nbN43Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369FF182A3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 528BD21E6E;
	Wed,  3 Jan 2024 08:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704270204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FGbDhAb1VSn1oyT4cWgIeM8OuXxB1azKP8xwd8px58k=;
	b=iHCQVP8Qm2QEEtUqkV38EM0jd9K7UpBZMr1dtQlEEx+oMatAUcBVT+oWWsE7LPiI1bTAGQ
	/fkfFHTk5AA0LJc2uPyCXIZXjnjA8Beh7iT1Oo8OeCeoMi7KBvip8upClnvRWvfxsV1Ok/
	8o2abX6OWcwe3pHVeQ02sDzbtq2qtbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704270204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FGbDhAb1VSn1oyT4cWgIeM8OuXxB1azKP8xwd8px58k=;
	b=z70Db0bU2l7rZOH/LhgeiQdOckf0b/vRtQn3BlhhGZrN4vMHzDl7jwSljQs84MtSK3TS1W
	amn+0BDgi897qRDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704270202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FGbDhAb1VSn1oyT4cWgIeM8OuXxB1azKP8xwd8px58k=;
	b=j8E1+H/DZhSDIRPrqAKBkfK7dPUnWdoeNG1T532C0UfuD1KiE896lhPSmuaRJfzaI7gD9x
	c7hNg72bgsc/g+VBYIZHmisoXbDyGtqE34bGwbRv1yB+w2ikPj0KTW1dayYH+yP/FpTbiR
	8ekD1IfiCkjeOHakVRtKQ0CEF1CQBFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704270202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FGbDhAb1VSn1oyT4cWgIeM8OuXxB1azKP8xwd8px58k=;
	b=85nbN43QbGxFXTP4MX9KcdUnCqgsQRx7LoTJfbX21z283pqh6TfvlN3V2m+caLg8LHLNsp
	Hsjn1TKTHcln/DCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A396D1340C;
	Wed,  3 Jan 2024 08:23:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mb0xJXkZlWUvXQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 03 Jan 2024 08:23:21 +0000
Date: Wed, 3 Jan 2024 09:24:12 +0100
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
Subject: Re: [PATCH v4 05/22] lib/stackdepot: add depot_fetch_stack helper
Message-ID: <ZZUZrJzmkXOf_Wsa@localhost.localdomain>
References: <cover.1700502145.git.andreyknvl@google.com>
 <170d8c202f29dc8e3d5491ee074d1e9e029a46db.1700502145.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170d8c202f29dc8e3d5491ee074d1e9e029a46db.1700502145.git.andreyknvl@google.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.74 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.43)[78.34%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,linux.dev:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,google.com,suse.cz,googlegroups.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="j8E1+H/D";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=85nbN43Q
X-Spam-Score: -0.74
X-Rspamd-Queue-Id: 528BD21E6E

On Mon, Nov 20, 2023 at 06:47:03PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Add a helper depot_fetch_stack function that fetches the pointer to
> a stack record.
> 
> With this change, all static depot_* functions now operate on stack pools
> and the exported stack_depot_* functions operate on the hash table.
> 
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

