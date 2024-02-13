Return-Path: <linux-kernel+bounces-63036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 853D1852995
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1612AB2304F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117DF171D8;
	Tue, 13 Feb 2024 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fHAkAZ0E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uxQoIPVl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fHAkAZ0E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uxQoIPVl"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1817589;
	Tue, 13 Feb 2024 07:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707808380; cv=none; b=T2dtcOK75/5qbwk6jo8GZFaVo4nz3+hqYmlPIvpvrmuwHZWehjlvFBDnHFtTc1JONDa19DOEmtQLk8LicP2i97AR+q/ugokqn2903okZFPfKZ1JnAYvD2sbcTHGMVzLfCMMrOhXzFexo9e6X9AwpkjUtTuLOdyNo7EvEGGghLu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707808380; c=relaxed/simple;
	bh=+vzgJHGB21CmFNaPwMTlSN7copnCy4aT9rIMOVIU3rw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgzh7hZWLeNMOFqjyw2W2tQKKkCDUST+Qg1fWTmTAFRP8Yb4lEIi/7R1RSsG/fEEsqGMA7IYDHoG+UNGEpLMzE4SShS9wl7eS0+6SkuEyEPNT17GZATMnlOyLzw/wCrzZ6I+hYO+Pjgbs25lv/GsZJeu+Y60MS8e0qM7F6LSQi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fHAkAZ0E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uxQoIPVl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fHAkAZ0E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uxQoIPVl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C2661F7D4;
	Tue, 13 Feb 2024 07:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707808376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V2HMBYlo6MPzo/mOplX1T0/FFqhj2lYh2wTDDLwynds=;
	b=fHAkAZ0EOM9dLUSBKkYKZfBibV94nUy4Uf5+LlDe8xiZvzoRQeJxqQZXe0XUSDFBo1mFTH
	ghlC5/TxNAmaviSRxrDaKddEWCvsGfbZDBkKeMaAZ7UDsrIG7/EKAm7masWTfEKt30MQ22
	CRW/B2Impffmw2Lr/qRKxsfUAQ8KZmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707808376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V2HMBYlo6MPzo/mOplX1T0/FFqhj2lYh2wTDDLwynds=;
	b=uxQoIPVlQVrX9wvqHh6EgUIHqdrDgzmD0HHGmkjn2GlB31nQdTjowE+CBPIbDmdHwKnuuv
	g29WU73PW9/yJeBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707808376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V2HMBYlo6MPzo/mOplX1T0/FFqhj2lYh2wTDDLwynds=;
	b=fHAkAZ0EOM9dLUSBKkYKZfBibV94nUy4Uf5+LlDe8xiZvzoRQeJxqQZXe0XUSDFBo1mFTH
	ghlC5/TxNAmaviSRxrDaKddEWCvsGfbZDBkKeMaAZ7UDsrIG7/EKAm7masWTfEKt30MQ22
	CRW/B2Impffmw2Lr/qRKxsfUAQ8KZmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707808376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V2HMBYlo6MPzo/mOplX1T0/FFqhj2lYh2wTDDLwynds=;
	b=uxQoIPVlQVrX9wvqHh6EgUIHqdrDgzmD0HHGmkjn2GlB31nQdTjowE+CBPIbDmdHwKnuuv
	g29WU73PW9/yJeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E59E513404;
	Tue, 13 Feb 2024 07:12:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0bPaNncWy2XLNgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Feb 2024 07:12:55 +0000
Date: Tue, 13 Feb 2024 08:12:55 +0100
Message-ID: <87il2skfbc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "T. Kudela" <ramzes005@gmail.com>
Cc: james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	luke@ljones.dev,
	andy.chi@canonical.com,
	shenghao-ding@ti.com,
	ruinairas1992@gmail.com,
	vitalyr@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Lenovo Legion 7i gen7 sound quirk
In-Reply-To: <20240212193327.59507-1-ramzes005@gmail.com>
References: <20240212193327.59507-1-ramzes005@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fHAkAZ0E;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uxQoIPVl
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.07 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	 RCPT_COUNT_TWELVE(0.00)[17];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[cirrus.com,opensource.cirrus.com,perex.cz,suse.com,realtek.com,ljones.dev,canonical.com,ti.com,gmail.com,alsa-project.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.56)[98.05%]
X-Spam-Score: -3.07
X-Rspamd-Queue-Id: 5C2661F7D4
X-Spam-Flag: NO

On Mon, 12 Feb 2024 20:33:27 +0100,
T. Kudela wrote:
> 
> Add sound support for the Legion 7i gen7 laptop (16IAX7).
> 
> Signed-off-by: T. Kudela <ramzes005@gmail.com>

Use a full real name for your sign-off, as it's a legal requirement.


thanks,

Takashi

