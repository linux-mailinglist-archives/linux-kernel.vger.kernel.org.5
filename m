Return-Path: <linux-kernel+bounces-149618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 635BC8A9384
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C96B21877
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F7E2D057;
	Thu, 18 Apr 2024 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rYomSldS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VxkEdgg5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rYomSldS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VxkEdgg5"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E87129A1;
	Thu, 18 Apr 2024 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422950; cv=none; b=LFFeZoQT0UNw/aZmvuzB9pcFN9V3bWwe8jIHnMCSuABT9ITFceA4VRGIUbhroWXbVAWk/FUSdX9k+++8S0MARwRLUb60cr3lKuEc9WEUe8TB2EWwtzcgYWNKacBEqZts7ZXfsbRP7IpqmkAygM4zmUkZ48gKUs1YP7PHH4O34+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422950; c=relaxed/simple;
	bh=GvMDsc5qT3Bc3RdbKLz9a4lp3vOD/saZfJ7m/naK73E=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrJ6jxXEPegQN+5dyJxCP6a+6Lj0netszduc4TX1eviLVoh3/UHzDTQRpmQrVMezAafFA3cG/R/gyoiVje5oK+iCh0V6SZc+A1czRS0Wxcv1BQcLdbIuH425Lxz5r+NzPIzLfhcU7nhtsPKUqsH+W7V/ijzqTu2Y7pJmTxXbdNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rYomSldS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VxkEdgg5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rYomSldS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VxkEdgg5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 33AF25C53E;
	Thu, 18 Apr 2024 06:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713422947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BrLYOlP5vYHrPTmGOXSY+Gf5C9IRw6nNSjXk0H/RY3A=;
	b=rYomSldSkIRYQc6fOMCiZC8b+Z6sAC8DyTThV7sGgDjCxVlAm00PAtKJ4gKexQ7qVcaEfE
	q8VOUW9XuUAul7+1y2lK2v70dzL9kmo4iGZIqjqG3g9s5890UEq5JHxJdNH+cye1L7I2hM
	QNvqY+TXhG3g13LcI3MngkKaMdDIAC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713422947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BrLYOlP5vYHrPTmGOXSY+Gf5C9IRw6nNSjXk0H/RY3A=;
	b=VxkEdgg5cuEuIhDgO6HYqHf5kBsNC5RPr1zrIm5DHVgpyseTsZE96ycafpYlEasyOl/QH1
	Pb3e49zw705SmMAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rYomSldS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VxkEdgg5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713422947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BrLYOlP5vYHrPTmGOXSY+Gf5C9IRw6nNSjXk0H/RY3A=;
	b=rYomSldSkIRYQc6fOMCiZC8b+Z6sAC8DyTThV7sGgDjCxVlAm00PAtKJ4gKexQ7qVcaEfE
	q8VOUW9XuUAul7+1y2lK2v70dzL9kmo4iGZIqjqG3g9s5890UEq5JHxJdNH+cye1L7I2hM
	QNvqY+TXhG3g13LcI3MngkKaMdDIAC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713422947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BrLYOlP5vYHrPTmGOXSY+Gf5C9IRw6nNSjXk0H/RY3A=;
	b=VxkEdgg5cuEuIhDgO6HYqHf5kBsNC5RPr1zrIm5DHVgpyseTsZE96ycafpYlEasyOl/QH1
	Pb3e49zw705SmMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E07B61384C;
	Thu, 18 Apr 2024 06:49:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 92x0NWLCIGYUegAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Apr 2024 06:49:06 +0000
Date: Thu, 18 Apr 2024 08:49:15 +0200
Message-ID: <87edb3xj10.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: zhanghuayu1233@qq.com
Cc: perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	zhanghuayu.dev@gmail.com
Subject: Re: [PATCH] Fix volumn control of ThinkBook 16P Gen4
In-Reply-To: <tencent_37EB880C5E5BD99D21C16B288115C4545F06@qq.com>
References: <tencent_37EB880C5E5BD99D21C16B288115C4545F06@qq.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-0.53 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	BAYES_HAM(-0.52)[80.30%];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,opensource.cirrus.com,alsa-project.org,vger.kernel.org,gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Queue-Id: 33AF25C53E
X-Spam-Flag: NO
X-Spam-Score: -0.53
X-Spamd-Bar: /

On Sat, 13 Apr 2024 13:41:22 +0200,
zhanghuayu1233@qq.com wrote:
> 
> From: Huayu Zhang <zhanghuayu1233@qq.com>
> 
> change HDA & AMP configuration from ALC287_FIXUP_CS35L41_I2C_2 to
> ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD for ThinkBook 16P Gen4 models to fix volumn
> control issue (cannot fully mute).
> 
> Signed-off-by: Huayu Zhang <zhanghuayu1233@qq.com>

Thanks, applied now.


Takashi

