Return-Path: <linux-kernel+bounces-28942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECD48304F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE2B2862F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3D81DFE2;
	Wed, 17 Jan 2024 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p3WTc8h0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Zzq4BwP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p3WTc8h0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Zzq4BwP"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB541DFC7;
	Wed, 17 Jan 2024 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705493307; cv=none; b=O8FLmgQHOqK+CHFsTpXJg7H3ZO9qTqsIcpgUSVQgQkGjr4QEFnp102/0zdmGgu0Y4u8RrBxZsHnnRVvvTTgUMQmpTwo6hWHFjmhfGwdJ8wWT4kVRuTkRd/817rXhES5/Nmg8ubLPuCBVk6MEv3hOWZJLf2i04CvWQoxZWnp/jLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705493307; c=relaxed/simple;
	bh=q4FKtlbQxuWFWzmo9yaIfVN2KvTlMKcHXxpzku4plKg=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Spam-Score:
	 X-Spamd-Result:X-Spam-Flag; b=a6IHwJtAo4JtLRF4FvHJmHUgBwFsN+nWnPO4Jux55eKnJTGxz0AhN7rG0yvWV1X4iYkIsSCYiHoLFCKJ/0zRCGsrNKvIyn/VyjpHLolUzEyumQd8s9N5QkY0VrObMdpT1EvxL6uFtpR19TQIDXEDPNSbGVOAbsSsWA2ztDXGv58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p3WTc8h0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Zzq4BwP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p3WTc8h0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Zzq4BwP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 39C9121FD1;
	Wed, 17 Jan 2024 12:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705493303;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTFWylkF/behWgunuXA11B8WAzc3sBR9mDzkTqI7sNc=;
	b=p3WTc8h0gXYOKAVJBGKxIMT+FjuK7T4yqXsBIdq8SI4v2ibXgI9A4xGSffQ0gANtJUqM8m
	kYAE89evCOsrsLBl7Ih7L6axGXoUQ6tJmQgobu/5fa/DWeqYMcGfQQLsR5MpX1j/ht1DOY
	EokMK1fNBC7TNVuiT+YQ/eAOCmlXTYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705493303;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTFWylkF/behWgunuXA11B8WAzc3sBR9mDzkTqI7sNc=;
	b=2Zzq4BwP+r98g+TuFI4ZZsJCj6P1tNrcEDtija3MhBcAlZNa2wDhxrall9hebT8RUu840h
	5mIHhYq01u6y7bBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705493303;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTFWylkF/behWgunuXA11B8WAzc3sBR9mDzkTqI7sNc=;
	b=p3WTc8h0gXYOKAVJBGKxIMT+FjuK7T4yqXsBIdq8SI4v2ibXgI9A4xGSffQ0gANtJUqM8m
	kYAE89evCOsrsLBl7Ih7L6axGXoUQ6tJmQgobu/5fa/DWeqYMcGfQQLsR5MpX1j/ht1DOY
	EokMK1fNBC7TNVuiT+YQ/eAOCmlXTYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705493303;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTFWylkF/behWgunuXA11B8WAzc3sBR9mDzkTqI7sNc=;
	b=2Zzq4BwP+r98g+TuFI4ZZsJCj6P1tNrcEDtija3MhBcAlZNa2wDhxrall9hebT8RUu840h
	5mIHhYq01u6y7bBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4C7213751;
	Wed, 17 Jan 2024 12:08:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i2CnLTbDp2XTUgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 17 Jan 2024 12:08:22 +0000
Date: Wed, 17 Jan 2024 13:08:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org,
	Maciej =?iso-8859-2?Q?=AFenczykowski?= <maze@google.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Matthias Gerstner <matthias.gerstner@suse.com>,
	Avinesh Kumar <akumar@suse.de>
Subject: Re: [PATCH 1/1] socket.7: Mention CAP_NET_RAW on SO_MARK
Message-ID: <20240117120821.GA2705119@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240116110418.2577798-1-pvorel@suse.cz>
 <ZaadPmLFCI4rsGy_@debian>
 <20240117091452.GB2665992@pevik>
 <ZafBxnhOSWxBRWko@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZafBxnhOSWxBRWko@debian>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.59
X-Spamd-Result: default: False [-1.59 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.09)[88.14%]
X-Spam-Flag: NO

> Hi Petr,

> On Wed, Jan 17, 2024 at 10:14:52AM +0100, Petr Vorel wrote:
> > Hi Alex,

> > > Hi Petr,

> > > On Tue, Jan 16, 2024 at 12:04:18PM +0100, Petr Vorel wrote:
> > > > Added in 079925cce1d0 ("net: allow SO_MARK with CAP_NET_RAW") in v5.17.

> > > > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> > > Patch applied.  Thanks!

> > Thank you! BTW I don't see this patch in git tree [1], maybe you just haven't
> > push yet.

> That's it.  I'm first pushing them to a 'contrib' branch (similar to
> Linux 'next') in my own server[1], and after one day or so I push to
> master.  That buffering allows me to catch some mistakes.

Thanks a lot for info!

> [1]:  <https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/log/?h=contrib>

Ah, maybe my patch to MAINTAINERS was wrong, please push the correct tree
https://lore.kernel.org/linux-man/20240117091903.2668916-1-pvorel@suse.cz/

> 	$ git log --all --graph --oneline -10
> 	* 0c118822f (alx/contrib, contrib) open.2: srcfix
> 	* 24347d22a syscalls.2: ffix
> 	* 9e04cb40f mremap.2: wfix
> 	* 3a271d5b8 fts.3, div_t.3type: ffix
> 	* 527f31b9f socket.7: Mention CAP_NET_RAW on SO_MARK
> 	| * 71c25f15d (alx/MR, MR) man*/: ffix (MR.sed)
> 	|/  
> 	* d82ce270c (HEAD -> master, korg/master, alx/main, main) locale.5: tfix
> 	* f65154cba cpuid.4: Note which CPUs don't support CPUID and what happens
> 	* f98168310 sched_getcpu.3: tfix
> 	* 26cdb3ebb faccessat(2), utimensat(2): Document AT_EMPTY_PATH flag

> I'll push in a moment to master.

Thanks!

Kind regards,
Petr

> Have a lovely day,
> Alex

