Return-Path: <linux-kernel+bounces-107116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5168187F7A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B7BB22B35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EB353E11;
	Tue, 19 Mar 2024 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pIsNx3T1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JtoMDHaY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pIsNx3T1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JtoMDHaY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5024F1FA;
	Tue, 19 Mar 2024 06:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830493; cv=none; b=nRU2xilbRz1Bc0bE5qKVAkS4zBsnlXbpG11SqCIhPfv0S51hCsmJAJsJYkv3JsERjLxi0BlG4cNsZfhuklJ34aaZSkhFma3GEVqiQSAH3ru9gb281XMWRewcryBSL0pYqC2DBLdeUjWqmG3ln2tLXJksL8EEHVHuuVAS7VYByf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830493; c=relaxed/simple;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/vTQJ5s7r85f2Vb9iDwTKviVhmtjyO7efP1PFMRxDRd0QWgfjVnAaf2O4J6NNytPe9SzNaUnEzTuMvPH/XU8dYBhww9ebbwiTYhGQFgDTFfMjoWrHWoKOWVl+6imdnT/vByBFuqzTJr810UBUq+i1jZstoY1EsnvRZs+YBZ5K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pIsNx3T1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JtoMDHaY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pIsNx3T1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JtoMDHaY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 33ACC373CB;
	Tue, 19 Mar 2024 06:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710830490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=pIsNx3T1Mky30y/iA+eYk+g0wpSPm5/B0yFMwU6RWFqxkf+mxii5/5cZnYjkaeNfQWUv+a
	QcxcZuOb4ivGrkMTEQCrnBg8nqEWO/vNl08QtRiWmnA94RW/H7hieXMaZyJzBgZsqoGiw5
	3W6j/xhuN9V19tfICREBhSVDoMG6vSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710830490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=JtoMDHaYF2CtUhahqqCQWsT4Wtg0x8QG8R1LNuKr3EAx/AvMJhKxAeJ2CX41XG4BM/tPx1
	7Uz400cVVyg+HrDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710830490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=pIsNx3T1Mky30y/iA+eYk+g0wpSPm5/B0yFMwU6RWFqxkf+mxii5/5cZnYjkaeNfQWUv+a
	QcxcZuOb4ivGrkMTEQCrnBg8nqEWO/vNl08QtRiWmnA94RW/H7hieXMaZyJzBgZsqoGiw5
	3W6j/xhuN9V19tfICREBhSVDoMG6vSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710830490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cB02ygBIYWAmN9avtVxh22JTZFVbrPvtMdEwWza9xhA=;
	b=JtoMDHaYF2CtUhahqqCQWsT4Wtg0x8QG8R1LNuKr3EAx/AvMJhKxAeJ2CX41XG4BM/tPx1
	7Uz400cVVyg+HrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC598136D6;
	Tue, 19 Mar 2024 06:41:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y9AdOJkz+WUyWgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 19 Mar 2024 06:41:29 +0000
Date: Tue, 19 Mar 2024 07:41:29 +0100
Message-ID: <87y1ae67vq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: syzbot <syzbot+d832e7bb0f8bf47217f1@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [syzbot] [sound?] inconsistent lock state in snd_timer_interrupt
In-Reply-To: <000000000000048fbc0613f4eff0@google.com>
References: <000000000000048fbc0613f4eff0@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pIsNx3T1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JtoMDHaY
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.96 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.95)[99.78%];
	 TAGGED_RCPT(0.00)[d832e7bb0f8bf47217f1];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -2.96
X-Rspamd-Queue-Id: 33ACC373CB
X-Spam-Flag: NO

#syz fix: ALSA: timer: Fix missing irq-disable at closing

