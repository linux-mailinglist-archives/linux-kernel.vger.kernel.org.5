Return-Path: <linux-kernel+bounces-60949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564CD850B79
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FCC1F214D1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D9059B79;
	Sun, 11 Feb 2024 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ag11Ucc8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SxWO8cKt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ag11Ucc8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SxWO8cKt"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8DD1E887
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 20:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707683900; cv=none; b=bIo/mJ1DMI6YvXT9jf/FmFs5UsIKQ4NE7h7jH3r1h71X1OWEb7EKS5lNyrdWkXWBCJQkeU9MJDtsf0fRiVO1Sx/tIZ99KMWbxdQQ2/5xZWEljBXCZqI0qDWy9p3oAEvEqUujYtr2FSX3vKV5shyqH67s8W8j2T6lIOvNuK7sjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707683900; c=relaxed/simple;
	bh=jgB6np7yNM5/5M+1YbiL/s2QczwQ+yAMQm0JOGUbLuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCFHbzSFLY9sFoELAHuyWH2ljfswI/Epk3Tlr4YzX6vk9YHJc3vjsF9y+8x9LSZSspVDz/M178Cclz1EayzSDCIOVOloPmN1/gg7v4J4/T/CK4fBVqr9yJK6azKR6IQ2MJXqicfGhmuKQtUISJAeysd3/XGiG3DoHJXBSvZfyQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ag11Ucc8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SxWO8cKt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ag11Ucc8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SxWO8cKt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C975C1FB8C;
	Sun, 11 Feb 2024 20:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707683896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5G9UufQhzBlj6wbuHLdb3OiYJa9vcLJo0W+Xwzs/0Mg=;
	b=ag11Ucc8Q7djBY2Sjy+KgNXbdA2VygDztlRBryiF3cTun2bxdST1CBgTLnJ51p4OADwUw9
	VufrsSS4/cuT3RTFumrZqwxVuIf2Iclqqk8m0I83kRCpugi/T02A0dha/oEIFAMXVJzLAT
	yEBohPirTxS3nXes8zu9tTC/CSmPmbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707683896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5G9UufQhzBlj6wbuHLdb3OiYJa9vcLJo0W+Xwzs/0Mg=;
	b=SxWO8cKtX+0JUuyh/20zvhpxUncM9AJFG6G5tdEG0HA8BMBvDHLj23C2j4qgwrchQHG4lJ
	Vzvt792rJpWPP9CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707683896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5G9UufQhzBlj6wbuHLdb3OiYJa9vcLJo0W+Xwzs/0Mg=;
	b=ag11Ucc8Q7djBY2Sjy+KgNXbdA2VygDztlRBryiF3cTun2bxdST1CBgTLnJ51p4OADwUw9
	VufrsSS4/cuT3RTFumrZqwxVuIf2Iclqqk8m0I83kRCpugi/T02A0dha/oEIFAMXVJzLAT
	yEBohPirTxS3nXes8zu9tTC/CSmPmbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707683896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5G9UufQhzBlj6wbuHLdb3OiYJa9vcLJo0W+Xwzs/0Mg=;
	b=SxWO8cKtX+0JUuyh/20zvhpxUncM9AJFG6G5tdEG0HA8BMBvDHLj23C2j4qgwrchQHG4lJ
	Vzvt792rJpWPP9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C38A13985;
	Sun, 11 Feb 2024 20:38:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kmM4DzgwyWVAUAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Sun, 11 Feb 2024 20:38:16 +0000
Date: Sun, 11 Feb 2024 21:39:24 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v7 3/4] mm,page_owner: Display all stacks and their count
Message-ID: <ZckwfAk3rAWU0Jg-@localhost.localdomain>
References: <20240208234539.19113-1-osalvador@suse.de>
 <20240208234539.19113-4-osalvador@suse.de>
 <CANpmjNNcPr=pPco_HN9nXBabubtfo02SAH=taZGNCvYDq42YUQ@mail.gmail.com>
 <ZcaesCP4mY-94ciJ@localhost.localdomain>
 <ZcaxxQE1PkepEWwf@localhost.localdomain>
 <CANpmjNOpfdgMT1jNPJev_e6tecZjGn4n8Sk6aoaLVDsqfJgmKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOpfdgMT1jNPJev_e6tecZjGn4n8Sk6aoaLVDsqfJgmKg@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.39 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,gmail.com,google.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.29)[90.02%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.39

On Sat, Feb 10, 2024 at 08:52:25AM +0100, Marco Elver wrote:
> The extra bits are used by KMSAN, and might conflict if enabled at the
> same time. I think the safest option is to keep your own list. I think
> that will also be more performant if there are other stackdepot users
> because you do not have to traverse any of the other entries.

Ok, I thought we had spare bits for other users.
But thinking about it some more, yes, it makes sense for page_owner to
maintain its own list, so traversing it is faster and we do not have
to place code to traverse the buckets in stackdepot.

-- 
Oscar Salvador
SUSE Labs

