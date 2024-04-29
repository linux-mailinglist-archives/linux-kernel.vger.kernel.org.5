Return-Path: <linux-kernel+bounces-162218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B285C8B57A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA85AB2617C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D255380B;
	Mon, 29 Apr 2024 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LE0uEKnI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m62Jjwkg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LE0uEKnI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m62Jjwkg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC21F535A2;
	Mon, 29 Apr 2024 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392944; cv=none; b=HyfDvdkJanhEnBfpVdVQi7VFUIEIPrZ9cCC00bJ5/MxM8IzacKBEdukIzlRUjQuzlD4ComQGr/uTzpu3np6GhJCSl7d7KGto+yE7u1BP5VZrQMt9JvYadgdK/v1VM1Zv5SIQAO2MKigtbPOGkVAZU/GmVK5UqsD49ETcNxCV7Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392944; c=relaxed/simple;
	bh=cYOL1tJRTvgRsSRBeQI6fqJ4MHgAImgZfkWcYgXM/18=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQzDyk76Gkcq67B1QCotABw5rmyxyghevJbct1dQrIE5i/NGuXZclSDnfyyX1McFem42yzSoWInrBdMSfiXnQxhY45iFvmSztfu7IBkqMN3h3EUGLa+kVymBdSWOxop43j9ImpJhLuddpHY873oMX+jMCnq3XtyrUN11oGvMLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LE0uEKnI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m62Jjwkg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LE0uEKnI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m62Jjwkg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E61FA1F397;
	Mon, 29 Apr 2024 12:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714392940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYgTSu72KpDPtvQDnavAwUGYEuGoWQ7yKpTecDsft60=;
	b=LE0uEKnIpYFoXEoUitHs6NjEUAj40vLGcOLSUDUJjY4tJVP9YTUBl6i69Jr2otTtdRbgTR
	/yqvXREKMqBqkCatsLRTyS0rOZUEv7ajUElN79CoxBFk1K5Y0ZpuMqU7N+L2UZ/vHpoZM6
	GQWadIHI1e14s4vMWbfa8K3JtXGCuPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714392940;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYgTSu72KpDPtvQDnavAwUGYEuGoWQ7yKpTecDsft60=;
	b=m62Jjwkgh1l/akcWa9BF63Cjfk2voe0v/1LgrADmJDNHdQ8tuF5bNOBPVNRiEzmLXEQv0p
	dBHZoQWKPoXtR+Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714392940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYgTSu72KpDPtvQDnavAwUGYEuGoWQ7yKpTecDsft60=;
	b=LE0uEKnIpYFoXEoUitHs6NjEUAj40vLGcOLSUDUJjY4tJVP9YTUBl6i69Jr2otTtdRbgTR
	/yqvXREKMqBqkCatsLRTyS0rOZUEv7ajUElN79CoxBFk1K5Y0ZpuMqU7N+L2UZ/vHpoZM6
	GQWadIHI1e14s4vMWbfa8K3JtXGCuPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714392940;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYgTSu72KpDPtvQDnavAwUGYEuGoWQ7yKpTecDsft60=;
	b=m62Jjwkgh1l/akcWa9BF63Cjfk2voe0v/1LgrADmJDNHdQ8tuF5bNOBPVNRiEzmLXEQv0p
	dBHZoQWKPoXtR+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2D9A139DE;
	Mon, 29 Apr 2024 12:15:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wl7tLWyPL2Z4WAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 29 Apr 2024 12:15:40 +0000
Date: Mon, 29 Apr 2024 14:15:52 +0200
Message-ID: <87frv4pdon.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Aman Dhoot <amandhoot12@gmail.com>
Cc: tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Patch for mute led of HP Laptop 15 da3001TU
In-Reply-To: <CAMTp=B+3NG65Z684xMwHqdXDJhY+DJK-kuSw4adn6xwnG+b5JA@mail.gmail.com>
References: <CAMTp=B+3NG65Z684xMwHqdXDJhY+DJK-kuSw4adn6xwnG+b5JA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.53
X-Spam-Level: 
X-Spamd-Result: default: False [-2.53 / 50.00];
	BAYES_HAM(-2.23)[96.36%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]

On Wed, 24 Apr 2024 18:06:42 +0200,
Aman Dhoot wrote:
> 
> 
> Hello there,
> 
> This patch is for fixing the volume mute LED on HP Laptop 15 da3001TU,
> this patch adds SND_PCI_QUIRK for HP Laptop 15-da3001TU, please review this
> patch & add this patch to the mainline kernel.
> 
> I have tested this patch on the latest kernel 6.8.7 & it is working without
> any problem.
> 
> From 12108ce794465925c9dc184253356d1daaa9f509 Mon Sep 17 00:00:00 2001
> From: Aman Dhoot <amandhoot12@gmail.com>
> Date: Mon, 22 Apr 2024 18:08:23 +0530
> Subject: [PATCH] Fix mute led of HP Laptop 15-da3001TU.
> 
> This patch simply add SND_PCI_QUIRK for HP Laptop 15-da3001TU to fixed mute led of laptop.
> 
> Signed-off-by: Aman Dhoot <amandhoot12@gmail.com>

Applied now.  Thanks.


Takashi

