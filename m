Return-Path: <linux-kernel+bounces-13117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56F981FFE6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072341C2185D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF61172F;
	Fri, 29 Dec 2023 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1fNFYglS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8i615z9f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1fNFYglS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8i615z9f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E263211721;
	Fri, 29 Dec 2023 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA67D21E41;
	Fri, 29 Dec 2023 14:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703859338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kQzfAYsuLbgtPe3qnqDoAaKCtE7KCl4zwYA1RE1jGqQ=;
	b=1fNFYglSuXed13Bt7FFfLQ+oW6E5zRCVD38vphDBWIom0LFTlyp/56jpqiwRKuatGhfwYY
	4YSEYhJuih/31SR+IHfrcnF7x54n/tPzNSY/UrplGGVDFgyWAJZdxvi9UJfWOehY6dNg3/
	bllYt7jsReWyxB4GKWYTi1Zp1PNygl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703859338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kQzfAYsuLbgtPe3qnqDoAaKCtE7KCl4zwYA1RE1jGqQ=;
	b=8i615z9f1Mg9DiR00o3ge00MUMPEQ0JlY7sgCQC60QTbdiGVKjm7zL5PQ6MBD+ZOIBWRmr
	uIXcHMLJ15J+BuCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703859338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kQzfAYsuLbgtPe3qnqDoAaKCtE7KCl4zwYA1RE1jGqQ=;
	b=1fNFYglSuXed13Bt7FFfLQ+oW6E5zRCVD38vphDBWIom0LFTlyp/56jpqiwRKuatGhfwYY
	4YSEYhJuih/31SR+IHfrcnF7x54n/tPzNSY/UrplGGVDFgyWAJZdxvi9UJfWOehY6dNg3/
	bllYt7jsReWyxB4GKWYTi1Zp1PNygl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703859338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kQzfAYsuLbgtPe3qnqDoAaKCtE7KCl4zwYA1RE1jGqQ=;
	b=8i615z9f1Mg9DiR00o3ge00MUMPEQ0JlY7sgCQC60QTbdiGVKjm7zL5PQ6MBD+ZOIBWRmr
	uIXcHMLJ15J+BuCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EA2B136D1;
	Fri, 29 Dec 2023 14:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FwI8JYrUjmUxeAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 29 Dec 2023 14:15:38 +0000
Date: Fri, 29 Dec 2023 15:15:38 +0100
Message-ID: <87le9dxfg5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/3] Support Dell models without _DSD
In-Reply-To: <20231221132518.3213-1-sbinding@opensource.cirrus.com>
References: <20231221132518.3213-1-sbinding@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-1.12 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.02)[95.15%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -1.12
X-Spam-Flag: NO

On Thu, 21 Dec 2023 14:25:15 +0100,
Stefan Binding wrote:
> 
> Add Quirks and driver properties for Dell models.
> Driver properties are required since these models do not have _DSD.
> Additionally, some laptops, including some of these, have an issue
> with their BIOS which causes the SPI speed to be set too slow.
> To ensure a decent performance for laptops with this slow speed,
> disable firmware loading. Running without firmware results in lower
> volume.
> 
> Changes since v1:
> - Rebased onto for-linus
> 
> Stefan Binding (3):
>   ALSA: hda: cs35l41: Support additional Dell models without _DSD
>   ALSA: hda: cs35l41: Prevent firmware load if SPI speed too low
>   ALSA: hda/realtek: Add quirks for Dell models

Applied to topic/cs35l41 branch, which is merged to for-next (for
6.8).


thanks,

Takashi

