Return-Path: <linux-kernel+bounces-15278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FEB82298A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033E41C22F3A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A5B18AE6;
	Wed,  3 Jan 2024 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EhgcP3Xi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UrbehE26";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EhgcP3Xi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UrbehE26"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE66318656
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BAA7121CA0;
	Wed,  3 Jan 2024 08:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704271147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ21A5M1432XhrI0B8t9DBW6XgpO8Z48yGjxR2fv7rY=;
	b=EhgcP3XiJrKpxQnj9O76GVqnMGCksO5VPM54p5b1Ij8KWJ7H83exiHoaNFRDaCf9UFh2bg
	8cFkEnHmG3pjfSURXA04hwSQjcVBghHEKhikLCwywQrZ8FGQd4f7khz7knzzH0Y7xLHeiP
	1PBtLHkvlv0Ax4yJpXict5YhO9mWR+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704271147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ21A5M1432XhrI0B8t9DBW6XgpO8Z48yGjxR2fv7rY=;
	b=UrbehE266lHkqG1BzBhz0z48A5EA2oUFSv1Fk6oePcwZsyg6HdVrQEB8+RztIu7J1O0FWt
	nbxqu9tlEJijJwCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704271147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ21A5M1432XhrI0B8t9DBW6XgpO8Z48yGjxR2fv7rY=;
	b=EhgcP3XiJrKpxQnj9O76GVqnMGCksO5VPM54p5b1Ij8KWJ7H83exiHoaNFRDaCf9UFh2bg
	8cFkEnHmG3pjfSURXA04hwSQjcVBghHEKhikLCwywQrZ8FGQd4f7khz7knzzH0Y7xLHeiP
	1PBtLHkvlv0Ax4yJpXict5YhO9mWR+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704271147;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ21A5M1432XhrI0B8t9DBW6XgpO8Z48yGjxR2fv7rY=;
	b=UrbehE266lHkqG1BzBhz0z48A5EA2oUFSv1Fk6oePcwZsyg6HdVrQEB8+RztIu7J1O0FWt
	nbxqu9tlEJijJwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D45D1340C;
	Wed,  3 Jan 2024 08:39:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y92ZHSsdlWUdYQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 03 Jan 2024 08:39:07 +0000
Date: Wed, 3 Jan 2024 09:39:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Christophe Lyon <christophe.lyon@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Greg Ungerer <gerg@linux-m68k.org>, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH 00/36] Remove UCLINUX from LTP
Message-ID: <20240103083905.GA1073466@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <ZZUTsDX8bKPimLgD@rei>
 <ZZUVCr2AZ6clmYIl@rei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZUVCr2AZ6clmYIl@rei>
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-3.34 / 50.00];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.04)[58.93%];
	 ARC_NA(0.00)[];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -3.34
X-Spam-Flag: NO

Hi Cyril,

> Hi!
> > > UCLINUX is broken in LTP and nobody really cares. Actually I dare to
> > > say UCLINUX is dead. Therefore I prepared patchset to remove UCLINUX
> > > from LTP. We have been actively removing UCLINUX from LTP during rewrite
> > > tests to new LTP API. This removes the rest from the old tests (which
> > > will be sooner or later rewritten to new API).

> > > Because the patchset is quite big, I did not want to send it to mailing
> > > lists (but I can do it if you want).

> > I agree that this should be done, but I'm not sure if we want to get
> > this in before the January release. I guess that such change would be
> > safer to merge just after the release so that we have a few months to
> > actually catch possible problems.

> Looking at the actuall changes it does not look awfuly complex, so maybe
> we can try to merge it before the pre-release testing and hopefully
> things will not break badly.

Thanks for a quick look. Both ways would work for me, depends on you and others.
Obviously fewer rebasing is better :).

Kind regards,
Petr

