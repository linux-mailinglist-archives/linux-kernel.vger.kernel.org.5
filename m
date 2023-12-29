Return-Path: <linux-kernel+bounces-13082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5725981FF7A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89ECB1C20E22
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE57C111AB;
	Fri, 29 Dec 2023 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y1SJsrhU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mch25re2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y1SJsrhU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mch25re2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C211700;
	Fri, 29 Dec 2023 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B354022079;
	Fri, 29 Dec 2023 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703853943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I7Wfom3eiZsOxTmsNiOfUqJFjm7nHGnBwz7eB13WVM8=;
	b=Y1SJsrhUaaooLYrM5oqGMT9wqnfNw7LbXg4i3rJkSJrULI0JndLP+e1bOLTLwFgoMYRJKS
	WN/OjKO4Vl4UzlsEVHvHKykt5eBMLhqaClUBMAMzoeiCFwuCLcETnqWcOMbJ40V88ynfTQ
	BuGncbnWFNeC8Q8rSC1Jh6dyfKLUdBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703853943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I7Wfom3eiZsOxTmsNiOfUqJFjm7nHGnBwz7eB13WVM8=;
	b=mch25re2XeVd4pMrCHda6Tuo6sl+ttlPRTb1QHGzlxez5YlCMnxkBU3fKYZMYCNkjnoO04
	l4HMIuq4EKwoRzCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703853943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I7Wfom3eiZsOxTmsNiOfUqJFjm7nHGnBwz7eB13WVM8=;
	b=Y1SJsrhUaaooLYrM5oqGMT9wqnfNw7LbXg4i3rJkSJrULI0JndLP+e1bOLTLwFgoMYRJKS
	WN/OjKO4Vl4UzlsEVHvHKykt5eBMLhqaClUBMAMzoeiCFwuCLcETnqWcOMbJ40V88ynfTQ
	BuGncbnWFNeC8Q8rSC1Jh6dyfKLUdBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703853943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I7Wfom3eiZsOxTmsNiOfUqJFjm7nHGnBwz7eB13WVM8=;
	b=mch25re2XeVd4pMrCHda6Tuo6sl+ttlPRTb1QHGzlxez5YlCMnxkBU3fKYZMYCNkjnoO04
	l4HMIuq4EKwoRzCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BE61133E5;
	Fri, 29 Dec 2023 12:45:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fbsuGXe/jmVaaAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 29 Dec 2023 12:45:43 +0000
Date: Fri, 29 Dec 2023 13:45:43 +0100
Message-ID: <87y1ddxjm0.wl-tiwai@suse.de>
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
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/tas2781: do not use regcache
In-Reply-To: <491aeed0e2eecc3b704ec856f815db21bad3ba0e.1703202126.git.soyer@irl.hu>
References: <491aeed0e2eecc3b704ec856f815db21bad3ba0e.1703202126.git.soyer@irl.hu>
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
X-Spamd-Result: default: False [-1.89 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.79)[99.11%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[ti.com,perex.cz,suse.com,gmail.com,kernel.org,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -1.89
X-Spam-Flag: NO

On Fri, 22 Dec 2023 00:48:56 +0100,
Gergo Koteles wrote:
> 
> There are two problems with using regcache in this module.
> 
> The amplifier has 3 addressing levels (BOOK, PAGE, REG). The firmware
> contains blocks that must be written to BOOK 0x8C. The regcache doesn't
> know anything about BOOK, so regcache_sync writes invalid values to the
> actual BOOK.
> 
> The module handles 2 or more separate amplifiers. The amplifiers have
> different register values, and the module uses only one regmap/regcache
> for all the amplifiers. The regcache_sync only writes the last amplifier
> used.
> 
> The module successfully restores all the written register values (RC
> profile, program, configuration, calibration) without regcache.
> 
> Remove regcache functions and set regmap cache_type to REGCACHE_NONE.
> 
> Link: https://lore.kernel.org/r/21a183b5a08cb23b193af78d4b1114cc59419272.1701906455.git.soyer@irl.hu/
> 
> Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> CC: stable@vger.kernel.org
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Applied to for-linus branch now.  Thanks.


Takashi

