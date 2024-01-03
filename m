Return-Path: <linux-kernel+bounces-15409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F29D822BA0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84EC1F2407D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E24218C34;
	Wed,  3 Jan 2024 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WNPa+fMi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GwfWdUn1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WNPa+fMi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GwfWdUn1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684C01864A;
	Wed,  3 Jan 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 601571FD11;
	Wed,  3 Jan 2024 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704279018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4wxXCY1XA5sZiJPe9cvdG0ludmPXkduZ1yrQ2KPpE7w=;
	b=WNPa+fMifSECdTIrV1WxIs4qiZq7PS35RKS09k97hVv7RuQC+OenR3Wfvc07Gs/GyJCMU0
	1SQCPko0Ak2zeyXgojyhrEE/gAesUux7mSZ1QkXBufp8AZAdupI9q5cDAsMin4EiALSHvK
	8hWJGgovw5OkS8IGWaURID42T1xXhe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704279018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4wxXCY1XA5sZiJPe9cvdG0ludmPXkduZ1yrQ2KPpE7w=;
	b=GwfWdUn1QNWHsEE58qZ+GjLILa1hzocESF2tMQbOcWzrdkl6Vs4jYsRXrPJduyd3/BIBCo
	8w3zk7+e+9bKjCBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704279018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4wxXCY1XA5sZiJPe9cvdG0ludmPXkduZ1yrQ2KPpE7w=;
	b=WNPa+fMifSECdTIrV1WxIs4qiZq7PS35RKS09k97hVv7RuQC+OenR3Wfvc07Gs/GyJCMU0
	1SQCPko0Ak2zeyXgojyhrEE/gAesUux7mSZ1QkXBufp8AZAdupI9q5cDAsMin4EiALSHvK
	8hWJGgovw5OkS8IGWaURID42T1xXhe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704279018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4wxXCY1XA5sZiJPe9cvdG0ludmPXkduZ1yrQ2KPpE7w=;
	b=GwfWdUn1QNWHsEE58qZ+GjLILa1hzocESF2tMQbOcWzrdkl6Vs4jYsRXrPJduyd3/BIBCo
	8w3zk7+e+9bKjCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC1B41340C;
	Wed,  3 Jan 2024 10:50:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yjX9N+k7lWXDBwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 03 Jan 2024 10:50:17 +0000
Date: Wed, 03 Jan 2024 11:50:17 +0100
Message-ID: <87bka2bsie.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dorian Cruveiller <doriancruveiller@gmail.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: cs35l41: fix building without CONFIG_SPI
In-Reply-To: <20240103102606.3742476-1-arnd@kernel.org>
References: <20240103102606.3742476-1-arnd@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: *
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.05 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,arndb.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[cirrus.com,opensource.cirrus.com,perex.cz,suse.com,arndb.de,gmail.com,huawei.com,alsa-project.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.74)[93.43%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WNPa+fMi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GwfWdUn1
X-Spam-Score: -1.05
X-Rspamd-Queue-Id: 601571FD11

On Wed, 03 Jan 2024 11:25:59 +0100,
Arnd Bergmann wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_SPI is disabled, the driver produces unused-variable warning:
> 
> sound/pci/hda/cs35l41_hda_property.c: In function 'generic_dsd_config':
> sound/pci/hda/cs35l41_hda_property.c:181:28: error: unused variable 'spi' [-Werror=unused-variable]
>   181 |         struct spi_device *spi;
>       |                            ^~~
> sound/pci/hda/cs35l41_hda_property.c:180:27: error: unused variable 'cs_gpiod' [-Werror=unused-variable]
>   180 |         struct gpio_desc *cs_gpiod;
>       |                           ^~~~~~~~
> 
> Avoid these by turning the preprocessor contionals into equivalent C code,
> which also helps readability.
> 
> Fixes: 916d051730ae ("ALSA: hda: cs35l41: Only add SPI CS GPIO if SPI is enabled in kernel")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied now.  Thanks.


Takashi

