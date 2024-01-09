Return-Path: <linux-kernel+bounces-20964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2DE8287D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C765B2530B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A4F39AE2;
	Tue,  9 Jan 2024 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zgE6ROAX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rdyqfgWD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uG//rdsp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jF1thjI2"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEBD39ACB;
	Tue,  9 Jan 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF13E1F806;
	Tue,  9 Jan 2024 14:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704809631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wpa4DDcUFck9COiGV1cpqENWfAxZcIO+P3YbLq2DPTw=;
	b=zgE6ROAXhe1eVKpqJ/3aZCJA6gAP1+Kxc20TSW/MT50LImr2L+IiYf2cyoUm8tp5QHB1b5
	QZZOrF7ELRAsR5/upPaJMT3yGrU/dpVAHmy/QyjbIdDLfZ9zF0ZFg+whTf1Z9JO9t7qbT/
	OL/JueVdw0c8uGDjlRafp6J28fPqz2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704809631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wpa4DDcUFck9COiGV1cpqENWfAxZcIO+P3YbLq2DPTw=;
	b=rdyqfgWDCE5RrzbTRi8gIyVf9Ue48YTLO8q7piNDOk9EN3lIAJSlS2j5k3j7YORWnWblr2
	M+IGh3O3uZ096kCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704809630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wpa4DDcUFck9COiGV1cpqENWfAxZcIO+P3YbLq2DPTw=;
	b=uG//rdspZ85/CJGw21d6Q7HcwBQosT8Glqofv25l10s2Qy6uDVv1LC8nN9KH0Zn0B4vozh
	Gp0WmLHkAR9kz2Ff+QSBQm7N1OtKykIO27x9iB3LGoNh1VQ3GCdNc5IlCuZLtOYn8hWxVw
	L81rjbYOH/9pR5ui1p1J+F/RVR7nxyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704809630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wpa4DDcUFck9COiGV1cpqENWfAxZcIO+P3YbLq2DPTw=;
	b=jF1thjI2BpYUw5JwyFDwsEHARJqmxWsXkayV8Fq/SvexUTuFlWJea227wKJny9vNAdyCAv
	MzUQBq8XLEHYJLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C476134E8;
	Tue,  9 Jan 2024 14:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tPq4IJ5UnWU6BgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 09 Jan 2024 14:13:50 +0000
Date: Tue, 09 Jan 2024 15:13:50 +0100
Message-ID: <87mster3vl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ALSA: hda/tas2781: annotate calibration data endianness
In-Reply-To: <3852ff28ea7d5d8f2086d8dd78aeff8d1d984991.1704748435.git.soyer@irl.hu>
References: <3852ff28ea7d5d8f2086d8dd78aeff8d1d984991.1704748435.git.soyer@irl.hu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.46
X-Spamd-Result: default: False [1.46 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.74)[98.87%]
X-Spam-Flag: NO

On Mon, 08 Jan 2024 22:16:46 +0100,
Gergo Koteles wrote:
> 
> Sparse reports an endian mismatch.
> The amplifier expects the calibration data as big-endian.
> Use the __be32 type to express endianness better.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401072137.Oc7pQgRW-lkp@intel.com/
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Thanks, applied with the additional Fixes tag to the commit.


Takashi

