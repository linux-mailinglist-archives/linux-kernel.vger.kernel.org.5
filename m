Return-Path: <linux-kernel+bounces-49457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A14846A92
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10072B28342
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B64718C36;
	Fri,  2 Feb 2024 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JsEP5sN2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eUu0rwB+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JsEP5sN2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eUu0rwB+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A031AAB1;
	Fri,  2 Feb 2024 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861840; cv=none; b=o4AMoZomk2AcCMWcKKG94Oaq6n5RoOczryGFWesqkwda1dfUAMzd74/zJBWI8QzZmfoOvSRkKMv3G0+qOGrTEjMVIevsG7/xd49VvIsXCDwAcNlM+yN1d4pCUE3to33tiaKP7ElwsXf9gaYndh6zT7LjCZEV4bcMxdmlz6xCv0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861840; c=relaxed/simple;
	bh=/ZwwgSNDdMT7eOjgjcfY+3VobjfrMFAGXehTLfvkE18=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SVMalsgrhAYBZ+rJlMXPW3EEhrLWSBBI+TJle2edDlFm2BugyRAmi/9RHd9oSft0S2dSho7AHyPt2g5dLJiua7PSWs0on/OPepDDSTR0PuMtqiV3MbXMRDC3wCPhOR+ETdbfjkojXZ7Tz9Zs6rnClvzmpFT3m4CozYbaNRQ4gHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JsEP5sN2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eUu0rwB+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JsEP5sN2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eUu0rwB+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B809E1F6E6;
	Fri,  2 Feb 2024 08:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706861836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEygOBYVbTy8p0b9vlbsDN79cPT+wKXNDCxum3hoToA=;
	b=JsEP5sN2A8Wtnv7iQV+0bkbKtG/i2e/eAjYAO+WCoPkwR2FBJ5prsX/m9Khf96e0oK7sMN
	Z2lP+Zfdo8YR3FmB0tRCVwU0iqeGQAedK0+qbQIAr6IaYo1Cw+FMqui28BKkzLDqUg2wnd
	MMdA0gmmgXDOXZ8X4wVia9TRs53USJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706861836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEygOBYVbTy8p0b9vlbsDN79cPT+wKXNDCxum3hoToA=;
	b=eUu0rwB+AjEBoJm3sdclqgkyjsKCmUeegdN2Qcr+0ed9L9NLfrnC4cfaddgo/K2iIbb/7W
	XJ5I+mAtDSv6y7Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706861836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEygOBYVbTy8p0b9vlbsDN79cPT+wKXNDCxum3hoToA=;
	b=JsEP5sN2A8Wtnv7iQV+0bkbKtG/i2e/eAjYAO+WCoPkwR2FBJ5prsX/m9Khf96e0oK7sMN
	Z2lP+Zfdo8YR3FmB0tRCVwU0iqeGQAedK0+qbQIAr6IaYo1Cw+FMqui28BKkzLDqUg2wnd
	MMdA0gmmgXDOXZ8X4wVia9TRs53USJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706861836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEygOBYVbTy8p0b9vlbsDN79cPT+wKXNDCxum3hoToA=;
	b=eUu0rwB+AjEBoJm3sdclqgkyjsKCmUeegdN2Qcr+0ed9L9NLfrnC4cfaddgo/K2iIbb/7W
	XJ5I+mAtDSv6y7Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 898AB13A58;
	Fri,  2 Feb 2024 08:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ed7CHwylvGUXPAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 02 Feb 2024 08:17:16 +0000
Date: Fri, 02 Feb 2024 09:17:16 +0100
Message-ID: <87fryb2sc3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: core: Fix dependencies for SND_CORE_TEST
In-Reply-To: <20240201221122.16627-1-ivan.orlov0322@gmail.com>
References: <20240201221122.16627-1-ivan.orlov0322@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JsEP5sN2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eUu0rwB+
X-Spamd-Result: default: False [-3.61 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.30)[96.75%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B809E1F6E6
X-Spam-Level: 
X-Spam-Score: -3.61
X-Spam-Flag: NO

On Thu, 01 Feb 2024 23:11:22 +0100,
Ivan Orlov wrote:
> 
> Select CONFIG_SND_PCM when enabling CONFIG_SND_CORE_TEST, as the test
> uses symbols from 'pcm_misc.c'.
> 
> Fixes: 3e39acf56ede ("ALSA: core: Add sound core KUnit test")
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Thanks, applied now.


Takashi

