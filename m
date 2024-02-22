Return-Path: <linux-kernel+bounces-76174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B20B85F3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7730B216D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED47536B02;
	Thu, 22 Feb 2024 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Eca0GC5V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bFnCNCQ7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tCUqd8XN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fv9U37kA"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931AE364C1;
	Thu, 22 Feb 2024 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592637; cv=none; b=W62ybg1tYkShpWQPAEkTN7K52BMP/9GPxBrjVU3tv0me2x0wzbSbPD9YskxCeqazeCwHSRvmD9vuuRn+0CHnxrASa9YFyta+nxcPEPe8qgWf+rEHkeyHywM8qqz6m+op7tSEuyKGB2TkfQSWkWy7VC4/fJqhM8HqS9WfHGBbXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592637; c=relaxed/simple;
	bh=caYL7S46dYbJ6MqUJ5Tc6qr0ttAat8UQ2n9Kka7dr9I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2fEaNigCtTOScZgcvDSPCJRumCF1hAyRT2Wa5Cdy/S0A1M1SilBXrEBjO5E57t1HM7BCICZrbvzFCd9aBu+zZLnZLEwqZgoSPkluLC94maNPPMOzP2VJnFRDbl+T6M9/+5ClEHPBrgGluzG+3IsS6dK6CkwfT7tFH7LxDHWdEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Eca0GC5V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bFnCNCQ7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tCUqd8XN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fv9U37kA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3695E21EFD;
	Thu, 22 Feb 2024 09:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708592628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8L9bOwG2ZDrSZaGMetmK5ju/fKbbJC2wUSyS9V4gboA=;
	b=Eca0GC5VPb1qUv9WB1IB6EAJXLGHBpZUeOhJjB5MbOGR2U65vjSeF+lPH3YiqBeDWrGoEe
	nDohVyqrxb2tkgIZR4fu3gEkFSy8RP1exkP/pAsQO+DjFoRbqkDD4zepUEBQBPlRAoUr+F
	tiEAVyY/SBtqfBir2CiaydD2IzjkNgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708592628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8L9bOwG2ZDrSZaGMetmK5ju/fKbbJC2wUSyS9V4gboA=;
	b=bFnCNCQ7qm3NvERNTMarl6a3DV2wrapjsMBDv03C0HJkwTbOcpDL6yvTBjgnXr3CD7TnAl
	vm6sAcAQMr0FLwDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708592627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8L9bOwG2ZDrSZaGMetmK5ju/fKbbJC2wUSyS9V4gboA=;
	b=tCUqd8XNncgdI1e1LV+SRSI14KQE/Hcx4SCkK6Qzo1Aqj824jRmAbfWbatOk7PPjKKuj/X
	xfJGx59oUgay355aYdmRIE6KZg4WEZHQ1jM4di8s/+gFEFY5FS4SN8cOCfvufLRtUyiidB
	2Wdy/6GalkjC1trNqmq1Ls8E3V1w3tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708592627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8L9bOwG2ZDrSZaGMetmK5ju/fKbbJC2wUSyS9V4gboA=;
	b=fv9U37kAC8DYAkRpS2il8MNAl84KV7tsf+VFrnPgB/Ol4DwO79H31iRjPKhHJ5h+tb10XI
	EJCSu9CJbVSU5dCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9D4313A8C;
	Thu, 22 Feb 2024 09:03:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r2ghN/IN12XNeAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 22 Feb 2024 09:03:46 +0000
Date: Thu, 22 Feb 2024 10:03:46 +0100
Message-ID: <87ttm06fbh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <broonie@kernel.org>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH 0/9] ALSA: cs35l56: Apply calibration from EFI
In-Reply-To: <20240221150507.1039979-1-rf@opensource.cirrus.com>
References: <20240221150507.1039979-1-rf@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tCUqd8XN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fv9U37kA
X-Spamd-Result: default: False [-0.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.29)[74.58%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.60
X-Rspamd-Queue-Id: 3695E21EFD
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Wed, 21 Feb 2024 16:04:58 +0100,
Richard Fitzgerald wrote:
> 
> Factory calibration of the speakers stores the calibration information
> into an EFI variable.
> 
> This set of patches adds support for applying speaker calibration
> data from that EFI variable.
> 
> Patch #1 and #2 are bugfixes that are prerequisites.
> 
> The HDA patches #7 and #8 depend on the ASoC patches.
> 
> Patch #9 is a KUnit test for the new cs-amp-lib library.
> 
> Richard Fitzgerald (8):
>   ASoC: wm_adsp: Fix missing mutex_lock in wm_adsp_write_ctl()
>   ASoC: wm_adsp: Add wm_adsp_start() and wm_adsp_stop()
>   ASoC: cs-amp-lib: Add helpers for factory calibration data
>   ASoC: cs35l56: Add helper functions for amp calibration
>   ASoC: cs35l56: Apply amp calibration from EFI data
>   ALSA: hda: hda_cs_dsp_ctl: Add helper function to write calibration
>   ALSA: hda: cs35l56: Apply amp calibration from EFI data
>   ASoC: cs-amp-lib: Add KUnit test for calibration helpers
> 
> Simon Trimmer (1):
>   ALSA: hda: hda_cs_dsp_ctl: Only call notify when a control has been
>     added to a card

I guess it's better to be merged through ASoC tree.
Feel free to my review tag

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

