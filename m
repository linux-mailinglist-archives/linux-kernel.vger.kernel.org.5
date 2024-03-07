Return-Path: <linux-kernel+bounces-95217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CCC874ACD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FC2281B06
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71FE839FD;
	Thu,  7 Mar 2024 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Zryh4i7G";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bjSGKP6w"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530AA1CD29;
	Thu,  7 Mar 2024 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803619; cv=none; b=I8ihgzJMjJ+lpL2oVQSqYY1CZWcCMBGo220psWmbOvC+SauFF4p9wDZQVJSxOX2Fl+NmYK4U0mHANyEk9huN4ZHbXcHU5KuIt6RqE9k55+FEA7A/Gyd6ol0z6GdpoHqLfz4FpU2ZiTNQtrKASGnNVeRE2LiP20JCvIabT3C8esE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803619; c=relaxed/simple;
	bh=fSVUIcKgmY6DvtXx3zD+ih7OZ3jvAza2NIYm6Zb4Enk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZBENRBTDCryGKO+JnSaHm1BBU6cSHCduEW0155+dl9kGSjVZ2kMtj5eyzfWHwY2RFhRXi6JUxFpZiFxmSqbVKgiJFDdblOfxstik7SM9g3jJvX/QRJoMAyMVXeeyS+rxhQam25l78nAiG8ntUYAms6CJ0kMtNzi3ymT2Hv8iMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Zryh4i7G; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bjSGKP6w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A92A13EB89;
	Thu,  7 Mar 2024 09:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709803588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=49eI9FsfEc0os9WuNfnd5K+4CQXJgYzosIDjRsUtlwQ=;
	b=Zryh4i7GQWJaae+0LvHwuuEXcojnHFGrRwQ6bIjfVfe/yjuT7YrMDQ5Jd1mlZaXID9jD79
	b6KRE0KDDhqJyUrrmKvGqwgDJfPNTmTQ3EIOYZEE/ZolmQ4Kxo8qqDOVNfxR8mf0reFFcy
	etSQf4Ci4ZkKrvcx6ReBFrgt08EDF6M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709803587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=49eI9FsfEc0os9WuNfnd5K+4CQXJgYzosIDjRsUtlwQ=;
	b=bjSGKP6wJyNQzALLKtdz6JeZvDQ4XpOaszh2ul11+k2G2wP9pWsgTI4dKY7izI9m06Ge0t
	9MGtZkCCYsPDw0Kk9/A+8kU6jUUrkYgMNoK4ldUAbUcQkcR+qNMKxs1+qSENqy1QYs+rAg
	o7yxPV6C8R/smpbn56Vx6J78+jCcEtU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81CFC12FC5;
	Thu,  7 Mar 2024 09:26:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S+uwHEOI6WXgGQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 07 Mar 2024 09:26:27 +0000
Date: Thu, 7 Mar 2024 10:26:18 +0100
From: Michal Hocko <mhocko@suse.com>
To: Bixuan Cui <cuibixuan@vivo.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, akpm@linux-foundation.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, opensource.kernel@vivo.com
Subject: Re: [PATCH -next v6 0/2] Make memory reclamation measurable
Message-ID: <ZemIOtbIoMYqcf-V@tiehlicka>
References: <20240105013607.2868-1-cuibixuan@vivo.com>
 <fac8d079-100e-4b8d-9a35-db8219b28b51@vivo.com>
 <20240220212202.59ddc123@gandalf.local.home>
 <3d4f44ee-f533-446f-a9e6-7f58afc78d65@vivo.com>
 <ZdWpyN_8Z6dvDQ48@tiehlicka>
 <a32030f0-b6f6-4bd6-8284-bb762ccf9205@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a32030f0-b6f6-4bd6-8284-bb762ccf9205@vivo.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bjSGKP6w
X-Spamd-Result: default: False [-1.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[38.88%]
X-Spam-Score: -1.81
X-Rspamd-Queue-Id: A92A13EB89
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu 07-03-24 15:40:29, Bixuan Cui wrote:
[...]
> Currently, with the help of kernel trace events or tools like Perfetto, we
> can only see that kswapd is competing for CPU and the frequency of memory
> reclamation triggers, but we do not have detailed information or metrics
> about memory reclamation, such as the duration and amount of each
> reclamation, or who is releasing memory (super_cache, f2fs, ext4), etc. This
> makes it impossible to locate the above problems.

I am not sure I agree with you here. We do provide insight into LRU and
shrinkers reclaim. Why isn't that enough. In general I would advise you
to focus more on describing why the existing infrastructure is
insuficient (having examples would be really appreciated).

> Currently this patch helps us solve 2 actual performance problems (kswapd
> preempts the CPU causing game delay)
> 1. The increased memory allocation in the game (across different versions)
> has led to the degradation of kswapd.
>     This is found by calculating the total amount of Reclaim(page) during
> the game startup phase.
> 
> 2. The adoption of a different file system in the new system version has
> resulted in a slower reclamation rate.
>     This is discovered through the OBJ_NAME change. For example, OBJ_NAME
> changes from super_cache_scan to ext4_es_scan.
> 
> Subsequently, it is also possible to calculate the memory reclamation rate
> to evaluate the memory performance of different versions.

Why cannot you achive this with existing tracing or /proc/vmstat
infrastructure?

> The main reasons for adding static tracepoints are:
> 1. To subdivide the time spent in the shrinker->count_objects() and
> shrinker->scan_objects() functions within the do_shrink_slab function. Using
> BPF kprobe, we can only track the time spent in the do_shrink_slab function.
> 2. When tracing frequently called functions, static tracepoints (BPF
> tp/tracepoint) have lower performance impact compared to dynamic tracepoints
> (BPF kprobe).

You can track the time process has been preempted by other means, no? We
have context switching tracepoints in place. Have you considered that
option?
-- 
Michal Hocko
SUSE Labs

