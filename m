Return-Path: <linux-kernel+bounces-60033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B2884FEE7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B551C218F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C321B268;
	Fri,  9 Feb 2024 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ak5x7Iht";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="okFJqHzw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ak5x7Iht";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="okFJqHzw"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A9C18B00
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514278; cv=none; b=SUH2DwM1Ye8UVuqA0M+jNUG5swGvjghTysbLgs/K1ecpwnlbE0RU9kzqpBlRRU7fTmTe4c+jycmI6XbI0DJDIZQtS4yAKVBwlviNXMKHyFiK5SFSJmy/q8/bsb1m3oXV6zWQsqrwYJFCqrUvEavKMgud/UeqdHDFQJl07NhnTCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514278; c=relaxed/simple;
	bh=3sZqXdpF/PYBqMBd8d5i9lOA4ttW3p1EgQHFa65NSGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+gzcLnEW4++CLBhBOqHzJxu94IAg1RhVD6ebu07Ts8PjBuypkHUxvNCANQWjtEh3TQpey390UzfNEz3d24D/2thbyKpzGnbtH2QaiLe4g4Yah7spNLTAcN6KtFJwUw7v/6ESsWqlKKSubu/f2rRPfHghFuhvr8ZG0n3CpzX4Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ak5x7Iht; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=okFJqHzw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ak5x7Iht; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=okFJqHzw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 589EF1F831;
	Fri,  9 Feb 2024 21:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707514275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/UgS6OKcLuwhRl+HIZ9vAVihq/Wj8OIdzwa6FbYGKY=;
	b=ak5x7Iht9azf/S89fqbDsollTjGsIaTkZ1pwqdWpmpZIVNYFExkw8diPEZiMusn/b5lEhL
	9V4ln2/0gHfXXCsCYIoz70gp60ttd9NYpXKJn+Qr5WNi27Lr5cSaTvNlAm/UdiEkn8ztit
	ihFAeMOLhti8CTk634J4IgyB8juCC3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707514275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/UgS6OKcLuwhRl+HIZ9vAVihq/Wj8OIdzwa6FbYGKY=;
	b=okFJqHzwlBp4YIGXAVy2FHIg/lp2C5mbYhIIm0aVs5V0sRRq3a61DzDjDarhKq6WT8n72E
	tDL1Nql7m7Sr94DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707514275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/UgS6OKcLuwhRl+HIZ9vAVihq/Wj8OIdzwa6FbYGKY=;
	b=ak5x7Iht9azf/S89fqbDsollTjGsIaTkZ1pwqdWpmpZIVNYFExkw8diPEZiMusn/b5lEhL
	9V4ln2/0gHfXXCsCYIoz70gp60ttd9NYpXKJn+Qr5WNi27Lr5cSaTvNlAm/UdiEkn8ztit
	ihFAeMOLhti8CTk634J4IgyB8juCC3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707514275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m/UgS6OKcLuwhRl+HIZ9vAVihq/Wj8OIdzwa6FbYGKY=;
	b=okFJqHzwlBp4YIGXAVy2FHIg/lp2C5mbYhIIm0aVs5V0sRRq3a61DzDjDarhKq6WT8n72E
	tDL1Nql7m7Sr94DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D55C3139E7;
	Fri,  9 Feb 2024 21:31:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4iZlMaKZxmU7aAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 09 Feb 2024 21:31:14 +0000
Date: Fri, 9 Feb 2024 22:32:21 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v7 0/4] page_owner: print stacks and their outstanding
 allocations
Message-ID: <ZcaZ5dwfeWIX_bis@localhost.localdomain>
References: <20240208234539.19113-1-osalvador@suse.de>
 <CANpmjNOV27EzxfQ1bU_ayKNKt0-FAwjeL9ASK7M2593Z7HvVow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOV27EzxfQ1bU_ayKNKt0-FAwjeL9ASK7M2593Z7HvVow@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.50
X-Spamd-Result: default: False [-2.50 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,gmail.com,google.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.20)[89.20%]
X-Spam-Flag: NO

On Fri, Feb 09, 2024 at 09:03:21AM +0100, Marco Elver wrote:
> On Fri, 9 Feb 2024 at 00:45, Oscar Salvador <osalvador@suse.de> wrote:
> >
> > Changes v6 -> v7:
> >      - Rebased on top of Andrey Konovalov's libstackdepot patchset
> >      - Reformulated the changelogs
> 
> Overall looks fine, but I think it's not rebased against the latest
> stackdepot version in -next. That version re-introduces variable-sized
> records and there's some trickery required so you do not end up with
> refcount warnings.

Thanks a lot Marco for having a look and for the feedback, that's highly
appreciated.


-- 
Oscar Salvador
SUSE Labs

