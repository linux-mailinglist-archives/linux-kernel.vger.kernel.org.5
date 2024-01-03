Return-Path: <linux-kernel+bounces-15270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B671682296E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B4228353F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6917182A8;
	Wed,  3 Jan 2024 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fp8SPTGr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1iBS7RE4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fp8SPTGr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1iBS7RE4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ED5182A4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B6DBE21E6E;
	Wed,  3 Jan 2024 08:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704270011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HypzNisJ4hYD1dxdCae8yyBWa40JveYyCJa3YAaa4wA=;
	b=Fp8SPTGrwk4lPX4vb6nIdaYvYXlXlIeJvMxgHV2rZFKCeiJ9lRvai2NSGlOhtKz7jmqisG
	LCHSwkobdMJI2dE97yUv+kfbry+GJNKSQcf6M42ivdEQLZHlzOlUIy/dDw34fuV1PkZDT3
	VkeFERoYCYvNMffPWQ3ktGIEsNJHhos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704270011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HypzNisJ4hYD1dxdCae8yyBWa40JveYyCJa3YAaa4wA=;
	b=1iBS7RE4o7OcdME2O7R7Nuv+G12jTN2JTe6KSl5VF1p+K53PBb245qoGDsMUfI7hb/klJR
	aHf9jksgb8qiK6Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704270011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HypzNisJ4hYD1dxdCae8yyBWa40JveYyCJa3YAaa4wA=;
	b=Fp8SPTGrwk4lPX4vb6nIdaYvYXlXlIeJvMxgHV2rZFKCeiJ9lRvai2NSGlOhtKz7jmqisG
	LCHSwkobdMJI2dE97yUv+kfbry+GJNKSQcf6M42ivdEQLZHlzOlUIy/dDw34fuV1PkZDT3
	VkeFERoYCYvNMffPWQ3ktGIEsNJHhos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704270011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HypzNisJ4hYD1dxdCae8yyBWa40JveYyCJa3YAaa4wA=;
	b=1iBS7RE4o7OcdME2O7R7Nuv+G12jTN2JTe6KSl5VF1p+K53PBb245qoGDsMUfI7hb/klJR
	aHf9jksgb8qiK6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14C7C1340C;
	Wed,  3 Jan 2024 08:20:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dS9bArsYlWVOXAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 03 Jan 2024 08:20:11 +0000
Date: Wed, 3 Jan 2024 09:21:02 +0100
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
Subject: Re: [PATCH v4 04/22] lib/stackdepot: drop valid bit from handles
Message-ID: <ZZUY7hOGtzRNHV_r@localhost.localdomain>
References: <cover.1700502145.git.andreyknvl@google.com>
 <34969bba2ca6e012c6ad071767197dee64dc5723.1700502145.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34969bba2ca6e012c6ad071767197dee64dc5723.1700502145.git.andreyknvl@google.com>
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,google.com,suse.cz,googlegroups.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.34)[76.12%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -0.44
X-Spam-Flag: NO

On Mon, Nov 20, 2023 at 06:47:02PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Stack depot doesn't use the valid bit in handles in any way, so drop it.
> 
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

