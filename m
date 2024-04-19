Return-Path: <linux-kernel+bounces-151069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4204D8AA89A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD0B1C20D49
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F3F3717D;
	Fri, 19 Apr 2024 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GfGoiyWl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7nYIMsGN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GfGoiyWl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7nYIMsGN"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0D037165;
	Fri, 19 Apr 2024 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713509205; cv=none; b=Ye21eIqS/KXy0b6gDHt03YZfJSyukh9XVVsSdfHDNGWUPA2UtyTwYoGobj8L4pMWGkdk01Zkew2IdA7LGpsPOQpdd60dRCdULAjDjwqN8uQMXvS608sXt5tfMTMtEZTunagSoO6YUE1q2mjlO9CxhvDZgkBNJ5/oB/8QZ84/Mek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713509205; c=relaxed/simple;
	bh=rk5dYVTOEKcf8TieWS5krXZV5RTCOihx7uuqubWxOxo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqOP4Fcz/wWnkhXQDI0SqekFjR0G5cMDvBsAGBfzVd+CHgH9YL4vk5o0A2U6/OIoScPGV0Ng4CO21CSzEplTIp1PwmFExF28t7RUj1eMBpt4NB5DNT66NHFO90DKtsQS8k02QM9DYB7cYP5qFdw1YYjjXRi4ESiibdwwyWSEt08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GfGoiyWl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7nYIMsGN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GfGoiyWl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7nYIMsGN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 415A15D3A0;
	Fri, 19 Apr 2024 06:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713509202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EeNeAuoW3dXuECUX3IUeU9F3dbFOKMP5qwJi1Qt8HHs=;
	b=GfGoiyWlF88tWZKouoMgWbF7SKh+0j8aVEgv0L0dY0MnEv9yBX2BvIhYrfRqGVUDspN/XM
	zdDxE8hzJyOeZ9e5URPaODXlw36w8fAIfhPVUYC3jGhHRhd/yCsn+cb89FFZTM/GFLSuN/
	tfDZp2W+lreJ7UMkAgeybzJA2grjWk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713509202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EeNeAuoW3dXuECUX3IUeU9F3dbFOKMP5qwJi1Qt8HHs=;
	b=7nYIMsGNjkFwF1RowN4V7yzcnP2t4kaa0IoZJCD12w2k3z9uWDR6n+435fst6tA0AjrZDo
	Ky+6o1lw4IQk4vBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GfGoiyWl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7nYIMsGN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713509202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EeNeAuoW3dXuECUX3IUeU9F3dbFOKMP5qwJi1Qt8HHs=;
	b=GfGoiyWlF88tWZKouoMgWbF7SKh+0j8aVEgv0L0dY0MnEv9yBX2BvIhYrfRqGVUDspN/XM
	zdDxE8hzJyOeZ9e5URPaODXlw36w8fAIfhPVUYC3jGhHRhd/yCsn+cb89FFZTM/GFLSuN/
	tfDZp2W+lreJ7UMkAgeybzJA2grjWk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713509202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EeNeAuoW3dXuECUX3IUeU9F3dbFOKMP5qwJi1Qt8HHs=;
	b=7nYIMsGNjkFwF1RowN4V7yzcnP2t4kaa0IoZJCD12w2k3z9uWDR6n+435fst6tA0AjrZDo
	Ky+6o1lw4IQk4vBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD30313687;
	Fri, 19 Apr 2024 06:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HKGPNFETImbLRgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Apr 2024 06:46:41 +0000
Date: Fri, 19 Apr 2024 08:46:49 +0200
Message-ID: <877cgtvoh2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ai Chao <aichao@kylinos.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek - Enable audio jacks of Haier Boyue G42 with ALC269VC
In-Reply-To: <20240419052803.339466-1-aichao@kylinos.cn>
References: <20240419052803.339466-1-aichao@kylinos.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-0.54 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.03)[55.20%];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -0.54
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 415A15D3A0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Fri, 19 Apr 2024 07:28:03 +0200,
Ai Chao wrote:
> 
> The Haier Boyue G42 with ALC269VC cannot detect the MIC of headset,
> the line out and internal speaker until
> ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS quirk applied.
> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index d6940bc4ec39..0ebdc676cfe1 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10473,6 +10473,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0xf111, 0x0001, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
>  	SND_PCI_QUIRK(0xf111, 0x0005, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
>  	SND_PCI_QUIRK(0xf111, 0x0006, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
> +	SND_PCI_QUIRK(0x1d17, 0x3288, "Haier Boyue G42", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),

The table is sorted in PCI SSID order.  Could you try to put at the
right place?


thanks,

Takashi

