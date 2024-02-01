Return-Path: <linux-kernel+bounces-48184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4399C845862
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE3BB23850
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6685186659;
	Thu,  1 Feb 2024 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lVmM8f89";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PqAs7Yqf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lVmM8f89";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PqAs7Yqf"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4756186645;
	Thu,  1 Feb 2024 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792709; cv=none; b=JZhYcMeZJ+L963iqm+WfnJK/NtTtRsSVfnV0HX05OxMpw4E8+kSEVRetN5MwqepOvLAFidKNzZbHLmetpD4EYZKlXKe9HJQB52BU1+g5dQ52Nkvsc7qbLdReMz7EC0lfCkJAWvAMyiZ81JehSD/kONPhNrMsojlUes7iVSq550M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792709; c=relaxed/simple;
	bh=LOhxzxY4XUUiXgiMzOVHmMj3k+qtieqyMqdHQc6sBmY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0y/eOuYNhTO8CCTxCPHHaCFUW5mkOcNpa+WOkCJOs+/PADrgpvOHu41zqpJHAyOAYp9CKEaxU8iU+ENiUGDSMwobvod62s0xCQbjugj/+E3qDsaH/atlpcZryrnkh9QbCr7+R5aGWm8VIJljn+/H2rFQsjF2beAtX8bRRMTs7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lVmM8f89; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PqAs7Yqf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lVmM8f89; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PqAs7Yqf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 36B9722104;
	Thu,  1 Feb 2024 13:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706792705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5flwLWjRdT6D38BHFSixHKVFpmcwLh1w8VKHHseQfis=;
	b=lVmM8f89uu3p0KJb7Cq8iLmS4IhiFxmpqeUlNmc1FAjcNm5N7C6HplOz9Rmb4Z7xJ1HVpg
	/X9hFtyUOns/jM7F8Gw1WNXW0M6DnDW7ElWuNwyNWpvD1R1Usgkc5z21zaG1Svud+zqz91
	UekSQZLYuqwtDy6jO9GYJjbt61jQmqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706792705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5flwLWjRdT6D38BHFSixHKVFpmcwLh1w8VKHHseQfis=;
	b=PqAs7YqfO0DQVmUi73VLL0i4HOjHb/UhJMdha/87rZKlV5324wpkvQRV/C/yyvW9YB9C7a
	uaG/S1f9fIJhPCBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706792705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5flwLWjRdT6D38BHFSixHKVFpmcwLh1w8VKHHseQfis=;
	b=lVmM8f89uu3p0KJb7Cq8iLmS4IhiFxmpqeUlNmc1FAjcNm5N7C6HplOz9Rmb4Z7xJ1HVpg
	/X9hFtyUOns/jM7F8Gw1WNXW0M6DnDW7ElWuNwyNWpvD1R1Usgkc5z21zaG1Svud+zqz91
	UekSQZLYuqwtDy6jO9GYJjbt61jQmqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706792705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5flwLWjRdT6D38BHFSixHKVFpmcwLh1w8VKHHseQfis=;
	b=PqAs7YqfO0DQVmUi73VLL0i4HOjHb/UhJMdha/87rZKlV5324wpkvQRV/C/yyvW9YB9C7a
	uaG/S1f9fIJhPCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B9B7139B1;
	Thu,  1 Feb 2024 13:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ktKpAQGXu2VrPwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 01 Feb 2024 13:05:05 +0000
Date: Thu, 01 Feb 2024 14:05:04 +0100
Message-ID: <87eddwz667.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: core: Fix dependencies for SND_CORE_TEST
In-Reply-To: <20240201094604.1347793-1-ivan.orlov0322@gmail.com>
References: <20240201094604.1347793-1-ivan.orlov0322@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lVmM8f89;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PqAs7Yqf
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.50 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.49)[79.78%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 0.50
X-Rspamd-Queue-Id: 36B9722104
X-Spam-Flag: NO

On Thu, 01 Feb 2024 10:46:04 +0100,
Ivan Orlov wrote:
> 
> Add the CONFIG_SND_PCM dependency for CONFIG_SND_CORE_TEST config entry
> as the test uses symbols from 'pcm_misc.c'.
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

It should rather select instead of depends-on.  User can't enable
CONFIG_SND_PCM explicitly, but it's selected by the top-level
drivers.

Also, please add Fixes tag.  It's a clear regression fix.


thanks,

Takashi

