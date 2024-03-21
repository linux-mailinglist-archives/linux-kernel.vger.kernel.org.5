Return-Path: <linux-kernel+bounces-109693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93400881C83
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74D51C2104C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C68E3FBBE;
	Thu, 21 Mar 2024 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BVmAlxDy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xJ+wJFu5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BVmAlxDy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xJ+wJFu5"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF853BB4F;
	Thu, 21 Mar 2024 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711002790; cv=none; b=XOibNK8h67pOOP9+/KzTtp2jyhLtIzxgkd6O03yo3sJMyE7nUqoAZ9o/2hy8W8fFbiGZY8/w5txZjYYfVQR441BTosqSJteMqKLsh+4zI3G6fU+XNaFJjUfbNwQ8GwYEzVZdezsNnqSHBbTjdNkHwvDfdQtZ/n4yXI3ZpF5sgrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711002790; c=relaxed/simple;
	bh=WwAGFrjD+oCIhEvw9WxEO4A1B0E7yDaH3fcLR5SunEY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTvNj6i1HzcMjDM8s1wq6N2EYZuoeHzP0Vmx03TdC90ar2lKuqb741rTRiZ5QNz7xHp0NibX0QYHYu0mAaDgd4Lu/nBlJHzVvlDlCfsQfAjZvmFc2ukpuwxt8gixEyqVCqYwPMWgKK2WDSSwhbFxu9IwmfRBir+1sGEXCfJ0aUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BVmAlxDy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xJ+wJFu5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BVmAlxDy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xJ+wJFu5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E1945C986;
	Thu, 21 Mar 2024 06:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711002784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrVBJ0KMskz94C4NAej7qaBmjKzm3A9HzZyOV0QawhY=;
	b=BVmAlxDy8I/IulSNNcOSJG/cttbGXGHqlk/VQCLb+dHNbTlBh1tglr3xPlcSfvnO/2UOtE
	QpJ/+zFxEEjPGvJdldDQ8zY2IX+q0Zui8FrWXtvlslvw5uvDR0Rg7VZWT+bgeJ5729iK4x
	vb8txFv19JTItTzDFxIP8Xoe9boMQMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711002784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrVBJ0KMskz94C4NAej7qaBmjKzm3A9HzZyOV0QawhY=;
	b=xJ+wJFu5HetTZfM8aJGWcXd1GAmal+RCAI9xAgt4KsUAlZNRy3gitxEH/6wXe+kOpfi3N9
	JFtYP4Cq5+AON3Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711002784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrVBJ0KMskz94C4NAej7qaBmjKzm3A9HzZyOV0QawhY=;
	b=BVmAlxDy8I/IulSNNcOSJG/cttbGXGHqlk/VQCLb+dHNbTlBh1tglr3xPlcSfvnO/2UOtE
	QpJ/+zFxEEjPGvJdldDQ8zY2IX+q0Zui8FrWXtvlslvw5uvDR0Rg7VZWT+bgeJ5729iK4x
	vb8txFv19JTItTzDFxIP8Xoe9boMQMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711002784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrVBJ0KMskz94C4NAej7qaBmjKzm3A9HzZyOV0QawhY=;
	b=xJ+wJFu5HetTZfM8aJGWcXd1GAmal+RCAI9xAgt4KsUAlZNRy3gitxEH/6wXe+kOpfi3N9
	JFtYP4Cq5+AON3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01CC5136AD;
	Thu, 21 Mar 2024 06:33:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cc1JOp/U+2VFTwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 21 Mar 2024 06:33:03 +0000
Date: Thu, 21 Mar 2024 07:33:03 +0100
Message-ID: <87y1acrt5s.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+18840ef96e57b83b7fea@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [PATCH] ALSA: timer: fix deadlock in _snd_pcm_stream_lock_irqsave
In-Reply-To: <tencent_AC7946DBB367A364897F43B2045A37625705@qq.com>
References: <00000000000096e5980613f4cb96@google.com>
	<tencent_AC7946DBB367A364897F43B2045A37625705@qq.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.90
X-Spamd-Result: default: False [-0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-2.10)[95.62%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[qq.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[18840ef96e57b83b7fea];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email];
	 FREEMAIL_TO(0.00)[qq.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Thu, 21 Mar 2024 03:22:24 +0100,
Edward Adam Davis wrote:
> 
> [Syzbot reported]
> swapper/2/0 just changed the state of lock:
> ffff88802a304110 (&group->lock#2){..-.}-{2:2}, at: _snd_pcm_stream_lock_irqsave+0xa0/0xd0 sound/core/pcm_native.c:170
> but this lock took another, SOFTIRQ-unsafe lock in the past:
>  (&timer->lock){+.+.}-{2:2}
> 
> 
> and interrupts could create inverse lock ordering between them.
> 
> 
> other info that might help us debug this:
>  Possible interrupt unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&timer->lock);
>                                local_irq_disable();
>                                lock(&group->lock#2);
>                                lock(&timer->lock);
>   <Interrupt>
>     lock(&group->lock#2);
> 
>  *** DEADLOCK ***
> [Fix]
> Ensure that the context interrupt state is the same before and after using the
> timer->lock.
> 
> Fixes: beb45974dd49 ("ALSA: timer: Use guard() for locking")
> Reported-and-tested-by: syzbot+18840ef96e57b83b7fea@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

This was already fixed in Linus tree commit
587d67fd929ad89801bcc429675bda90d53f6592.


thanks,

Takashi

