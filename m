Return-Path: <linux-kernel+bounces-25934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096C582D883
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C38B20BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76E72C68D;
	Mon, 15 Jan 2024 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oUH71L6Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V8O65D+L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J+tfy3gE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vmyZlXtx"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E52C689;
	Mon, 15 Jan 2024 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0DCF1FD32;
	Mon, 15 Jan 2024 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705318970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fa77VaAZn9UVOV4vrMGq9naLXzpjHArd8P1qmSRNbmw=;
	b=oUH71L6Z4J/EgGXkRls1dCSZL+jk2X5LofEIlbjWPsEq7jt+xWs3PcYL0q6drkLBIOlm/z
	aN2/Jnpqsy5BF5ycWotWquThD80lNRd4aPtX6ftF7r29IsIddxdpIOsgKTAw2luVUP+Ra9
	eGcxwJOSyqB4hJAUawKW4moK5sVw00Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705318970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fa77VaAZn9UVOV4vrMGq9naLXzpjHArd8P1qmSRNbmw=;
	b=V8O65D+L/4bnpO+sE9xANk5xOWLpXOvUghl5aiKAA+a2pNniU5/zJUIVRQS2GoPvIBY3X2
	mmBWWUujhGLwXIAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705318969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fa77VaAZn9UVOV4vrMGq9naLXzpjHArd8P1qmSRNbmw=;
	b=J+tfy3gElBbqY62Ix/9oq7H32RSHu53SXfkk4533yv8AKQywY7IMBfmlMNpnHk2HnJOwnS
	CaSwYbIVTrskI0g7xkcyQrpnCwhKut8UKAgynPPVAw5FoDFXDW07VTqt4pGuL4030bjeYA
	FOY7FWOfnXBsIt3SsSTzqVjzwFy+iaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705318969;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fa77VaAZn9UVOV4vrMGq9naLXzpjHArd8P1qmSRNbmw=;
	b=vmyZlXtx8TSl0fKGZ7fOHnU5qAXyb2gZ4q2iIwgRPUQDHp77CVYLVb/FsbhrxgPl113+Ad
	FlG9aorv+pglFCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94F0813712;
	Mon, 15 Jan 2024 11:42:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vEidIDkapWW+QAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 15 Jan 2024 11:42:49 +0000
Date: Mon, 15 Jan 2024 12:42:49 +0100
Message-ID: <878r4qyg92.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-3?Q?=C7a=BBhan?= Demir <caghandemir@marun.edu.tr>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/relatek: Enable Mute LED on HP Laptop 15s-fq2xxx
In-Reply-To: <20240113023734.10817-2-caghandemir@marun.edu.tr>
References: <20240113023734.10817-2-caghandemir@marun.edu.tr>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-3
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J+tfy3gE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vmyZlXtx
X-Spamd-Result: default: False [0.35 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.34)[76.10%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.35
X-Rspamd-Queue-Id: D0DCF1FD32
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Sat, 13 Jan 2024 03:37:33 +0100,
Ça»han Demir wrote:
> 
> This HP Laptop uses ALC236 codec with COEF 0x07 idx 1 controlling
> the mute LED. This patch enables the already existing quirk for
> this device.
> 
> Signed-off-by: Ça»han Demir <caghandemir@marun.edu.tr>
> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index b68c94757..124bee526 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -9876,6 +9876,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
>  	SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
>  	SND_PCI_QUIRK(0x103c, 0x887a, "HP Laptop 15s-eq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
> +	SND_PCI_QUIRK(0x103c, 0x87FE, "HP Laptop 15s-fq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),

The entry is sorted in PCI SSID order.
Could you put it at the right position?
Also, the lower alphabets are used for hex numbers in general.


thanks,

Takashi

