Return-Path: <linux-kernel+bounces-126488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF9C89388F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BEB2817AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468FDB66C;
	Mon,  1 Apr 2024 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vxCmglZw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9kDpKOM2"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792639468;
	Mon,  1 Apr 2024 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711955265; cv=none; b=L9lnnOcTcREq047H+QYB22XJ7TZ4GfKB4Sa5EI6ATvWCSabXkijATY4KKfEdN7xWklFlNjbnBemtUvBEf3f7Jj7OuE98x3u3p0mJADQx4zcrAeFUROfUTdkwOf3+OrWhqwk1XkZ5IX3698102JA6BtSsN8o7+itKxqvbFYYhLc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711955265; c=relaxed/simple;
	bh=dVDH2ru8zx7ARrYDcg9bt/4QbbK1H+rD7UOIXtsFGH0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTweOTcTUQ/fH02i8AS5lKnsnxLqwB8WoGJQKqJ6KRupgC7LdTCv6noi6l6cEvUocg6mT1HpO/sIjMaoEdXQxb/aE40UFnHC1N0fBFHhwifldogTey0hM1tA1fUxSTSEZ5f10DShuJ3hDpn5ZQWFbENbb+P3dDRrIep8Y2mtRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vxCmglZw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9kDpKOM2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F7E91FF6F;
	Mon,  1 Apr 2024 07:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711955256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i52Yxm/nY5hizam5kxXaT7uQYvU/I7XuHa8ZoWvq5HE=;
	b=vxCmglZw9kxtcTQzcB8PvtT4ilf6Dm24tZJGT0kGjF+mG+W9lYB6q7rn3ZmUp/KdLk2JNw
	RzJ4eHSYHPDfZRJ7ArSV+w/YQf3u4LZZpb9fBRn6ZZexuN4L4QfTk9J26goi3dT59ZpN35
	Se+MIS1Ck/EVYEVATvHuXYt1eWIJZsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711955256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i52Yxm/nY5hizam5kxXaT7uQYvU/I7XuHa8ZoWvq5HE=;
	b=9kDpKOM2KOB6MroD7+76OnBpplDMxiuImoM552gB6Z34+nAk4i9Qy5Hrngn3zdILddZJav
	IARzHSEufDgCvwAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 02B541348C;
	Mon,  1 Apr 2024 07:07:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qM5hOjddCmbkRgAAn2gu4w
	(envelope-from <tiwai@suse.de>); Mon, 01 Apr 2024 07:07:35 +0000
Date: Mon, 01 Apr 2024 09:07:40 +0200
Message-ID: <874jcl7e83.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	linux-sound@vger.kernel.org
Subject: Re: regression/bisected/6.9 commit 587d67fd929ad89801bcc429675bda90d53f6592 decrease 30% of gaming performance
In-Reply-To: <CABXGCsNmEtrN9DK-XmESaPm_1xpXm8A+juE+44Jf6AK5JE0+TQ@mail.gmail.com>
References: <CABXGCsNmEtrN9DK-XmESaPm_1xpXm8A+juE+44Jf6AK5JE0+TQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.69 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	BAYES_HAM(-0.00)[31.89%];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: 0.69
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 2F7E91FF6F

On Sun, 31 Mar 2024 22:21:20 +0200,
Mikhail Gavrilov wrote:
> 
> Hi,
> 
> I spotted that FPS was around 122 [1] in the Shadow of the Tomb Raider
> benchmark at commit f6cef5f8c37f but after moving to commit
> 4ae3dc83b047 it decreased to 84 [2].
> 
> I bisected it and the first bad commit was 587d67fd929a.
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Fri Mar 15 11:14:42 2024 +0100
> 
>     ALSA: timer: Fix missing irq-disable at closing
> 
>     The conversion to guard macro dropped the irq-disablement at closing
>     mistakenly, which may lead to a race.  Fix it.
> 
>     Fixes: beb45974dd49 ("ALSA: timer: Use guard() for locking")
>     Reported-by: syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com
>     Closes: http://lore.kernel.org/r/0000000000000b9a510613b0145f@google.com
>     Message-ID: <20240315101447.18395-1-tiwai@suse.de>
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
>  sound/core/timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> To make sure of this I builded kernel at commit 712e14250dd2 with
> revert 587d67fd929a and the benchmarking result was returned to best
> observed by me.
> 
> [1] good results - https://postimg.cc/G4NPHMyk
> [2] bad results - https://postimg.cc/1n0D7sYH
> 
> I attached here my build .config and kernel log.
> Is it possible to find a better approach than 587d67fd929a?

Is it a regression against the performance on 6.8?

If so, what happens when you revert both this (587d67fd929a) and
beb45974dd49?  That should make the timer code back to 6.8 code.


Takashi

