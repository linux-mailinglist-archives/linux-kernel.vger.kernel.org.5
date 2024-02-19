Return-Path: <linux-kernel+bounces-71173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DB085A19D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172731C213F8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5666F2C192;
	Mon, 19 Feb 2024 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s86i5twg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UBGlvilk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s86i5twg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UBGlvilk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379ABA4D;
	Mon, 19 Feb 2024 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340821; cv=none; b=hoh2TWy8zMhlOxkvsw5HHqFvYgAZJJnF8Umg+kiE2w0NrUiweeCON+S9K98zz7FCBRgn25kD+TT11sABEZ+llUm3LNM98vzO9T++lGNeYa8SqBeFJpwAwYlrO0ajQ6WeGX7CpPlmzpLWMTRD4W8ZA1/YvDnd54DfDFpO3Ynhtho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340821; c=relaxed/simple;
	bh=mH/z9hy5y1/jEvD4un/BSTP6zQ3aR1t42CU+6SFkCKk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHTaqNrWrHuIU1u9A0pa2mKsIXPE6RzLjzcrHOHFXQHtM5iHwE2mh3nvvSYErvPzWLE75dWL5ixqS1CIOx1I5j33qBsz9HXhlSuQrMHo8xswi3NKCPxjmFEudE1dALbI5kF3FmG6x8I7iM6Oq1qFCbjRiDb+UcsjjbYGIB/XU74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s86i5twg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UBGlvilk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s86i5twg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UBGlvilk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A8D1222F9;
	Mon, 19 Feb 2024 11:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708340818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2VkQEWzEnd6uPTyGy38QQbhsmDl2BuN3OJaCFvojlto=;
	b=s86i5twgn2MtfLizWr3v+vuGVLzcvSg2Peyh1FBKe0C46J9WSpVN57M0vvk7PW1Xoq/QEl
	z9bbhf99Z0nt85d3UbQULxdp7NbnGWm52kd4LnJWMWcajaxRuVvn4Q/qmFtoMRk8uEdmPp
	uvljSRR5m862OU6OV9k0hmj+TTxigaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708340818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2VkQEWzEnd6uPTyGy38QQbhsmDl2BuN3OJaCFvojlto=;
	b=UBGlvilkdOxexvJtL8JZ/pQLZ4r0X/oeFfep7ABRM5KKeSHlczaUTfG3OyLuq5COBK6Nne
	EmDpEGzvDifdsfBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708340818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2VkQEWzEnd6uPTyGy38QQbhsmDl2BuN3OJaCFvojlto=;
	b=s86i5twgn2MtfLizWr3v+vuGVLzcvSg2Peyh1FBKe0C46J9WSpVN57M0vvk7PW1Xoq/QEl
	z9bbhf99Z0nt85d3UbQULxdp7NbnGWm52kd4LnJWMWcajaxRuVvn4Q/qmFtoMRk8uEdmPp
	uvljSRR5m862OU6OV9k0hmj+TTxigaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708340818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2VkQEWzEnd6uPTyGy38QQbhsmDl2BuN3OJaCFvojlto=;
	b=UBGlvilkdOxexvJtL8JZ/pQLZ4r0X/oeFfep7ABRM5KKeSHlczaUTfG3OyLuq5COBK6Nne
	EmDpEGzvDifdsfBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B50FF13647;
	Mon, 19 Feb 2024 11:06:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id viCtKlE202XtLgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Feb 2024 11:06:57 +0000
Date: Mon, 19 Feb 2024 12:06:57 +0100
Message-ID: <87o7ccogq6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Mark Brown <broonie@kernel.org>,
	stable@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
	"Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
	"Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
	Ethan Geller <ethang@valvesoftware.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: Re: [REGRESSION] Acp5x probing regression introduced between kernel 6.7.2 -> 6.7.4
In-Reply-To: <3e364929-807e-477c-8530-f23db4ae7caf@amd.com>
References: <CAD_nV8BG0t7US=+C28kQOR==712MPfZ9m-fuKksgoZCgrEByCw@mail.gmail.com>
	<7a0cd63f-8a83-4dc5-8763-63dcdae8d68a@leemhuis.info>
	<878r3qxcyr.wl-tiwai@suse.de>
	<871q9hwz2w.wl-tiwai@suse.de>
	<ZdDXJyXiZ++KiNqW@finisterre.sirena.org.uk>
	<87msrzos6m.wl-tiwai@suse.de>
	<3e364929-807e-477c-8530-f23db4ae7caf@amd.com>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=s86i5twg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UBGlvilk
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 2A8D1222F9
X-Spam-Flag: NO

On Mon, 19 Feb 2024 11:50:46 +0100,
Venkata Prasad Potturu wrote:
> 
> 
> On 2/18/24 00:04, Takashi Iwai wrote:
> > On Sat, 17 Feb 2024 16:56:23 +0100,
> > Mark Brown wrote:
> >> On Mon, Feb 12, 2024 at 03:12:55PM +0100, Takashi Iwai wrote:
> >>> Takashi Iwai wrote:
> >>>> Interestingly, the system seems working with 6.8-rc3, so some piece
> >>>> might be missing.  Or simply reverting this patch should fix.
> >>> In the bugzilla entry, the reporter confirmed that the revert of the
> >>> commit 4b6986b170f2f2 fixed the problem.
> >> Any news on a patch for this?  Venkata?
> Hi Mark & Takashi,
> Sorry for the late reply.
> 
> 4b6986b170f2f2 ASoC: amd: Add new dmi entries for acp5x platform
> 
> There is no relation with the below error and this reverted patch, this patch is to
> define is to load Legacy driver for Jupiter Steam deck variant.
> 
> We will check on this.
> 
> Error logs.
> [    8.755614] cs35l41 spi-VLV1776:00: supply VA not found, using dummy regulator
> [    8.760506] cs35l41 spi-VLV1776:00: supply VP not found, using dummy regulator
> [    8.777148] cs35l41 spi-VLV1776:00: Cirrus Logic CS35L41 (35a40), Revision: B2
> [    8.777471] cs35l41 spi-VLV1776:01: supply VA not found, using dummy regulator
> [    8.777532] cs35l41 spi-VLV1776:01: supply VP not found, using dummy regulator
> [    8.777709] cs35l41 spi-VLV1776:01: Reset line busy, assuming shared reset
> [    8.788465] cs35l41 spi-VLV1776:01: Cirrus Logic CS35L41 (35a40), Revision: B2
> [    8.877280] snd_hda_intel 0000:04:00.1: enabling device (0000 -> 0002)
> [    8.877595] snd_hda_intel 0000:04:00.1: Handle vga_switcheroo audio client
> [    8.889913] snd_acp_pci 0000:04:00.5: enabling device (0000 -> 0002)
> [    8.890063] snd_acp_pci 0000:04:00.5: Unsupported device revision:0x50
> [    8.890129] snd_acp_pci: probe of 0000:04:00.5 failed with error -22

My understanding is that the fact that snd_acp_pci matches caused the
problem (without backports of other relevant changes).
In the working case, it's probed with snd_pci_acp5x driver.


thanks,

Takashi

