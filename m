Return-Path: <linux-kernel+bounces-167889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D078BB0B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22F51F24A53
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A234C155339;
	Fri,  3 May 2024 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DmHHtJ+M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iFUIqD0I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DmHHtJ+M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iFUIqD0I"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A8152DFE;
	Fri,  3 May 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752981; cv=none; b=aW9dZ1RqbnIwOfNDE7FE8WbDpoolI1uvhJxXiU/VTH00BhJRW6Wa/NIGJ8LD/vSOD1tHttZriCI62K4PefFkE7NZvwqYRyhH4LoJAoGbAA3iUKBMZ7+0tE6kYHncX5zgyseMosNudGszK5atj1NVnhariQyF4UDxxCu2ngk/WtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752981; c=relaxed/simple;
	bh=9JAuqzmFfvLFHF54ovz6fulY0osoFcF5ZH4aXMlz1PQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6g1iHVyDNM2nnwcmdGcdBxr2rwSXMyqnqESdx+R7S3iybbWVD8rKnHswzFeUoIp36+DvKTQ0hWj6O2WKENEZtgkNPsbY5Lx+yJQrJWNXuBzvfzy68odTfH9NgH9xTNnMbkjr1rAJTaWtKbKvndeaXlz6O+u+gExcxNoMIHDSRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DmHHtJ+M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iFUIqD0I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DmHHtJ+M; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iFUIqD0I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 465EA1FDB7;
	Fri,  3 May 2024 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714752978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oiTqZfHoHoeBGnqeqSO0b2VdvRk2sjq5+PSJaOuL1J4=;
	b=DmHHtJ+MYCJdNH6JIU0KC553fLk/9sAAgAovImFzpQ1vMzLklTjNuokU5eFvCtdGzQZ5BC
	YmgpNV0YYjKKne8RUldDaWDlJvi6vwV6W20qAAtIWLW3exBwh3/ozBNqAvkZXOOv9jOLvM
	HrLC0NGd3YlYNFICqYhbuJI7yb8VQu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714752978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oiTqZfHoHoeBGnqeqSO0b2VdvRk2sjq5+PSJaOuL1J4=;
	b=iFUIqD0Ijr2dnAw7WNVSjNJUdzuZdNwFXAVyezKDbdLRK5P3NHxHjrQ+jfEG+j8O/owkEd
	tmRkXYZZdOyZK6DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714752978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oiTqZfHoHoeBGnqeqSO0b2VdvRk2sjq5+PSJaOuL1J4=;
	b=DmHHtJ+MYCJdNH6JIU0KC553fLk/9sAAgAovImFzpQ1vMzLklTjNuokU5eFvCtdGzQZ5BC
	YmgpNV0YYjKKne8RUldDaWDlJvi6vwV6W20qAAtIWLW3exBwh3/ozBNqAvkZXOOv9jOLvM
	HrLC0NGd3YlYNFICqYhbuJI7yb8VQu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714752978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oiTqZfHoHoeBGnqeqSO0b2VdvRk2sjq5+PSJaOuL1J4=;
	b=iFUIqD0Ijr2dnAw7WNVSjNJUdzuZdNwFXAVyezKDbdLRK5P3NHxHjrQ+jfEG+j8O/owkEd
	tmRkXYZZdOyZK6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B6AB13991;
	Fri,  3 May 2024 16:16:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Txw+AdINNWboOwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 03 May 2024 16:16:18 +0000
Date: Fri, 03 May 2024 18:16:31 +0200
Message-ID: <87bk5man1c.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda/cs_dsp_ctl: Actually remove ALSA controls
In-Reply-To: <d9c5b863-53a5-4255-ab15-9ac3cb10ec10@opensource.cirrus.com>
References: <20240503144920.61075-1-rf@opensource.cirrus.com>
	<87msp79b7o.wl-tiwai@suse.de>
	<d9c5b863-53a5-4255-ab15-9ac3cb10ec10@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Fri, 03 May 2024 17:31:15 +0200,
Richard Fitzgerald wrote:
> 
> On 03/05/2024 16:17, Takashi Iwai wrote:
> > On Fri, 03 May 2024 16:49:20 +0200,
> > Richard Fitzgerald wrote:
> >> 
> >> hda_cs_dsp_control_remove() must remove the ALSA control when
> >> deleting all the infrastructure for handling the control.
> >> 
> >> Without this it is possible for ALSA controls to be left in
> >> the Soundcard after the amp driver module has been unloaded.
> >> So the get/set callbacks point to code that no longer exists.
> >> 
> >> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> >> Fixes: 3233b978af23 ("ALSA: hda: hda_cs_dsp_ctl: Add Library to support CS_DSP ALSA controls")
> >> ---
> >> Note: it would be better to use the control private_free to do the
> >> cleanup, and that is my plan long-term. But that is a larger change
> >> to the code.
> >> 
> >> I like to keep bugfix patches as simple as possible so they are
> >> low-risk and easy to cherry-pick into older kernels. So this patch
> >> fixes the bug. Sometime I will send a patch for future kernel
> >> versions that reworks the cleanup to use private_free.
> > 
> > I also like to keep as simple as possible :)
> > 
> > One slight concern is whether cs_dsp kctls can be deleted at the
> > snd_card removal (disconnect) before this function gets called.
> > That is, snd_card_free() of the main card may delete all associated
> > kctls, and may this function be called afterwards?
> > If yes, this change would lead to a UAF.
> > 
> 
> That's a good question. This is is safe for the cs35l56 driver because
> if the soundcard (or HDA codec driver) is removed, the HDA codec will
> destroy the component binding in its HDA_FIXUP_ACT_FREE. This will cause
> an unbind() call to the amp driver, which will (indirectly) call this
> function to remove all the controls. So they will have been removed
> before the soundcard is cleaned up.
> 
> But it turns out that the cs35l41 driver doesn't clean up the cs_dsp
> instance in its unbind() call so the controls _won't_ be cleaned up
> and a double-free is possible. The firmware handling in the cs35l41
> driver is strange and confusing so I'm not sure whether this is a bug
> or something necessary.

OK, then setting kctl->private_free additionally like below could work
around it, I suppose.


Takashi

--- a/sound/pci/hda/hda_cs_dsp_ctl.c
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -97,6 +97,14 @@ static unsigned int wmfw_convert_flags(unsigned int in)
 	return out;
 }
 
+static void hda_cs_dsp_coeff_free(struct snd_kcontrol *kctl)
+{
+	struct hda_cs_dsp_coeff_ctl *ctl = snd_kcontrol_chip(kctl);
+	
+	if (ctl)
+		ctl->kctl = NULL;
+}
+
 static void hda_cs_dsp_add_kcontrol(struct hda_cs_dsp_coeff_ctl *ctl, const char *name)
 {
 	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
@@ -130,6 +138,7 @@ static void hda_cs_dsp_add_kcontrol(struct hda_cs_dsp_coeff_ctl *ctl, const char
 	}
 
 	dev_dbg(cs_ctl->dsp->dev, "Added KControl: %s\n", kcontrol.name);
+	kctl->private_free = hda_cs_dsp_coeff_free;
 	ctl->kctl = kctl;
 }
 

