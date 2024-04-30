Return-Path: <linux-kernel+bounces-163958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F5F8B7694
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455761F22B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EE5171650;
	Tue, 30 Apr 2024 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tFjYY3ik";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9oZ4487R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tFjYY3ik";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9oZ4487R"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC9712CD8F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482436; cv=none; b=I6X0B3z7HVnL8TjnLN26BnlAIxCv4dBMo2CwOZiIGeTfZglVj6F0BA4ctrv+RFrG8H/5Jewd9wBylzVbQu8h2+YPk7tG2/QpNV/aKr1QeG8w6KIFJjBSFv95Z78CAyPeBfjPGLTh7ultGIzE6eaOBo68Wr8GhVlWrUMq0GgdAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482436; c=relaxed/simple;
	bh=r7FRtwI8zRzPvvCl2KCVkCnQ1HmMBmLozjO1kH0+tzY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8GqW3XjI/V1YSYjHACQZpr3JlkU/z54Ejz79P+XlLoY71rm4uAI8lk4HHEMsC8kd/IxxAViPlcvfF3KcUHvoMCu6C2iI3YZpZEF3OQKK9NbsSLl5R+nG1WGMBkR5RNL9Fd/zS6Bv29dpjVEKpA2/yF9Iuh6AfSxzJQw6J1fz+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tFjYY3ik; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9oZ4487R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tFjYY3ik; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9oZ4487R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A9E43405D;
	Tue, 30 Apr 2024 13:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714482432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nz8N0tF3ZAzNA0MyZhuy8ig+mc3JPzOBiuWey73KYMw=;
	b=tFjYY3ik4DFWQ/rDjFDfkvcMtsG4+pt+FYsUquNUtBTyk/nfg4rYO7AMonqWsMTz+sQa6O
	09b5Iju0hbTbO8Bi0jUneQqg9lDJWEYO9hc/B3/N30qRsAcdWhqwlzsv43fYEwLxYb/Oj8
	Wx+evBumRboEZGb5S1mNhrC9ihQsrLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714482432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nz8N0tF3ZAzNA0MyZhuy8ig+mc3JPzOBiuWey73KYMw=;
	b=9oZ4487RN1jyid4pLMdhXnk/Z496UXr5WcvJeB9l6tDr5ZO0Vgg7swsLQ7auJrYl7xmYSA
	QrRnIFrvX5yEX1Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tFjYY3ik;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9oZ4487R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714482432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nz8N0tF3ZAzNA0MyZhuy8ig+mc3JPzOBiuWey73KYMw=;
	b=tFjYY3ik4DFWQ/rDjFDfkvcMtsG4+pt+FYsUquNUtBTyk/nfg4rYO7AMonqWsMTz+sQa6O
	09b5Iju0hbTbO8Bi0jUneQqg9lDJWEYO9hc/B3/N30qRsAcdWhqwlzsv43fYEwLxYb/Oj8
	Wx+evBumRboEZGb5S1mNhrC9ihQsrLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714482432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nz8N0tF3ZAzNA0MyZhuy8ig+mc3JPzOBiuWey73KYMw=;
	b=9oZ4487RN1jyid4pLMdhXnk/Z496UXr5WcvJeB9l6tDr5ZO0Vgg7swsLQ7auJrYl7xmYSA
	QrRnIFrvX5yEX1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 562B9136A8;
	Tue, 30 Apr 2024 13:07:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j+FuFADtMGY7LAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 30 Apr 2024 13:07:12 +0000
Date: Tue, 30 Apr 2024 15:07:24 +0200
Message-ID: <87ikzzm22b.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baojun Xu <baojun.xu@ti.com>
Cc: <robh+dt@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>,
	<perex@perex.cz>,
	<pierre-louis.bossart@linux.intel.com>,
	<kevin-lu@ti.com>,
	<shenghao-ding@ti.com>,
	<navada@ti.com>,
	<13916275206@139.com>,
	<v-po@ti.com>,
	<niranjan.hy@ti.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>,
	<yung-chuan.liao@linux.intel.com>,
	<broonie@kernel.org>,
	<soyer@irl.hu>
Subject: Re: [PATCH v4 2/3] ALSA: hda/tas2781: Tas2781 hda driver for SPI
In-Reply-To: <20240430072544.1877-3-baojun.xu@ti.com>
References: <20240430072544.1877-1-baojun.xu@ti.com>
	<20240430072544.1877-3-baojun.xu@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -1.87
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8A9E43405D
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.87 / 50.00];
	BAYES_HAM(-2.86)[99.39%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,perex.cz,ti.com,139.com,alsa-project.org,vger.kernel.org,intel.com,irl.hu];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Tue, 30 Apr 2024 09:25:43 +0200,
Baojun Xu wrote:
> 
> Main source code for tas2781 hda driver for SPI.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>

That's far little description than wished.  You can copy the contents
of your cover letter to here, for example, for more detailed
information.

Second, and most: this patch breaks again the build.
You added the code calling functions that aren't defined yet
(appearing in the patch 3).

Also, some functions seem defined but not really used, e.g.
tasdevice_spi_calbin_remove(), and some are not needed to be global
functions.


thanks,

Takashi

