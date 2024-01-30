Return-Path: <linux-kernel+bounces-44687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7801C8425F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3FB2934D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17B36BB54;
	Tue, 30 Jan 2024 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j7p6M2rS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fcbkxqsP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j7p6M2rS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fcbkxqsP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A352274E0D;
	Tue, 30 Jan 2024 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620504; cv=none; b=LN0aYNDPT0GaZcAe/YRQbAL2npY8LG6e3ITTrTVswtb3auxu+CtupSp/CtANAI0parmmp5z/lczM/vuqvCo0AW/ILxc8uvujBpMMD+tqmY2zKfAWFgp5cGtNrviW2GHgbQ/PEHv/N4NaOdotRWbK/tJ86noXkH6+2omGPhVmglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620504; c=relaxed/simple;
	bh=XzgL+n4cnmh65E3tupGX/Y9mODh/MkIzXKMo80VVDsM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2pTI2O3KsnM1rV/+yyldk44xxaqIohn8GBfhkn1v3c/mRITxYdSLzXjc/mNIcW/7gAIYrCl9yU7cINCb8aEukKUfCZOeYNZ6eH9kg4SUY3ftzvu+e+I3D8DFfMy3/O8x/JibSY3sEeie89QTDd4u/63DA4sd+mOb8sY1+PWEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j7p6M2rS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fcbkxqsP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j7p6M2rS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fcbkxqsP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E4EA91F84B;
	Tue, 30 Jan 2024 13:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706620500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C20JTUPpSyGGJZB6BpIGKouuM36f4VjdkcvrYvd2OG8=;
	b=j7p6M2rSxY1fqRrfGnnEUjHSyodlEuP1g/51oxlwIP3MVG1mUZ8I4JRaSSQbJNOBvl6Jaf
	67W1wKvZXIq2I77CSXO0E9jS7CxYUpCOEG5n29l4QPltP4JfItm8iWAY1pwrmPHhYUiInT
	/ioE7bdZPCAo87tcaAB6ReoWHwPXbOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706620500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C20JTUPpSyGGJZB6BpIGKouuM36f4VjdkcvrYvd2OG8=;
	b=fcbkxqsP011Fc7c4WBBUKhvmV16eMMTLcJADCcgw5CCmc/ojHQm+s5pnkZxXiQurPTL+i3
	lKm/+Y190oo+XEAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706620500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C20JTUPpSyGGJZB6BpIGKouuM36f4VjdkcvrYvd2OG8=;
	b=j7p6M2rSxY1fqRrfGnnEUjHSyodlEuP1g/51oxlwIP3MVG1mUZ8I4JRaSSQbJNOBvl6Jaf
	67W1wKvZXIq2I77CSXO0E9jS7CxYUpCOEG5n29l4QPltP4JfItm8iWAY1pwrmPHhYUiInT
	/ioE7bdZPCAo87tcaAB6ReoWHwPXbOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706620500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C20JTUPpSyGGJZB6BpIGKouuM36f4VjdkcvrYvd2OG8=;
	b=fcbkxqsP011Fc7c4WBBUKhvmV16eMMTLcJADCcgw5CCmc/ojHQm+s5pnkZxXiQurPTL+i3
	lKm/+Y190oo+XEAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD88F12FF7;
	Tue, 30 Jan 2024 13:15:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FL7DKFT2uGW5WQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 30 Jan 2024 13:15:00 +0000
Date: Tue, 30 Jan 2024 14:15:00 +0100
Message-ID: <87wmrr2ca3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ALSA: pcm: Add missing formats to formats list
In-Reply-To: <20240125223522.1122765-1-ivan.orlov0322@gmail.com>
References: <20240125223522.1122765-1-ivan.orlov0322@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.30
X-Spamd-Result: default: False [0.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.90)[86.07%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Thu, 25 Jan 2024 23:35:19 +0100,
Ivan Orlov wrote:
> 
> Add 4 missing formats to 'snd_pcm_format_names' array in order to be
> able to get their names with 'snd_pcm_format_name' function.
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Now applied all three patches.  This first one is to for-linus, while
the rest two are to for-next for 6.9 kernel.

For further improvements (e.g. Amadeusz suggested), let's apply on top
of that.


thanks,

Takashi

