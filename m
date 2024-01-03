Return-Path: <linux-kernel+bounces-15259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41382294D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D328E1C23088
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216F5182A9;
	Wed,  3 Jan 2024 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UWH2dHaa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4V4gpIFY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bxvUgOrz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QyFt7WxI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E79182A4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6656A1F797;
	Wed,  3 Jan 2024 08:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704269112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGcbw3rvTR2Ld6aqvwwzw+7Jf0vakMAAY1hsseRN4hI=;
	b=UWH2dHaae2YV2l+ISYddx5ia8KxFgTnOBVikH1ttJWZZRv3k1Pmcnh3rMSBAegH+92XNs3
	XAhm7JnAD2OXtUupeZrq1R2m7yWl/s4qNPlZ1H1bYGzFwZmmbGxRABC5K7naQhzlFcEziZ
	Ph3GUFfHb3kFCrxDceiHFSBw935lPjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704269112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGcbw3rvTR2Ld6aqvwwzw+7Jf0vakMAAY1hsseRN4hI=;
	b=4V4gpIFY+OAi9OzMAaSqyvqyhEotHnRZLzFlYo1Gk9qei84qhxPPwhj3UualCNHyxWNAvr
	fkdYkgGqJtX82bCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704269111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGcbw3rvTR2Ld6aqvwwzw+7Jf0vakMAAY1hsseRN4hI=;
	b=bxvUgOrzHpYruhYJ6lZuhoF76D4f/p+eps1jJZP/iVXIlNHK+Vka0ln7fbMUmrC7XHM2aH
	zwgQNWsIDs/Ucs+21mFIrhMOQWOOxckNAVGleiKpyJPsw8PIHzndBzc1Wmrk6u2GW76/AK
	fuWzJoTrF7YURG4FC0lPfinUVbGT/TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704269111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGcbw3rvTR2Ld6aqvwwzw+7Jf0vakMAAY1hsseRN4hI=;
	b=QyFt7WxICJF3AmaC4vPpBjw3AJRbpxu01LHc9JaVXfqSY7YBCbfqQYrX/OQ/lp4xOTtHzd
	V9/kf7AeZ3TG8ABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53CCD1340C;
	Wed,  3 Jan 2024 08:05:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z3FbEzcVlWUrWAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 03 Jan 2024 08:05:11 +0000
Date: Wed, 3 Jan 2024 09:04:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Christophe Lyon <christophe.lyon@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Greg Ungerer <gerg@linux-m68k.org>, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH 00/36] Remove UCLINUX from LTP
Message-ID: <ZZUVCr2AZ6clmYIl@rei>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <ZZUTsDX8bKPimLgD@rei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZUTsDX8bKPimLgD@rei>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.88
X-Spamd-Result: default: False [-0.88 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.08)[63.86%]
X-Spam-Flag: NO

Hi!
> > UCLINUX is broken in LTP and nobody really cares. Actually I dare to
> > say UCLINUX is dead. Therefore I prepared patchset to remove UCLINUX
> > from LTP. We have been actively removing UCLINUX from LTP during rewrite
> > tests to new LTP API. This removes the rest from the old tests (which
> > will be sooner or later rewritten to new API).
> > 
> > Because the patchset is quite big, I did not want to send it to mailing
> > lists (but I can do it if you want).
> 
> I agree that this should be done, but I'm not sure if we want to get
> this in before the January release. I guess that such change would be
> safer to merge just after the release so that we have a few months to
> actually catch possible problems.

Looking at the actuall changes it does not look awfuly complex, so maybe
we can try to merge it before the pre-release testing and hopefully
things will not break badly.

-- 
Cyril Hrubis
chrubis@suse.cz

