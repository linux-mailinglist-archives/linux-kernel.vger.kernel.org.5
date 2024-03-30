Return-Path: <linux-kernel+bounces-125621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029698929B9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1181C20F89
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 08:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE69C883C;
	Sat, 30 Mar 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TEgOtIQ1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c+kTOGDy"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAA1179;
	Sat, 30 Mar 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788031; cv=none; b=mmYsMTeexsIMzTT6UwsmQUqaDrubWy+E/WrfftWjO3b1aJTfnHAIQqi8H8pfRLbBMcZc/7E9AWdiUicq4VJdD5rLaOpP0Cq/wESFJ4HRQFFmDo5wO/24IQBhkL61czdrKNsm/zfpZcFR+W9n2dBw1YBEzEIYBd486gNdx/oa+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788031; c=relaxed/simple;
	bh=0yrqjuNnlfumpGwdRGoXq9Rorc75sw1LbVM5vR15tUU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sz/53kaOw35/VtQh/5q+FzUv9HCBxvC/bEWdYdN88tmmppGcOKtDWOQi3gtuzFTdlMTQjf2eRNUr+G5yxxdE1YLFDmThVjWAzAhWH2NbGtifDQBjEidDjm8yqRJt/9jPXgMBX/o9K+I9rT1HBu9zHQ/tvRgz8n/YItLfHfI+BvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TEgOtIQ1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c+kTOGDy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D16A85D2D6;
	Sat, 30 Mar 2024 08:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711788027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NzIUrhYo1Cw3sQoKqYI3sYPX+W+/DiYB3PH1BSBVBeI=;
	b=TEgOtIQ1tUxkHmfRxUIzpjfCJ3C6lgskMHwHPy5ejZV6lNgdzDf1PyZIi9pZ5jp9T6BaNJ
	BcJ1//TjBNg4ZPJo1ZMyY88HgPotfT0KCZPhvMbSVw5R/Neyj1b4Zhk9fIMbjEVRkOPjzW
	YOQCXZbX4RTvyeI3WOrqwwx5k3+/62g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711788027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NzIUrhYo1Cw3sQoKqYI3sYPX+W+/DiYB3PH1BSBVBeI=;
	b=c+kTOGDycv9C1pQlfnNWcLXNoxBpi+vwt2BmrSb1tly4iEilgURPqdeUCrZ3uC5oWZHihK
	KtnYWPp036IWKdAQ==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F09613A90;
	Sat, 30 Mar 2024 08:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id xwYLIfvPB2b7bgAAn2gu4w
	(envelope-from <tiwai@suse.de>); Sat, 30 Mar 2024 08:40:27 +0000
Date: Sat, 30 Mar 2024 09:40:30 +0100
Message-ID: <87o7awnmdd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <broonie@kernel.org>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH 0/5] ALSA: cirrus: Tidy up of firmware control read/write
In-Reply-To: <20240325113127.112783-1-rf@opensource.cirrus.com>
References: <20240325113127.112783-1-rf@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-0.60 / 50.00];
	BAYES_HAM(-1.30)[90.11%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -0.60
X-Spam-Level: 
X-Spam-Flag: NO

On Mon, 25 Mar 2024 12:31:22 +0100,
Richard Fitzgerald wrote:
> 
> This set of patches factors out some repeated code to clean up
> firmware control read/write functions, and removes some redundant
> control notification code.
> 
> Simon Trimmer (5):
>   firmware: cs_dsp: Add locked wrappers for coeff read and write
>   ASoC: wm_adsp: Use cs_dsp_coeff_lock_and_[read|write]_ctrl()
>   ALSA: hda: hda_cs_dsp_ctl: Use
>     cs_dsp_coeff_lock_and_[read|write]_ctrl()
>   ASoC: wm_adsp: Remove notification of driver write
>   ALSA: hda: hda_cs_dsp_ctl: Remove notification of driver write

The patch 4 doesn't look cleanly applicable to my tree.
Should it be applied via Mark's tree?


thanks,

Takashi

