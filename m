Return-Path: <linux-kernel+bounces-142841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4FF8A30B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB15E1C22FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAE913C8F6;
	Fri, 12 Apr 2024 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uvwp+VqA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uvwp+VqA"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2435E13C8E6;
	Fri, 12 Apr 2024 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932332; cv=none; b=bE6hFpJy6XlJ4HrHzg767xj8WKQeCOBPe+GNxPln++dECcasWUY9JFfqt3XTCtxdVak6TmcYrhUkH52LIbIZLkQ5ESBej575uZDcXBtTbMjgX6r6FLyHOr+TvgxMBs6ZV6dgRlgZLKgG5keZklBNJZT7Wb+DujxceparSHBKCws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932332; c=relaxed/simple;
	bh=IFZvJykfn2sGx0b/uRLpxd0pNmIcSX5ob3V09SFcUIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+QB69mH8c/NaAgrAeHRSOvC26ugHfvW0aeyyH5z8fSGMlf2gx2qzCPNPY1E7E5bDL7f/VMFsTdheikeLwz9EQDCX+SzoNVNqvky39lo6Lwu6UmSt8W7MlMzzxsOr0EIdJ/muWmDzW8R5t/FCYmyGj+zBnAwArvXw5ewNoEBWVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uvwp+VqA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uvwp+VqA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2297338375;
	Fri, 12 Apr 2024 14:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712932329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFZvJykfn2sGx0b/uRLpxd0pNmIcSX5ob3V09SFcUIM=;
	b=uvwp+VqABkwHrsr/ZHKGMio1xE1cSeLJUay+GWE4xY9G1zEzsy5JylgoNyBZ6tpxYlyAu4
	ZiIX7IuGFLlc5eZODcZeFWZkoXwzSA8kUExaMYNKPSFHOWzeoUkMXcdzjcIddsoywZn7Gn
	9B0lM2cWZadjj6iRxd8WGR8Zqu6UtW8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uvwp+VqA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712932329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFZvJykfn2sGx0b/uRLpxd0pNmIcSX5ob3V09SFcUIM=;
	b=uvwp+VqABkwHrsr/ZHKGMio1xE1cSeLJUay+GWE4xY9G1zEzsy5JylgoNyBZ6tpxYlyAu4
	ZiIX7IuGFLlc5eZODcZeFWZkoXwzSA8kUExaMYNKPSFHOWzeoUkMXcdzjcIddsoywZn7Gn
	9B0lM2cWZadjj6iRxd8WGR8Zqu6UtW8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 106EF1368B;
	Fri, 12 Apr 2024 14:32:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WcHOA+lFGWZpcwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Fri, 12 Apr 2024 14:32:09 +0000
Date: Fri, 12 Apr 2024 16:32:07 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Kees Cook <keescook@chromium.org>, Tycho Andersen <tandersen@netflix.com>, 
	Jens Axboe <axboe@kernel.dk>, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Re: [PATCH 2/3] kernel/pid: Remove default pid_max value
Message-ID: <thp7quwb52md3f4vguhoe2ynf6qm4a3fibtwsjywxyqjpwudgp@qcld4t66c7iy>
References: <20240408145819.8787-1-mkoutny@suse.com>
 <20240408145819.8787-3-mkoutny@suse.com>
 <20240408132955.70d10145d2ea1b0b12b7a5d0@linux-foundation.org>
 <uu7pzw6cib324p6orccxonr5dqhgy5zdrjgpdqtt7yuf6b76o5@5nbw3mm64p7w>
 <20240411150331.84f57aeb42b0907536997fa6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411150331.84f57aeb42b0907536997fa6@linux-foundation.org>
X-Spam-Flag: NO
X-Spam-Score: -3.97
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2297338375
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.97 / 50.00];
	BAYES_HAM(-2.96)[99.84%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]

On Thu, Apr 11, 2024 at 03:03:31PM -0700, Andrew Morton <akpm@linux-foundation.org> wrote:
> A large increase in the maximum number of processes.

The change from (some) default to effective infinity is the crux of the
change. Because that is only a number.
(Thus I don't find the number's 12700% increase alone a big change.)

Actual maximum amount of processes is "workload dependent" and hence
should be determined based on the particular workload.

> Or did I misinterpret?

I thought you saw an issue with projection of that number into sizings
based on the default. Which of them comprises the large change in your
eyes?

Thanks,
Michal

