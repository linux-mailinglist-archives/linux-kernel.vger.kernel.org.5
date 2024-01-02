Return-Path: <linux-kernel+bounces-14518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462FB821E31
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82A7283A20
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC73812E6C;
	Tue,  2 Jan 2024 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BLe5hZh2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8HQatM3L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BLe5hZh2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8HQatM3L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922C612E5A;
	Tue,  2 Jan 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CFE51FCFE;
	Tue,  2 Jan 2024 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704207468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQJI3EG12GWIfcTwJlLIHvQNuwA6baztBnKKGLCuepA=;
	b=BLe5hZh2vZAIsWEZ6udDDTMsYwA3l2he7Z1bAffb4C03EV6TBvdbawrq8svzFhaNhhyf1l
	Tc3JU5hY1rcX0/24IqYrA09x3vF5foJ8sPVpBqTR+C02wDuD1UkSJwZNYfCXYoDfsP6hs1
	ZXZ8td3wME9bEaRbOGioA8KAQFkpF58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704207468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQJI3EG12GWIfcTwJlLIHvQNuwA6baztBnKKGLCuepA=;
	b=8HQatM3Louwk6VNndB2Y1Pxt0LswjG8fT+duwY1L5St520HdluFKXPWkIvQv2P6octpbpA
	/e6gWEJ8R2TTwJDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704207468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQJI3EG12GWIfcTwJlLIHvQNuwA6baztBnKKGLCuepA=;
	b=BLe5hZh2vZAIsWEZ6udDDTMsYwA3l2he7Z1bAffb4C03EV6TBvdbawrq8svzFhaNhhyf1l
	Tc3JU5hY1rcX0/24IqYrA09x3vF5foJ8sPVpBqTR+C02wDuD1UkSJwZNYfCXYoDfsP6hs1
	ZXZ8td3wME9bEaRbOGioA8KAQFkpF58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704207468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQJI3EG12GWIfcTwJlLIHvQNuwA6baztBnKKGLCuepA=;
	b=8HQatM3Louwk6VNndB2Y1Pxt0LswjG8fT+duwY1L5St520HdluFKXPWkIvQv2P6octpbpA
	/e6gWEJ8R2TTwJDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE67C1340C;
	Tue,  2 Jan 2024 14:57:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 59iYMGsklGUBaAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 02 Jan 2024 14:57:47 +0000
Date: Tue, 02 Jan 2024 15:57:47 +0100
Message-ID: <87y1d77pg4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: Andy Chi <andy.chi@canonical.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Kailang Yang <kailang@realtek.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Matthew Anderson <ruinairas1992@gmail.com>,
	Luka Guzenko <l.guzenko@web.de>,
	Yuchi Yang <yangyuchi66@gmail.com>,
	Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for a HP ZBook
In-Reply-To: <ZZO/Az2puwFY5L3R@geday>
References: <20240102024916.19093-1-andy.chi@canonical.com>
	<ZZOQamQsHUR7eEPd@geday>
	<CAEzXkg3YiH_XQGz4vbFc7dptmMSWrVDrALdNJAmmQgWa17PP1A@mail.gmail.com>
	<CAEzXkg1DmR2PJ2SKF8hRdbRaPVVU8eWHjzjXHcJE-KqCU-8wqA@mail.gmail.com>
	<ZZOwVZN7Xn2rIKtB@geday>
	<CAEzXkg0NLYxgKHr4iyoJPU7aZcrtcQFBo3o_K=qHuBpXeyNvbQ@mail.gmail.com>
	<ZZO/Az2puwFY5L3R@geday>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BLe5hZh2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8HQatM3L
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[canonical.com,perex.cz,suse.com,opensource.cirrus.com,realtek.com,ljones.dev,ti.com,gmail.com,web.de,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 4CFE51FCFE
X-Spam-Flag: NO

On Tue, 02 Jan 2024 08:45:07 +0100,
Geraldo Nascimento wrote:
> 
> On Tue, Jan 02, 2024 at 02:59:56PM +0800, Andy Chi wrote:
> > On Tue, Jan 2, 2024 at 2:42 PM Geraldo Nascimento
> > <geraldogabriel@gmail.com> wrote:
> > >
> > > On Tue, Jan 02, 2024 at 01:49:40PM +0800, Andy Chi wrote:
> > > > Hi Geraldo,
> > > > Yes, this model is not yet publicly available, so I can't type the
> > > > full name on this patch.
> > > >
> > > > (change to text plain mode to send out again.)
> > >
> > Hi Geraldo,
> > > Hi Andy, please be kind and next time refrain from top-posting,
> > > as it reverses the attention order for those reading the
> > > discussion for posterity.
> > >
> > Got it, appreciate your feedback.
> > > I think it is reasonable to mention it explicitly as an
> > > upcoming product in order not to cause any confusion and
> > > to make sure there's another janitorial patch later on
> > > filling in the model details.
> > >
> > Should I mention it in the commit message? Or is it ok if I put the
> > model name after it's on the market?
> 
> Andy, in order to clear up any confusion that might arise later on, and
> to maintain high the quality of both code and git meta-information I think
> you should explicitly mention both in the commit info and commit message
> that this is an upcoming product.
> 
> Also, instead of just "HP" in the commit proper, it should say something
> like "Upcoming HP ZBook".
> 
> But that's just my advice, now you need to wait and hear Takashi's advice.
> 
> We should always strive toward striking a healthy balance between companies'
> needs and the public nature of the development of the Linux kernel and ALSA.
> Unfortunately that means some details of upcoming models may end up
> catching up the attention of the specialized press.
> 
> I encourage you to look on the bright side and think of it as free PR ;)

I merged as is now with some comments about the new model.
It's fine with the current patch if the entry will be updated later
with a proper model name; having the code fix before the name
definition would be more important.


thanks,

Takashi

