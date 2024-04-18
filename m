Return-Path: <linux-kernel+bounces-150251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 990338A9C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20B71C20D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985B5165FCD;
	Thu, 18 Apr 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b7fYvs2w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xf6obBvM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b7fYvs2w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xf6obBvM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F5D1635BB;
	Thu, 18 Apr 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449382; cv=none; b=th658UYozy3ZrmJ2kPumDGa2ipJoFIV3hMu6z/AKYY3F+SOMFf5At6lAYIzTvoA0gEEFkOcPiaBSiI7BX9L5sSw/f27h+mEi2aDx9xrxhse7ZmW6CLdGpbspNaiqWdFVjd6gKKLJ09zzP+jfND/6SUVSJlRPnKbrY2IL/+jYHaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449382; c=relaxed/simple;
	bh=A8Mks8OEjnKoJPkHboz3k+HgPBr8f4wcnalTXqlxDPc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJ1d9sYDuDiCAdTaYGcNGmWbQP255IXfqVE0FI3IGagg95sPFN88P+EgLKyYfa+jrO6NJX/8LBXBt5ChpxcE4pFhdv+rVXUM6DdIwtHiGzUbTzFtX5bSNIMTuS6ESWfYj+UGmt5gFgBPyv9PGYnCW1EI3LW6lfBQ29VFeWq7KfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b7fYvs2w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xf6obBvM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b7fYvs2w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xf6obBvM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D065342E5;
	Thu, 18 Apr 2024 14:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713449376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3OJ4/bXydiAt8KgqqTkfhtbCN1YrrE2xwd3vvC2540=;
	b=b7fYvs2w/VseAGgpPE7mwc6xHBwfmKQsfIIfG22WT2ffaw7mJ24a7T7tJvB6AotPcbW4k2
	P38ZYnIVl5QgvBkuy0BKdhFPrx3Kmk5u7pKO9VvoLabwCV6PaPKkmZZ0Y0eq675hoelsHX
	i+mTzefxiKb51zgWsdT+fj9T/0qT8z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713449376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3OJ4/bXydiAt8KgqqTkfhtbCN1YrrE2xwd3vvC2540=;
	b=xf6obBvMMFIugmelJqSqf/vFg5xRMhEXvYAhgjbjwXKwShCDBZKgnb/aiNOH92nSkxWw66
	p0nSm/1KMqLaXIBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713449376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3OJ4/bXydiAt8KgqqTkfhtbCN1YrrE2xwd3vvC2540=;
	b=b7fYvs2w/VseAGgpPE7mwc6xHBwfmKQsfIIfG22WT2ffaw7mJ24a7T7tJvB6AotPcbW4k2
	P38ZYnIVl5QgvBkuy0BKdhFPrx3Kmk5u7pKO9VvoLabwCV6PaPKkmZZ0Y0eq675hoelsHX
	i+mTzefxiKb51zgWsdT+fj9T/0qT8z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713449376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3OJ4/bXydiAt8KgqqTkfhtbCN1YrrE2xwd3vvC2540=;
	b=xf6obBvMMFIugmelJqSqf/vFg5xRMhEXvYAhgjbjwXKwShCDBZKgnb/aiNOH92nSkxWw66
	p0nSm/1KMqLaXIBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4665013687;
	Thu, 18 Apr 2024 14:09:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qQDtD6ApIWZCHgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Apr 2024 14:09:36 +0000
Date: Thu, 18 Apr 2024 16:09:44 +0200
Message-ID: <87v84ewymv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,	Pierre-Louis Bossart
 <pierre-louis.bossart@linux.intel.com>,	linux-kernel@vger.kernel.org,
	Amadeusz =?ISO-8859-2?Q?S=B3awi=F1ski?=
 <amadeuszx.slawinski@linux.intel.com>,	Bard Liao
 <yung-chuan.liao@linux.intel.com>,	Brady Norander
 <bradynorander@gmail.com>,	Jaroslav Kysela <perex@perex.cz>,	Mark Brown
 <broonie@kernel.org>,	Mark Hasemeyer <markhas@chromium.org>,	Takashi Iwai
 <tiwai@suse.com>,	linux-sound@vger.kernel.org,	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Huawei Matebook D14 NBLB-WAX9N quirk detection
In-Reply-To: <ZiEoyDaRHPZkFI-T@smile.fi.intel.com>
References: <5e6ba980c0738199589749b68b83f2d730512107.1713430105.git.mchehab@kernel.org>
	<20240418110453.10efcb60@sal.lan>
	<ZiEoyDaRHPZkFI-T@smile.fi.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.04
X-Spam-Level: 
X-Spamd-Result: default: False [-3.04 / 50.00];
	BAYES_HAM(-2.74)[98.86%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,vger.kernel.org,gmail.com,perex.cz,chromium.org,suse.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Thu, 18 Apr 2024 16:06:00 +0200,
Andy Shevchenko wrote:
> 
> On Thu, Apr 18, 2024 at 11:04:53AM +0100, Mauro Carvalho Chehab wrote:
> > Em Thu, 18 Apr 2024 09:48:27 +0100
> > Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:
> > 
> > > Newer Matebook D14 model comes with essx8336 and supports SOF,
> > > but the initial models use the legacy driver, with a Realtek ALC 256
> > > AC97 chip on it.
> > > 
> > > The BIOS seems to be prepared to be used by both models, so
> > > it contains an entry for ESSX8336 on its DSDT table.
> > > 
> > > Add a quirk, as otherwise dspconfig driver will try to load
> > > SOF, causing audio probe to fail.
> 
> ...
> 
> > Worth to mention that I opened an issue on Github about that:
> > 
> > https://github.com/thesofproject/linux/issues/4934
> > 
> > I added there the ACPI DSDT table as a reference.
> 
> Yeah, please add a BugLink tag.

I thought a Link tag is preferred over a BugLink tag nowadays.

I can add it in my side, but let's wait for the review by Intel people
at first.


thanks,

Takashi

