Return-Path: <linux-kernel+bounces-70014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC8F8591C5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875831C218CD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180EA7E0FB;
	Sat, 17 Feb 2024 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GqVrhd4n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cYMmScP8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GqVrhd4n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cYMmScP8"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B43141A91;
	Sat, 17 Feb 2024 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708194902; cv=none; b=VBBq9l+GL/WPM/AzZXtUX6Hh2pLUmkTdLjTA/j8Y+5jOKe6ea4/yyTRALUiLIUmqT/QgH3xQPvW8lUKiwfhWY1duvrpzyuYGldOsUpYf3b/QKiG1/a8FWQiKPziFtF6HCLiGUmBhukAjU1dDPgfUDB+ujl77dW8S5mD7wYw7amY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708194902; c=relaxed/simple;
	bh=JZmENFr1/E49tYj8nITnU3QnMwuNKMj08cRzSpfOLcw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anEh7mSpRP3y04xwXkdwWtU9Odbwr2A4lT0/fckMoWRxEO1b9sl2rjG1XNInkLmaghrkJ0SW973xnEmM14ww47IuM0gu/e7GBLVby6n8ygiS2H/yZZtbsyIrdwaiBg+q8BjLBbClpS/C7jFDsmYHqfD+J+jnwMuJsm51KT3UglY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GqVrhd4n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cYMmScP8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GqVrhd4n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cYMmScP8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A9A8621FF9;
	Sat, 17 Feb 2024 18:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708194898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCpnJvjlWwU46xbEg8kPZwPBFVx75dBdkJOjoJNk6a0=;
	b=GqVrhd4nJPq080UQ9K4v7hTjmxmyz4IYpjGr3yrugYU+gawsbsQt2O5bl9fNvPvmiyJoxw
	JHNSd883bNeCP+rWmsIV50G1dbGCcQ+qjc2H8Ax2UYxj+GdAs+aua1Lrh8IOdRyK1y/C1v
	ynCCVLOruMdUftbD36EaZ3kPFrO6/Rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708194898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCpnJvjlWwU46xbEg8kPZwPBFVx75dBdkJOjoJNk6a0=;
	b=cYMmScP8qgCxRqPYb9aXx4J/hu042iqRdMikfbW/PjJcGjFxaKTscdD/3HFujo3qpdmM69
	ExVd+AG07VmJAuBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708194898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCpnJvjlWwU46xbEg8kPZwPBFVx75dBdkJOjoJNk6a0=;
	b=GqVrhd4nJPq080UQ9K4v7hTjmxmyz4IYpjGr3yrugYU+gawsbsQt2O5bl9fNvPvmiyJoxw
	JHNSd883bNeCP+rWmsIV50G1dbGCcQ+qjc2H8Ax2UYxj+GdAs+aua1Lrh8IOdRyK1y/C1v
	ynCCVLOruMdUftbD36EaZ3kPFrO6/Rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708194898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCpnJvjlWwU46xbEg8kPZwPBFVx75dBdkJOjoJNk6a0=;
	b=cYMmScP8qgCxRqPYb9aXx4J/hu042iqRdMikfbW/PjJcGjFxaKTscdD/3HFujo3qpdmM69
	ExVd+AG07VmJAuBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 603BE1370C;
	Sat, 17 Feb 2024 18:34:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cw8YFVL80GUadwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 17 Feb 2024 18:34:58 +0000
Date: Sat, 17 Feb 2024 19:34:57 +0100
Message-ID: <87msrzos6m.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	stable@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Acp5x probing regression introduced between kernel 6.7.2 -> 6.7.4
In-Reply-To: <ZdDXJyXiZ++KiNqW@finisterre.sirena.org.uk>
References: <CAD_nV8BG0t7US=+C28kQOR==712MPfZ9m-fuKksgoZCgrEByCw@mail.gmail.com>
	<7a0cd63f-8a83-4dc5-8763-63dcdae8d68a@leemhuis.info>
	<878r3qxcyr.wl-tiwai@suse.de>
	<871q9hwz2w.wl-tiwai@suse.de>
	<ZdDXJyXiZ++KiNqW@finisterre.sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.11 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.01)[95.09%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.11

On Sat, 17 Feb 2024 16:56:23 +0100,
Mark Brown wrote:
> 
> On Mon, Feb 12, 2024 at 03:12:55PM +0100, Takashi Iwai wrote:
> > Takashi Iwai wrote:
> 
> > > Interestingly, the system seems working with 6.8-rc3, so some piece
> > > might be missing.  Or simply reverting this patch should fix.
> 
> > In the bugzilla entry, the reporter confirmed that the revert of the
> > commit 4b6986b170f2f2 fixed the problem.
> 
> Any news on a patch for this?  Venkata?

It was already reverted in 6.7.5, as there was no further follow up.


thanks,

Takashi

