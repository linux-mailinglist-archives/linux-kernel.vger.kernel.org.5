Return-Path: <linux-kernel+bounces-56898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D0784D0FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521C41F28C2D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7120839F0;
	Wed,  7 Feb 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k9puPfw6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wD9lp1FB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k9puPfw6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wD9lp1FB"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D089B83CA7;
	Wed,  7 Feb 2024 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329627; cv=none; b=las/8wjDw1Yb7fPPWFK0dfcCfAp54D7Ma3VDXZsW4Npx+uXsttmcIeCXgep2OXisv70v6GypjXELRLruZSeJHzSTlsbeYCjZw5FsI6MQkSxSuI0kNyTWnMVfDCkd4vPaw0OcFef0gVj5tLqUtGevOmtfW6Sj0hI/BNrGVRW8RtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329627; c=relaxed/simple;
	bh=9HvsAONbrtp/bywjjWOLTQvsdOXTPBVIAYItcIIyQrw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nuLrkJByZ8vZMD9NR+lPrkRC/Ur8/OfuM+D2OS9/+P7Q0HnyHT/S/tZi8HTT9A408Q7U/TXgS9MwboJyK1MmeOqVdJLcZ6QTMBS+1qvUhrO1hIa+uNd1Dr9UUZITg4J8RHJiH/HQPj00cNgnlQzdVECinfMLbGxydJPsj3l71xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k9puPfw6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wD9lp1FB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k9puPfw6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wD9lp1FB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1095221DE;
	Wed,  7 Feb 2024 18:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707329622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNNR2C2S8ckO8T2jS3L5HyHOHI9cQbyncIQ0RXIxN9U=;
	b=k9puPfw6kR/Jm4Sj31+G+DE1Jks2LZUYTS3kIJlmPL+YVnTgzcDewJRf0nhd9zrHITjwxc
	wL1t6bWWv2oz82c7VgXZLPdK7DNv4uw6odwIRG7vWflCmk5RU6hF2O4DtCPpaIx/hyHRbg
	hqfU62+wtfL18+NQfs6Kk838QG0xYxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707329622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNNR2C2S8ckO8T2jS3L5HyHOHI9cQbyncIQ0RXIxN9U=;
	b=wD9lp1FBEGqUxS0ApDR1Y4/P8it1ZRsrFHJUuy5RMdJr0n9fFOQ7tNWd3/1e1cy4DpEREJ
	wtPCdzUMK76uh7CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707329622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNNR2C2S8ckO8T2jS3L5HyHOHI9cQbyncIQ0RXIxN9U=;
	b=k9puPfw6kR/Jm4Sj31+G+DE1Jks2LZUYTS3kIJlmPL+YVnTgzcDewJRf0nhd9zrHITjwxc
	wL1t6bWWv2oz82c7VgXZLPdK7DNv4uw6odwIRG7vWflCmk5RU6hF2O4DtCPpaIx/hyHRbg
	hqfU62+wtfL18+NQfs6Kk838QG0xYxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707329622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNNR2C2S8ckO8T2jS3L5HyHOHI9cQbyncIQ0RXIxN9U=;
	b=wD9lp1FBEGqUxS0ApDR1Y4/P8it1ZRsrFHJUuy5RMdJr0n9fFOQ7tNWd3/1e1cy4DpEREJ
	wtPCdzUMK76uh7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 798781326D;
	Wed,  7 Feb 2024 18:13:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id twNUGlbIw2U/bAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 07 Feb 2024 18:13:42 +0000
Date: Wed, 07 Feb 2024 19:13:41 +0100
Message-ID: <877cjg5ei2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?Jean-Lo=EFc?= Charroud <lagiraudiere+linux@free.fr>
Cc: Takashi Iwai <tiwai@suse.de>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound <linux-sound@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	patches <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: cs35l41: Fix internal speaker support for ASUS UM3402 with missing DSD
In-Reply-To: <4879c094-5fdc-4fe4-a7ba-21168d7b2afe@free.fr>
References: <726559913.576332068.1707239153891.JavaMail.zimbra@free.fr>
	<87o7cs5r29.wl-tiwai@suse.de>
	<1366935939.585144512.1707316246651.JavaMail.zimbra@free.fr>
	<87jzng5mzv.wl-tiwai@suse.de>
	<4879c094-5fdc-4fe4-a7ba-21168d7b2afe@free.fr>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[free.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[linux];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[free.fr];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Wed, 07 Feb 2024 18:48:13 +0100,
Jean-Loïc Charroud wrote:
> 
> Le 07/02/2024 à 16:10, Takashi Iwai a écrit :
> > Jean-Loïc Charroud wrote:
> >> Fix device ID for "ASUS UM3402" and "ASUS UM6702RA/RC".
> > This change is only about the string in the table, not the actual
> > behavior, right?
> 
> Well, not sure it doesn't matter.
> Before the device ID were swapped, my syslog reported :
>     cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Error: ACPI _DSD
>     Properties are missing for HID CSC3551.
> And then, after the patch 51d976079976c800ef19ed1b542602fcf63f0edb, it
> reports :
>     cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Failed property
>     cirrus,dev-index: -22
> So, as it looks like a regression, it makes me think that the model name
> may be checked along the device ID...

It can't be.  The name string is discarded (not compiled at all)
unless CONFIG_SND_DEBUG is set, so it's really optional.

That is, the swap of the name strings must not influence on the driver
behavior.  Try it out.

So, splitting the patches into logical pieces helps to improve the
understanding of the problems more clearly.  You see the effect.

> > The name string there is only for debug info, so
> > it's no big problem even if it's not 100% right.
> > That is, this can be again split to another patch -- with the
> > additional Fixes tag to the commit that introduced the entries.
> > 
> >> Add DSD values for "ASUS UM3402" to cs35l41_config_table[].
> > ... and this one is the mandatory fix for your device.  It should be
> > the patch 1.  Then we'll have two more, one for correcting the entry
> > names, and another for sorting the entries.
> I already submitted that last one
> > 
> > I'm a bit picky, but now you see how the things work.
> > Divide-and-conquer is the basic strategy.
> Yes, but not smooth, as I have to workaround my broken mailer...

Good that you spotted out, it had to be fixed in anyway :)


Takashi

