Return-Path: <linux-kernel+bounces-13656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71699820A6A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14FB9B217D3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 08:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE9B185D;
	Sun, 31 Dec 2023 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HZVxcC/y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T5ztKVj1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HZVxcC/y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T5ztKVj1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D31186C;
	Sun, 31 Dec 2023 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 22E3421DFB;
	Sun, 31 Dec 2023 08:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704011624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4RTRshVREzFDoQShoQSeJ7L1xCrv3rMfCKwpXDSiu4=;
	b=HZVxcC/yybZy9ySs7R1EzckIbpfuTkvqsqaGiunMvFXeP0u/PWrW7ktJmLQO7ihlMWx6rR
	9nuGxmsxp1tD50YZLX7GMmpiSzsurMftAsXFMU4cU2VcTcAUiORHrXmRTC21aQIToX7m0Z
	gsqw7b5xpKmOVAL+CiDLa/B0byxFgbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704011624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4RTRshVREzFDoQShoQSeJ7L1xCrv3rMfCKwpXDSiu4=;
	b=T5ztKVj1Pk/2MNK6+rQHZd7Q0j92pkpdLJfYYfbyMMurDW0n3iYSVV6z6auWlXDEo1xSmE
	wVVRnlF0bfXm6HAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704011624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4RTRshVREzFDoQShoQSeJ7L1xCrv3rMfCKwpXDSiu4=;
	b=HZVxcC/yybZy9ySs7R1EzckIbpfuTkvqsqaGiunMvFXeP0u/PWrW7ktJmLQO7ihlMWx6rR
	9nuGxmsxp1tD50YZLX7GMmpiSzsurMftAsXFMU4cU2VcTcAUiORHrXmRTC21aQIToX7m0Z
	gsqw7b5xpKmOVAL+CiDLa/B0byxFgbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704011624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4RTRshVREzFDoQShoQSeJ7L1xCrv3rMfCKwpXDSiu4=;
	b=T5ztKVj1Pk/2MNK6+rQHZd7Q0j92pkpdLJfYYfbyMMurDW0n3iYSVV6z6auWlXDEo1xSmE
	wVVRnlF0bfXm6HAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B96031398B;
	Sun, 31 Dec 2023 08:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4JsKKmcnkWWkHwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 31 Dec 2023 08:33:43 +0000
Date: Sun, 31 Dec 2023 09:33:43 +0100
Message-ID: <87cyumwz2w.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 0/4] ALSA: hda/tas2781: Add tas2563 support
In-Reply-To: <3933d97638cfe57de5f9651b1f9a168bf88e43a5.camel@irl.hu>
References: <cover.1701906455.git.soyer@irl.hu>
	<cover.1703891777.git.soyer@irl.hu>
	<87il4fwrs1.wl-tiwai@suse.de>
	<3933d97638cfe57de5f9651b1f9a168bf88e43a5.camel@irl.hu>
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.67 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
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
	 FREEMAIL_CC(0.00)[ti.com,perex.cz,suse.com,gmail.com,kernel.org,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[54.96%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="HZVxcC/y";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=T5ztKVj1
X-Spam-Score: 0.67
X-Rspamd-Queue-Id: 22E3421DFB

On Sat, 30 Dec 2023 21:18:06 +0100,
Gergo Koteles wrote:
> 
> Hi Takashi,
> 
> On Sat, 2023-12-30 at 17:59 +0100, Takashi Iwai wrote:
> > Thanks, I guess I'll take this series later for 6.8 unless any
> > objection is raised from reviewers.
> > 
> > But, I'd like to hear clarifications of some points beforehand:
> > 
> > - Did we get consensus about the ACPI HID?  I didn't follow the
> >   previous thread completely.
> > 
> 
> The INT8866 is a (wrong) PNP ID, that should only be used by the owner
> "Interphase Corporation".
> Intel has also mistakenly used the INT PNP prefix in the past, and now
> TI/leNovo.

Yeah, and the question is whether TI / Lenovo recognize the problem
and will avoid such a failure in future again.

> >   Since those models have been already in the market for quite some
> >   time, we'd have to accept "INT8866", I'm afraid.  But it's still
> >   very important to know whether a similar problem can be avoided in
> >   future.
> > 
> > - Will be the firmware files upstreamed to linux-firmware tree later?
> >   Otherwise users will have significant difficulties.
> 
> Shenghao sent the two files to linux-firmware@kernel.org a few days
> ago, but I think the "Allegedly GPLv2+ ... Found in hex form in kernel
> source." Licence needs to be fixed before acceptance.

OK, that sounds promising.

> But even if it is not included in the linux-firmware package, it is
> easier for users to put two files in place per OS installation than
> patching the kernel.

Sure.


thanks,

Takashi

