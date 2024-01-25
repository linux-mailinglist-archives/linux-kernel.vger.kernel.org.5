Return-Path: <linux-kernel+bounces-38234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145F683BCDC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D21291EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB71BC3A;
	Thu, 25 Jan 2024 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QTabPfsN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uhZpULmk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QTabPfsN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uhZpULmk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD5A1BC23;
	Thu, 25 Jan 2024 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173547; cv=none; b=Bzw8CSKLe5Ay7i0RbTae8qPpDYZga78kZ40crSqx08NN0UqLgP/a4JIa23N1eGijEiQ0wHXQVgsLECFUvB0BBK8oSFIuBlLEKvURy+cR/rF9tLfSLEDDrx9cU6qiC5nfPVyr77113eSEvYbmSgZeIVH5A2yfhME/yKlwcktuJ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173547; c=relaxed/simple;
	bh=/Awd5Rpw/LP0WK2bkwYJVJu10+RpEs5ehXlnYOdjEfU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQS9DSBM+aMbzANYpZeKQ1JjuN5ApZ8oriC2j/KAOOaWAd4AsII1aJQDd8CN2yts3vrZLoK+U+Uvnig56vjc7CjEUbc18pE9peaAv3apXF9tRJNkuoVA7PALM5bV6fPSyevHp+wH6JfGX1Eu1MkE6Gb6zZxVN7kPvCHmG0/rj9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QTabPfsN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uhZpULmk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QTabPfsN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uhZpULmk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BFF051F84C;
	Thu, 25 Jan 2024 09:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706173540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LqO3/k5my85BZMbKqkCA9egmBjk9aaibA3LxQHowLFY=;
	b=QTabPfsNk0guURroVYzz+FmbtUAVMvVU+U/QVhvxpghjL64cTAe/0I1kGdF0ojvHfePUmw
	s4oFAktLUZBiHr2rd9e1PZBxZ0LQ1bKVXxHPhpuT452T7xqLhHyeLx/fwWygoPXKWU0nzX
	c7IA9xoYQdLvCLMHICIJnbAprtUNTKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706173540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LqO3/k5my85BZMbKqkCA9egmBjk9aaibA3LxQHowLFY=;
	b=uhZpULmkXrNFMbMhGHbbHVJvzLH5vasozTg6RYgYPoAkQm2k2iXlytkmDzl2tz++C8ujhK
	z7qGV0VQdTzKWYAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706173540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LqO3/k5my85BZMbKqkCA9egmBjk9aaibA3LxQHowLFY=;
	b=QTabPfsNk0guURroVYzz+FmbtUAVMvVU+U/QVhvxpghjL64cTAe/0I1kGdF0ojvHfePUmw
	s4oFAktLUZBiHr2rd9e1PZBxZ0LQ1bKVXxHPhpuT452T7xqLhHyeLx/fwWygoPXKWU0nzX
	c7IA9xoYQdLvCLMHICIJnbAprtUNTKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706173540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LqO3/k5my85BZMbKqkCA9egmBjk9aaibA3LxQHowLFY=;
	b=uhZpULmkXrNFMbMhGHbbHVJvzLH5vasozTg6RYgYPoAkQm2k2iXlytkmDzl2tz++C8ujhK
	z7qGV0VQdTzKWYAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76A90134C3;
	Thu, 25 Jan 2024 09:05:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PI+MG2QksmUcPwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 25 Jan 2024 09:05:40 +0000
Date: Thu, 25 Jan 2024 10:05:40 +0100
Message-ID: <87o7d9kckb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<soyer@irl.hu>,
	<shenghao-ding@ti.com>,
	<perex@perex.cz>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH 0/2] ALSA: hda: Move component binding support into separate library
In-Reply-To: <87plxqlucs.wl-tiwai@suse.de>
References: <20240124112607.77614-1-rf@opensource.cirrus.com>
	<87plxqlucs.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QTabPfsN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uhZpULmk
X-Spamd-Result: default: False [-1.18 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	 BAYES_HAM(-1.87)[94.27%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BFF051F84C
X-Spam-Level: 
X-Spam-Score: -1.18
X-Spam-Flag: NO

On Wed, 24 Jan 2024 14:43:47 +0100,
Takashi Iwai wrote:
> 
> On Wed, 24 Jan 2024 12:26:05 +0100,
> Richard Fitzgerald wrote:
> > 
> > The Cirrus Logic amplifiers are currently paired with Realtek HDA codecs.
> > But they could be used with other codecs. To prepare for this, these two
> > patches move the manager side of the component binding out of the Realtek
> > driver into a library module.
> > 
> > The first patch tweaks the CS35L41 code so that it is not hardcoded to
> > CS35L41, and changes the TAS2781 handling so that it re-uses that code
> > instead of having a near-identical copy of it.
> > 
> > Can someone please test that these two patches don't break TAS2781?
> > I have checked that they should work in theory but I don't have hardware
> > to test on.
> > 
> > Richard Fitzgerald (2):
> >   ALSA: hda: realtek: Re-work CS35L41 fixups to re-use for other amps
> >   ALSA: hda: realtek: Move hda_component implementation to module
> 
> Through a quick glance, it looks good.
> I'll wait for the verification for TAS codec for a while.

Now applied to for-next branch.


thanks,

Takashi

