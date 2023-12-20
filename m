Return-Path: <linux-kernel+bounces-6544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FEB819A28
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBA41C2565B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0683E18E3C;
	Wed, 20 Dec 2023 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yP2pDTrU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SB7ag+G9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yP2pDTrU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SB7ag+G9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD51DA27;
	Wed, 20 Dec 2023 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 67C2B21EA6;
	Wed, 20 Dec 2023 08:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703059838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OeeY1coWVj10KFZo2dtcob3FMIN2wLZHWXWf9T04zvM=;
	b=yP2pDTrUVDVPCBGsaRh8ZGIkRH/EwbtfNgfd9Z5QI+YXYyL1XkOfLQBvooZcyPosXp3mMR
	NTOkqmj1R7q2HEbRRrqcA9pK6g28iIH0d8nvCJeqh+eGDaHXMwg5+kNNyutMaLGZX3fDbx
	eVSn6Oy+hCb5lCz9YPOhF1TL18d9V5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703059838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OeeY1coWVj10KFZo2dtcob3FMIN2wLZHWXWf9T04zvM=;
	b=SB7ag+G9nSt4alG06a8lMZHCwSaALRB1YxOVb42A2/CXu+IGHVgRzNRQZZA4Viy+6NX3AG
	Dxzhq5Xhp2siinDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703059838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OeeY1coWVj10KFZo2dtcob3FMIN2wLZHWXWf9T04zvM=;
	b=yP2pDTrUVDVPCBGsaRh8ZGIkRH/EwbtfNgfd9Z5QI+YXYyL1XkOfLQBvooZcyPosXp3mMR
	NTOkqmj1R7q2HEbRRrqcA9pK6g28iIH0d8nvCJeqh+eGDaHXMwg5+kNNyutMaLGZX3fDbx
	eVSn6Oy+hCb5lCz9YPOhF1TL18d9V5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703059838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OeeY1coWVj10KFZo2dtcob3FMIN2wLZHWXWf9T04zvM=;
	b=SB7ag+G9nSt4alG06a8lMZHCwSaALRB1YxOVb42A2/CXu+IGHVgRzNRQZZA4Viy+6NX3AG
	Dxzhq5Xhp2siinDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 467B913722;
	Wed, 20 Dec 2023 08:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ficEH6hgmW1RwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 20 Dec 2023 08:10:38 +0000
Date: Wed, 20 Dec 2023 09:10:37 +0100
Message-ID: <s5h8r5puwea.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 2/2] ALSA: hda: cs35l41: Only add SPI CS GPIO if SPI is enabled in kernel
In-Reply-To: <20231219162232.790358-3-sbinding@opensource.cirrus.com>
References: <20231219162232.790358-1-sbinding@opensource.cirrus.com>
	<20231219162232.790358-3-sbinding@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-0.01 / 50.00];
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
	 BAYES_HAM(-0.91)[86.10%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -0.01
X-Spam-Flag: NO

On Tue, 19 Dec 2023 17:22:32 +0100,
Stefan Binding wrote:
> 
> If CONFIG_SPI is not set in the kernel, there is no point in trying
> to set the chip selects. We can selectively compile it.

I guess it should with IS_REACHABLE() instead of IS_ENABLED()?
It can be still CONFIG_SPI=m while CONFIG_SND_HDA_*=y.


thanks,

Takashi


> 
> Fixes: 8c4c216db8fb ("ALSA: hda: cs35l41: Add config table to support many laptops without _DSD")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312192256.lJelQEoZ-lkp@intel.com/
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  sound/pci/hda/cs35l41_hda_property.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
> index 73b304e6c83c..194e1179a253 100644
> --- a/sound/pci/hda/cs35l41_hda_property.c
> +++ b/sound/pci/hda/cs35l41_hda_property.c
> @@ -210,6 +210,8 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
>  
>  	if (cfg->bus == SPI) {
>  		cs35l41->index = id;
> +
> +#if IS_ENABLED(CONFIG_SPI)
>  		/*
>  		 * Manually set the Chip Select for the second amp <cs_gpio_index> in the node.
>  		 * This is only supported for systems with 2 amps, since we cannot expand the
> @@ -249,6 +251,7 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
>  				spi_setup(spi);
>  			}
>  		}
> +#endif
>  	} else {
>  		if (cfg->num_amps > 2)
>  			/*
> -- 
> 2.34.1
> 

