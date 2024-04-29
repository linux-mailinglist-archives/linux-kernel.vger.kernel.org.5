Return-Path: <linux-kernel+bounces-162506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1398B5C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236081F2185C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A625D7EEF2;
	Mon, 29 Apr 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e2lHkh/1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LV3TJBbF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e2lHkh/1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LV3TJBbF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3616D81729;
	Mon, 29 Apr 2024 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402828; cv=none; b=phCuGUeI27lq9Lcvn77L0/qCTKdbvz4o/YLNEEshvtDyoxmC3M91q9m/POx/BW4uM/5OBFdN7L6mMzizrvmmCbqTzhqCz5MvnRDpTVSXLsd0Svyi6icOkfHE25kRWQyg8YvDum42jG5YcJaqKSC3DWexuNHDOCYheqUW+e3i+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402828; c=relaxed/simple;
	bh=AoEcZWPaPmzELVD9CbCwfoVXprt2zSFSuipKEKqMbz4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XW7FFoZy6+A6rdLXqp1isLr6hGrLmxS2SH4PmJqB83ve6tRsDrP59hVJen+jdgUT+cXzDKHBellvsZrhCDVK/vRpn5LJz0OCFNR9nkcGNw2axeCy737sdGrzzfLaNMMAqgFlGpe3a4bw9u/mL4k/FdMMpC3Ae7HXJlGjq4WZ0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e2lHkh/1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LV3TJBbF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e2lHkh/1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LV3TJBbF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 107DE1F445;
	Mon, 29 Apr 2024 15:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714402824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6ISOxBlAV6CDQEEnStu0qtNtqvx4/HjkaEqq8aneuI=;
	b=e2lHkh/1yUv8ZHdX2ry60AaD6xgrs6pdjSud8tisrs8VriJV6sk4EnVnflfqvPx2E5G+oe
	VmQV01B93zU/0DRHkPWU4TrKmaQGaDC+VllVnqfLbIql4z3DoCtm5wHgKLOqRsNMLPOIoM
	7ND7IZ06ZyVrmMFqPQPFcBqEnZ34QaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714402824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6ISOxBlAV6CDQEEnStu0qtNtqvx4/HjkaEqq8aneuI=;
	b=LV3TJBbFwtRB0h9S76K2/GSkJ532TdH4vtPe1dA2QLBuRPDezgNp7W/66cYfmiROsf8jMw
	wdJ8UjwAFDkYVHCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714402824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6ISOxBlAV6CDQEEnStu0qtNtqvx4/HjkaEqq8aneuI=;
	b=e2lHkh/1yUv8ZHdX2ry60AaD6xgrs6pdjSud8tisrs8VriJV6sk4EnVnflfqvPx2E5G+oe
	VmQV01B93zU/0DRHkPWU4TrKmaQGaDC+VllVnqfLbIql4z3DoCtm5wHgKLOqRsNMLPOIoM
	7ND7IZ06ZyVrmMFqPQPFcBqEnZ34QaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714402824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6ISOxBlAV6CDQEEnStu0qtNtqvx4/HjkaEqq8aneuI=;
	b=LV3TJBbFwtRB0h9S76K2/GSkJ532TdH4vtPe1dA2QLBuRPDezgNp7W/66cYfmiROsf8jMw
	wdJ8UjwAFDkYVHCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD2D0138A7;
	Mon, 29 Apr 2024 15:00:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WKavKAe2L2Y7FQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 29 Apr 2024 15:00:23 +0000
Date: Mon, 29 Apr 2024 17:00:35 +0200
Message-ID: <875xw0p624.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,	Takashi Iwai
 <tiwai@suse.de>,	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org,	Amadeusz =?ISO-8859-2?Q?S=B3awi=F1ski?=
 <amadeuszx.slawinski@linux.intel.com>,	Bard Liao
 <yung-chuan.liao@linux.intel.com>,	Brady Norander
 <bradynorander@gmail.com>,	Jaroslav Kysela <perex@perex.cz>,	Mark Brown
 <broonie@kernel.org>,	Mark Hasemeyer <markhas@chromium.org>,	Takashi Iwai
 <tiwai@suse.com>,	linux-sound@vger.kernel.org,	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Huawei Matebook D14 NBLB-WAX9N quirk detection
In-Reply-To: <c0120da6-ac95-46c6-94d5-471f31e7c857@linux.intel.com>
References: <5e6ba980c0738199589749b68b83f2d730512107.1713430105.git.mchehab@kernel.org>
	<20240418110453.10efcb60@sal.lan>
	<848bcc94-3a31-4fb4-81bc-bd3f138e12f6@linux.intel.com>
	<87edaopdlt.wl-tiwai@suse.de>
	<Zi-RpauZjcWg0t_q@smile.fi.intel.com>
	<c0120da6-ac95-46c6-94d5-471f31e7c857@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,suse.de,kernel.org,vger.kernel.org,gmail.com,perex.cz,chromium.org,suse.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]

On Mon, 29 Apr 2024 15:51:03 +0200,
Pierre-Louis Bossart wrote:
> 
> 
> 
> On 4/29/24 07:25, Andy Shevchenko wrote:
> > On Mon, Apr 29, 2024 at 02:17:34PM +0200, Takashi Iwai wrote:
> >> On Thu, 18 Apr 2024 15:24:10 +0200,
> >> Pierre-Louis Bossart wrote:
> >>> On 4/18/24 05:04, Mauro Carvalho Chehab wrote:
> > 
> > ...
> > 
> >>> Andy, what do you think and what would be your recommendation?
> >>
> >> This one is still pending, and I'd like to hear the decision from
> >> Intel people.  Let me know if this hack is acceptable.
> > 
> > IIRC it was resolved on GitHub by Pierre, anything else I need to contribute?
> 
> This initial patch was replaced by the one I sent on Friday
> "[PATCH] ALSA: hda: intel-dsp-config: harden I2C/I2S codec detection"
> 
> I should have made it clearer in the commit message, sorry.

OK, thanks for the updates!


Takashi

