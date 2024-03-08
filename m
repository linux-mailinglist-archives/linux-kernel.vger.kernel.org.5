Return-Path: <linux-kernel+bounces-97382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0458769D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22437B21345
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EBA381B8;
	Fri,  8 Mar 2024 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q3v8WJFx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JabkKrle";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q3v8WJFx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JabkKrle"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A71170F;
	Fri,  8 Mar 2024 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918889; cv=none; b=pQOSqnswB+gOIoGcc35fLzTzc7XATqSN1HH2q354C1uRwowMj/bhg0tEloXqo4LoSJ5Xc+11UFzwutlG6eXjUlFoLcZfhq6T89SdJMKfOWAYxoogiwzM3H27S1OBoyPHvF4OUlupJvCjjtlaHSIMIBS9AMeJfIFSLzPE/j3RUpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918889; c=relaxed/simple;
	bh=jSd7IIXQ7VLOmg5dOyp3aWtcasoACFv/Wzn1lQdNPGQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFVlPtExfnBMtfkOdxSaZAUg1Lcy3ziZ91i3jvNaWKnI4NYhCUcbBctQPeptTqte6tdP6Si9lr+xvlwtgfjJSXE20LmiPTK8gANfY8i5x0sXBxxEGIq6jrQmrRi86JPZ7m+4+8R3twACfA7YdBKh9aF70Wiyn4WxPV5FbDSRdIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q3v8WJFx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JabkKrle; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q3v8WJFx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JabkKrle; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 32C7F38984;
	Fri,  8 Mar 2024 17:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709917300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JplA17DpVz2NSdYvWMuTpMBcFjE3T30ebSwmXrG1t4E=;
	b=Q3v8WJFx7o2fsPQpSOC/SLdlrPBcMqqbM6FKV/IVhO/MwGfFJJj26pmz4LyhP1E1Bp8rlY
	pldcsGR/3ihuclHzqHasc4eqEx87v58Iq+umN6WBJ3G5ZmWQGzBISyzBrKQbT/959FidAs
	U2rTWXmsUjBo/XeO+r1UtYvIs2xmU3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709917300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JplA17DpVz2NSdYvWMuTpMBcFjE3T30ebSwmXrG1t4E=;
	b=JabkKrleE3jFzGoB6O82N27VgsmfyaAH0LcGEa2IiIIVG+usEXnMxjUP9EFgUgriAlTnsX
	YoOL9JKpQtqZkoDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709917300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JplA17DpVz2NSdYvWMuTpMBcFjE3T30ebSwmXrG1t4E=;
	b=Q3v8WJFx7o2fsPQpSOC/SLdlrPBcMqqbM6FKV/IVhO/MwGfFJJj26pmz4LyhP1E1Bp8rlY
	pldcsGR/3ihuclHzqHasc4eqEx87v58Iq+umN6WBJ3G5ZmWQGzBISyzBrKQbT/959FidAs
	U2rTWXmsUjBo/XeO+r1UtYvIs2xmU3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709917300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JplA17DpVz2NSdYvWMuTpMBcFjE3T30ebSwmXrG1t4E=;
	b=JabkKrleE3jFzGoB6O82N27VgsmfyaAH0LcGEa2IiIIVG+usEXnMxjUP9EFgUgriAlTnsX
	YoOL9JKpQtqZkoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDB0A133DC;
	Fri,  8 Mar 2024 17:01:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PvNnMHNE62XTYgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 08 Mar 2024 17:01:39 +0000
Date: Fri, 08 Mar 2024 18:01:38 +0100
Message-ID: <87bk7od5e5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <broonie@kernel.org>,
	<tiwai@suse.com>,
	<hdegoede@redhat.com>,
	<lenb@kernel.org>,
	<rafael@kernel.org>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>,
	<platform-driver-x86@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 0/3] ALSA: Add support for Cirrus Logic CS35L54 and CS35L57
In-Reply-To: <20240308135900.603192-1-rf@opensource.cirrus.com>
References: <20240308135900.603192-1-rf@opensource.cirrus.com>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Q3v8WJFx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JabkKrle
X-Spamd-Result: default: False [-2.82 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[suse.de:dkim];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.51)[91.76%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -2.82
X-Rspamd-Queue-Id: 32C7F38984
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Fri, 08 Mar 2024 14:58:57 +0100,
Richard Fitzgerald wrote:
> 
> The CS35L54 and CS35L57 are Boosted Smart Amplifiers. The CS35L54 has
> I2C/SPI control and I2S/TDM audio. The CS35L57 also has SoundWire
> control and audio.
>     
> The hardware differences between L54, L56 and L57 do not affect the
> driver control interface so they can all be handled by the same driver.
> 
> The HDA patch has build dependencies on the ASoC patch.
> 
> The final patch updates serial-multi-instantiate and scan.c to trap
> the ACPI HID for HDA systems that declare multiple amps all under one
> Device() node. This patch does not have any build dependency on the
> first two patches so can be taken separately.
> 
> Simon Trimmer (3):
>   ASoC: cs35l56: Add support for CS35L54 and CS35L57
>   ALSA: hda: cs35l56: Add support for CS35L54 and CS35L57
>   platform/x86: serial-multi-instantiate: Add support for CS35L54 and
>     CS35L57

Applied all three patches to for-next branch now.


thanks,

Takashi

