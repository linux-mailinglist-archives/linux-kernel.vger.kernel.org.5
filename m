Return-Path: <linux-kernel+bounces-166299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2216B8B98BB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E34284623
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC2858236;
	Thu,  2 May 2024 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wtklsYGQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8PRz+hei";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wtklsYGQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8PRz+hei"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00953373;
	Thu,  2 May 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645542; cv=none; b=EZPLJEblAa4gt42UHWXGhccx7cp4xNjqfxdfC5ySX+j4gH1+9j70UB+NeFbXCnBu9b/OSVTNHu2wmoYEGOww5yIDWef9dkDorbgfAzIkuuN47JGOWfjevYRjvXhmfsurxYlZegGopiFm9mPeOZRKue3q8QagHW5H4O67DmcPkIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645542; c=relaxed/simple;
	bh=9TkTZ57YAAxNkPWthAJ9DpDRSGTHMSlyYmnHgN70MRQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJqfetCmssahrIofnKYQm/V/rQUd7iLba4caWyNEebH7TYjEoGXgggYV8W92JvnB61NNSnaxmaew2A0tQ06pF/Vfns4VF2ORHhDjvcNsAoGq1qKZ10W41PVHyZjcto+QrKLHHIfp4LZHC1SYICSO1S8+7DGFBBvuLLe3HOCI+oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wtklsYGQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8PRz+hei; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wtklsYGQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8PRz+hei; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4BA3351D9;
	Thu,  2 May 2024 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714645538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nRNsEWuTL5AgiSXgw65Rfs9x849N3wWjfMiLj4+bsbA=;
	b=wtklsYGQzF6Cm63lDgSKIu0L0JY8LoTvP/AoFzxBCbF7xkEdqOu8IoVjaVNhcRDeNdrioN
	bJJwrfzuegzGjd6bTgMHDhQxVEuMAadiuII9QGkOkzPzgTTF3C8/QIxw6uIcFTG1O18LZQ
	NbJy+b+lmDtrQE9wqfFV9McxLM7uqm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714645538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nRNsEWuTL5AgiSXgw65Rfs9x849N3wWjfMiLj4+bsbA=;
	b=8PRz+heicRrv7NM8CC8qiY3ggk0EhJQwXI5W/UqEXFvRTSNhVMPZlK9eW2jHn+gOV+C63V
	/UhLosmJ02y38vBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714645538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nRNsEWuTL5AgiSXgw65Rfs9x849N3wWjfMiLj4+bsbA=;
	b=wtklsYGQzF6Cm63lDgSKIu0L0JY8LoTvP/AoFzxBCbF7xkEdqOu8IoVjaVNhcRDeNdrioN
	bJJwrfzuegzGjd6bTgMHDhQxVEuMAadiuII9QGkOkzPzgTTF3C8/QIxw6uIcFTG1O18LZQ
	NbJy+b+lmDtrQE9wqfFV9McxLM7uqm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714645538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nRNsEWuTL5AgiSXgw65Rfs9x849N3wWjfMiLj4+bsbA=;
	b=8PRz+heicRrv7NM8CC8qiY3ggk0EhJQwXI5W/UqEXFvRTSNhVMPZlK9eW2jHn+gOV+C63V
	/UhLosmJ02y38vBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7080B1386E;
	Thu,  2 May 2024 10:25:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xj3uGSJqM2bfDgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 02 May 2024 10:25:38 +0000
Date: Thu, 02 May 2024 12:25:51 +0200
Message-ID: <87edakjys0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: 'Richard Fitzgerald'
	<rf@opensource.cirrus.com>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l56: Perform firmware download in the background
In-Reply-To: <001401da9c79$fb9f2de0$f2dd89a0$@opensource.cirrus.com>
References: <20240501111755.21231-1-simont@opensource.cirrus.com>
	<87ttjgk6ph.wl-tiwai@suse.de>
	<a9345d24-af36-42b4-9139-0701a0dbe1a3@opensource.cirrus.com>
	<87h6fgk0ba.wl-tiwai@suse.de>
	<001401da9c79$fb9f2de0$f2dd89a0$@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,cirrus.com:email,alsa-project.org:email]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Thu, 02 May 2024 12:17:48 +0200,
Simon Trimmer wrote:
> 
> > -----Original Message-----
> > From: Takashi Iwai <tiwai@suse.de>
> > Sent: Thursday, May 2, 2024 10:53 AM
> > To: Richard Fitzgerald <rf@opensource.cirrus.com>
> > Cc: Simon Trimmer <simont@opensource.cirrus.com>; tiwai@suse.com; linux-
> > sound@vger.kernel.org; alsa-devel@alsa-project.org; linux-
> > kernel@vger.kernel.org; patches@opensource.cirrus.com
> > Subject: Re: [PATCH] ALSA: hda: cs35l56: Perform firmware download in the
> > background
> > 
> > On Thu, 02 May 2024 11:21:36 +0200,
> > Richard Fitzgerald wrote:
> > >
> > > On 02/05/2024 08:34, Takashi Iwai wrote:
> > > > On Wed, 01 May 2024 13:17:55 +0200,
> > > > Simon Trimmer wrote:
> > > >> @@ -964,6 +1011,14 @@ int cs35l56_hda_common_probe(struct
> > cs35l56_hda *cs35l56, int hid, int id)
> > > >>   	mutex_init(&cs35l56->base.irq_lock);
> > > >>   	dev_set_drvdata(cs35l56->base.dev, cs35l56);
> > > >>   +	cs35l56->dsp_wq =
> > > >> create_singlethread_workqueue("cs35l56-dsp");
> > > >> +	if (!cs35l56->dsp_wq) {
> > > >> +		ret = -ENOMEM;
> > > >> +		goto err;
> > > >> +	}
> > > >
> > > > Do we really need a dedicated workqueue?  In most usages, simple
> > > > schedule_work*() works fine and is recommended.
> > > >
> > >
> > > On a slow I2C bus with 4 amps this work could take over 2 seconds.
> > > That seems too long to be blocking a global system queue. We use a
> > > dedicated queue in the ASoC driver.
> > >
> > > Also if we queue work on an ordered (single-threaded) system queue the
> > > firmware won't be downloaded to multiple amps in parallel, so we don't
> > > get the best use of the available bus bandwidth.
> > 
> > OK, that sounds like a sensible argument.
> > 
> > But the patch has no call of a queue destructor.  Won't it leak
> > resources?
> 
> Oops that's a good spot - I missed that and will send a v2

If you submit a newer version, it'd be appreciated to explain about
the workqueue usage in the patch description, too.


thanks,

Takashi

