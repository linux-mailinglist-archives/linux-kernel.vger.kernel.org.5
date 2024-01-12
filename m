Return-Path: <linux-kernel+bounces-24431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179A882BC79
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D311EB22B67
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA6753E14;
	Fri, 12 Jan 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zElDNEeG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jkh4AA8I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zElDNEeG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jkh4AA8I"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C042057;
	Fri, 12 Jan 2024 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B3DE1FC24;
	Fri, 12 Jan 2024 08:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705049178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FKd2vrnCJc+ZSoIlM3guxZ67+jWlztH2KbgryFDlQoo=;
	b=zElDNEeGfpShF+8jwZ26dyAYpEBX+ZHyw7CES1ySvN0Vd1wdf7oOtIkMd/4oFXEiE42s/8
	hpHVbCD0M+pyiD2ETyXP4etpUVqIY2MzVBsUjQZkmfAZ4uFN37nwFQe2/Rodl/v2PFh/kF
	D97r89l6RRt73wCOXS1SecRooT6dhSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705049178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FKd2vrnCJc+ZSoIlM3guxZ67+jWlztH2KbgryFDlQoo=;
	b=Jkh4AA8InzLyeIyFaJBbDLTt+1lgd5eFwy8FyRPww+XUHZnDyNBvuM/RshYV3lnyiYK9s3
	hswbjdDzgxcLVpBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705049178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FKd2vrnCJc+ZSoIlM3guxZ67+jWlztH2KbgryFDlQoo=;
	b=zElDNEeGfpShF+8jwZ26dyAYpEBX+ZHyw7CES1ySvN0Vd1wdf7oOtIkMd/4oFXEiE42s/8
	hpHVbCD0M+pyiD2ETyXP4etpUVqIY2MzVBsUjQZkmfAZ4uFN37nwFQe2/Rodl/v2PFh/kF
	D97r89l6RRt73wCOXS1SecRooT6dhSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705049178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FKd2vrnCJc+ZSoIlM3guxZ67+jWlztH2KbgryFDlQoo=;
	b=Jkh4AA8InzLyeIyFaJBbDLTt+1lgd5eFwy8FyRPww+XUHZnDyNBvuM/RshYV3lnyiYK9s3
	hswbjdDzgxcLVpBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8C3B13782;
	Fri, 12 Jan 2024 08:46:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b0STL1n8oGUSKQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 12 Jan 2024 08:46:17 +0000
Date: Fri, 12 Jan 2024 09:46:17 +0100
Message-ID: <87bk9rndly.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Chancel Liu <chancel.liu@nxp.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	ivan.orlov0322@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: aloop: Introduce a function to get if access is interleaved mode
In-Reply-To: <20240111025219.2678764-1-chancel.liu@nxp.com>
References: <20240111025219.2678764-1-chancel.liu@nxp.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zElDNEeG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Jkh4AA8I
X-Spamd-Result: default: False [-2.74 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 BAYES_HAM(-2.93)[99.70%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[perex.cz,suse.com,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0B3DE1FC24
X-Spam-Level: 
X-Spam-Score: -2.74
X-Spam-Flag: NO

On Thu, 11 Jan 2024 03:52:19 +0100,
Chancel Liu wrote:
> 
> There's a use case that playback stream of a loopback cable works on
> RW_INTERLEAVED mode while capture stream works on MMAP_INTERLEAVED mode:
> 
> aplay -Dhw:Loopback,0,0 S32_48K_2ch.wav;
> arecord -Dplughw:Loopback,1,0 -fS32_LE -r16000 -c2 cap.wav;
> 
> The plug plugin handles only slave PCM support MMAP mode. Not only plug
> plugin but also other plugins like direct plugins(dmix/dsnoop/dshare)
> work on MMAP access mode. In this case capture stream is the slave
> PCM works on MMAP_INTERLEAVED mode. However loopback_check_format()
> rejects this access setting and return:
> 
> arecord: pcm_read:2240: read error: Input/output error
> 
> To fix it a function called is_access_interleaved() is introduced to
> get if access is interleaved mode. If both access of capture stream and
> playback stream is interleaved mode loopback_check_format() will allow
> this kind of access setting.
> 
> Fixes: 462494565c27 ("ALSA: aloop: Add support for the non-interleaved access mode")
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>

Applied now.  Thanks.


Takashi

