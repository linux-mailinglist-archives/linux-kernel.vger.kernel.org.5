Return-Path: <linux-kernel+bounces-165017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7148B868C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDC21F22E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454114EB3F;
	Wed,  1 May 2024 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TL3RjE1C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d3YZLuBK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yNcB27fz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IaD1OLW0"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9644D9FD;
	Wed,  1 May 2024 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714550141; cv=none; b=OyVzXDDt0vGxb/LjOlU5Mlayu9OA6BDqIx02DbvnFR+v00xJ/SoI5YbMnsU7u2NU5wwXf9khk6GAnl9KfGODCSf9GyQ1+9U1t435HTKHVjrSqqHwTogNRVNdK95t9rIF8eYW9U9uM3XhCgLC/E3ioCdWAbroxANRfxBY2WfJmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714550141; c=relaxed/simple;
	bh=uMttE0qhbz8kzX+Cp4ePSzGxNRWzrM6vWLazjFTdaDo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lw/uZ6UHEHv/fzKmE4+1QnQ4kdGiLGj9Gn2MD1HT1A/Pytm7OYbjEGij67e/VXWn5MO4h3GgQe6epjbuGlMiKEPtb4qWDCjqXsbBLtxqZ/NHKJw6QfQIWO+kZ5WFs3m0sH6MFKFYQvssvJJ0BtlzbWY4/JWk00YnPyEvAaj8RSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TL3RjE1C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d3YZLuBK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yNcB27fz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IaD1OLW0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E64EB2222C;
	Wed,  1 May 2024 07:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714550138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fKP9IUsaQw2KIKjb+xbduzrCjX0eQanRZdwpyhbMhl8=;
	b=TL3RjE1CfebbYCYIdHhjhyoiHYUQiYGu5CGDS+jPn5wpKl7JTG4/v76fvdvGRVb+yDtUYK
	QY1kJdVnJ75ClmkJ+31ySov/LkK1gnmngd3SydUQ4Dg0awjnALZnCZYBXEdTYDqtNfTSl8
	Fm9bjQ3H2V+bLNeAa2/erAQdYBrTfPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714550138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fKP9IUsaQw2KIKjb+xbduzrCjX0eQanRZdwpyhbMhl8=;
	b=d3YZLuBKoC3OyF/3grO6HSkQY4lrJaVbBVmqNgLnUG+HWxgTE73gciDvyoGtzwrGXWBkAq
	0ZSGXZlxxnS9CQBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714550137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fKP9IUsaQw2KIKjb+xbduzrCjX0eQanRZdwpyhbMhl8=;
	b=yNcB27fzZ9y9hRiCrcRQSPrI+zmAn+qatan8//V+JRR4fXNNci/hMUCwMGDlovThgXAHmj
	iVIhfYeRPyV7b/NziapG70onXRRLwOa0I8A0KAxw3N+nj/SxupMxsvVZB+7wF2nzNnnDDJ
	l6jQ+78LJ6eUmWPWp7RwB6XxB1npqxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714550137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fKP9IUsaQw2KIKjb+xbduzrCjX0eQanRZdwpyhbMhl8=;
	b=IaD1OLW0J3FQikd8cIFP4cBc5W7NBnwFGXJ7rQIGpw7iXY2D8IHiMVwphPLna1sfntlQOX
	SyXd3m7fZb9dqzCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACAC613942;
	Wed,  1 May 2024 07:55:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D+BlKHn1MWbnYwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 01 May 2024 07:55:37 +0000
Date: Wed, 01 May 2024 09:55:50 +0200
Message-ID: <87mspakltl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Manuel Barrio Linares <mbarriolinares@gmail.com>
Cc: alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ALSA: usb-audio: Add sampling rates support for Mbox3
In-Reply-To: <20240430171020.192285-1-mbarriolinares@gmail.com>
References: <87cyq7nw19.wl-tiwai@suse.de>
	<20240430171020.192285-1-mbarriolinares@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.28 / 50.00];
	BAYES_HAM(-2.98)[99.90%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -3.28
X-Spam-Flag: NO

On Tue, 30 Apr 2024 19:10:18 +0200,
Manuel Barrio Linares wrote:
> 
> This adds support for all sample rates supported by the
> hardware,Digidesign Mbox 3 supports: {44100, 48000, 88200, 96000}
> 
> Fixes syncing clock issues that presented as pops. To test this, without
> this patch playing 440hz tone produces pops.
> 
> Clock is now synced between playback and capture interfaces so no more
> latency drift issue when using pipewire pro-profile.
> (https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/3900)
> 
> Signed-off-by: Manuel Barrio Linares <mbarriolinares@gmail.com>

Applied to for-next branch now.  Thanks!


Takashi

