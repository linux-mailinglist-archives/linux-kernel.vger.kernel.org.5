Return-Path: <linux-kernel+bounces-50031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0946184736A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CB01F26E5C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA95D145B3D;
	Fri,  2 Feb 2024 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JE3/OF6P";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JE3/OF6P"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CBE1872
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888333; cv=none; b=QTYn8UG/3OKoa3gxezJF2TxJSpNBx/XC8e9nvatf5iuOZKMGjl+7lhlbVPvRH/bJj1HVfGDurSxwHxyfEfVj6ouN0t46K5OVVn1xpVGrSvzGBdZt9+zUjSXOgQ5aMoIOlcSqgxnCrzRiNR8dU3dyOoucKWbjeH3fGqH6PBt655U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888333; c=relaxed/simple;
	bh=UYblkh2pH0hBjmVVJDctM71dsCbLqTeguVKb8o0oNq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8AtRM5AyfdowcMg+wDwCJOr0drI6GYW7wk1FYNu1zZ3GXJPNDuHyfXE/onZs3p1pVn8EZNzAuotRYDDvF9KvSpj4tCOB6MzG8s4uUz/2sEpOF8bBUslPluYb4kTXMtR+gFLO4qOh6difw9r6CaEQahpErGQ5UfWfbknPDiWdTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JE3/OF6P; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JE3/OF6P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D71021E95;
	Fri,  2 Feb 2024 15:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706888329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7DD5NcDaE4KXkL73aEaoSi9tMEuvt0oHfZv8FAecTdE=;
	b=JE3/OF6P/OICQQObQF+DQQ8eB5RUYQtXiBvl8Dn2OzA9BiY6zEjcozPa/dL3PdOzAJwq3g
	xtL/tF+edkLZESb51NpOwIykl3OsP5jOwq5aGwJOUcehIb5xdVk07tkJBGuN690O9tJJwp
	qmJ44rbfcdkW7XLFO8jmuAMJs+K2A5Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706888329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7DD5NcDaE4KXkL73aEaoSi9tMEuvt0oHfZv8FAecTdE=;
	b=JE3/OF6P/OICQQObQF+DQQ8eB5RUYQtXiBvl8Dn2OzA9BiY6zEjcozPa/dL3PdOzAJwq3g
	xtL/tF+edkLZESb51NpOwIykl3OsP5jOwq5aGwJOUcehIb5xdVk07tkJBGuN690O9tJJwp
	qmJ44rbfcdkW7XLFO8jmuAMJs+K2A5Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 201AC139AB;
	Fri,  2 Feb 2024 15:38:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5RaJBokMvWXWMwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 02 Feb 2024 15:38:49 +0000
Date: Fri, 2 Feb 2024 16:38:48 +0100
From: Michal Hocko <mhocko@suse.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com,
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com,
	minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on
 collapse
Message-ID: <Zb0MiIONNRVhcIhC@tiehlicka>
References: <20240201125226.28372-1-ioworker0@gmail.com>
 <Zby-sHLDlmTRaUcd@tiehlicka>
 <CAK1f24=7sy_Bczpt5YeDbkhfriYUc1=zreSFdGCxfF3R0D6sRQ@mail.gmail.com>
 <ZbzfxNn4AYnTVFLh@tiehlicka>
 <CAK1f24mvBkc2c=fHL6UxMhL2mgLHVrSwZfE5516bOR0yVdfZpQ@mail.gmail.com>
 <ZbzmvwyTGeW18nJy@tiehlicka>
 <CAK1f24kdyOnUjcpnrk6j4cF6bSFXQwwzFk9tM+jD4RsO_Hc4hA@mail.gmail.com>
 <Zbz_ao0uBKabzKB1@tiehlicka>
 <CAK1f24nHmvqm1XD_UkWUB7DmNdH0NEOKzpLgKDJ=UuPWO=rEHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK1f24nHmvqm1XD_UkWUB7DmNdH0NEOKzpLgKDJ=UuPWO=rEHw@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="JE3/OF6P"
X-Spamd-Result: default: False [-2.13 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,google.com,redhat.com,bytedance.com,gmail.com,kernel.org,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.32)[96.85%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3D71021E95
X-Spam-Level: 
X-Spam-Score: -2.13
X-Spam-Flag: NO

On Fri 02-02-24 22:52:49, Lance Yang wrote:
> How about blocking khugepaged from
> collapsing lazyfree pages? This way,
> is it not better to keep the semantics
> of MADV_FREE?

I do not see any reason why. And you are not providing any
actual reasoning either. Unless you have a very specific
example in mind I do not think we want to change the current
behavior.
-- 
Michal Hocko
SUSE Labs

