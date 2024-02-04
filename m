Return-Path: <linux-kernel+bounces-51544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A08848C5B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D98F5B21444
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097AD15AD0;
	Sun,  4 Feb 2024 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c7kSfMDH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WAqqFhlt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="el4UZjvr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oMPicvEC"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B2714A8F;
	Sun,  4 Feb 2024 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707037713; cv=none; b=h83qlFwfcjLmIqkcYo9mmFLf8bCsvwNA/PJFTbj8CYBiYzxFNAVgLE3m6EG317va4ZoqL/YbCSklidhcuv4220hzEf71RFkAakeJTiHxUDdnOvzD1S5GxMAhDzPinKiVY5xMDET+ai3F6im1YOkOTbGoVXG+K0tOFOvIKV9uziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707037713; c=relaxed/simple;
	bh=fnRsaTlq67FXcTEhJ5s4Dz1L+z/4ixVqsmLdVNLWIYU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZePdYYjzNcYE0cBKczLeRgYSdJiDLU3rm9ihs5CXqyYQUgPpfcGEzth3/qB3AsmnkxrgNR36w5bgNKF3sRjjA2Ql5plwWhTCDrgJzChDFSKS1pPdyhpmYxy5UR9Iw0HN8qk8QbfU1FHoqRR1kf+7p78zhtvkFgklBPzUN49LDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c7kSfMDH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WAqqFhlt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=el4UZjvr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oMPicvEC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E341D21DB9;
	Sun,  4 Feb 2024 09:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707037709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8zZk9am+/llx2FeDEWS0fQshv+0W3QWllyxtRYVXBUY=;
	b=c7kSfMDHkhansuGk//Ywvc9n3uV2hjOg1xdoSl3UnVA3o8v2+r+F9eoTEIsyWBbli78L7N
	B43N0XlV44iKZCN3a7T8Hq5cekbUz5wp5MI0UzfC6wlTDszTH1epxqmr/UltA5OVMaM9N+
	M1/5jctR15UNB6lUOgSV0jfMmz5uzOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707037709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8zZk9am+/llx2FeDEWS0fQshv+0W3QWllyxtRYVXBUY=;
	b=WAqqFhltMafA4AyC9dND7m83GW4DuPPWJ+stcc/9FM3DXCzbULegQVc3QsqoN0/u1Imsid
	Bqd9TpHBPxAdHZDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707037708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8zZk9am+/llx2FeDEWS0fQshv+0W3QWllyxtRYVXBUY=;
	b=el4UZjvrhG0sBWO0+GlJ6cG2lIXfPin5ssbVMLevkFFghAA1ZUm0+7HI5zNm0YkhN9mjRX
	QKrquvdDakw7l6/gPpy8c4wCYfDqhTTDjDMDQfwSJXUrYu4XVahfNkvNcMq9AXhblgKcDC
	rulzzSPGKiGLnO1N5oJTstk03g5WC/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707037708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8zZk9am+/llx2FeDEWS0fQshv+0W3QWllyxtRYVXBUY=;
	b=oMPicvEC3PfeSgpbcVPPh3oM/MTk1spcYnquD69ZgISO9T0lKwby9eGZp8loU0sPxG+emz
	SkV91NV3J4GmNHBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84BD91338E;
	Sun,  4 Feb 2024 09:08:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1yNmHgxUv2UvAQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 04 Feb 2024 09:08:28 +0000
Date: Sun, 04 Feb 2024 10:08:28 +0100
Message-ID: <87a5ogbnqr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: remove duplicated CONFIG_SND_PXA2XX_AC97 entry
In-Reply-To: <CAK7LNAQExdrSmucgzj8UHcgvXjKjdLqkiww+cuUN6EBzkJAy3w@mail.gmail.com>
References: <20240204090223.37621-1-masahiroy@kernel.org>
	<CAK7LNAQExdrSmucgzj8UHcgvXjKjdLqkiww+cuUN6EBzkJAy3w@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=el4UZjvr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oMPicvEC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.80 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-1.79)[93.71%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[free.fr,gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[perex.cz,suse.com,vger.kernel.org,zonque.org,gmail.com,free.fr,lists.infradead.org,kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -0.80
X-Rspamd-Queue-Id: E341D21DB9
X-Spam-Flag: NO

On Sun, 04 Feb 2024 10:04:32 +0100,
Masahiro Yamada wrote:
> 
> Maybe, the patch subject "ASoC: pxa:" might be better than "sound:"
> so it matches the change history in this directory.

Yes, care to resubmit with that prefix?


thanks,

Takashi

