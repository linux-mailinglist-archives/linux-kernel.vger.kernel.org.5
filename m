Return-Path: <linux-kernel+bounces-112279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1135C8877CB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB416282A5D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D54F9FE;
	Sat, 23 Mar 2024 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Juk4anC+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4ji9fY8b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Juk4anC+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4ji9fY8b"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDDA611A;
	Sat, 23 Mar 2024 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711186272; cv=none; b=pIqrXPJdigv7ihdaVLwri5SlD3xQ7s7gQBcGaCncBbKupa9PN2pUJomD68Xrcspo8JYXTY0y79cICYNkko8ZaU8goMbl43voo+FY7lhv/uplBzH/MX9INXBqO3z/jIQgOWOY2Lw/Rc9AtKMIzive1P+JF9DciliXCGoZ82CVpUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711186272; c=relaxed/simple;
	bh=6NpyDAgbjRw3OQ0pMhygod1k/+4qizrRRqzBiVimABA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWfDQwzNTzQUaOtfD3v2vmIKC1hL80FvSMSlP1pIlgHMM+OBm8goZOc1KOW843Z37qycmJn14J84iELm31zYghca4M82ZKh4smIL77v6uEBYR9c9+5bHFk0ISEsVDHLmi5kFtmEl06wyp4u0Vh7NqUrAaoc8W4WEi2JCvgQ9pAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Juk4anC+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4ji9fY8b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Juk4anC+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4ji9fY8b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A89E3ED7A;
	Sat, 23 Mar 2024 09:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711186268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3m9NH58/AaLMQRUBEgsCthtaq6BILqdmeuQvfjbMDxU=;
	b=Juk4anC+ArAXOUxTB5FdYB6hGk+9YVzppOA3K/GNFA7BIBECqkSJgh8XsevXOVcF/b2brh
	lvOj0Ad7TaALeB7i3TTReCFuTAlCjCGRZ7bNwqANoHeOaW2WVQYElvKc19Mi39wAcWyuTM
	CWN/vqsS2KDq9UQtzeiu55cuzjgNGsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711186268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3m9NH58/AaLMQRUBEgsCthtaq6BILqdmeuQvfjbMDxU=;
	b=4ji9fY8bAMagWrUv1xqzttshcJNKAu6QCUVyS3EGg+GxEiLfVGOrPvoQAnrXQyg2ZH0ATq
	WxR/yfx5lBkGQfBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711186268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3m9NH58/AaLMQRUBEgsCthtaq6BILqdmeuQvfjbMDxU=;
	b=Juk4anC+ArAXOUxTB5FdYB6hGk+9YVzppOA3K/GNFA7BIBECqkSJgh8XsevXOVcF/b2brh
	lvOj0Ad7TaALeB7i3TTReCFuTAlCjCGRZ7bNwqANoHeOaW2WVQYElvKc19Mi39wAcWyuTM
	CWN/vqsS2KDq9UQtzeiu55cuzjgNGsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711186268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3m9NH58/AaLMQRUBEgsCthtaq6BILqdmeuQvfjbMDxU=;
	b=4ji9fY8bAMagWrUv1xqzttshcJNKAu6QCUVyS3EGg+GxEiLfVGOrPvoQAnrXQyg2ZH0ATq
	WxR/yfx5lBkGQfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 573C5136A1;
	Sat, 23 Mar 2024 09:31:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZJnNE1yh/mVzIwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 23 Mar 2024 09:31:08 +0000
Date: Sat, 23 Mar 2024 10:31:08 +0100
Message-ID: <87jzltxpk3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: LuMingYin <lumingyindetect@163.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	minhuadotchen@gmail.com
Subject: Re: [PATCH] sound:Fix a memory leak in snd_ctl_elem_add_compat function
In-Reply-To: <20240323092712.685675-1-lumingyindetect@163.com>
References: <20240323092712.685675-1-lumingyindetect@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -0.81
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Juk4anC+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4ji9fY8b
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[163.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[vger.kernel.org,perex.cz,suse.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.30)[75.00%]
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8A89E3ED7A

On Sat, 23 Mar 2024 10:27:12 +0100,
LuMingYin wrote:
> 
> In the function snd_ctl_elem_add_compat defined in /linux/sound/core/control_compat.c, a pointer named data is declared. This pointer allocates a block of dynamic memory using the kzalloc function at line 354. When the if statement at line 355 returns false, it indicates successful allocation of the dynamic memory area pointed to by data. However, when the if statements at lines 359 or 362 are true, the program will not execute the snd_ctl_elem_add(file, data, replace); operation at line 389 and will return directly. During this process, the dynamic memory area pointed to by data is neither freed nor used, leading to a memory leak bug. This commit fixes the aforementioned memory leak issue.
> 
> Signed-off-by: LuMingYin <lumingyindetect@163.com>

Ditto as another mail, it's automatically freed.


Takashi

