Return-Path: <linux-kernel+bounces-104250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB1E87CB3A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05204B22E29
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7531862E;
	Fri, 15 Mar 2024 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aowXEWcR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hMhKqYEh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aowXEWcR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hMhKqYEh"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E2182D4;
	Fri, 15 Mar 2024 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710497675; cv=none; b=bjDmpHcR2WQjgmtxAl43udKUgPogulIi+kBVmNaExSjS248eoNuTPHcJvzLEg7by3JEpD8a0FdY1adYGqjMA9PY3pzVdAsA2jRJSCf3h/ur3kzZr6rxZxWIfjyJozxXo7t8s7UNPaTDJ65poFPHvRX46IUJxEjIar/sQ1Z1kCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710497675; c=relaxed/simple;
	bh=UsbmK9fmU3C126PD4sa4jNSwSxuxUdY1RLY4p+iJL2I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9E9e5hv9knoGykCXu+FGT+sASbau940OcyINxQuHKTIgssUHl3b8CVtLaEm5OjEDhn7sWDigb3w/wutOyTeDBqNFPJIh3sfuWgEvY95HK0JNYJMRLJSEGKHXPkLYAzUuJx/sunFs57TSXL5dfz+XedSXHzFYx23yOH4Ovjc2ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aowXEWcR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hMhKqYEh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aowXEWcR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hMhKqYEh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AFE0B1FB59;
	Fri, 15 Mar 2024 10:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710497671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G1dpeR8AdO6+eAWIu+TQT/0nMheZgF9XKgeFMBR3eEU=;
	b=aowXEWcRuEcGaXPIxVRDPmYOwc0oQzyKIFcwsB5OX/Q0/q700PkS8DH/UjXL5srYROuZS7
	L2m26NLS+wKmzON7msyoZyIxPpimzRxfaW1Y/b4Jsy63JtzW1mH7BGQ3lli0DFcKIAVbS0
	YvcFjpIM36ViSkkvMvGQViBVA40bJP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710497671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G1dpeR8AdO6+eAWIu+TQT/0nMheZgF9XKgeFMBR3eEU=;
	b=hMhKqYEhThNZHSOaPSOD5eIRRBMXrUqaPhw+e1Cax1tdW4TSA6w074B9aJWNvuUqUBKzK9
	0ClhCuCE3EVcIoAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710497671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G1dpeR8AdO6+eAWIu+TQT/0nMheZgF9XKgeFMBR3eEU=;
	b=aowXEWcRuEcGaXPIxVRDPmYOwc0oQzyKIFcwsB5OX/Q0/q700PkS8DH/UjXL5srYROuZS7
	L2m26NLS+wKmzON7msyoZyIxPpimzRxfaW1Y/b4Jsy63JtzW1mH7BGQ3lli0DFcKIAVbS0
	YvcFjpIM36ViSkkvMvGQViBVA40bJP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710497671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G1dpeR8AdO6+eAWIu+TQT/0nMheZgF9XKgeFMBR3eEU=;
	b=hMhKqYEhThNZHSOaPSOD5eIRRBMXrUqaPhw+e1Cax1tdW4TSA6w074B9aJWNvuUqUBKzK9
	0ClhCuCE3EVcIoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EA6A13460;
	Fri, 15 Mar 2024 10:14:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1r46GYcf9GVzaAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 Mar 2024 10:14:31 +0000
Date: Fri, 15 Mar 2024 11:14:30 +0100
Message-ID: <87wmq3by49.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: syzbot <syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [syzbot] [sound?] possible deadlock in snd_pcm_period_elapsed (4)
In-Reply-To: <0000000000000b9a510613b0145f@google.com>
References: <0000000000000b9a510613b0145f@google.com>
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
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aowXEWcR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hMhKqYEh
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.84 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.15)[68.98%];
	 TAGGED_RCPT(0.00)[28c1a5a5b041a754b947];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: 0.84
X-Rspamd-Queue-Id: AFE0B1FB59
X-Spam-Flag: NO

On Fri, 15 Mar 2024 11:00:31 +0100,
syzbot wrote:
(snip)
> the shortest dependencies between 2nd lock and 1st lock:
>  -> (&timer->lock){+.+.}-{2:2} {
>     HARDIRQ-ON-W at:
>                       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>                       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>                       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>                       spin_lock include/linux/spinlock.h:351 [inline]
>                       class_spinlock_constructor include/linux/spinlock.h:561 [inline]
>                       snd_timer_close_locked+0x53/0x8d0 sound/core/timer.c:412

Ouch, I incorrectly converted from spin_lock_irq() to
guard(spinlock).  It should have been guard(spinlock_irq), of course.

Will submit the fix patch.


thanks,

Takashi

