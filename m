Return-Path: <linux-kernel+bounces-167330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544FC8BA7FF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBCB61F221AA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7C3147C61;
	Fri,  3 May 2024 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H2h40Ybz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d+ngBvXO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H2h40Ybz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d+ngBvXO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9858465
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714722111; cv=none; b=ZHOUzFEfYIA5aYaSNYTCyZHvLX6AKM2OnHUCmW5HbwAwccTw7Ae25YGX9hxCNUrcQnImI1rJ+y7MZBgkVHgr+X9q7Il38s0ow72y1eaJI6tPq1fnxqfemqYv8TneaqQg+qsaaXkIgJEMn49X8H/4lhO8+U7ZqRBJAPDXEA2+1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714722111; c=relaxed/simple;
	bh=0LjN+RgCM/NbA+vxmMMMADV3hC1wK1/e5glTLyBwGTA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1jbOiXtwebNJuxjM6v0zGDe9VSfsYLbPkQvRjtPOX8YFSpvtMH1mr+JAkP/rwnMCPUT8BgbVNcB1UqRAi2JYoGiXpZrDvIISchlZvbO8/M0pIs1UwToTVD6hoVovaGCvk75hbM9uKrmWADlPkToBFBsvKaC3cDg9CTARMb30wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H2h40Ybz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d+ngBvXO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H2h40Ybz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d+ngBvXO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9866A22B7E;
	Fri,  3 May 2024 07:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714722108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gunftjrVkw4beEJHcIhpNH7D+9VWjwKFtIXJPtbrtFc=;
	b=H2h40Ybzwl4+ohfj8rjJQDun/VElHyL793NYk6hvRAVgx/LT3OqMrJHL+d0QZFyuAJwEyk
	sq4i0Jw0RzOmkwoYZB232H/1hr6XOZtp7Uf8zSyYxw1giJJv5ygWNDN0GlhrYMpxEcZmzI
	Twa1HG+mFEhDefmERvO8QTFeqsqF2L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714722108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gunftjrVkw4beEJHcIhpNH7D+9VWjwKFtIXJPtbrtFc=;
	b=d+ngBvXOFGAX0KV7jt2Hy2fNRxACDNnTXmilgc9h+XBhawg87yv3cPVqOSZery7PC6Tyqm
	pS9HcORxzb8xmXDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714722108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gunftjrVkw4beEJHcIhpNH7D+9VWjwKFtIXJPtbrtFc=;
	b=H2h40Ybzwl4+ohfj8rjJQDun/VElHyL793NYk6hvRAVgx/LT3OqMrJHL+d0QZFyuAJwEyk
	sq4i0Jw0RzOmkwoYZB232H/1hr6XOZtp7Uf8zSyYxw1giJJv5ygWNDN0GlhrYMpxEcZmzI
	Twa1HG+mFEhDefmERvO8QTFeqsqF2L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714722108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gunftjrVkw4beEJHcIhpNH7D+9VWjwKFtIXJPtbrtFc=;
	b=d+ngBvXOFGAX0KV7jt2Hy2fNRxACDNnTXmilgc9h+XBhawg87yv3cPVqOSZery7PC6Tyqm
	pS9HcORxzb8xmXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2718A139CB;
	Fri,  3 May 2024 07:41:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hyf5BzyVNGa+DAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 03 May 2024 07:41:48 +0000
Date: Fri, 03 May 2024 09:42:01 +0200
Message-ID: <878r0ribp2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>,
	<perex@perex.cz>,
	<pierre-louis.bossart@linux.intel.com>,
	<13916275206@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>,
	<bard.liao@intel.com>,
	<yung-chuan.liao@linux.intel.com>,
	<kevin-lu@ti.com>,
	<cameron.berkenpas@gmail.com>,
	<baojun.xu@ti.com>,
	<soyer@irl.hu>,
	<Baojun.Xu@fpt.com>
Subject: Re: [PATCH v3] ALSA: ASoc/tas2781: Fix wrong loading calibrated data sequence
In-Reply-To: <20240502232450.484-1-shenghao-ding@ti.com>
References: <20240502232450.484-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -1.78
X-Spam-Level: 
X-Spamd-Result: default: False [-1.78 / 50.00];
	BAYES_HAM(-2.98)[99.92%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,perex.cz,139.com,alsa-project.org,vger.kernel.org,intel.com,ti.com,irl.hu,fpt.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]

On Fri, 03 May 2024 01:24:49 +0200,
Shenghao Ding wrote:
> 
> Calibrated data will be set to default after loading DSP config params,
> which will cause speaker protection work abnormally. Reload calibrated
> data after loading DSP config params.
> 
> 'Fixes: 0a0877812628 ("ASoc: tas2781: Fix spelling mistake "calibraiton"
>  -> "calibration"")'

This usage of Fixes tag is utterly wrong: first off, drop the single
quote of the whole line.  Moreover, the suggested commit looks very
dubious.  It's merely a change to correct spelling, and this can't be
the culprit of the bug itself.  Please point to the right commit.

> @@ -13,8 +13,8 @@
>  // Author: Kevin Lu <kevin-lu@ti.com>
>  //
>  
> -#ifndef __TASDEVICE_DSP_H__
> -#define __TASDEVICE_DSP_H__
> +#ifndef __TAS2781_DSP_H__
> +#define __TAS2781_DSP_H__

This is unnecessary / related change, better to keep or do it in
another patch.

> @@ -1878,7 +1878,7 @@ int tas2781_load_calibration(void *context, char *file_name,
>  {
>  	struct tasdevice_priv *tas_priv = (struct tasdevice_priv *)context;
>  	struct tasdevice *tasdev = &(tas_priv->tasdevice[i]);
> -	const struct firmware *fw_entry;
> +	const struct firmware *fw_entry = NULL;

Why is this needed?  If a NULL initialization is a must (for some
warning fix or whatever), do it in an individual fix patch instead.

The rest changes look OK, but it's a bit hard to judge because the
code has too few comments, unfortunately...


thanks,

Takashi

