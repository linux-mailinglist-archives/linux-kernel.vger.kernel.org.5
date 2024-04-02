Return-Path: <linux-kernel+bounces-127425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62361894B26
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEA5282655
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB811B5A0;
	Tue,  2 Apr 2024 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1J8e8PZL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m+428NSt"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789E20B02;
	Tue,  2 Apr 2024 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038447; cv=none; b=irFa7mv7/yi4Q0cxLAIfssu5AMhEd2jMGxf4xSzyvMTS7U1Ss3MpykkcI72zqfI/y9fjz2TjCslI1NN8KpgcIvWNZhg9CwMNVWjQkpwsuAwZZRz8ZZLrhxzMiiWIBUm7om/MALqImizyzhtY2toTwvW9BzlVbYFNEEi2rF+Ussk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038447; c=relaxed/simple;
	bh=vSgNDpsIqNdwM2q7pzpW0xs896tER/hVFCAn9jhArbI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StSFH/+2YQYIrHofR1B8UAM1xfQtLsRflPdXd8o4d7Pvx1NoVuBcYrUbM8SsK1aR11o6JxVaGvNOMwJYV6YcYLQi4iyTf2TodQLldAQ15vS86Jke4o+KLIniTSYku5vPGhAb7UMWzA9YHaMfB2YXGjnrqbA6vFzGbXomD0AY3Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1J8e8PZL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m+428NSt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2244E20C84;
	Tue,  2 Apr 2024 06:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712038444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LIxXxoXIP4P9PQwM12nxsuvm0JoqTs4mYkXj4iPdTUE=;
	b=1J8e8PZL5eo04xLvrqY8xT7NqpOHcBgHU++atEwlkh59FjFuOpc7aBeKB6kE49p0ikAvR9
	iJqdJScdmxwTE2ITGvdU8Pj5lBkwHFiUyYVmFWGONTM14bzDsxQ6Uw9PWaYqYYTyxjCCam
	xiOeVTS4eJBgYyTALklF8OdwbRhjAug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712038444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LIxXxoXIP4P9PQwM12nxsuvm0JoqTs4mYkXj4iPdTUE=;
	b=m+428NStka2t9gXdn0XODGeHN68oCWA6DR4VlqVSGsghx9GzD0k33uMM3AXsJYL7AmABHB
	uEEcj0Xob1ivYzDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B742013A90;
	Tue,  2 Apr 2024 06:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id trhaKyuiC2bwNgAAn2gu4w
	(envelope-from <tiwai@suse.de>); Tue, 02 Apr 2024 06:14:03 +0000
Date: Tue, 02 Apr 2024 08:14:08 +0200
Message-ID: <87zfucs34f.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Luke D. Jones" <luke@ljones.dev>
Cc: tiwai@suse.com,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kailang@realtek.com,
	shenghao-ding@ti.com,
	foss@athaariq.my.id
Subject: Re: [PATCH] ALSA: hda/realtek: cs35l41: Support ASUS ROG G634JYR
In-Reply-To: <20240402015126.21115-1-luke@ljones.dev>
References: <20240402015126.21115-1-luke@ljones.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 2244E20C84
X-Spamd-Result: default: False [-1.24 / 50.00];
	BAYES_HAM(-1.95)[94.78%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.18)[-0.899];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -1.24
X-Spam-Level: 
X-Spam-Flag: NO

On Tue, 02 Apr 2024 03:51:26 +0200,
Luke D. Jones wrote:
> 
> Fixes the realtek quirk to initialise the Cirrus amp correctly and adds
> related quirk for missing DSD properties. This model laptop has slightly
> updated internals compared to the previous version with Realtek Codec
> ID of 0x1caf.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Applied now.  Thanks.


Takashi

