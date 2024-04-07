Return-Path: <linux-kernel+bounces-134195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF46D89AEDE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BC828280F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53CC12B83;
	Sun,  7 Apr 2024 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hqx8hzPH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fbxt/+np";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hqx8hzPH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fbxt/+np"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E9111A1
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712471488; cv=none; b=TTEbygmWIG9RX06PlHTd3DuntBNyhE6JcK51H0PxX9idAr9/+lQ/wNk5XbENqQwcah30Rf895uszL2dwZIU/n+a5WZTGHhRPNvwC1tc1+9DTjSbOPXwzhDlhf/Nh3KDbdO0V8VbL3jCXdcH31l9mWlyW8XUwT8iveG67YR1FjKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712471488; c=relaxed/simple;
	bh=LscY6GJocMQK+H4Ib59aNmIafLZacoz4kUKURedAWAw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVsNYvPeQuxaQTjO+HQWO6aAwUcErOjZYrZamzAMzaNtSKKpFvonHAGsVlXH+zRKdHCMol5rIMXaSESXi6tLo+OVY/j1RaXrp5ynulxPWK1OrjLIVm5Y2MNC6ZWwE/jN5H+CSdgG4NkMk8UJAZIpRLlq0n8GgsptTUMjYA1GN0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hqx8hzPH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fbxt/+np; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hqx8hzPH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fbxt/+np; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2AD5721B53;
	Sun,  7 Apr 2024 06:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712471484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vtb8XL6l6oh4C5DZHSL7lhOAIWkvJstc+d1On1Jd1gI=;
	b=hqx8hzPHIwYUxxQ/uX+fhkcT1hhzVU5u1Ndt8eeSWYhKWVnL5gr1GoKJ8R3NHYVUEnAgBR
	sdxXpC9jS6rlxn8UEK/XZWX9b2GsDtjojNbhANjIVOKG0unkhKJ/C6MYg1Rg3VU1bjKOnY
	iDAKyQtsV+OBaYiYsNYX6RhsDXNKJi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712471484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vtb8XL6l6oh4C5DZHSL7lhOAIWkvJstc+d1On1Jd1gI=;
	b=fbxt/+npRJJfu9MBIFt171OCmriZyseIPvt9x4YrpN3/fsPF048q7g4WDI3mT4z3VZ5wgf
	HfEdN+Qw9ifbqNBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hqx8hzPH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="fbxt/+np"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712471484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vtb8XL6l6oh4C5DZHSL7lhOAIWkvJstc+d1On1Jd1gI=;
	b=hqx8hzPHIwYUxxQ/uX+fhkcT1hhzVU5u1Ndt8eeSWYhKWVnL5gr1GoKJ8R3NHYVUEnAgBR
	sdxXpC9jS6rlxn8UEK/XZWX9b2GsDtjojNbhANjIVOKG0unkhKJ/C6MYg1Rg3VU1bjKOnY
	iDAKyQtsV+OBaYiYsNYX6RhsDXNKJi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712471484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vtb8XL6l6oh4C5DZHSL7lhOAIWkvJstc+d1On1Jd1gI=;
	b=fbxt/+npRJJfu9MBIFt171OCmriZyseIPvt9x4YrpN3/fsPF048q7g4WDI3mT4z3VZ5wgf
	HfEdN+Qw9ifbqNBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EEE9F13586;
	Sun,  7 Apr 2024 06:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id q6nZOLs9EmY8JwAAn2gu4w
	(envelope-from <tiwai@suse.de>); Sun, 07 Apr 2024 06:31:23 +0000
Date: Sun, 07 Apr 2024 08:31:29 +0200
Message-ID: <87msq5lm4e.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	<patches@opensource.cirrus.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for HP SnowWhite laptops
In-Reply-To: <20240405210635.22193-1-vitalyr@opensource.cirrus.com>
References: <20240405210635.22193-1-vitalyr@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-0.58 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.07)[62.81%];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -0.58
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 2AD5721B53
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Fri, 05 Apr 2024 23:06:35 +0200,
Vitaly Rodionov wrote:
> 
> Add support for HP SnowWhite laptops with CS35L51 amplifiers on I2C
> bus connected to Realtek codec.
> 
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

Thanks, applied.


Takashi

