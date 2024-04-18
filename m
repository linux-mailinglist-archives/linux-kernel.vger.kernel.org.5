Return-Path: <linux-kernel+bounces-149661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F828A943A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191161F22825
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7686651B1;
	Thu, 18 Apr 2024 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zbn4As1n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZaAvhyla";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jm84Mmh9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bzsPY2Ua"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF825757;
	Thu, 18 Apr 2024 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425846; cv=none; b=Rj94zRU+Zg8OJk+qCNHlagX/0rG2ZJmd09oFRPlTfM9SeIh05yj7HGhj61LgHqE9gUMHBx0aG7VtbsTmSmx6eVmspx1/TJmGy/uF4uBUWk09NnVyIxQE46Nf9HDd8ew57SVSpCHCswvXwbxkfRUXqbUYvGtVuzrALwEVGr8cOu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425846; c=relaxed/simple;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgWIHSIeVduYSnb6B+xE+25Wc/DhQJ5B+pc5ZdxO97GcKfxBGNDobk3fRHP6yxQgVw/vrBu1ZM9P8ffduIekGIxH6zplkO++PHKjYntIUh02tyuCAttJEeAhRkMgE1nKZMTXtPifM+j1adbfLVn48Ehvxo2LtsyztbjQKbp4FSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zbn4As1n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZaAvhyla; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jm84Mmh9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bzsPY2Ua; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 07A2D5C5F3;
	Thu, 18 Apr 2024 07:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713425843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=Zbn4As1nt92hnqQz9M9tiZiclcFRTJ8fwduDo81mw3VnGqNzQWXVOiJmchU+2TjY4hrhEX
	1XYyVMmEe2jGJuBGgRSpytN3WOj1ufRl8Lk4wsR/I0VP4JDwzMUwyptdGgqT+zOcuQmQfZ
	vGJ7zC0s/8sNOfs+wS886PI7XF0wHdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713425843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=ZaAvhylasFfLiw6T178Rvz4jXJyCIWYuLQa5PtwcSsxbczVH8Y/vJMPYfkKATiY5UBeaPE
	gsfntwM9pNiVRKBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Jm84Mmh9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bzsPY2Ua
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713425842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=Jm84Mmh9D6ecYoYE3RmJHALkHq0jfTK8LGmVEqPClMhlyt+OJbaWaTgPQ3JxWm8M1gXNN3
	z64Mp76Qf6ATXI9MKHI+UEwJ3BBKldFtRZcWu97SUpaKeYDkKh2yUsj/SNKsv2SFnkLObj
	HQ2CViEb2uTFile5XS/TAb6RTQ7eV4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713425842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=bzsPY2Uahgzcdsan2XLofGXjeANf9LBbc7LhAO+GeP2DsmXfsBZb5lXbdYovr9WN2mak5S
	QtZNa3ElmbfvBaDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B56801384C;
	Thu, 18 Apr 2024 07:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9GDcKrHNIGZzDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Apr 2024 07:37:21 +0000
Date: Thu, 18 Apr 2024 09:37:30 +0200
Message-ID: <877cgvxgsl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: syzbot <syzbot+0a26629966fddb6d4760@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [syzbot] [sound?] inconsistent lock state in snd_timer_interrupt (3)
In-Reply-To: <0000000000000c4ce90615d48234@google.com>
References: <0000000000000c4ce90615d48234@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [0.80 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAYES_HAM(-0.19)[71.05%];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[0a26629966fddb6d4760];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 0.80
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 07A2D5C5F3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

#syz fix: ALSA: timer: Fix missing irq-disable at closing

