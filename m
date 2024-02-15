Return-Path: <linux-kernel+bounces-67176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB648567B0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5753EB2F35B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF08133282;
	Thu, 15 Feb 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="14LIfcvz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+kKA2wdk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="14LIfcvz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+kKA2wdk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F40133409;
	Thu, 15 Feb 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010854; cv=none; b=BRU4YbZLZBWQTOj42kmh8C8XaMSr0OF6PFzgzZfTSxLrhMqXAm3leLsVbzZn93+bCFVU7P+Dj3Hrk3AasyYI7hH1z64V44MlhjKX5pt56L0tGA7xe67IlxJy1S0/xAS/JDkVK7Vov95K+h85letRFN1QSrgPiJaYixSxJNGdWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010854; c=relaxed/simple;
	bh=tIB0aVF8fkWJBLrc3QB1oscufH+jGkcfrOMFyPY34Bk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XyH++qo/05esoQgZ0skASTZNeU6do+O21C4MV8VsNVX0VlwWDNDxsFeqZnLuHCfieYkZSHgLcvC3lNRWLgPr53r4N99TLPJQBkCSUlZnvphnln/7iUCZiGl6xkZxTvks8Bv3w1kxmeN8Hmjs5jHqijrkH6UYyV6m6GPWccunJPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=14LIfcvz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+kKA2wdk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=14LIfcvz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+kKA2wdk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 298C621EAB;
	Thu, 15 Feb 2024 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708010851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fgGz8FQ3Yeil4YKvWk4ajn7gdPuvzhX3/yvB5lwxJlg=;
	b=14LIfcvzZcFUPnsGw4v7eriv2+KDIL11QUdQxzMAkww9khBWSBfzzSPzBUWM3s9yJhE9VG
	PjBOG9giPHNZUOCW/SNlPKUT13Wh5DV2KUQYMoKqU2xTz6XMS764RQkDMtScHEHsIY/0wc
	UX3tLdkxZu0pzSPwWU6ozbWKaOVwkYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708010851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fgGz8FQ3Yeil4YKvWk4ajn7gdPuvzhX3/yvB5lwxJlg=;
	b=+kKA2wdkYQlQxhHSVCUqje+8UFimcMRLspkZbNm1PhIT6Q9NFjMaiOol05Wb7NgwNdZrQj
	I7sx/8fwrG8wmhBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708010851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fgGz8FQ3Yeil4YKvWk4ajn7gdPuvzhX3/yvB5lwxJlg=;
	b=14LIfcvzZcFUPnsGw4v7eriv2+KDIL11QUdQxzMAkww9khBWSBfzzSPzBUWM3s9yJhE9VG
	PjBOG9giPHNZUOCW/SNlPKUT13Wh5DV2KUQYMoKqU2xTz6XMS764RQkDMtScHEHsIY/0wc
	UX3tLdkxZu0pzSPwWU6ozbWKaOVwkYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708010851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fgGz8FQ3Yeil4YKvWk4ajn7gdPuvzhX3/yvB5lwxJlg=;
	b=+kKA2wdkYQlQxhHSVCUqje+8UFimcMRLspkZbNm1PhIT6Q9NFjMaiOol05Wb7NgwNdZrQj
	I7sx/8fwrG8wmhBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D358813A53;
	Thu, 15 Feb 2024 15:27:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oh9CMmItzmVjdQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 15 Feb 2024 15:27:30 +0000
Date: Thu, 15 Feb 2024 16:27:30 +0100
Message-ID: <87frxteoil.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Zhang, Eniac" <eniac-xw.zhang@hp.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	"Gagniuc, Alexandru"
	<alexandru.gagniuc@hp.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Eniac Zhang
	<eniacz@gmail.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LED For HP mt645
