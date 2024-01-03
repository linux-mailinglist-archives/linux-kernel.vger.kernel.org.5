Return-Path: <linux-kernel+bounces-15255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D82A822931
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188DCB213C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DF718050;
	Wed,  3 Jan 2024 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rl0lataF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Xx/gzVB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PBRI/Ri2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xx7QSCiP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE701803D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 31AC51F794;
	Wed,  3 Jan 2024 07:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704268766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/+XgaVZhEtaaw71eJX+qMxtn9jHEUYxgF/derp86AW4=;
	b=rl0lataFPHqkUio9e5ekLXx/w262FSKIJgFL1WcabP++IkhBO1ahFHvovoEr0nxmqHwFmq
	NZciqrme8szOzS9eND5ajlawumGwyfmsEnQyX47/50ce0SuJeLH+akUHlycLuhbiDy88lf
	lkgjvg/dRN7mHIuEqdfUCp/gHVK4NoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704268766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/+XgaVZhEtaaw71eJX+qMxtn9jHEUYxgF/derp86AW4=;
	b=5Xx/gzVBU6veHB+iKV38MqSgwtbdF+BH7l9XkLoA8lN9k7TLNKhTRyRDTOJFOH3PxUjwHC
	+Lw65Uc8PNV/KDDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704268765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/+XgaVZhEtaaw71eJX+qMxtn9jHEUYxgF/derp86AW4=;
	b=PBRI/Ri2F/WXSJwjqaZbJNvD8BwU9WH44v1xxV+OxYpbuMn36fRf/fkIXwtPOhWRAWovvu
	WxiEmeP1diXGGpd0kCNeN4Hx/Ffz3+gi2oWjPGJ5cQAK23omsGJqLt+zSk4hx4gx/Pf0E/
	kKyZz8PChHrN/Lm6D3VsK8V3CjJmR9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704268765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/+XgaVZhEtaaw71eJX+qMxtn9jHEUYxgF/derp86AW4=;
	b=Xx7QSCiPzC/NCSJzO38a0IrhSJv3Z8StejhPiO829nqo/zyo4D3Pcdro9w1OZQVKlqAG5U
	RmxIVpeAQSOfrVBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AF3813AA6;
	Wed,  3 Jan 2024 07:59:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ruxGBt0TlWWwVgAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 03 Jan 2024 07:59:25 +0000
Date: Wed, 3 Jan 2024 08:58:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Li Wang <liwang@redhat.com>,
	Andrea Cervesato <andrea.cervesato@suse.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Christophe Lyon <christophe.lyon@linaro.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/36] Remove UCLINUX from LTP
Message-ID: <ZZUTsDX8bKPimLgD@rei>
References: <20240103015240.1065284-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103015240.1065284-1-pvorel@suse.cz>
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-3.76 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.16)[69.10%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -3.76
X-Spam-Flag: NO

Hi!
> UCLINUX is broken in LTP and nobody really cares. Actually I dare to
> say UCLINUX is dead. Therefore I prepared patchset to remove UCLINUX
> from LTP. We have been actively removing UCLINUX from LTP during rewrite
> tests to new LTP API. This removes the rest from the old tests (which
> will be sooner or later rewritten to new API).
> 
> Because the patchset is quite big, I did not want to send it to mailing
> lists (but I can do it if you want).

I agree that this should be done, but I'm not sure if we want to get
this in before the January release. I guess that such change would be
safer to merge just after the release so that we have a few months to
actually catch possible problems.

-- 
Cyril Hrubis
chrubis@suse.cz

