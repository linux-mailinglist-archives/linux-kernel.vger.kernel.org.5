Return-Path: <linux-kernel+bounces-32981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B218362C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD627B25EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262AA3BB24;
	Mon, 22 Jan 2024 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WmR+wmLp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kvWQqSrW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WmR+wmLp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kvWQqSrW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0564E3B79F;
	Mon, 22 Jan 2024 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924962; cv=none; b=qL7yQc3/QmdyDcnycOvyQxjb/fTr7eOFU1STAcEkpiSFqs+LnW0zYIb3LoDXYb5AU7WLshyUbbtoHjyCcN8fxPpd1WI86jhnH/1HObUWNhzI8qAnuyafs6P/rJ0GIzHbB00VFkuaZc0P1lEzfK52i+HUoiO0B9/EW1L2IR0BBHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924962; c=relaxed/simple;
	bh=3g2UaZk1IE9/7R+6DoJkLt7AksV4fGrXOAwdrHYs2RA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ussP+oACEtmQ3Ppws/UqJKNHDXR1yD1TfOa6IyFKj3ifBUzd3Rcnorn/GKV4Di778XZo4wPStV+Jc4Hk2cpY/dl5zifEJLrSvKLO/qDSxHeIKvWjt/pLpH1FjA85fL23lMbTIFOW6nnR52Natf7+ULqDv8PjrkjgCNc6L+2d29Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WmR+wmLp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kvWQqSrW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WmR+wmLp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kvWQqSrW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B06822257;
	Mon, 22 Jan 2024 12:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705924959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oj+PDVuFXN81uf8Y2pGOBWJODZWMWXISlcAlnKoM3aE=;
	b=WmR+wmLpICymr58PoLhGOoNK1pnp3NmVCn52+7QY0pGClQckCiMEZczuIXVwuJlMgJ66EX
	9NCGXMFexmjPDmCsqSnAv90BO8xK8tD1szMn1lzxAeKgyZfApZCKMRWiGBJxi3RiAhhhie
	93gg8VlZbk9q20+7329muam/GQMxEBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705924959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oj+PDVuFXN81uf8Y2pGOBWJODZWMWXISlcAlnKoM3aE=;
	b=kvWQqSrW3FXheVjuKabXyHeWDhc3hDa4D/VTFvbEfsvC0mOqaSao/hcSdkmtMgU1qfMkHy
	tvdauqBSJW3zp+CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705924959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oj+PDVuFXN81uf8Y2pGOBWJODZWMWXISlcAlnKoM3aE=;
	b=WmR+wmLpICymr58PoLhGOoNK1pnp3NmVCn52+7QY0pGClQckCiMEZczuIXVwuJlMgJ66EX
	9NCGXMFexmjPDmCsqSnAv90BO8xK8tD1szMn1lzxAeKgyZfApZCKMRWiGBJxi3RiAhhhie
	93gg8VlZbk9q20+7329muam/GQMxEBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705924959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oj+PDVuFXN81uf8Y2pGOBWJODZWMWXISlcAlnKoM3aE=;
	b=kvWQqSrW3FXheVjuKabXyHeWDhc3hDa4D/VTFvbEfsvC0mOqaSao/hcSdkmtMgU1qfMkHy
	tvdauqBSJW3zp+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D26AE139A2;
	Mon, 22 Jan 2024 12:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QJnoMV5ZrmXxJQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 22 Jan 2024 12:02:38 +0000
Date: Mon, 22 Jan 2024 13:02:38 +0100
Message-ID: <87bk9dy3s1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andy Chi <andy.chi@canonical.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Kailang Yang <kailang@realtek.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Matthew Anderson <ruinairas1992@gmail.com>,
	Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for HP ZBook Power
In-Reply-To: <20240122074826.1020964-1-andy.chi@canonical.com>
References: <20240122074826.1020964-1-andy.chi@canonical.com>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WmR+wmLp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kvWQqSrW
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.84 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[perex.cz,suse.com,opensource.cirrus.com,realtek.com,ljones.dev,ti.com,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.33)[96.89%]
X-Spam-Score: -2.84
X-Rspamd-Queue-Id: 3B06822257
X-Spam-Flag: NO

On Mon, 22 Jan 2024 08:48:24 +0100,
Andy Chi wrote:
> 
> The HP ZBook Power using ALC236 codec which using 0x02 to
> control mute LED and 0x01 to control micmute LED.
> Therefore, add a quirk to make it works.
> 
> Signed-off-by: Andy Chi <andy.chi@canonical.com>

Thanks, applied.


Takashi

