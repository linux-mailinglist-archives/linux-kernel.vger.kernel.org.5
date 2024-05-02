Return-Path: <linux-kernel+bounces-166255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4982F8B981E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A961B244D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CBF5730D;
	Thu,  2 May 2024 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LUnS+/TV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g79upUkd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LUnS+/TV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g79upUkd"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3DB56766;
	Thu,  2 May 2024 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643552; cv=none; b=qB06eNuh/hhFqD1REYa+zZx0Ac1zFOMmbP2R1wX6+kiEHNquURfU11eNuVAxiT8xo7lWaH9t0AHYHpWY2YN1WtQOrkx9y1LWJSy8ASfNbIY2CnSJqO2nOMO5M9mCQ8v7RM2XDn27g+T9Y7UbmEiDVy0xW1rkfgWp1DeseMnJ//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643552; c=relaxed/simple;
	bh=vITXKoMtPN6CljACjRovE4Q9eiO6CiuoWCW2T4ojjQU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mdxr8vmRteN+D3WbnPxIuKZgndLjpvXyMpdLqBdALSSArb3SX9+xO5yvtDiknq4zUf9917sQ13mzYiA6E7Taohc2FZl5r7W8MUeiw0b6S5t2gH9MAOlLs+baf0DiJWAEhoYlp3mSLEBEwK41kwy/KLdrW8+5N4VJjCurv/i6+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LUnS+/TV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g79upUkd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LUnS+/TV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g79upUkd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C76D21FB79;
	Thu,  2 May 2024 09:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714643548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4eGmpuaeDMzhLfyJ1oPJc4iz3E5Oauzqw7fHW9MAvVU=;
	b=LUnS+/TVSf5LwASnqw0/CLTNtkxsRKWb8pZZPOLXhfRBePYDzUjhoVGfctSCo3wKVmqlKj
	qq0XTuaWQXHoY41HPXctervNoTKfgrrFjP8IFxxyvD9hQa6WLAHIBSUV3R54iJL4ZF0AU7
	JC4W6IYA/f/p47iXIMX9YypJQkK9SA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714643548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4eGmpuaeDMzhLfyJ1oPJc4iz3E5Oauzqw7fHW9MAvVU=;
	b=g79upUkdIzPMIzIFCPogoZ30i5uuKqxIsOiDKBcSRozI6Mzg9HcrxXP4P2y0JYgPLg6UyD
	j2xkcQRUc4OD3IBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="LUnS+/TV";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=g79upUkd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714643548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4eGmpuaeDMzhLfyJ1oPJc4iz3E5Oauzqw7fHW9MAvVU=;
	b=LUnS+/TVSf5LwASnqw0/CLTNtkxsRKWb8pZZPOLXhfRBePYDzUjhoVGfctSCo3wKVmqlKj
	qq0XTuaWQXHoY41HPXctervNoTKfgrrFjP8IFxxyvD9hQa6WLAHIBSUV3R54iJL4ZF0AU7
	JC4W6IYA/f/p47iXIMX9YypJQkK9SA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714643548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4eGmpuaeDMzhLfyJ1oPJc4iz3E5Oauzqw7fHW9MAvVU=;
	b=g79upUkdIzPMIzIFCPogoZ30i5uuKqxIsOiDKBcSRozI6Mzg9HcrxXP4P2y0JYgPLg6UyD
	j2xkcQRUc4OD3IBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9354D13957;
	Thu,  2 May 2024 09:52:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U81mIlxiM2aIAgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 02 May 2024 09:52:28 +0000
Date: Thu, 02 May 2024 11:52:41 +0200
Message-ID: <87h6fgk0ba.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Simon Trimmer <simont@opensource.cirrus.com>,
	<tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l56: Perform firmware download in the background
In-Reply-To: <a9345d24-af36-42b4-9139-0701a0dbe1a3@opensource.cirrus.com>
References: <20240501111755.21231-1-simont@opensource.cirrus.com>
	<87ttjgk6ph.wl-tiwai@suse.de>
	<a9345d24-af36-42b4-9139-0701a0dbe1a3@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C76D21FB79
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Thu, 02 May 2024 11:21:36 +0200,
Richard Fitzgerald wrote:
> 
> On 02/05/2024 08:34, Takashi Iwai wrote:
> > On Wed, 01 May 2024 13:17:55 +0200,
> > Simon Trimmer wrote:
> >> @@ -964,6 +1011,14 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
> >>   	mutex_init(&cs35l56->base.irq_lock);
> >>   	dev_set_drvdata(cs35l56->base.dev, cs35l56);
> >>   +	cs35l56->dsp_wq =
> >> create_singlethread_workqueue("cs35l56-dsp");
> >> +	if (!cs35l56->dsp_wq) {
> >> +		ret = -ENOMEM;
> >> +		goto err;
> >> +	}
> > 
> > Do we really need a dedicated workqueue?  In most usages, simple
> > schedule_work*() works fine and is recommended.
> > 
> 
> On a slow I2C bus with 4 amps this work could take over 2 seconds.
> That seems too long to be blocking a global system queue. We use a
> dedicated queue in the ASoC driver.
> 
> Also if we queue work on an ordered (single-threaded) system queue the
> firmware won't be downloaded to multiple amps in parallel, so we don't
> get the best use of the available bus bandwidth.

OK, that sounds like a sensible argument.

But the patch has no call of a queue destructor.  Won't it leak
resources?


thanks,

Takashi

