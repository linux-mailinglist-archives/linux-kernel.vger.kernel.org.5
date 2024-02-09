Return-Path: <linux-kernel+bounces-60034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C8B84FEE9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E751C21B0E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B86517C75;
	Fri,  9 Feb 2024 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tissuEUV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4nUJ5Nsr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tissuEUV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4nUJ5Nsr"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401163B9
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514356; cv=none; b=gkK/W8HyP8um3jKS+/Ngd4ri6kGwjvD+wLGuBg+nJI6q8HLySe4wK74Wkc4DZ12SzcoVh5RBLOzZpvi1B1T7UKdL6xX9u6Rv2c46P4wXneXXLETwdlag8ieoW9RqRkiESk2pkGZ5vp0iC3rWDAOjO+PiHcEU0XQZoEF1Jtcc1JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514356; c=relaxed/simple;
	bh=K3Q6lSKgKZjHTEb9DGMZRqP4y+AE9MrJXAdqEOkH7N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGbLj/eiCSKe4n6IP/IxcQI6tGzHxWvJuDleMF05KEu9QzSjP4zy+JuY+nn4Fd4tctnf78dijcvcqMeA3xx8X7MqZnpGuzGfK+mpDxP7HnoWJTbU3BdxyIsunjp1kkj/TZFepAVhWZMMbhEVM55o7tN35W8mGhDFIXUgFOrspIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tissuEUV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4nUJ5Nsr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tissuEUV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4nUJ5Nsr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B44221F831;
	Fri,  9 Feb 2024 21:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707514353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZvmyKdHVxJ/thojldSl4lvPiTjCgxInTW7G7s2pny4=;
	b=tissuEUVVKmNHAbiDR5CBTOnY3E0hBDLiiZmu8Rqo2W5UdesCWb3PC2NZQoGs6JYrm1xBB
	/CKqqSKgUGPyz1/TtvzQTLVje0D33EiCO3yrASvAVfJQWqXNCL2/ZnVdP1W5wbgb8/f/Gi
	2P3RtSlK6DMm9DygNba5bJLfUAerDRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707514353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZvmyKdHVxJ/thojldSl4lvPiTjCgxInTW7G7s2pny4=;
	b=4nUJ5NsrpYpJPCqqQLkywTHUlmItn4kNSJg+9ImroxMcrnyv2PCKXQsnus4MGnUNi11jzz
	oKGhPSFeLT6gBECw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707514353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZvmyKdHVxJ/thojldSl4lvPiTjCgxInTW7G7s2pny4=;
	b=tissuEUVVKmNHAbiDR5CBTOnY3E0hBDLiiZmu8Rqo2W5UdesCWb3PC2NZQoGs6JYrm1xBB
	/CKqqSKgUGPyz1/TtvzQTLVje0D33EiCO3yrASvAVfJQWqXNCL2/ZnVdP1W5wbgb8/f/Gi
	2P3RtSlK6DMm9DygNba5bJLfUAerDRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707514353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZvmyKdHVxJ/thojldSl4lvPiTjCgxInTW7G7s2pny4=;
	b=4nUJ5NsrpYpJPCqqQLkywTHUlmItn4kNSJg+9ImroxMcrnyv2PCKXQsnus4MGnUNi11jzz
	oKGhPSFeLT6gBECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B5DC139E7;
	Fri,  9 Feb 2024 21:32:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RZjHC/GZxmV3aAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 09 Feb 2024 21:32:33 +0000
Date: Fri, 9 Feb 2024 22:33:32 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v7 1/4] lib/stackdepot: Move stack_record struct
 definition into the header
Message-ID: <ZcaaLKeKADD5L2cr@localhost.localdomain>
References: <20240208234539.19113-1-osalvador@suse.de>
 <20240208234539.19113-2-osalvador@suse.de>
 <CANpmjNOHchgjgJbM8OGQTTxE5wiAjt5rJE8UZYJgcF0y1EtBZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOHchgjgJbM8OGQTTxE5wiAjt5rJE8UZYJgcF0y1EtBZw@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.17 / 50.00];
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
	 BAYES_HAM(-0.07)[62.37%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.17

On Fri, Feb 09, 2024 at 08:45:21AM +0100, Marco Elver wrote:
> > -#define DEPOT_HANDLE_BITS (sizeof(depot_stack_handle_t) * 8)
> > -
> > -#define DEPOT_POOL_ORDER 2 /* Pool size order, 4 pages */
> > -#define DEPOT_POOL_SIZE (1LL << (PAGE_SHIFT + DEPOT_POOL_ORDER))
> > -#define DEPOT_STACK_ALIGN 4
> > -#define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
> > -#define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
> > -                              STACK_DEPOT_EXTRA_BITS)
> >  #if IS_ENABLED(CONFIG_KMSAN) && CONFIG_STACKDEPOT_MAX_FRAMES >= 32
> >  /*
> >   * KMSAN is frequently used in fuzzing scenarios and thus saves a lot of stack
> 
> ^^ This hunk no longer exists, try to rebase against the version in -next.
> 
> Other than that, this looks fine.

Yeah, I noticed it later.
I already synced the last -next and I have rebased it on top.

Thanks

-- 
Oscar Salvador
SUSE Labs

