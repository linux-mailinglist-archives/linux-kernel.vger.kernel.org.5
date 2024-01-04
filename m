Return-Path: <linux-kernel+bounces-16498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385A7823F5E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218491C238B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4AE20B22;
	Thu,  4 Jan 2024 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EMvMPWHw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jco3uzab";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EMvMPWHw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jco3uzab"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884320B05
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 200711F7E5;
	Thu,  4 Jan 2024 10:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704363499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Glk8o7g6rLUF+Y5xoK5c97MnCA6oOnTmvlAIcCHTwSw=;
	b=EMvMPWHwOckOKt82lWh0kJhFu32+JtfJRRmsKS9L/xrxPK4tUG+nvZQWGU2XsZQcals0Js
	wVnpC/Y7aLlGVL5vang1EI3ev5ehrsWlQWRxBLUlb+qoTkKBNg6gi7QC9VF56szq+cB/Zp
	bU3K4w7Jcb7fY9qsPPabRYEBj/+it8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704363499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Glk8o7g6rLUF+Y5xoK5c97MnCA6oOnTmvlAIcCHTwSw=;
	b=Jco3uzabqstMOqqWr/FKD1AnJyePQunZGPtaTTlKQjjyKdD9I0+L2jZWo3ycYLrzJbsNV2
	0xXmQW9rAnKjflAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704363499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Glk8o7g6rLUF+Y5xoK5c97MnCA6oOnTmvlAIcCHTwSw=;
	b=EMvMPWHwOckOKt82lWh0kJhFu32+JtfJRRmsKS9L/xrxPK4tUG+nvZQWGU2XsZQcals0Js
	wVnpC/Y7aLlGVL5vang1EI3ev5ehrsWlQWRxBLUlb+qoTkKBNg6gi7QC9VF56szq+cB/Zp
	bU3K4w7Jcb7fY9qsPPabRYEBj/+it8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704363499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Glk8o7g6rLUF+Y5xoK5c97MnCA6oOnTmvlAIcCHTwSw=;
	b=Jco3uzabqstMOqqWr/FKD1AnJyePQunZGPtaTTlKQjjyKdD9I0+L2jZWo3ycYLrzJbsNV2
	0xXmQW9rAnKjflAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 413F5137E8;
	Thu,  4 Jan 2024 10:18:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /st8DOqFlmVUbwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jan 2024 10:18:18 +0000
Date: Thu, 4 Jan 2024 11:19:09 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Marco Elver <elver@google.com>
Cc: andrey.konovalov@linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v4 17/22] lib/stackdepot: allow users to evict stack
 traces
Message-ID: <ZZaGHbaerKfli0Wu@localhost.localdomain>
References: <cover.1700502145.git.andreyknvl@google.com>
 <1d1ad5692ee43d4fc2b3fd9d221331d30b36123f.1700502145.git.andreyknvl@google.com>
 <ZZZx5TpqioairIMP@localhost.localdomain>
 <CANpmjNMWyVOvni-w-2Lx6WyEUnP+G_cLVELJv_-B4W1fMrQpnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMWyVOvni-w-2Lx6WyEUnP+G_cLVELJv_-B4W1fMrQpnw@mail.gmail.com>
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
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,gmail.com,google.com,suse.cz,googlegroups.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[40.79%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -0.10
X-Spam-Flag: NO

On Thu, Jan 04, 2024 at 10:25:40AM +0100, Marco Elver wrote:
> I think a boolean makes the interface more confusing for everyone
> else. At that point stack_depot_put merely decrements the refcount and
> becomes a wrapper around refcount_dec, right?

Thanks Marco for the feedback.

Fair enough.

> I think you want to expose the stack_record struct anyway for your
> series, so why not simply avoid calling stack_depot_put and decrement
> the refcount with your own helper (there needs to be a new stackdepot
> function to return a stack_record under the pool_rwlock held as
> reader).

Yeah, that was something I was experimenting with my last version.
See [0], I moved the "stack_record" struct into the header so page_owner
can make sense of it. I guess that's fine right?
If so, I'd do as you mentioned, just decrementing it with my own helper
so no calls to stack_depot_put will be needed.

Regarding the locking, I yet have to check the patch that implements
the read/write lock, but given that page_owner won't be evicting
anything, do I still have to fiddle with the locks?

> Also, you need to ensure noone else calls stack_depot_put on the stack
> traces you want to keep. If there is a risk someone else may call
> stack_depot_put on them, it obviously won't work (I think the only
> option then is to introduce a way to pin stacks).

Well, since page_owner won't call stack_depot_put, I don't see
how someone else would be able to interfere there, so I think
I am safe there.

[0] https://patchwork.kernel.org/project/linux-mm/patch/20231120084300.4368-3-osalvador@suse.de/

-- 
Oscar Salvador
SUSE Labs

