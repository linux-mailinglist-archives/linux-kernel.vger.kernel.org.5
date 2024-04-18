Return-Path: <linux-kernel+bounces-149654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE3A8A9409
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87500B2200B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEF574435;
	Thu, 18 Apr 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rT7vRLN1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZdiEr3HP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rT7vRLN1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZdiEr3HP"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362856A8AD;
	Thu, 18 Apr 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425542; cv=none; b=beIImV/aJfz3RxHRwqvnzPzszHrwHHDP/63zKDHBoDjtb/p1jYjzbmji2CXmqJeec+AtpLPwBNEXAElD7RH3enMC9IhGkFcYXQGJKXXaaeHSQm2j5ZRU7HKlE+CD/3gEcY+4M71cWgF1fnI5AavoL7IIJiLO8re0P3oeL0YSbgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425542; c=relaxed/simple;
	bh=90YhdNNJcxrDaRsu55Rjh/2OZ7oiSVLChqVXQkJ6qK0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oX0yk/ck5o4QnHpIHJeZuaf0b/ZozxQ591sczPWAS6vObci5WepQ5WNX6JtDqt/Zvq3NTxGg+U+CuO3m6Kl4IxMbuByQUvgnUjlEOcCFF29z87ophNHgJnJtITvwqAGZUKWQJW7viiOQOMcVccEKhtPWZjx4g2B4ETnTBRYvMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rT7vRLN1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZdiEr3HP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rT7vRLN1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZdiEr3HP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57C8534AFC;
	Thu, 18 Apr 2024 07:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713425535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FKRoM0BRzYX0RT/WZrESQAqQcadfdTDQIy5FQXB1umI=;
	b=rT7vRLN1WzMjsARKZhDofgz4r2kSB6s/87hU82UL8pFiKX4ED29btrxGJ53KUTIFQaslWI
	2Pd6vw7IXXWFnAjFZcNqH/Nvg788gSNh0YtIi6nhYpjYzE0fo0vghwgNEC3qwLAgqv0YpF
	u7C29Z2FCt3l5DQJaVnofJFCEekDZc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713425535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FKRoM0BRzYX0RT/WZrESQAqQcadfdTDQIy5FQXB1umI=;
	b=ZdiEr3HPLg4llHafwf4QDgE2lt76Cm9ohE8CWJD5o32RNaLj3mAc+48WvLRWLPffFnJylP
	8zh8VZmPFvvK96Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713425535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FKRoM0BRzYX0RT/WZrESQAqQcadfdTDQIy5FQXB1umI=;
	b=rT7vRLN1WzMjsARKZhDofgz4r2kSB6s/87hU82UL8pFiKX4ED29btrxGJ53KUTIFQaslWI
	2Pd6vw7IXXWFnAjFZcNqH/Nvg788gSNh0YtIi6nhYpjYzE0fo0vghwgNEC3qwLAgqv0YpF
	u7C29Z2FCt3l5DQJaVnofJFCEekDZc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713425535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FKRoM0BRzYX0RT/WZrESQAqQcadfdTDQIy5FQXB1umI=;
	b=ZdiEr3HPLg4llHafwf4QDgE2lt76Cm9ohE8CWJD5o32RNaLj3mAc+48WvLRWLPffFnJylP
	8zh8VZmPFvvK96Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F36571384C;
	Thu, 18 Apr 2024 07:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x+kZOn7MIGaACwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Apr 2024 07:32:14 +0000
Date: Thu, 18 Apr 2024 09:32:23 +0200
Message-ID: <87bk67xh14.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-sound@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>,
	Athaariq Ardhiansyah <foss@athaariq.my.id>,
	Jaroslav Kysela <perex@perex.cz>,
	Kailang Yang <kailang@realtek.com>,
	Matthew Anderson <ruinairas1992@gmail.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirks for Huawei Matebook D14 NBLB-WAX9N
In-Reply-To: <b92a9e49fb504eec8416bcc6882a52de89450102.1713370457.git.mchehab@kernel.org>
References: <b92a9e49fb504eec8416bcc6882a52de89450102.1713370457.git.mchehab@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -1.41
X-Spam-Level: 
X-Spamd-Result: default: False [-1.41 / 50.00];
	BAYES_HAM(-1.11)[88.30%];
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
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,ljones.dev,athaariq.my.id,perex.cz,realtek.com,gmail.com,ti.com,opensource.cirrus.com,linux.intel.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Wed, 17 Apr 2024 18:16:33 +0200,
Mauro Carvalho Chehab wrote:
> 
> The headset mic requires a fixup to be properly detected/used.
> 
> As a reference, this specific model from 2021 reports
> the following devices:
> 	https://alsa-project.org/db/?f=1a5ddeb0b151db8fe051407f5bb1c075b7dd3e4a
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Applied now.  Thanks.


Takashi

