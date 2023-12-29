Return-Path: <linux-kernel+bounces-13083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BB581FF7B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794F11F21663
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2A9111A9;
	Fri, 29 Dec 2023 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j07wtth6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DQrZ7hF6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j07wtth6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DQrZ7hF6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1851119E;
	Fri, 29 Dec 2023 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 124922208C;
	Fri, 29 Dec 2023 12:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703853961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7B4LW+mQKTLiF9B7ExmNOsvLkn97hrOWGwMnemgkAoI=;
	b=j07wtth64fr63hE9x6uboChfrO6ks1o51CZDIEkwX0u5wMJJMTqciPRGyZs8t7rrygElet
	yVcFP/06+1LCmPHprzLqFt15nEupBYMeZ/cyhev/i9tEPTpWW5QBTmSrIES9+l67zUdz/T
	6eafXx6h9wklgV1RCDIB2L8Cd7RHdIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703853961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7B4LW+mQKTLiF9B7ExmNOsvLkn97hrOWGwMnemgkAoI=;
	b=DQrZ7hF6xl3NRT0tWENkXX82OV547lHpv6qR+GU/EiDYqjDAwdIbnPSInoBjReL5YYP3I4
	oVabohDwCHNnApCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703853961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7B4LW+mQKTLiF9B7ExmNOsvLkn97hrOWGwMnemgkAoI=;
	b=j07wtth64fr63hE9x6uboChfrO6ks1o51CZDIEkwX0u5wMJJMTqciPRGyZs8t7rrygElet
	yVcFP/06+1LCmPHprzLqFt15nEupBYMeZ/cyhev/i9tEPTpWW5QBTmSrIES9+l67zUdz/T
	6eafXx6h9wklgV1RCDIB2L8Cd7RHdIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703853961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7B4LW+mQKTLiF9B7ExmNOsvLkn97hrOWGwMnemgkAoI=;
	b=DQrZ7hF6xl3NRT0tWENkXX82OV547lHpv6qR+GU/EiDYqjDAwdIbnPSInoBjReL5YYP3I4
	oVabohDwCHNnApCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE397133E5;
	Fri, 29 Dec 2023 12:46:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1qFgK4i/jmVoaAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 29 Dec 2023 12:46:00 +0000
Date: Fri, 29 Dec 2023 13:46:00 +0100
Message-ID: <87wmsxxjlj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/tas2781: fix typos in comment
In-Reply-To: <ead5609d63e71e8e87c13e1767decca5b272d696.1703203812.git.soyer@irl.hu>
References: <ead5609d63e71e8e87c13e1767decca5b272d696.1703203812.git.soyer@irl.hu>
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
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=j07wtth6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DQrZ7hF6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-7.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[99.98%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -7.01
X-Rspamd-Queue-Id: 124922208C
X-Spam-Flag: NO

On Fri, 22 Dec 2023 01:11:54 +0100,
Gergo Koteles wrote:
> 
> Correct typos.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Applied now.  Thanks.


Takashi

