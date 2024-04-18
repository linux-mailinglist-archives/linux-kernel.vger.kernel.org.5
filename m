Return-Path: <linux-kernel+bounces-149662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4548A943C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA861C2192A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1186A00B;
	Thu, 18 Apr 2024 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uixo/B+l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WZncZakz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uixo/B+l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WZncZakz"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFB1651B1;
	Thu, 18 Apr 2024 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425855; cv=none; b=mL8qZJLo8d1kI3MNCl2TmDZ7Gga+QQASz8/yy5TH9zWZgSEPSCZxqprYw4LWWNy7PHXA03NxbCtjWB9usHKRuyL+lYZ0SBo0mbzwCfXJpT9yZY5pj2ZUVSGSzwUu+TSnF3Exq+qFD6zo6jkk0543oJz2f5yX89/EGbDnDkKi/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425855; c=relaxed/simple;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCUSJ4fSbla4yjnlJp22+Nk1hwZ49KGjCSnP6BYaS4Rx+dGToAaO7sFSe8IQyw/6WxGd9XRRsq1gMFv7TAZCrN5KjXYNW3uFd1HpXnvbqSXBLu2zU8CpzxIaNR8qY7k20Qk1Awngz7TNE8ndf25Mqbx0Lw/BpDTfhNndL8XwPjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uixo/B+l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WZncZakz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uixo/B+l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WZncZakz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B3C95C5F4;
	Thu, 18 Apr 2024 07:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713425852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=uixo/B+l07Io368sphBkjVUxPqTNwtYTmUFXlX05euxjznkrDrX3kS6yTYA/NumafYlwyX
	KUQ++dC29Sid+EbwgunIzmjxIIsEb68qajjTssjVQVVvQ9cXapM/3wq2YjaBAeaBCqscIs
	Bg9ONz066ZI3OCX+i7jt5ZC99KmsSR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713425852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=WZncZakzvhcvNnS+lIJJfwdxCCN0YlGl3xtNtKzhu5TUAw/iiVUp7YsUbJYa9c4u/H10pM
	JE5NKjjyyNiDC9DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713425852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=uixo/B+l07Io368sphBkjVUxPqTNwtYTmUFXlX05euxjznkrDrX3kS6yTYA/NumafYlwyX
	KUQ++dC29Sid+EbwgunIzmjxIIsEb68qajjTssjVQVVvQ9cXapM/3wq2YjaBAeaBCqscIs
	Bg9ONz066ZI3OCX+i7jt5ZC99KmsSR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713425852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=WZncZakzvhcvNnS+lIJJfwdxCCN0YlGl3xtNtKzhu5TUAw/iiVUp7YsUbJYa9c4u/H10pM
	JE5NKjjyyNiDC9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59B1B1384C;
	Thu, 18 Apr 2024 07:37:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1xOXFLzNIGaBDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Apr 2024 07:37:32 +0000
Date: Thu, 18 Apr 2024 09:37:40 +0200
Message-ID: <875xwfxgsb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: syzbot <syzbot+19df3985ca9ea18a8fdf@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com,
	tiwai@suse.de
Subject: Re: [syzbot] [sound?] possible deadlock in snd_timer_close_locked (2)
In-Reply-To: <00000000000007c58c0616069d0e@google.com>
References: <00000000000007c58c0616069d0e@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: 1.19
X-Spam-Level: *
X-Spamd-Result: default: False [1.19 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.01)[50.84%];
	TAGGED_RCPT(0.00)[19df3985ca9ea18a8fdf];
	SINGLE_SHORT_PART(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]

#syz fix: ALSA: timer: Fix missing irq-disable at closing

