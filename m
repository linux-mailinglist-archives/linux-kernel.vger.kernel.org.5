Return-Path: <linux-kernel+bounces-141078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB108A1A60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B371284E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A950E47F41;
	Thu, 11 Apr 2024 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mvILCXvr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mvILCXvr"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F89C1D6385;
	Thu, 11 Apr 2024 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850008; cv=none; b=A2g0PTKmSFjS1jryXsLO8gyjTc04o2arCgood6WBpqIxp/ntSy9oTSgglReNFtzZANyKmgrcuS47fNFoNRp72MSK5ZuIOKBRW1xL7ZE9zUDqSem06fXD4VZYEGPNajTyNb91GJ1BCsrln8JJChVTIAI9NUNW8kPWgO75cHP7h5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850008; c=relaxed/simple;
	bh=oluwa4uBbq2SQ9awi8ofoYyeGu4WJDGRc+3ri+ChAIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ue0nyFvq5JLDCnQTVxDc9NwTkubiRvXXGJY6aGqPD0aWSJA/J7nosv6yvrGvXcioBYzmYLuJGKZ3UnGat6OiPsH6ljkLyB4V5e2U/8gImRL6YJIxKYcvOq47KdHSE0oom5QkZSKAZ14CM+RLKvg47UIOx/DIPPsLkn3em3FKM5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mvILCXvr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mvILCXvr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3088A3765C;
	Thu, 11 Apr 2024 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712850004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2XByNyMRfD+PxUu51kh1WRBKG3twlIy8uQsFNS0GR0=;
	b=mvILCXvrw4TQ6/5rw3DDP2K9H8aytX5IdghSHeyb+oTDAAa5Bl/2XnGevAfzT20pzQIdS5
	AnlOXGlE7elw4PLnYymf1WzAQcpVQP3avnsOROultPJoq05D4E3Xj1SA6Y23/Vbshi71Zl
	thh+kgHvOlaLf0ydHuDPk0QiYpnBjHg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mvILCXvr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712850004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2XByNyMRfD+PxUu51kh1WRBKG3twlIy8uQsFNS0GR0=;
	b=mvILCXvrw4TQ6/5rw3DDP2K9H8aytX5IdghSHeyb+oTDAAa5Bl/2XnGevAfzT20pzQIdS5
	AnlOXGlE7elw4PLnYymf1WzAQcpVQP3avnsOROultPJoq05D4E3Xj1SA6Y23/Vbshi71Zl
	thh+kgHvOlaLf0ydHuDPk0QiYpnBjHg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E2691368B;
	Thu, 11 Apr 2024 15:40:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l6UjB1QEGGajXwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Thu, 11 Apr 2024 15:40:04 +0000
Date: Thu, 11 Apr 2024 17:40:02 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Kees Cook <keescook@chromium.org>, Tycho Andersen <tandersen@netflix.com>, 
	Jens Axboe <axboe@kernel.dk>, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Re: [PATCH 2/3] kernel/pid: Remove default pid_max value
Message-ID: <uu7pzw6cib324p6orccxonr5dqhgy5zdrjgpdqtt7yuf6b76o5@5nbw3mm64p7w>
References: <20240408145819.8787-1-mkoutny@suse.com>
 <20240408145819.8787-3-mkoutny@suse.com>
 <20240408132955.70d10145d2ea1b0b12b7a5d0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408132955.70d10145d2ea1b0b12b7a5d0@linux-foundation.org>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3088A3765C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]

Hello.

On Mon, Apr 08, 2024 at 01:29:55PM -0700, Andrew Morton <akpm@linux-foundation.org> wrote:
> That seems like a large change.

In what sense is it large?

I tried to lookup the code parts that depend on this default and either
add the other patches or mention the impact (that part could be more
thorough) in the commit message.

> It isn't clear why we'd want to merge this patchset.  Does it improve
> anyone's life and if so, how?

- kernel devs who don't care about policy
  - policy should be decided by distros/users, not in kernel

- users who need many threads
  - current default is too low
  - this is one more place to look at when configuring

- users who want to prevent fork-bombs
  - current default is ineffective (too high), false feeling of safety
  - i.e. they should configure appropriate mechanism appropriately


I thought that the first point alone would be convincing and that only
scaling impact might need clarification.

Regards,
Michal

