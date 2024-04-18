Return-Path: <linux-kernel+bounces-149663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C478A943D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756D91C2174A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B86A342;
	Thu, 18 Apr 2024 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0kBrImHD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qttZgbQM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0kBrImHD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qttZgbQM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5469651B1;
	Thu, 18 Apr 2024 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425863; cv=none; b=Mak62gbsmXHjyvz1IJxFpsD4gv7SekmRzJIdONO8RANvvK9mILwGATFZsg4Xb5G28VlnMjE1Dsfwc/unYXqjUL3xt3Rudkq4ZlnqesGhJAIPk0G+nvKw6jSmlEx93DLEEPjWohXUeLbiQ7CX/vSUVc5MugceGEWO2tPs+rA0XKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425863; c=relaxed/simple;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2RAGr62Sd5GAlf6z1npVelgCtnUknAtxmFWZ8doWySjY7psT18NhPoAo4saa2wNSt2jQ6bOIpgx0cg5NHX5gRNfeZCq9BOtOh+vcRAfFOV9+fib8EIu3xZH93kpY+1uY6cA8o0KYl8a+sTL1ht8y/IgH25vKJ6LNRu7yjHOJvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0kBrImHD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qttZgbQM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0kBrImHD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qttZgbQM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40DD65C5F4;
	Thu, 18 Apr 2024 07:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713425859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=0kBrImHDFrKSQ/ex6CRLUiNWpJJupOMDIcSoAaFDqerAKAv7859uXrpWoPzLJzo5NRO9h0
	j2cHKiPU+aWJtnu4ZDAxvyzS7d+dlyrZmtPv5d3Ih7+77ISpkkNBRzZ1y6j9x6b1H3pVWV
	H2yqqGIiqcgu74gYFbFWswkOWxSoohc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713425859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=qttZgbQMF3vYJ5lV9PvJVdX9iwnYVqTpteV4i5btt6O63DxGxBAQb/H5lxbEFQNMNeskSN
	+R6R+Ir9O/zeG2Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0kBrImHD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qttZgbQM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713425859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=0kBrImHDFrKSQ/ex6CRLUiNWpJJupOMDIcSoAaFDqerAKAv7859uXrpWoPzLJzo5NRO9h0
	j2cHKiPU+aWJtnu4ZDAxvyzS7d+dlyrZmtPv5d3Ih7+77ISpkkNBRzZ1y6j9x6b1H3pVWV
	H2yqqGIiqcgu74gYFbFWswkOWxSoohc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713425859;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=qttZgbQMF3vYJ5lV9PvJVdX9iwnYVqTpteV4i5btt6O63DxGxBAQb/H5lxbEFQNMNeskSN
	+R6R+Ir9O/zeG2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07D021384C;
	Thu, 18 Apr 2024 07:37:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iiB2O8LNIGaVDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Apr 2024 07:37:38 +0000
Date: Thu, 18 Apr 2024 09:37:47 +0200
Message-ID: <874jbzxgs4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: syzbot <syzbot+faf0acea764965b3e59e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [syzbot] [sound?] possible deadlock in _snd_pcm_stream_lock_irqsave (5)
In-Reply-To: <0000000000000457ff0616069d07@google.com>
References: <0000000000000457ff0616069d07@google.com>
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
X-Spamd-Result: default: False [-0.05 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-1.04)[87.60%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[faf0acea764965b3e59e];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 40DD65C5F4
X-Spam-Flag: NO
X-Spam-Score: -0.05
X-Spamd-Bar: /

#syz fix: ALSA: timer: Fix missing irq-disable at closing

