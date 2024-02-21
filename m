Return-Path: <linux-kernel+bounces-74270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A17885D1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8941C23774
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5363B799;
	Wed, 21 Feb 2024 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WaACTNG2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WaACTNG2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FD53B787;
	Wed, 21 Feb 2024 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502155; cv=none; b=TLy/pm3epXHdCTR9GoRTuC5ZoHJ4Lra/FHH7y4TSS4I2D/8H/9eLxpDIfbeY354deUoDQbIYZshQgwjKJBg13cotGbIt4QaCHNZfl94Whv1EGz7fI5RjaVQiWBHHDCDPcjKjG2opsFJTTizEAnkT8v5t9QWXxaJnQLKNyinOG8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502155; c=relaxed/simple;
	bh=P4IowivBzoNIWBfFyDl62im4NWjMcpg9erihxXbDmVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1wnBEU2B0ojX0HvBuarnfA9oJL9fGU8E8P+zBayRqjKIYiyBSgJH23CzWgAoRhZzE6gL85EwQyo5L9+ujoguYwdJYNjB029u95A6WZC5K55CoV0v62cJsVxLq+SNXxHtAnlqKM53SZ/40WAkuj4kyrMqUyjO9RZWP3FpKcBXD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WaACTNG2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WaACTNG2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ADCC522224;
	Wed, 21 Feb 2024 07:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708502151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PtbBQesguJw5L/5dujKSNhT2R4ZTGtPZub9PPAkUNuw=;
	b=WaACTNG2/y8guzY3WY0wfs9CdWpKiwbXdw2pZfRoXwkCDPRrwEb12F0V/creKp7RrW8/do
	ETwi0zyfpAZqWZQx/RyErjUL0gPr4D55+d2BxzBtUcanO905Nf0Nd9L0NDbAomPUnukkt8
	Bkz2ZiPfhs6visJ1+k8WipKmXOYAFV0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708502151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PtbBQesguJw5L/5dujKSNhT2R4ZTGtPZub9PPAkUNuw=;
	b=WaACTNG2/y8guzY3WY0wfs9CdWpKiwbXdw2pZfRoXwkCDPRrwEb12F0V/creKp7RrW8/do
	ETwi0zyfpAZqWZQx/RyErjUL0gPr4D55+d2BxzBtUcanO905Nf0Nd9L0NDbAomPUnukkt8
	Bkz2ZiPfhs6visJ1+k8WipKmXOYAFV0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9562E13A69;
	Wed, 21 Feb 2024 07:55:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G4NzIYes1WUaHwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 21 Feb 2024 07:55:51 +0000
Date: Wed, 21 Feb 2024 08:55:49 +0100
From: Michal Hocko <mhocko@suse.com>
To: Carlos Galo <carlosgalo@google.com>
Cc: rostedt@goodmis.org, akpm@linux-foundation.org, surenb@google.com,
	android-mm@google.com, kernel-team@android.com,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: Update mark_victim tracepoints fields
Message-ID: <ZdWshXSoLthv6J6b@tiehlicka>
References: <20240111210539.636607-1-carlosgalo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111210539.636607-1-carlosgalo@google.com>
X-Spam-Level: ****
X-Spamd-Bar: ++++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WaACTNG2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [4.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 BAYES_SPAM(5.10)[99.99%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 4.09
X-Rspamd-Queue-Id: ADCC522224
X-Spam-Flag: NO

Hi,
sorry I have missed this before.

On Thu 11-01-24 21:05:30, Carlos Galo wrote:
> The current implementation of the mark_victim tracepoint provides only
> the process ID (pid) of the victim process. This limitation poses
> challenges for userspace tools that need additional information
> about the OOM victim. The association between pid and the additional
> data may be lost after the kill, making it difficult for userspace to
> correlate the OOM event with the specific process.

You are correct that post OOM all per-process information is lost. On
the other hand we do dump all this information to the kernel log. Could
you explain why that is not suitable for your purpose?

> In order to mitigate this limitation, add the following fields:
> 
> - UID
>    In Android each installed application has a unique UID. Including
>    the `uid` assists in correlating OOM events with specific apps.
> 
> - Process Name (comm)
>    Enables identification of the affected process.
> 
> - OOM Score
>    Allows userspace to get additional insights of the relative kill
>    priority of the OOM victim.

What is the oom score useful for?

Is there any reason to provide a different information from the one
reported to the kernel log?
__oom_kill_process:
pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
                message, task_pid_nr(victim), victim->comm, K(mm->total_vm),
                K(get_mm_counter(mm, MM_ANONPAGES)),
                K(get_mm_counter(mm, MM_FILEPAGES)),
                K(get_mm_counter(mm, MM_SHMEMPAGES)),
                from_kuid(&init_user_ns, task_uid(victim)),
                mm_pgtables_bytes(mm) >> 10, victim->signal->oom_score_adj);

-- 
Michal Hocko
SUSE Labs

