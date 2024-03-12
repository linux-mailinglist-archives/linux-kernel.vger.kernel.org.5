Return-Path: <linux-kernel+bounces-100177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E1879304
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CC01C20EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D2F79B88;
	Tue, 12 Mar 2024 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DG5PmHu/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kkwonUXt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="msxMbRZM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FRR9LtLm"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB020304;
	Tue, 12 Mar 2024 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710243069; cv=none; b=bHdJn2glt+GmQedoxL8XzDL522FQewVFnbozD5qwR+Hyb90796uFeULAIQ7kdY/RkD06B8pdCSSS16tBtfKZtvxjE4RO/p/YxS3HER6kuNhEHFZY7Y7uySmZa6rGI8uQrnkSeirdUZAL+72CNU75p0jJfgrkNpLPaXavahIabqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710243069; c=relaxed/simple;
	bh=MP0JRLNxFjkIuQaCWUsq/84138rYzlZEgnBzrBtF1Dk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCoF563kTGEDzCiP3Vz+nBSV9Q7zd+YYUTJZIrjsmXiWeeUP1r4/6+ykWxAJVPpj/ENHKaseXMCNOnoyZ8PLdx0GhpWmZUvSU977eHMgsVxHLRTy+AYdgpaZy6s0jPgdeJXh7RiqgQv0uHxNofnt0wTFWkQf6Bwkg+zYbT2BEn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DG5PmHu/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kkwonUXt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=msxMbRZM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FRR9LtLm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 124C1375E6;
	Tue, 12 Mar 2024 11:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710243065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUWeccaaobTK6qF95MjlX9Yi3J/YlTM7KHg6Q4pDQSo=;
	b=DG5PmHu/HNZtYAtOLO8hEhxShe0kah95ol8onjsuI3H1sW0HPeLeNLMMzIrk9Vf083WQpj
	DvYC+sT9NNkC+r6S7srA7t1T9tPIW2QuyvwaHfpRBAM1FozEl8GvzteoYf8/13GKI5Xwzl
	ggcxY57nYT8RcfC1o39xSJiZMTw5bMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710243065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUWeccaaobTK6qF95MjlX9Yi3J/YlTM7KHg6Q4pDQSo=;
	b=kkwonUXtV/7RgzcoSwNpqG3jRYxywn520vl/qrbOuud1TmO2ylZOm+DV0AeEGEsGRWiCG/
	JLRwfjYl5eFqMlAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710243063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUWeccaaobTK6qF95MjlX9Yi3J/YlTM7KHg6Q4pDQSo=;
	b=msxMbRZMvIWBpD/MxpZ8xqhox6ui94UzMbRXgblprk7RP5kFboHaTpWf/DgezR9c6MA8XB
	9upXk81X6PtHwZkKcwbY1YP+vAnZ7QLwggj3w4P0TExl9HdfO6sRpjmH8UUc4+eY92v4dl
	kgZ61xU1Sb9/YT8q7NbAi12o9LOYhWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710243063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUWeccaaobTK6qF95MjlX9Yi3J/YlTM7KHg6Q4pDQSo=;
	b=FRR9LtLm+/xQBCMD4QaQCxSrxm8B04Kq2MDi7KtAzQX1gKL+eU+IGGxtnDlMNTttvpW8Gd
	gF40WoS/dxmhOeBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED8451364F;
	Tue, 12 Mar 2024 11:31:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A+ovOfY88GVTYQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 12 Mar 2024 11:31:02 +0000
Date: Tue, 12 Mar 2024 12:31:01 +0100
Message-ID: <87v85r6616.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: aaci: Delete unused variable in aaci_do_suspend
In-Reply-To: <20240312-aaci-unused-v1-1-09be643f67c2@linutronix.de>
References: <20240312-aaci-unused-v1-1-09be643f67c2@linutronix.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.90)[99.57%]
X-Spam-Score: -2.00
X-Spam-Flag: NO

On Tue, 12 Mar 2024 12:22:28 +0100,
Thomas Weiﬂschuh wrote:
> 
> The variable aaci is not used anymore and can be deleted.
> 
> Fixes: 792a6c51875c ("[ALSA] Fix PM support")
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
> Note: This only seems to trigger with the series
> "ALSA: Clean up with DEFINE_SIMPLE_DEV_PM_OPS()" applied.
> 
> (Encountered on next-20240312)
> 
> [0] https://lore.kernel.org/all/20240207155140.18238-1-tiwai@suse.de/

Thanks, applied now.


Takashi

