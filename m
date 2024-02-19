Return-Path: <linux-kernel+bounces-70936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8D3859E42
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432101C218D2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B48D21114;
	Mon, 19 Feb 2024 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UQl//MT4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6niTp9FV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oIl96RWi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X8//vfLG"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC4EADB;
	Mon, 19 Feb 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331521; cv=none; b=uPlqt4zLYAypttjWaz96JhgSBheUFxn37x8HMear/uiswEEVnmpnGVmIPZcfLaDmd7NI+VQd/U1znzR+UjhMftS9wRui50JQDXzZWVyaOvO4ctmbKI34NiR00TO8m3N+mG7kq123kmdOFj3raDTUkUs1rHpCXxVBiXGA5xDlCMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331521; c=relaxed/simple;
	bh=AdQtMeJgH2/BHN3sSej+s7w2viE8v0aJWk+2thNs0dg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNFB9IbpbEw3fKzvcLtCVAd33wty0obN/XeUbuqS7LPagI7diB4JAmUEaThnS6b2CN4XmNOaClxIv4OI33Nwu9ureWg8BV8/W68Ahljjc2VY+bXsZFdXvFuyxwxeewxtEMYszqW4gj11hg107EjFmpzxLHGh92aP58aZJ0DbzBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UQl//MT4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6niTp9FV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oIl96RWi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X8//vfLG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCCC6222FE;
	Mon, 19 Feb 2024 08:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708331517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pGt6MuPRGBnHkBNOq3vW8nHROQlJopdTk2qgvu5Tcx8=;
	b=UQl//MT4MeIn8g+KFjYTXs/jgi5lvknX/rf2TXWMHY5e0+ZfsHVu6+uZVUxDzbBHgcdfKa
	50Na0lvfVzv2xHzJ9fIMbvCNI+GTLyVSAbtkxuDD3vrd/BrgcHnCPiWaoXstYWsA34+yET
	QPGwkMtfFPZdndNv6/LtZEgdgGRtGms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708331517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pGt6MuPRGBnHkBNOq3vW8nHROQlJopdTk2qgvu5Tcx8=;
	b=6niTp9FVmUhEojZoxtReRiPmN2MAed6Y7pvFdDcdZ7BO+AEEyvPieIpgZjc0kUgBjXFeF6
	2PvqsmxVeeodMjBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708331515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pGt6MuPRGBnHkBNOq3vW8nHROQlJopdTk2qgvu5Tcx8=;
	b=oIl96RWixquwOiYjVph9YxMuv22ArILOYFj3N+aHpIvB8nlgmyib0XfXMUtuA7jAdwhCv0
	wtnS24sskmRH9vKbi3Zz8RYz+DzAK/8bF6/z5bAE6QKYvjKb0j/4JJBJCLZXw9Wr0Wtom9
	7JCahSHGpJMlMTcHkh6u6wChFJl4drM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708331515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pGt6MuPRGBnHkBNOq3vW8nHROQlJopdTk2qgvu5Tcx8=;
	b=X8//vfLGRwEPtJK2mlj2u0iHdkiZYC1Vzxb55USzEAmYXZkH7+uoD9NPzlM0nnw8/IJysi
	KlJ09jd4dcDGcUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A191D13647;
	Mon, 19 Feb 2024 08:31:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mzr0JfsR02UeBwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Feb 2024 08:31:55 +0000
Date: Mon, 19 Feb 2024 09:31:55 +0100
Message-ID: <874je4q2h0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hans Peter <flurry123@gmx.ch>
Cc: tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable Mute LED on HP 840 G8 (MB 8AB8)
In-Reply-To: <a170992c-2acf-42f9-9dcc-b5dae5fffa67@gmx.ch>
References: <a170992c-2acf-42f9-9dcc-b5dae5fffa67@gmx.ch>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oIl96RWi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="X8//vfLG"
X-Spamd-Result: default: False [0.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmx.ch];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[alsa-info.sh:url,suse.de:dkim];
	 FREEMAIL_TO(0.00)[gmx.ch];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[35.63%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.69
X-Rspamd-Queue-Id: CCCC6222FE
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Sun, 18 Feb 2024 13:16:03 +0100,
Hans Peter wrote:
> 
> The HP EliteBook 840 G8 seems to be circulating with different
> subsystem-IDs. alsa-info.sh showed on my box:
> 
> !!DMI Information
> !!---------------
> 
> Manufacturer:      HP
> Product Name:      HP EliteBook 840 G8 Notebook PC
> Product Version:   SBKPF
> Firmware Version:  T37 Ver. 01.15.02
> System SKU:        5S7R6EC#ABD
> Board Vendor:      HP
> Board Name:        8AB8
> 
> ...
> 
> !!HDA-Intel Codec information
> !!---------------------------
> --startcollapse--
> 
> Codec: Realtek ALC285
> Address: 0
> AFG Function Id: 0x1 (unsol 1)
> Vendor Id: 0x10ec0285
> Subsystem Id: 0x103c8ab9
> Revision Id: 0x100002
> 
> 
> So an additional quirk enabled mute led for me:
> 
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -9752,6 +9752,7 @@
>  	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)",
> ALC236_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8aa8, "HP EliteBook 640 G9 (MB 8AA6)",
> ALC236_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8aab, "HP EliteBook 650 G9 (MB 8AA9)",
> ALC236_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8ab9, "HP EliteBook 840 G8 (MB 8AB8)",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9",
> ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook
> PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook
> PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),

Could you repost a proper patch with your Signed-off-by tag?  It's a
legal requirement.  See Documentation/process/submitting-patches.rst
for details.

Also the information of your device could be a bit more concise.

Last but not least, the patch doesn't seem cleanly applicable.  Your
mailer seems breaking the lines.  Please fix your setup, or use
git-send-email to resubmit.


thanks,

Takashi

