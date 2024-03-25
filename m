Return-Path: <linux-kernel+bounces-117456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1122888AB9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D001F61734
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49E5131E29;
	Mon, 25 Mar 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dFQALtxg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3Jr5cvn4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dFQALtxg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3Jr5cvn4"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23757131BDC;
	Mon, 25 Mar 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383634; cv=none; b=s+mDzPblcqUmgc1/CKwB5b+x4ZoSpZitqARJJVRzEY7O3Pu4tZKz3T/qUyorW+E+P1+yo1xLnoWD7Q+MqGvW1naxo/np/9OJ4XzTaK3fNlyp5Ti9issIwGpIQGXFKvtpozOY7VvEBgUqzGVHFxEEoboqQYbspLjKw1cO+pRWAjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383634; c=relaxed/simple;
	bh=FVbkQCzAdIw4q3itUG9P08Dcata9gXWtTydpboh50RU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7EtJjVe77vzaJB3rgLJsThqiz5+ASvbkRtP8aB1memFViPhavRj+bKcm0oYdIBckpZWwWdGe7VBM2M2X90z+2TqRpJmCoPoh3SMLYpdxNM4P3lpq60y+jfqStCgnoJ8T7mEJdvYhs09cDDUamWxy+Gw40+WrAE/GtL/8DQrCTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dFQALtxg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3Jr5cvn4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dFQALtxg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3Jr5cvn4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 34E423476E;
	Mon, 25 Mar 2024 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711383630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=47zzowitN7FnCAMt8Wzhn4k4ZMZM2cQ36obDnp4K5bw=;
	b=dFQALtxgQrLApuv3dK4Gk/Y1evBLn6QNuDtcFGSoQhHViz9dkWKqEMTg6JyRXRSG/hWtd6
	NJe0Z5pwIpKu6GZeXPobp9tNQSQr9Gz3JPVUPjxfrqMaIIsZkLBOZBttrS2FJRLOHqyltV
	MFIQCNbS5KmNU14Igwb6L+hpKOGfXF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711383630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=47zzowitN7FnCAMt8Wzhn4k4ZMZM2cQ36obDnp4K5bw=;
	b=3Jr5cvn4sJk308DRLI/MyI7PwY0BRTNyQk5dth9jsGmT6eFXlKFVXHFA4/QMYuzIC58xeY
	5PZXJlmIWEBZItAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711383630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=47zzowitN7FnCAMt8Wzhn4k4ZMZM2cQ36obDnp4K5bw=;
	b=dFQALtxgQrLApuv3dK4Gk/Y1evBLn6QNuDtcFGSoQhHViz9dkWKqEMTg6JyRXRSG/hWtd6
	NJe0Z5pwIpKu6GZeXPobp9tNQSQr9Gz3JPVUPjxfrqMaIIsZkLBOZBttrS2FJRLOHqyltV
	MFIQCNbS5KmNU14Igwb6L+hpKOGfXF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711383630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=47zzowitN7FnCAMt8Wzhn4k4ZMZM2cQ36obDnp4K5bw=;
	b=3Jr5cvn4sJk308DRLI/MyI7PwY0BRTNyQk5dth9jsGmT6eFXlKFVXHFA4/QMYuzIC58xeY
	5PZXJlmIWEBZItAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF1A213503;
	Mon, 25 Mar 2024 16:20:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WuaCOE2kAWYTFgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 25 Mar 2024 16:20:29 +0000
Date: Mon, 25 Mar 2024 17:20:31 +0100
Message-ID: <87o7b2waeo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>,
	"Simon Trimmer" <simont@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l56: Raise device name message log level
In-Reply-To: <20240325142937.257869-1-rf@opensource.cirrus.com>
References: <20240325142937.257869-1-rf@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.15
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.15 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.14)[88.64%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dFQALtxg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3Jr5cvn4
X-Rspamd-Queue-Id: 34E423476E

On Mon, 25 Mar 2024 15:29:37 +0100,
Richard Fitzgerald wrote:
> 
> From: Simon Trimmer <simont@opensource.cirrus.com>
> 
> The system and amplifier names influence which firmware and tuning files
> are downloaded to the device; log these values to aid end-user system
> support.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Thanks, applied now.


Takashi

