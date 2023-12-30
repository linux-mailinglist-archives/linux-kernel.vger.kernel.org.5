Return-Path: <linux-kernel+bounces-13410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0F78204B1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8BC61C20DA1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6722579EF;
	Sat, 30 Dec 2023 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wp8cm74A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YPc66DdU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wp8cm74A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YPc66DdU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC96B79C2;
	Sat, 30 Dec 2023 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D37CC21D74;
	Sat, 30 Dec 2023 11:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703937529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VpRQsOoqVYZv+qicTdREYXiCPnaI1kN7KRMd0EK1Ppw=;
	b=Wp8cm74AiiBBFO3bvILNvUkFMTypFl02xfk9uIwgnTaodkGVFs+JLTwBg4anasWZa1dGVX
	eLXmz5F25Usd99JZWm3NnyXDdrjVfWHaDfhVJJCBeO7aAlelv7SX4keRI3gx5o52KxUNor
	WqbLriejL8pAoYeIpo/rzAkzpwHG6G4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703937529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VpRQsOoqVYZv+qicTdREYXiCPnaI1kN7KRMd0EK1Ppw=;
	b=YPc66DdURjNKPZml066q+HeJPwvFRiZIzhO4nzeIUhavduStu8z9hd3/q5fjdBIe7iQ1iw
	g+hSuePVDZDX5wBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703937529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VpRQsOoqVYZv+qicTdREYXiCPnaI1kN7KRMd0EK1Ppw=;
	b=Wp8cm74AiiBBFO3bvILNvUkFMTypFl02xfk9uIwgnTaodkGVFs+JLTwBg4anasWZa1dGVX
	eLXmz5F25Usd99JZWm3NnyXDdrjVfWHaDfhVJJCBeO7aAlelv7SX4keRI3gx5o52KxUNor
	WqbLriejL8pAoYeIpo/rzAkzpwHG6G4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703937529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VpRQsOoqVYZv+qicTdREYXiCPnaI1kN7KRMd0EK1Ppw=;
	b=YPc66DdURjNKPZml066q+HeJPwvFRiZIzhO4nzeIUhavduStu8z9hd3/q5fjdBIe7iQ1iw
	g+hSuePVDZDX5wBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B449136D1;
	Sat, 30 Dec 2023 11:58:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WSxpGPkFkGUtUAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 30 Dec 2023 11:58:49 +0000
Date: Sat, 30 Dec 2023 12:58:49 +0100
Message-ID: <87mstrx5om.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dorian Cruveiller <doriancruveiller@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	luke@ljones.dev,
	andy.chi@canonical.com,
	shenghao-ding@ti.com,
	l.guzenko@web.de,
	ruinairas1992@gmail.com,
	yangyuchi66@gmail.com,
	vitalyr@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ALSA:hda/realtek enable SND_PCI_QUIRK for Lenovo Legion Slim 7 Gen 8 (2023) serie
In-Reply-To: <20231230114001.19855-1-doriancruveiller@gmail.com>
References: <20231229230703.73876-1-doriancruveiller@gmail.com>
	<20231230114001.19855-1-doriancruveiller@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [0.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[perex.cz,suse.com,opensource.cirrus.com,realtek.com,ljones.dev,canonical.com,ti.com,web.de,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[46.19%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.89
X-Spam-Flag: NO

On Sat, 30 Dec 2023 12:40:01 +0100,
Dorian Cruveiller wrote:
> 
> Link up the realtek audio chip to the cirrus cs35l41 sound amplifier chip
> on 4 models of the Lenovo legion slim 7 gen 8 (2023). These models are
> 16IRH8 (2 differents subsystem id) and 16APH8 (2 differents subsystem ids).
> 
> Subsystem ids list:
>  - 17AA38B4
>  - 17AA38B5
>  - 17AA38B6
>  - 17AA38B7
> 
> Signed-off-by: Dorian Cruveiller <doriancruveiller@gmail.com>

Applied both patches now.  Thanks.


Takashi

