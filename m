Return-Path: <linux-kernel+bounces-15269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D3382296B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695C51F23D76
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DDD1805C;
	Wed,  3 Jan 2024 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1fiIcHij";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cHM00vUP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1fiIcHij";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cHM00vUP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C50618056
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5950B1F79B;
	Wed,  3 Jan 2024 08:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704269942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9esiW43PFp1nOnTYVzDQBW7TFJkdqXost6VpQW1eec=;
	b=1fiIcHijtt/C7H4dnD6zvu8S4TD3gVEXvhV1JBV03KIs8NYvd/gKYBveAyFxwVrmflm4wa
	ILCK6eMtISbyqXFDJUmhd7nwY/5ofMrmHi8RLWtVx6wq30teAIjotN7FoFmHb4zKW+qWTu
	VWEIux45Ie+VNI+mgK/H32odgNj1tC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704269942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9esiW43PFp1nOnTYVzDQBW7TFJkdqXost6VpQW1eec=;
	b=cHM00vUPN2qdxoooabvyuX4QeQCzpsOlVZtaWuX9MxKTCNHMKDSYcaL4UaCaakpFCtdewK
	ojKvHao7963ZXZAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704269942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9esiW43PFp1nOnTYVzDQBW7TFJkdqXost6VpQW1eec=;
	b=1fiIcHijtt/C7H4dnD6zvu8S4TD3gVEXvhV1JBV03KIs8NYvd/gKYBveAyFxwVrmflm4wa
	ILCK6eMtISbyqXFDJUmhd7nwY/5ofMrmHi8RLWtVx6wq30teAIjotN7FoFmHb4zKW+qWTu
	VWEIux45Ie+VNI+mgK/H32odgNj1tC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704269942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V9esiW43PFp1nOnTYVzDQBW7TFJkdqXost6VpQW1eec=;
	b=cHM00vUPN2qdxoooabvyuX4QeQCzpsOlVZtaWuX9MxKTCNHMKDSYcaL4UaCaakpFCtdewK
	ojKvHao7963ZXZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6D5C1340C;
	Wed,  3 Jan 2024 08:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pYkFJnUYlWXsWwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 03 Jan 2024 08:19:01 +0000
Date: Wed, 3 Jan 2024 09:19:52 +0100
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
Subject: Re: [PATCH v4 03/22] lib/stackdepot: simplify __stack_depot_save
Message-ID: <ZZUYqIOqjbSjxSft@localhost.localdomain>
References: <cover.1700502145.git.andreyknvl@google.com>
 <3b0763c8057a1cf2f200ff250a5f9580ee36a28c.1700502145.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b0763c8057a1cf2f200ff250a5f9580ee36a28c.1700502145.git.andreyknvl@google.com>
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-0.44 / 50.00];
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
	 BAYES_HAM(-0.34)[76.25%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -0.44
X-Spam-Flag: NO

On Mon, Nov 20, 2023 at 06:47:01PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> The retval local variable in __stack_depot_save has the union type
> handle_parts, but the function never uses anything but the union's
> handle field.
> 
> Define retval simply as depot_stack_handle_t to simplify the code.
> 
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

