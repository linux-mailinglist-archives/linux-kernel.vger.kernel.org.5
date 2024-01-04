Return-Path: <linux-kernel+bounces-16450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD09823EBF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E2F1C215B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E4A208BE;
	Thu,  4 Jan 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zOxUEE1I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zSPGc6/a";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zOxUEE1I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zSPGc6/a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73078208AD;
	Thu,  4 Jan 2024 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7745D21E11;
	Thu,  4 Jan 2024 09:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704360967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCC2Cqka0ThfsVWehN5bZIJn79HD8yA3L7KVMrzWJC4=;
	b=zOxUEE1IL7CrQfOcOmtr/2orimz4bzTdiAlBXqOzf+rkQsNmwyU8md+TTbOPHDn6VxFF3j
	aZLo+OMZPqEYXGgMOHmF2oXap+KdCahM8RzN8HK3R2j4/bsGpTYpHf5UFWLPwn1dZGRi5x
	VecOWJV4Far3MjR7HMxoxCkW+Wlm5Ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704360967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCC2Cqka0ThfsVWehN5bZIJn79HD8yA3L7KVMrzWJC4=;
	b=zSPGc6/atvrRxg2R/2cyRa6ypt8OX14m4P85XDyJ+vKlzt9+vBBczNoYbvLCGAqLu0OnME
	nFtL1ArW7By4FzAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704360967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCC2Cqka0ThfsVWehN5bZIJn79HD8yA3L7KVMrzWJC4=;
	b=zOxUEE1IL7CrQfOcOmtr/2orimz4bzTdiAlBXqOzf+rkQsNmwyU8md+TTbOPHDn6VxFF3j
	aZLo+OMZPqEYXGgMOHmF2oXap+KdCahM8RzN8HK3R2j4/bsGpTYpHf5UFWLPwn1dZGRi5x
	VecOWJV4Far3MjR7HMxoxCkW+Wlm5Ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704360967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCC2Cqka0ThfsVWehN5bZIJn79HD8yA3L7KVMrzWJC4=;
	b=zSPGc6/atvrRxg2R/2cyRa6ypt8OX14m4P85XDyJ+vKlzt9+vBBczNoYbvLCGAqLu0OnME
	nFtL1ArW7By4FzAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E47D3137E8;
	Thu,  4 Jan 2024 09:36:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zTOfNgZ8lmWFYgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 04 Jan 2024 09:36:06 +0000
Date: Thu, 04 Jan 2024 10:36:06 +0100
Message-ID: <87cyuha1a1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Matthew Anderson <ruinairas1992@gmail.com>
Cc: tanure@linux.com,
	voreck-lukas@tutanota.com,
	Bagasdotme <bagasdotme@gmail.com>,
	Alsa Devel <alsa-devel@alsa-project.org>,
	Andy Chi <andy.chi@canonical.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Faenkhauser <faenkhauser@gmail.com>,
	James Schulman <james.schulman@cirrus.com>,
	Kailang <kailang@realtek.com>,
	L Guzenko <l.guzenko@web.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux Sound <linux-sound@vger.kernel.org>,
	Luke <luke@ljones.dev>,
	Overloader <overloader@tutanota.com>,
	Patches <patches@opensource.cirrus.com>,
	Perex <perex@perex.cz>,
	Rf <rf@opensource.cirrus.com>,
	Sbinding <sbinding@opensource.cirrus.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Tiwai <tiwai@suse.com>,
	Tsengalb99 <tsengalb99@gmail.com>,
	Vitalyr <vitalyr@opensource.cirrus.com>,
	Yangyuchi66 <yangyuchi66@gmail.com>
Subject: Re: Fwd: No sound drivers on HP Envy x360 ey0xxx
In-Reply-To: <CAEnG5GADVZeFe55dPyEDbQA_jeNqQLNvCRPK4vBCMPCq25gmdA@mail.gmail.com>
References: <NnE33wh--3-9@tutanota.com>
	<CAJX_Q+0NL1_dkLD2oePhW+EjvGiPLQ7S-1jarz4dANm12iHNMg@mail.gmail.com>
	<CAEnG5GAsD_Db7G3TGkfA+bjO64V6tJuGph1dLOnvGhYicvLW_Q@mail.gmail.com>
	<CAJX_Q+1OoXdBAv=tMFdD1-Kfg0sDdnDjbYDpU9g8YfOeECwukA@mail.gmail.com>
	<CAEnG5GADVZeFe55dPyEDbQA_jeNqQLNvCRPK4vBCMPCq25gmdA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.13
X-Spamd-Result: default: False [0.13 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 NEURAL_SPAM_LONG(2.43)[0.695];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[tutanota.com:email,linux.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.com,tutanota.com,gmail.com,alsa-project.org,canonical.com,cirrus.com,realtek.com,web.de,vger.kernel.org,ljones.dev,opensource.cirrus.com,perex.cz,ti.com,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Wed, 03 Jan 2024 17:19:31 +0100,
Matthew Anderson wrote:
> 
> They have something working around it on Windows. It's the same issue we've
> had to work around on Asus devices such as the ROG Ally.
> 
>  You can use DSDT overrides to enable audio on Linux but this is dangerous
> and not recommended because we have no way of knowing the safe values to
> use.
> 
> Asus eventually pushed an update adding the missing information for the ROG
> ally so it's no longer an issue. This is the proper solution.

There are recent additions to apply the static configuration for such
machines with broken BIOSen.  For HP, it'll be included in 6.8,
currently found in for-next branch (or topic/cs35l41 branch) of
sound.git tree.

You'd need to adjust the quirk tables in both
sound/pci/hda/patch_realtek.c and sound/pci/hda/cs35l41_hda_property.c
to match with yours.


HTH,

Takashi

> 
> On Wed, Jan 3, 2024, 9:56 AM Lucas Tanure <tanure@linux.com> wrote:
> 
> >
> >
> > On Wed, 3 Jan 2024, 11:47 Matthew Anderson, <ruinairas1992@gmail.com>
> > wrote:
> >
> >> The issue is that HP does not provide the DSD information in the BIOS for
> >> the Cirrus Amp. I've already emailed HP informing them of the issue. I too
> >> have a newer HP Envy X360 which has the same problem.
> >>
> >> On Wed, Jan 3, 2024, 8:28 AM Lucas Tanure <tanure@linux.com> wrote:
> >>
> >>>
> >>>
> >>> On Wed, 3 Jan 2024, 08:23 , <voreck-lukas@tutanota.com> wrote:
> >>>
> >>>> I hope I'm responding correctly
> >>>>
> >>>> On bugzilla I was asked to attach dmesg and lspci output. I'm sending
> >>>> both as attachments (cause of their length) and hope it works, it's my
> >>>> first time working with these mailing lists.
> >>>>
> >>>
> >>> Hi,
> >>>
> >>> The most important thing to start is the DSDT dump from your Bios.
> >>> That should describe the key points about the hardware configuration.
> >>>
> >>> Thanks
> >>> Lucas Tanure
> >>>
> >>
> > Are you sure?
> > How the can  Windows driver be loaded without that?
> >
> >>

