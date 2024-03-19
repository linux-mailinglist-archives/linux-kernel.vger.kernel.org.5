Return-Path: <linux-kernel+bounces-107115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9A487F7A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA2E1C21AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CAD51C36;
	Tue, 19 Mar 2024 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mO9Anxl4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KvrlguMM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HJafmUFp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LJReiJu+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0558A5024E;
	Tue, 19 Mar 2024 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830438; cv=none; b=qfMuFhVJRpvU2+XzFN/s6EEK62r4KCbDumzeZX7glh6sN/Xxui9R3A+la2hrAh5VWGtIGJ2RisKjya0qQJpAcrbzJMn9KMhCbpBdhVyR6DoN83TuGCTvKrEUKr/xqTGv2HlAAVJxWWhJHEvhlZhJz+Y8Fv0Fh5sKOwdhj7LdqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830438; c=relaxed/simple;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNDPaE6QhYdzEw0r9Bas2gUuKAdQMZBp8laD9qHPwzXjOt8/kdi3dWoS3Vx90gP1vt8JOPK9A9XPvF5+HdNM9E4tYRzlV0nMEYb1E9oEWmp/lh4z/1auVUVcTefa16l6AKouzwy1NtD48LBkBmFg0JZLmLfKjpKYxN2lMPKvdpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mO9Anxl4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KvrlguMM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HJafmUFp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LJReiJu+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 98CB5373CA;
	Tue, 19 Mar 2024 06:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710830433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=mO9Anxl4+UMViXXxplAe36SM1H22H+iMrGAOHFXtfNkjKRX7SeLC1FkjkvJietYwQWgQoK
	sqcYrJTztZx89QF3h2yo3HtluRGZLtxaGuuVp2nQuz2r0Gtl6C/SLg0ktZ3MacuN8oUnHZ
	Fyyi1/5xowFKjs5LM9vqRW4ocbj6Odg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710830433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=KvrlguMM/X8MvvkZcJfPbFYY3+MGo2B8m4K3vHTGjId8q2CuPbDn4+5qq7GwY6MmSffU8Q
	PsNTtpjifBojRyDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710830432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=HJafmUFpvbw9GVNIi2JMHqDO+LMK+Znc/qlm5Yxb1xSaUy54LtHH2MK5vW1fb7uCHHZDYk
	1iObHyB8STNcOmnKlm6NDjIssEdjakwDDltOsmC66ee2ujVao7Ubn3gp5lhPEokNPFFVz/
	5UC8NgqsIfr4QjzWavWEmUVHNz/hUhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710830432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=LJReiJu+SXjHep+Des3rCjdTYR8il8Zau/MY9yuXIizaqgZTWXFWDiWl/luXrYnUTlHqXz
	XQ40k+g4+s/zLgCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D392136D6;
	Tue, 19 Mar 2024 06:40:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O9OQEWAz+WXzWQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 19 Mar 2024 06:40:32 +0000
Date: Tue, 19 Mar 2024 07:40:31 +0100
Message-ID: <87zfuu67xc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: syzbot <syzbot+18840ef96e57b83b7fea@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [syzbot] [sound?] possible deadlock in _snd_pcm_stream_lock_irqsave (4)
In-Reply-To: <00000000000096e5980613f4cb96@google.com>
References: <00000000000096e5980613f4cb96@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -2.57
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.57 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.56)[98.03%];
	 SUBJECT_HAS_QUESTION(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[18840ef96e57b83b7fea];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HJafmUFp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LJReiJu+
X-Rspamd-Queue-Id: 98CB5373CA

#syz fix: ALSA: timer: Fix missing irq-disable at closing

