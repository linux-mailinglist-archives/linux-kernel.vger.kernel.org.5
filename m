Return-Path: <linux-kernel+bounces-18815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 319E382636C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 09:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32311F21C54
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 08:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0501DDB1;
	Sun,  7 Jan 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AX7dmfrG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zJekQkhA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C17rAa/B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7XQ8xU1n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221D712B6C;
	Sun,  7 Jan 2024 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D4D0721D2E;
	Sun,  7 Jan 2024 08:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704616835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xUS2X825L4EYM78LevIrFDvwad94rNHlyzQZCDAhf/c=;
	b=AX7dmfrGtT5r3szDd96QZqFF4wwqQXcMHKns6WPT6kq384gHMdLXdHPY+cr0Dl0OOEpHvE
	Evq+CwLBqBqUfS/+PUF7qLboXBeeFfpr/UDab9fC5g+9tfnXXSv81KmhaXnqoYCkugyzsh
	3zO5RJh9bDFe+cbyuPnDpkdQhTpotY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704616835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xUS2X825L4EYM78LevIrFDvwad94rNHlyzQZCDAhf/c=;
	b=zJekQkhA9C61DzpnPO3hyJZMFc1SBCM+pI8cDqFNVnOSlVAE0AjPDI75FgGf6e05nk0WbK
	Uz/tWEsugPo4l3Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704616834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xUS2X825L4EYM78LevIrFDvwad94rNHlyzQZCDAhf/c=;
	b=C17rAa/BZnO78nvfIjiXULuS5Kb96/em3bNZff5PTLxFZWA+X2cBkLdL+TAkRCOKKOOC/l
	XVe24vpOClhMkC9LeP+5cX45hKS5yM0DYSX8JvEwzQrLUpIyos4VB6KCMfd3EN5OKXmnz3
	HfzvoPVH2ed3mfVIEOzxEYZQFSkhTuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704616834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xUS2X825L4EYM78LevIrFDvwad94rNHlyzQZCDAhf/c=;
	b=7XQ8xU1nRm/GtrkjNYAYK8axLQ/B6Mg/6JLNjz7ZZEvxpXupozLL0WDNme+iOdLFFs55yh
	RgC35LOZidY1oaBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96BAF13496;
	Sun,  7 Jan 2024 08:40:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qsP8IoJjmmWSMwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 07 Jan 2024 08:40:34 +0000
Date: Sun, 07 Jan 2024 09:40:34 +0100
Message-ID: <87msthilj1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: alexious@zju.edu.cn
Cc: "Takashi Iwai" <tiwai@suse.de>,
	"Jaroslav Kysela" <perex@perex.cz>,
	"Takashi Iwai" <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ALSA: hdsp: fix some memleaks in snd_hdsp_hwdep_ioctl
In-Reply-To: <21989c36.77f56.18ce306a4c1.Coremail.alexious@zju.edu.cn>
References: <20231227060322.3556052-1-alexious@zju.edu.cn>
	<87o7e9xhyd.wl-tiwai@suse.de>
	<21989c36.77f56.18ce306a4c1.Coremail.alexious@zju.edu.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[27.67%]
X-Spam-Flag: NO

On Sun, 07 Jan 2024 09:25:12 +0100,
alexious@zju.edu.cn wrote:
> 
>  
> > On Wed, 27 Dec 2023 07:03:20 +0100,
> > Zhipeng Lu wrote:
> > > 
> > > When snd_hdsp_load_firmware_from_cache and snd_hdsp_enable_io fails,
> > > the hdsp->fw_uploaded needs to be free.Or there could be memleaks in
> > > snd_hdsp_hwdep_ioctl.
> > > 
> > > Fixes: 90caaef6a1ce ("ALSA: hdsp: improve firmware caching")
> > > Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> > 
> > Thanks for the patch, but the patch description is misleading.
> > The allocated object isn't really "leaked"; it's released at the
> > removal of the driver.
> 
> It is a little confused to me that I can't find a clear "removal" operation for 
> hdsp->fw_uploaded. Could you please give a more detailed explaination, 
> such as call chain, why hdsp->fw_uploaded is not leaked?

It's released in snd_hdsp_card_free().


Takashi

