Return-Path: <linux-kernel+bounces-13080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054F681FF75
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 733CFB216BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F61111A6;
	Fri, 29 Dec 2023 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wvYnRPjD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/Zg013Go";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wvYnRPjD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/Zg013Go"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066D1119E;
	Fri, 29 Dec 2023 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5BA5121E82;
	Fri, 29 Dec 2023 12:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703853865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PfSIuJOLoDBb/clSFRScf5DAtw9ldgb0edljZkRP9XM=;
	b=wvYnRPjDe4snZSvoIn2Mm4/Ut85eUT6oTuXqxlOkCZNE7czFJZEvwRrv/MXYFIozFG6Zth
	QmAMpp20mRXxhHvglISamUonbp7DgbAJzvT5Q7519HZru+RAGHnTjR8yDsceUHOW5e3RUE
	jpaycRaxf+OLIhU1631oEgTfPQ9Qtrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703853865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PfSIuJOLoDBb/clSFRScf5DAtw9ldgb0edljZkRP9XM=;
	b=/Zg013Gon+ocWUGkcPFZqsgi6VkYiJOq3WS5zgbAVRdrFGL7LAU3xbB0ZPzsxh0Nkaq4/n
	8yv4wR7OWHrbi7Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703853865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PfSIuJOLoDBb/clSFRScf5DAtw9ldgb0edljZkRP9XM=;
	b=wvYnRPjDe4snZSvoIn2Mm4/Ut85eUT6oTuXqxlOkCZNE7czFJZEvwRrv/MXYFIozFG6Zth
	QmAMpp20mRXxhHvglISamUonbp7DgbAJzvT5Q7519HZru+RAGHnTjR8yDsceUHOW5e3RUE
	jpaycRaxf+OLIhU1631oEgTfPQ9Qtrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703853865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PfSIuJOLoDBb/clSFRScf5DAtw9ldgb0edljZkRP9XM=;
	b=/Zg013Gon+ocWUGkcPFZqsgi6VkYiJOq3WS5zgbAVRdrFGL7LAU3xbB0ZPzsxh0Nkaq4/n
	8yv4wR7OWHrbi7Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBD03133E5;
	Fri, 29 Dec 2023 12:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H72LMyi/jmUCaAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 29 Dec 2023 12:44:24 +0000
Date: Fri, 29 Dec 2023 13:44:24 +0100
Message-ID: <87zfxtxjo7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dorian Cruveiller <doriancruveiller@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	luke@ljones.dev,
	andy.chi@canonical.com,
	shenghao-ding@ti.com,
	ruinairas1992@gmail.com,
	l.guzenko@web.de,
	yangyuchi66@gmail.com,
	vitalyr@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add support for cirrus cs35l41 sound amplifier
In-Reply-To: <20231225181352.185455-1-doriancruveiller@gmail.com>
References: <20231225181352.185455-1-doriancruveiller@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.75 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[perex.cz,suse.com,opensource.cirrus.com,realtek.com,ljones.dev,canonical.com,ti.com,gmail.com,web.de,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.94)[99.75%];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wvYnRPjD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/Zg013Go"
X-Spam-Score: -5.75
X-Rspamd-Queue-Id: 5BA5121E82

On Mon, 25 Dec 2023 19:13:52 +0100,
Dorian Cruveiller wrote:
> 
> Link up the realtek audio chip to the cirrus cs35l41 sound amplifier chip
> on 2 two models of the Lenovo legion slim 7 gen 8 (2023). These models are
> 16IRH8 and 16APH8.
> 
> Signed-off-by: Dorian Cruveiller <doriancruveiller@gmail.com>
> ---
>  sound/pci/hda/patch_realtek.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index c3a756528886..d8c8bb4c71b7 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10208,6 +10208,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),
>  	SND_PCI_QUIRK(0x17aa, 0x3820, "Yoga Duet 7 13ITL6", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
>  	SND_PCI_QUIRK(0x17aa, 0x3824, "Legion Y9000X 2020", ALC285_FIXUP_LEGION_Y9000X_SPEAKERS),
> +	SND_PCI_QUIRK(0x17aa, 0x38b4, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
> +	SND_PCI_QUIRK(0x17aa, 0x38b7, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
>  	SND_PCI_QUIRK(0x17aa, 0x3827, "Ideapad S740", ALC285_FIXUP_IDEAPAD_S740_COEF),
>  	SND_PCI_QUIRK(0x17aa, 0x3834, "Lenovo IdeaPad Slim 9i 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
>  	SND_PCI_QUIRK(0x17aa, 0x383d, "Legion Y9000X 2019", ALC285_FIXUP_LEGION_Y9000X_SPEAKERS),

The table entries are sorted in PCI SSID order.
Could you try to put at the right place and resubmit?


thanks,

Takashi

