Return-Path: <linux-kernel+bounces-96017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082CC875621
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF10C2875CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4493B130E58;
	Thu,  7 Mar 2024 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kYdVwRmY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AsGqLZZx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1E12F598
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836380; cv=none; b=eSSXWUsVael8j48K3Pqjw/UTYBLHznw93aF+8DZCVoj5PZgovBlKtIpuNGPO4jwbFvoXYsI3EE1urtfV2PnLdK5kEwj9XMqN9rQ638Rhf3BAHNmI8tY9Ry+hyV/BaBObYTpY9qOgYLJImNpZlf0zy28wa9uBxtrSt/i29mOYibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836380; c=relaxed/simple;
	bh=VAXUxaxdS4pLAzu73O4nshBQzUEzZlBJTiIomrvMzA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rv2iIGhzFpOKJuiWLM5e/5wuQBuBi8IHgz+ntLZLZ/YADzi6rlyv1b3brG1S5vH+G1yW5HYe24dNmmyGLLiv5VuS6jmqx/ZA8LzXDg8CwqVBlyzokbmSqVus6FAO9CLo1tODrE5Zt6Y2msW5TPs9Xh/XHS20dGBv3ARnNbkOC7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kYdVwRmY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AsGqLZZx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4F718CD5C;
	Thu,  7 Mar 2024 14:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709823378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2KszUYOBGLfqXjulgY6GDBZGiFLsZvCYA4KUnJdz9lg=;
	b=kYdVwRmYwqGr1iEz6h50LRy2Kpm9JwFXZ+Qn732+h7spqjS1Dcem4C4IpzSWUsnDlScN0x
	POw3g5yN5HyicC9C6Pqr7VHV9BYA8EYs8c33yllpGC4Oz3rWzWgNYX41RYEHOsA57od+Px
	q9sEek7LOO5jHEboPYvp/DWNRvabv6o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709823377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2KszUYOBGLfqXjulgY6GDBZGiFLsZvCYA4KUnJdz9lg=;
	b=AsGqLZZx832zzeKRrQRKyRj0/tPxKdlh3cNZrhkXbeDGIYBLbNxaq6j96zPAbf89pTQUBD
	zowts50M2dRt1TqfMuL2p39z/NlidqspjOkmzZpQrPSKfCbZW5EP1mxXtDnPmeM0u/TzS6
	ENubnPm9tKUU1NxwHnJ/VvjzP+jELK4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A52DD136BA;
	Thu,  7 Mar 2024 14:56:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c7B1J5HV6WWKZgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 07 Mar 2024 14:56:17 +0000
Date: Thu, 7 Mar 2024 15:56:17 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: CVE-2023-52592: libbpf: Fix NULL pointer dereference in
 bpf_object__collect_prog_relos
Message-ID: <ZenVkY9ZM1yPbVKC@tiehlicka>
References: <2024030645-CVE-2023-52592-4693@gregkh>
 <ZemPuxhM_ZZ-khTh@tiehlicka>
 <2024030706-unscathed-wilt-e310@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024030706-unscathed-wilt-e310@gregkh>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=AsGqLZZx
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL1n8icn5up97yham4u6fu14qe)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,linux.dev,gmail.com,google.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: C4F718CD5C
X-Spam-Flag: NO

On Thu 07-03-24 13:16:26, Greg KH wrote:
[...]
> > OK, so this one is quite interesting. This is a userspace tooling
> > gaining a kernel CVE. Is this just an omission or is this really
> > expected.
> 
> "omission"?  I don't understand the question.
> 
> We are responsible for assigning CVEs to stuff that is in the "Linux
> kernel source tree" (some have tried to get us to assign CVEs to
> programs like git that are just hosted on kernel.org), so for now, yes,
> this includes libbpf as well as stuff like perf.

I really do not want to nit pick here but the documentation doesn't talk
about tools:
: The Linux kernel developer team does have the ability to assign CVEs for
: potential Linux kernel security issues.
[...]
: Process
: =======
: 
: As part of the normal stable release process, kernel changes that are
: potentially security issues are identified by the developers responsible
: for CVE number assignments and have CVE numbers automatically assigned
: to them.

So it is quite natural to ask whether this has been a patern matching
not working properly.

> > Also what is the security threat model here? If a malformed ELF file is
> > loaded then the process gets SEGV which is perfectly reasonable thing to
> > do.
> 
> Again, we do not do "threat modeling", we do "does this fix a weakness",
> and I think this does as causing SEGV might not be a good thing, right?

Well, is it? It surely makes the code more robust but that would be the
case for almost any bug fix. Killing a misbheaving application (whether it
uses libbpf or any other library) is an expected behavior. But maybe BPF
developers can give us some useful insight.
-- 
Michal Hocko
SUSE Labs

