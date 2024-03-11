Return-Path: <linux-kernel+bounces-98531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F53877B91
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074441F21A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E960D11725;
	Mon, 11 Mar 2024 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f7lgkKtM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I6y/si1t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f7lgkKtM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I6y/si1t"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0CF10A22;
	Mon, 11 Mar 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710144906; cv=none; b=Ws/y1xfnGghrCusondz2fYDeazGUKNhE2YvwBtRagl2KtmT6zgpPo98NCzBB2K7Dh3PNJyPvwQfsIBmOMY1erDjmAgrWylgLvbX8UDr5ZTe8rW9zNEfjzM7jOmPBiTR2b1eCmbc3GWqXiM0APFznoePLH2o2wG8/LqTYMapYJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710144906; c=relaxed/simple;
	bh=FVllI8QtFIZjIjnFvsA8JdzVNs0CfuBSrBpd59Qk24M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2u3AhrQSVGzvClRIqJRIhZ4L+Od7ZXxY37FHYGDKu5OkHMJx3Qs7qVkT3sNSjqmm/op1wdG78Oc8RKbqleK9BcHw/F1woo6Kps84/hFZWyQT/Uq6fWOuhBuChHoNst5D7EPaHyOTNBLBlut64VnGoe1UrzgGyZ7PdAP4AcF3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f7lgkKtM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I6y/si1t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f7lgkKtM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I6y/si1t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BAE59349CA;
	Mon, 11 Mar 2024 08:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710144902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjwpVhv0qVF2xZiPxWjWjVpiLGlOhSeZIiEq/w2dGR4=;
	b=f7lgkKtMwMV2hIDIYXvXVPR9zINayVgPSLIq9mR5P5vQi+rabKkfVjr6VCxXDR1wtjGGFd
	WOQedzNpXA2Zbu5dZZSHePjl3DIvs6p6DBYfT4BCJEeDvOks4B8+oY0ONUjrDSTRqXjbth
	8FjDnJan9t07anoDRfgY0MN7MVmlOow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710144902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjwpVhv0qVF2xZiPxWjWjVpiLGlOhSeZIiEq/w2dGR4=;
	b=I6y/si1td0owmJpP1ib1zLHSw9Jmfq0xmPdypbAgjybXc+nOKnZIcZYavk47jEMs3XF7jD
	kZZknlfWx9FDy8Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710144902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjwpVhv0qVF2xZiPxWjWjVpiLGlOhSeZIiEq/w2dGR4=;
	b=f7lgkKtMwMV2hIDIYXvXVPR9zINayVgPSLIq9mR5P5vQi+rabKkfVjr6VCxXDR1wtjGGFd
	WOQedzNpXA2Zbu5dZZSHePjl3DIvs6p6DBYfT4BCJEeDvOks4B8+oY0ONUjrDSTRqXjbth
	8FjDnJan9t07anoDRfgY0MN7MVmlOow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710144902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjwpVhv0qVF2xZiPxWjWjVpiLGlOhSeZIiEq/w2dGR4=;
	b=I6y/si1td0owmJpP1ib1zLHSw9Jmfq0xmPdypbAgjybXc+nOKnZIcZYavk47jEMs3XF7jD
	kZZknlfWx9FDy8Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6865A1383D;
	Mon, 11 Mar 2024 08:15:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VFWoF4a97mXeaAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 11 Mar 2024 08:15:02 +0000
Date: Mon, 11 Mar 2024 09:15:01 +0100
Message-ID: <87plw1b2wq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] ALSA: hda/tas2781: restore power state after system_resume
In-Reply-To: <cover.1709918447.git.soyer@irl.hu>
References: <cover.1709918447.git.soyer@irl.hu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=f7lgkKtM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="I6y/si1t"
X-Spamd-Result: default: False [-1.75 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.44)[97.42%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -1.75
X-Rspamd-Queue-Id: BAE59349CA
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Fri, 08 Mar 2024 18:41:39 +0100,
Gergo Koteles wrote:
> 
> This series makes some simplifications, speeding up the start of the 
> playback and restoring the power state of the amplifiers after 
> system_resume.
> 
> Gergo Koteles (5):
>   ALSA: hda/tas2781: use dev_dbg in system_resume
>   ALSA: hda/tas2781: add lock to system_suspend
>   ALSA: hda/tas2781: do not reset cur_* values in runtime_suspend
>   ALSA: hda/tas2781: do not call pm_runtime_force_* in
>     system_resume/suspend
>   ALSA: hda/tas2781: restore power state after system_resume

Applied all patches now.  Thanks.


Takashi

