Return-Path: <linux-kernel+bounces-64935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1423F8544D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460D11C21666
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF2E11706;
	Wed, 14 Feb 2024 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qz8rLErA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DquwO05s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qz8rLErA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DquwO05s"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E55012B6A;
	Wed, 14 Feb 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902207; cv=none; b=iUm6YioW5hrGWZEKPpsMml8g/is8eNFIOA5VmJBDcN5WZhqR9VZpCAG0VZK2sRBfD8kQ99iI9AYs7Z7vZQLa6Xy/pW147DS2dwzAd8EK8E41awYTbe6ykVwYKUNojf0g9hBTOZ7DiaqDTEpbqOSvzITPcsZ7XMuzCZqqxkc5GbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902207; c=relaxed/simple;
	bh=9P4kpomF3bNeybAYmZS0y2gY7CRPQWc1UBBH3QsjyRY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StJ3QZNo2nTlp16eWSmsKEuspCMueEWn6Gamx3RsONRXeaXqZDZOm1UH9xCwQlSrnIlpUkOS1Po93S85NJ0TuONojrjurd5zB7T/9Tzpox1qUUxu0Xjvzj7PgQ9sqVpnMfrIEB1a/6KwxZSkZsUDthReNAhK35UYucMyZ900sUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qz8rLErA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DquwO05s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qz8rLErA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DquwO05s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA5BC221A8;
	Wed, 14 Feb 2024 09:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707902203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDY10ZmZhoo5+CijPSkvE0/in3mGhJO9T1cwpM7hddM=;
	b=Qz8rLErAnBKe3jmCEO8gJXXnlI1GM7TVMOQ24hPfnF4Dz4GUk6hzmIgjS9EttYvycpXOaa
	i9K9Wf1DuaYSwFHPvT/5Db3eja6N56Eb6PlLGRKZMEOysMWaSKt2P+j2KEN5ipviSEkYKr
	pqZne8LLyYQ5n4J+E7VTaN+QCobLJgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707902203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDY10ZmZhoo5+CijPSkvE0/in3mGhJO9T1cwpM7hddM=;
	b=DquwO05sdys7C1CTfjlNWF1q3QBDz9L56M6ln8mwJxCufcPwgmJDzsALbtQL56/I5Chmqh
	3bpl1dQIy6WM+zBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707902203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDY10ZmZhoo5+CijPSkvE0/in3mGhJO9T1cwpM7hddM=;
	b=Qz8rLErAnBKe3jmCEO8gJXXnlI1GM7TVMOQ24hPfnF4Dz4GUk6hzmIgjS9EttYvycpXOaa
	i9K9Wf1DuaYSwFHPvT/5Db3eja6N56Eb6PlLGRKZMEOysMWaSKt2P+j2KEN5ipviSEkYKr
	pqZne8LLyYQ5n4J+E7VTaN+QCobLJgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707902203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDY10ZmZhoo5+CijPSkvE0/in3mGhJO9T1cwpM7hddM=;
	b=DquwO05sdys7C1CTfjlNWF1q3QBDz9L56M6ln8mwJxCufcPwgmJDzsALbtQL56/I5Chmqh
	3bpl1dQIy6WM+zBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90D5613A6D;
	Wed, 14 Feb 2024 09:16:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v1b/IfuEzGV4NwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 14 Feb 2024 09:16:43 +0000
Date: Wed, 14 Feb 2024 10:16:43 +0100
Message-ID: <87h6ibiex0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?Jean-Lo=EFc?= Charroud <lagiraudiere+linux@free.fr>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	linux-sound <linux-sound@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	patches <patches@opensource.cirrus.com>
Subject: Re: [PATCH v3 0/3] ALSA: hda/realtek: cs35l41: Fix internal speaker support for ASUS UM3402 with missing DSD
In-Reply-To: <644212740.650323792.1707867443153.JavaMail.zimbra@free.fr>
References: <644212740.650323792.1707867443153.JavaMail.zimbra@free.fr>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.19
X-Spamd-Result: default: False [1.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[51.20%];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[free.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[linux];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[free.fr];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Wed, 14 Feb 2024 00:37:23 +0100,
Jean-Loïc Charroud wrote:
> 
> This patch set adds the missing DSD properties, to make the internal speaker works for the "ASUS UM3402" and does some cleanup. 
> 
> Following feedback, I've divided the initial patch into three independent parts and adjusted the explanations: 
> - Patch 1 : Add internal speaker support for ASUS UM3402 with missing DSD 
> - Patch 2 : Fix device ID / model name (no functional changes) 
> - Patch 3 : Fix order and duplicates entry in quirks table (cleanup, no functional changes) 
> 
> Thank you Takashi for your guidance 
> I hope everything is in good shape now. 

Thanks!  It's almost fine and I corrected minor things in my side
(e.g. adding Fixes tags), now applied all to for-linus branch.


Takashi

