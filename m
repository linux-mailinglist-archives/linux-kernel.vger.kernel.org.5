Return-Path: <linux-kernel+bounces-56809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 130B984CF88
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56711F21110
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B4382D82;
	Wed,  7 Feb 2024 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kvVSuDZB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OOBMScTm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kvVSuDZB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OOBMScTm"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE8A8563A;
	Wed,  7 Feb 2024 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325863; cv=none; b=ZMppKzBMuazSwhLwO41uydk9bjUtHMKk1mYGywVQQxDktzW6Z4CSVYtC/I8fUAiiwKFY0EjiNGUPOToPcLpBobSGYAaRn81yjYcUQ5676AICSZZTwkyUfQ5fSrDPBZyNl0yhWHtOmfvKpe2o/81YLiyxJDH22qzAfwYbzv6qJUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325863; c=relaxed/simple;
	bh=Mt/l8aZUda+KyZuYKq8pIuUmZNY1MPGj3fns3RAVTug=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SzGJmwXRxE8+SoJIqfpKuGEV3AvsMwTRnsDT63c2CX3pwzVcsaVo0xwajiTTtQZVSnN/iedB5UBcMV3P8/jvv8NRNnzaPZzBXryXZx5ci22I+tWP3k/9HhYLGdlSJmXYxmBCT9KWfUK3MGEldkoCTsbT3/rQsrl1I3kwn9a07II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kvVSuDZB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OOBMScTm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kvVSuDZB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OOBMScTm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26E3122308;
	Wed,  7 Feb 2024 17:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707325859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/zuir+lY4KzZdr5irkJPiOYaJbGRlBWIj2gbTROfJ0=;
	b=kvVSuDZBNRnVTP7vkYoB3R1KFKza6GhpgCbKOUa1s7bdWZRfx35ZSfsOaBlf1TqV9jAe9E
	gH17C6NGvwEYaegNCv+GABTDVaXRBlRZf6ahEGt3Lv8Pn6QOL20Tj0erJ4X04l40CQ5baP
	spM3/0bK410TDkmUu+mx+8SKS+tZfvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707325859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/zuir+lY4KzZdr5irkJPiOYaJbGRlBWIj2gbTROfJ0=;
	b=OOBMScTmfxqH+PA6LrFQvKYDgV3mYtnMr6Dh8bQu+rpiASxoK2G4JGfMOwLumV50ubL6Nk
	nTlHvuAU31ChkABg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707325859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/zuir+lY4KzZdr5irkJPiOYaJbGRlBWIj2gbTROfJ0=;
	b=kvVSuDZBNRnVTP7vkYoB3R1KFKza6GhpgCbKOUa1s7bdWZRfx35ZSfsOaBlf1TqV9jAe9E
	gH17C6NGvwEYaegNCv+GABTDVaXRBlRZf6ahEGt3Lv8Pn6QOL20Tj0erJ4X04l40CQ5baP
	spM3/0bK410TDkmUu+mx+8SKS+tZfvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707325859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/zuir+lY4KzZdr5irkJPiOYaJbGRlBWIj2gbTROfJ0=;
	b=OOBMScTmfxqH+PA6LrFQvKYDgV3mYtnMr6Dh8bQu+rpiASxoK2G4JGfMOwLumV50ubL6Nk
	nTlHvuAU31ChkABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD35D13931;
	Wed,  7 Feb 2024 17:10:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wAKqNKK5w2XMWwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 07 Feb 2024 17:10:58 +0000
Date: Wed, 07 Feb 2024 18:10:58 +0100
Message-ID: <87a5oc5hel.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?Jean-Lo=EFc?= Charroud <lagiraudiere+linux@free.fr>
Cc: Takashi Iwai <tiwai@suse.de>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound <linux-sound@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	patches <patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda/realtek: cs35l41: Fix device ID / model name
In-Reply-To: <1618884269.586462178.1707324711030.JavaMail.zimbra@free.fr>
References: <726559913.576332068.1707239153891.JavaMail.zimbra@free.fr>
	<87o7cs5r29.wl-tiwai@suse.de>
	<1366935939.585144512.1707316246651.JavaMail.zimbra@free.fr>
	<87jzng5mzv.wl-tiwai@suse.de>
	<1618884269.586462178.1707324711030.JavaMail.zimbra@free.fr>
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
X-Spam-Score: -0.52
X-Spamd-Result: default: False [-0.52 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-1.72)[93.29%];
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
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[free.fr];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Wed, 07 Feb 2024 17:51:51 +0100,
Jean-Loïc Charroud wrote:
> 
> (un)swap device ID for "ASUS UM3402" and "ASUS UM6702RA/RC".

You need to explain why it's needed.  Was it wrongly done?  Or for
what purpose you swap?

And, here you need to give "Fixes:" tag pointing to the commit that
introduced the change / line.  In this case, it was 51d976079976
("ALSA: hda/realtek: Add quirks for ASUS Zenbook 2022 Models").
It modified the entry 1043:1e2e from "ASUS UM3402" to "ASUS
UM6702RA/RC" and add another entry for "ASUS UM3402" with 104e:1ee2.


thanks,

Takashi

