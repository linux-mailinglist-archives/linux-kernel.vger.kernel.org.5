Return-Path: <linux-kernel+bounces-27160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F392282EB58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921501F24144
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1471112B6D;
	Tue, 16 Jan 2024 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1RMrtCQy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TukuqNgk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VLyvgA1P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vWs3yONw"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE5125C4;
	Tue, 16 Jan 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1D114220EE;
	Tue, 16 Jan 2024 09:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705396566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ArBPrKm5RcSvKqAvi/Mho8YH7n96j32xhTlGZo9rzwg=;
	b=1RMrtCQyHfB8sADu4/vlCFSJtdnUcuinAPB1IeQgO6zKsTc4EmHUzunIR7JCF0DDQXyByD
	0ZifjNGr/j80aEQGqlZSe0GLvLmRt0b5Ok0iYY3qlxEnqWq44Uh32t1w7caC4yr/uqlBy7
	iumqNQ96z+XamdO3Ir9BRzgVoYRg2Co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705396566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ArBPrKm5RcSvKqAvi/Mho8YH7n96j32xhTlGZo9rzwg=;
	b=TukuqNgktlkFrEgCQe1Wsb7Y2hK0OKsZRilVErdcC/E6L8YptvIQVD396FpyZX6a1jr04D
	VvhfhQR54/RNLfAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705396565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ArBPrKm5RcSvKqAvi/Mho8YH7n96j32xhTlGZo9rzwg=;
	b=VLyvgA1Pp24mv7CFm7gEAQzSDfGct2BhfgNM7JffdZu6eFQ0vnhgmZZFcrkzj8vqqaRccg
	zA2mNMkDN9m/RuIULu1R/vWqL7ofU5A768cJO+NEaMVql3VMdhZWrUpMaUvEw4DTjCpynT
	kE0bqcuElbzHapC/Gav2U2TXfLGRClg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705396565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ArBPrKm5RcSvKqAvi/Mho8YH7n96j32xhTlGZo9rzwg=;
	b=vWs3yONwGjyVOu4q4wBmnONccSVmiAp5CvGKUk5MCHp10gONqJhlPS1Dh8CuXWneXKwP49
	AcEb0SYKsx0i7PBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2E08132FA;
	Tue, 16 Jan 2024 09:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qcdMJlRJpmUsDwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 16 Jan 2024 09:16:04 +0000
Date: Tue, 16 Jan 2024 10:16:04 +0100
Message-ID: <8734uxwsdn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Yo-Jung Lin <leo.lin@canonical.com>
Cc: andy.chi@canonical.com,
	0xff07@gmail.com,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Kailang Yang <kailang@realtek.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Matthew Anderson <ruinairas1992@gmail.com>,
	Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable mute/micmute LEDs and limit mic boost on HP ZBook
In-Reply-To: <20240116020722.27236-1-leo.lin@canonical.com>
References: <20240116020722.27236-1-leo.lin@canonical.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.48
X-Spamd-Result: default: False [-2.48 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[canonical.com,gmail.com,perex.cz,suse.com,opensource.cirrus.com,realtek.com,ljones.dev,ti.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.18)[96.07%]
X-Spam-Flag: NO

On Tue, 16 Jan 2024 03:07:19 +0100,
Yo-Jung Lin wrote:
> 
> On some HP ZBooks, the audio LEDs can be enabled by
> ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF. So use it accordingly.
> 
> Signed-off-by: Yo-Jung Lin <leo.lin@canonical.com>

Thanks, applied now.


Takashi

