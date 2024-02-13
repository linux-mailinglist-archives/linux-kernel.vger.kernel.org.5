Return-Path: <linux-kernel+bounces-63517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6318530AA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2970E284E14
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DA5405D8;
	Tue, 13 Feb 2024 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SZ6UQP7G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RPeGOW7c";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SZ6UQP7G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RPeGOW7c"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF3F3D99C;
	Tue, 13 Feb 2024 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828020; cv=none; b=uUKnfP55jqdjGuoeL/R50WHnO+62IBX0YO6c7ejJ4YPvJoLhg7h+m62mqtfRN6ApdyfkLU607Z+rm86fPrxIxa5nQYIaHTWsVsH/t9TOI6wdS8m6R4uEZo110ByFM3ZvzvxCm4D07s5tyAUnZ8P1MpoEXPGYye4X/a67HWTZDeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828020; c=relaxed/simple;
	bh=nsQaodfl9NJX9KJz9ZaP8kZ32Jiqkz3pOs9LjaG1zic=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTb1dbYR6eWPR4ArR6E87UKs16oV/YHJTCZ4o5PJ+hTXFdMWVD6Wu458ILtAaSxxqSnoGA9ZUtslnpGq5Rikk7Vs9FY5yS8yrbllQ+L3FMUb+xoCi2kEowsSvgAeCfJa7krz2lKy++tT/xrVZ5t8HV9tjRg6ow5WVGsdFLl2x+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SZ6UQP7G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RPeGOW7c; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SZ6UQP7G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RPeGOW7c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2125A21B27;
	Tue, 13 Feb 2024 12:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707828017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0EbfyZcM04yRKW1xDvxiAp8kbWKb8cV4YUngr0YREg=;
	b=SZ6UQP7GpocFP6VMllvIikAFdA8uo6KIg5f04SHTEFNbVedmnQx4Rwis/SzgoijLdiBtJ1
	aIhge8NxNbe1nH7r5IwURQXsE/xvJNKIgzGT1N3LwgoqQbIjS3ZY53WPd94EFrs1/6YlDA
	g+P5MNN1vHgBHHTo/9BTpgM01hhOowM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707828017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0EbfyZcM04yRKW1xDvxiAp8kbWKb8cV4YUngr0YREg=;
	b=RPeGOW7c1E8i7WgZyS3A+AOH0GWCZHTLt0UvU2dmMI89L1KzW9hXxUJAgv1dx4jT3MFLvc
	xL0drZvFPA671wAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707828017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0EbfyZcM04yRKW1xDvxiAp8kbWKb8cV4YUngr0YREg=;
	b=SZ6UQP7GpocFP6VMllvIikAFdA8uo6KIg5f04SHTEFNbVedmnQx4Rwis/SzgoijLdiBtJ1
	aIhge8NxNbe1nH7r5IwURQXsE/xvJNKIgzGT1N3LwgoqQbIjS3ZY53WPd94EFrs1/6YlDA
	g+P5MNN1vHgBHHTo/9BTpgM01hhOowM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707828017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0EbfyZcM04yRKW1xDvxiAp8kbWKb8cV4YUngr0YREg=;
	b=RPeGOW7c1E8i7WgZyS3A+AOH0GWCZHTLt0UvU2dmMI89L1KzW9hXxUJAgv1dx4jT3MFLvc
	xL0drZvFPA671wAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF69F13404;
	Tue, 13 Feb 2024 12:40:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sO8GNjBjy2W6DAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Feb 2024 12:40:16 +0000
Date: Tue, 13 Feb 2024 13:40:16 +0100
Message-ID: <87jzn8y1u7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Tomasz Kudela <ramzes005@gmail.com>
Cc: sbinding@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	andy.chi@canonical.com,
	david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	kailang@realtek.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	luke@ljones.dev,
	patches@opensource.cirrus.com,
	perex@perex.cz,
	rf@opensource.cirrus.com,
	ruinairas1992@gmail.com,
	shenghao-ding@ti.com,
	tiwai@suse.com,
	vitalyr@opensource.cirrus.com
Subject: Re: [PATCH v3] Add Lenovo Legion 7i gen7 sound quirk
In-Reply-To: <20240213115614.10420-1-ramzes005@gmail.com>
References: <000101da5e63$6a2565e0$3e7031a0$@opensource.cirrus.com>
	<20240213115614.10420-1-ramzes005@gmail.com>
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
X-Spamd-Result: default: False [-1.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[17];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[opensource.cirrus.com,alsa-project.org,canonical.com,cirrus.com,realtek.com,vger.kernel.org,ljones.dev,perex.cz,gmail.com,ti.com,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.69)[98.66%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.79

On Tue, 13 Feb 2024 12:56:14 +0100,
Tomasz Kudela wrote:
> 
> From: "Tomasz Kudela" <ramzes005@gmail.com>
> 
> Add sound support for the Legion 7i gen7 laptop (16IAX7).
> 
> Signed-off-by: Tomasz Kudela <ramzes005@gmail.com>

You tested with this new patch and confirmed it's still working,
right?  Just to be sure.
 

Takashi

