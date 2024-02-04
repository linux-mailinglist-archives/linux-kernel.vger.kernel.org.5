Return-Path: <linux-kernel+bounces-51635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D54A848D93
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4831F21A25
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E277122331;
	Sun,  4 Feb 2024 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="if2a57vL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L1DPQy3X";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="if2a57vL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L1DPQy3X"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FE22232E;
	Sun,  4 Feb 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707049664; cv=none; b=WzroVoPEkIgq75BToKlli/AqeoNTHWthXB/elm2JIbVhDhyZZhdCmJs07tRArx5+3fZlUmFmohpofVXaZqI2bmxMnwJXyWDBUX9jJlxSdwzjtFrCcfaK7FHwfqa4m80+IvecbK037c/1j7dXMsBYQfaddsmJ0TTe1y4bdVe2Dyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707049664; c=relaxed/simple;
	bh=sk8cuBAyWQHenmPv7AkWtabIhbrkDRqObzdPUm9ZGKk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKWu2CtzhKS+YsSzJ6uGxNyxOcbLjWLv9G8sLTIDbYtJ3M5eXF2lg7TLzqTbauMKQ1tJGFyObsYFxzfEWF3hta8xAk8YxNPovamloG3q29dc5o+f3pOvst8fwSGtg5y/ZFi/cIE2S2N8Jsfm0oZvcDdHTPU2uKIay/NcgjsI7uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=if2a57vL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L1DPQy3X; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=if2a57vL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L1DPQy3X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD98A21F92;
	Sun,  4 Feb 2024 12:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707049660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhkhJIt8openUCHgF2QKZ7kta7GJxD0PzmAypQY7rM4=;
	b=if2a57vLMPSPXf0ySWFNJA9Iys68L1X3AN4r7HeZuzOssObRRM+FRmn4fugj7POOR/j/HJ
	mWAPFClTe0V2I56jvno5hxnhTCFpTn5MAd/H1XGhRbfGWdR39sZDCUoZRnlBh4VYiXRvss
	KSCEtz9auKPbzKMeOBYiC6hfUDkivjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707049660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhkhJIt8openUCHgF2QKZ7kta7GJxD0PzmAypQY7rM4=;
	b=L1DPQy3XrDncH6UUCSSpFgo453k5TmFnBAmT0/L864A5QOtuYiH2WyX0JZN3dVLhIBg/Vt
	QevhYh1D3Dy2GsDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707049660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhkhJIt8openUCHgF2QKZ7kta7GJxD0PzmAypQY7rM4=;
	b=if2a57vLMPSPXf0ySWFNJA9Iys68L1X3AN4r7HeZuzOssObRRM+FRmn4fugj7POOR/j/HJ
	mWAPFClTe0V2I56jvno5hxnhTCFpTn5MAd/H1XGhRbfGWdR39sZDCUoZRnlBh4VYiXRvss
	KSCEtz9auKPbzKMeOBYiC6hfUDkivjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707049660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QhkhJIt8openUCHgF2QKZ7kta7GJxD0PzmAypQY7rM4=;
	b=L1DPQy3XrDncH6UUCSSpFgo453k5TmFnBAmT0/L864A5QOtuYiH2WyX0JZN3dVLhIBg/Vt
	QevhYh1D3Dy2GsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F987132DD;
	Sun,  4 Feb 2024 12:27:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6VrRHbyCv2WyJgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 04 Feb 2024 12:27:40 +0000
Date: Sun, 04 Feb 2024 13:27:40 +0100
Message-ID: <874jeobeir.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: bo liu <bo.liu@senarytech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/conexant: Add quirk for SWS JS201D
In-Reply-To: <20240204045344.48397-1-bo.liu@senarytech.com>
References: <20240204045344.48397-1-bo.liu@senarytech.com>
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
X-Spamd-Result: default: False [-0.24 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.14)[88.57%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.24

On Sun, 04 Feb 2024 05:53:44 +0100,
bo liu wrote:
> 
> The SWS JS201D need a different pinconfig from windows driver.
> Add a quirk to use a specific pinconfig to SWS JS201D.
> 
> Signed-off-by: bo liu <bo.liu@senarytech.com>
> ---
>  sound/pci/hda/patch_conexant.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
> index e8819e8a9876..a0bb4d91502b 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -344,6 +344,7 @@ enum {
>  	CXT_FIXUP_HP_ZBOOK_MUTE_LED,
>  	CXT_FIXUP_HEADSET_MIC,
>  	CXT_FIXUP_HP_MIC_NO_PRESENCE,
> +	CXT_PINCFG_SWS_JS201D,
>  };
>  
>  /* for hda_fixup_thinkpad_acpi() */
> @@ -841,6 +842,17 @@ static const struct hda_pintbl cxt_pincfg_lemote[] = {
>  	{}
>  };
>  
> +/* SuoWoSi/South-holding JS201D with sn6140 */
> +static const struct hda_pintbl cxt_pincfg_sws_js201d[] = {
> +	{ 0x16, 0x03211040 }, /* hp out */
> +	{ 0x17, 0x91170110 }, /* SPK/Class_D */
> +	{ 0x18, 0x95a70130 }, /* Internal mic */
> +	{ 0x19, 0x03a11020 }, /* Headset Mic */
> +	{ 0x1a, 0x40f001f0 }, /* Not used */
> +	{ 0x21, 0x40f001f0 }, /* Not used */
> +	{}
> +};
> +
>  static const struct hda_fixup cxt_fixups[] = {
>  	[CXT_PINCFG_LENOVO_X200] = {
>  		.type = HDA_FIXUP_PINS,
> @@ -996,6 +1008,10 @@ static const struct hda_fixup cxt_fixups[] = {
>  		.chained = true,
>  		.chain_id = CXT_FIXUP_HEADSET_MIC,
>  	},
> +	[CXT_PINCFG_SWS_JS201D] = {
> +		.type = HDA_FIXUP_PINS,
> +		.v.pins = cxt_pincfg_sws_js201d,
> +	},
>  };
>  
>  static const struct snd_pci_quirk cxt5045_fixups[] = {
> @@ -1091,6 +1107,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
>  	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", CXT_FIXUP_THINKPAD_ACPI),
>  	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
>  	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
> +	SND_PCI_QUIRK(0x14f1, 0x0265, "SWS JS201D", CXT_PINCFG_SWS_JS201D),
>  	{}
>  };

The table is sorted in PCI SSID order.  Please try to put at the right
position.


thanks,

Takashi

