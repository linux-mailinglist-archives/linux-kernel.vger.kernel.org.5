Return-Path: <linux-kernel+bounces-120632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0640C88DA91
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766211F28346
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB37E3A1DF;
	Wed, 27 Mar 2024 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qZ2Pkttu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gG1XQHzO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qZ2Pkttu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gG1XQHzO"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0051CA9C;
	Wed, 27 Mar 2024 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533254; cv=none; b=I8DOqZ2CflYjv91eSGbznQneeGdSY7Qd+6RKoDrag9CDBZ1eLAU77zp6ietafLlT23kSTvq9tpaRlm82P06jTEHwPEACCp0ivxJxdw31CTAFaKLQ/E8tZI8+EYaVxgRpCuRappyqGz77Y62yQGJxI+HlYDgZ/TmktWpStWFuV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533254; c=relaxed/simple;
	bh=/RSGL1gNTTk+E2Qxud2oSKiTaC1ct0/6iam11UaSoM4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILg52E0p0mzqsuxccXJRdRWOst8jsqBhW1VKaWqDUsAo/j6VjbTF3NdC5t1XIfti03FV4vP8Ger0tVNqPO1cWk5/KVUKutzFoTBUEkWyEvNDI0GBL92LHFk4i+SIkoVXBzneSjDNI+iOGwsINSsL7+pdcYszDY3S1AOPNFyfYU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qZ2Pkttu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gG1XQHzO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qZ2Pkttu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gG1XQHzO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9078601E9;
	Wed, 27 Mar 2024 09:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711533250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nYySJVDEu2ItYGQHILPTW390eiYeDpkVRciD4RPI5YM=;
	b=qZ2PkttutCx3A9rM55tb41fQ0opeVQtVnXNICDaifyiWQ2jrBk7Wpkf56XZi7MUiFBjYig
	dOS+pMYWboQDTEzoLFbq5MN90hcCMqZLpYhnqTIui3L0e4/6UQg2PTEPOSCB1R5Y0cD5bt
	Pj3Ty139KnGos/+Nj8TZEfWymm0VRZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711533250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nYySJVDEu2ItYGQHILPTW390eiYeDpkVRciD4RPI5YM=;
	b=gG1XQHzOzWGD2lMQFjyWo+j5As2FUbTuYo9fqU3Z/I+zh8rd88Fsp0okf2pfVfGczHGrVx
	YFRmfQaFYu8O8BAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711533250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nYySJVDEu2ItYGQHILPTW390eiYeDpkVRciD4RPI5YM=;
	b=qZ2PkttutCx3A9rM55tb41fQ0opeVQtVnXNICDaifyiWQ2jrBk7Wpkf56XZi7MUiFBjYig
	dOS+pMYWboQDTEzoLFbq5MN90hcCMqZLpYhnqTIui3L0e4/6UQg2PTEPOSCB1R5Y0cD5bt
	Pj3Ty139KnGos/+Nj8TZEfWymm0VRZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711533250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nYySJVDEu2ItYGQHILPTW390eiYeDpkVRciD4RPI5YM=;
	b=gG1XQHzOzWGD2lMQFjyWo+j5As2FUbTuYo9fqU3Z/I+zh8rd88Fsp0okf2pfVfGczHGrVx
	YFRmfQaFYu8O8BAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E1411369F;
	Wed, 27 Mar 2024 09:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bs/bEcLsA2ZFHQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 27 Mar 2024 09:54:10 +0000
Date: Wed, 27 Mar 2024 10:54:12 +0100
Message-ID: <87il1880fv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: llvm@lists.linux.dev,
	Johannes Berg <johannes@sipsolutions.net>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dawei Li <set_pte_at@outlook.com>,
	linuxppc-dev@lists.ozlabs.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] ALSA: aoa: avoid false-positive format truncation warning
In-Reply-To: <20240326223825.4084412-9-arnd@kernel.org>
References: <20240326223825.4084412-1-arnd@kernel.org>
	<20240326223825.4084412-9-arnd@kernel.org>
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
X-Spam-Score: -1.10
X-Spamd-Result: default: False [-1.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[outlook.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[17];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[lists.linux.dev,sipsolutions.net,perex.cz,suse.com,kernel.org,arndb.de,google.com,outlook.com,lists.ozlabs.org,alsa-project.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.80)[84.71%]
X-Spam-Flag: NO

On Tue, 26 Mar 2024 23:38:07 +0100,
Arnd Bergmann wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang warns about what it interprets as a truncated snprintf:
> 
> sound/aoa/soundbus/i2sbus/core.c:171:6: error: 'snprintf' will always be truncated; specified size is 6, but format string expands to at least 7 [-Werror,-Wformat-truncation-non-kprintf]
> 
> The actual problem here is that it does not understand the special
> %pOFn format string and assumes that it is a pointer followed by
> the string "OFn", which would indeed not fit.
> 
> Slightly increasing the size of the buffer to its natural alignment
> avoids the warning, as it is now long enough for the correct and
> the incorrect interprations.
> 
> Fixes: b917d58dcfaa ("ALSA: aoa: Convert to using %pOFn instead of device_node.name")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied this one now to sound.git tree.  Thanks.


Takashi