In-Reply-To: <DS0PR84MB341799A29B99290A1FB10F58BB4D2@DS0PR84MB3417.NAMPRD84.PROD.OUTLOOK.COM>
References: <20240214184507.777349-1-alexandru.gagniuc@hp.com>
	<87v86pevt7.wl-tiwai@suse.de>
	<DS0PR84MB341799A29B99290A1FB10F58BB4D2@DS0PR84MB3417.NAMPRD84.PROD.OUTLOOK.COM>
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
X-Spamd-Result: default: False [-0.60 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.de,hp.com,vger.kernel.org,perex.cz,suse.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.60

On Thu, 15 Feb 2024 16:25:05 +0100,
Zhang, Eniac wrote:
> 
> Hi Takashi,
> 
> I can sign off this merge request.  Alex is ThinPro's new kernel maintainer.  He is trying to push all those old HP patches upstream to make our life (and other HP machine user's life) easier.
> 
> Let me know if there's anything else I can do.

Yes, your sign-off is appreciated.
Also, let's have only one sign-off from Alex (that matches with the
submission mail address) for avoiding confusion.

Please resubmit with those two things addressed.


thanks,

Takashi

> 
> Regards/Eniac
> 
> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de> 
> Sent: Thursday, February 15, 2024 5:50 AM
> To: Gagniuc, Alexandru <alexandru.gagniuc@hp.com>
> Cc: linux-sound@vger.kernel.org; perex@perex.cz; tiwai@suse.com; linux-kernel@vger.kernel.org; Zhang, Eniac <eniac-xw.zhang@hp.com>; Eniac Zhang <eniacz@gmail.com>; Alexandru Gagniuc <mr.nuke.me@gmail.com>; stable@vger.kernel.org
> Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LED For HP mt645
> 
> CAUTION: External Email
> 
> On Wed, 14 Feb 2024 19:45:07 +0100,
> Alexandru Gagniuc wrote:
> >
> > From: Eniac Zhang <eniacz@gmail.com>
> >
> > The HP mt645 G7 Thin Client uses an ALC236 codec and needs the 
> > ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to make the mute and 
> > micmute LEDs work.
> >
> > There are two variants of the USB-C PD chip on this device. Each uses 
> > a different BIOS and board ID, hence the two entries.
> >
> > Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
> 
> Any reason to have two your sign-offs?
> Also, can we get a sign-off from the original author?
> 
> 
> thanks,
> 
> Takashi
> 
> > Cc: <stable@vger.kernel.org>
> > ---
> >  sound/pci/hda/patch_realtek.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/sound/pci/hda/patch_realtek.c 
> > b/sound/pci/hda/patch_realtek.c index 6994c4c5073c..c837470ef5b8 
> > 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -9928,6 +9928,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> >       SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> >       SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> >       SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 
> > Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> > +     SND_PCI_QUIRK(0x103c, 0x8b0f, "HP Elite mt645 G7 Mobile Thin 
> > + Client U81", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> >       SND_PCI_QUIRK(0x103c, 0x8b2f, "HP 255 15.6 inch G10 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
> >       SND_PCI_QUIRK(0x103c, 0x8b42, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> >       SND_PCI_QUIRK(0x103c, 0x8b43, "HP", 
> > ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> > @@ -9935,6 +9936,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> >       SND_PCI_QUIRK(0x103c, 0x8b45, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> >       SND_PCI_QUIRK(0x103c, 0x8b46, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> >       SND_PCI_QUIRK(0x103c, 0x8b47, "HP", 
> > ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> > +     SND_PCI_QUIRK(0x103c, 0x8b59, "HP Elite mt645 G7 Mobile Thin 
> > + Client U89", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> >       SND_PCI_QUIRK(0x103c, 0x8b5d, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> >       SND_PCI_QUIRK(0x103c, 0x8b5e, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> >       SND_PCI_QUIRK(0x103c, 0x8b63, "HP Elite Dragonfly 13.5 inch G4", 
> > ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
> > --
> > 2.42.0
> >
> 

