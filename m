Return-Path: <linux-kernel+bounces-15523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C62F822D53
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB761F24336
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A084B19BCF;
	Wed,  3 Jan 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q1K1lETl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o4/D6hUa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q1K1lETl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o4/D6hUa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB2A19BC0;
	Wed,  3 Jan 2024 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D8E1821C46;
	Wed,  3 Jan 2024 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704285623;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20ruKaqHGpSyHLXE/c7mqjiw1CKRRpotINPqVduOYwo=;
	b=Q1K1lETliTdRlrbpuYcbDJCNLRyfseNkT7O9KG7k43qo+zJQDGQoR5Teztc1JjCG66Jfu7
	YYWOF836ktg9Z6PpkDO/Avyey1jC5Ex/SA/W76gfXQyMMZHJa7Cwu6lvmN/Se9fDUhy/8p
	/8zVWhI6yjswCRwf6Dx5NjBQN2LSmtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704285623;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20ruKaqHGpSyHLXE/c7mqjiw1CKRRpotINPqVduOYwo=;
	b=o4/D6hUaN6oYe8c2NZs5CLAwmgMgPxUEow+rj3/B7s9DS0yeUZUMkz5qyhW64gpEUXwpBc
	PshODaVzO680AtCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704285623;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20ruKaqHGpSyHLXE/c7mqjiw1CKRRpotINPqVduOYwo=;
	b=Q1K1lETliTdRlrbpuYcbDJCNLRyfseNkT7O9KG7k43qo+zJQDGQoR5Teztc1JjCG66Jfu7
	YYWOF836ktg9Z6PpkDO/Avyey1jC5Ex/SA/W76gfXQyMMZHJa7Cwu6lvmN/Se9fDUhy/8p
	/8zVWhI6yjswCRwf6Dx5NjBQN2LSmtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704285623;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20ruKaqHGpSyHLXE/c7mqjiw1CKRRpotINPqVduOYwo=;
	b=o4/D6hUaN6oYe8c2NZs5CLAwmgMgPxUEow+rj3/B7s9DS0yeUZUMkz5qyhW64gpEUXwpBc
	PshODaVzO680AtCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72B151340C;
	Wed,  3 Jan 2024 12:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mpD9GrdVlWWJKAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 03 Jan 2024 12:40:23 +0000
Date: Wed, 3 Jan 2024 13:40:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, ltp@lists.linux.it,
	Li Wang <liwang@redhat.com>,
	Andrea Cervesato <andrea.cervesato@suse.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Christophe Lyon <christophe.lyon@linaro.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH 00/36] Remove UCLINUX from LTP
Message-ID: <20240103124013.GA1095350@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZVOhlGPg5KRyS-F@yuki>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 4.00
X-Spamd-Result: default: False [4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[33.18%]
X-Spam-Flag: NO

Hi Geert, Cyril, all,

Geert, first, thank you for Cc all the other lists.
For anybody from those lists, we talk about:
https://lore.kernel.org/ltp/20240103015240.1065284-1-pvorel@suse.cz/

> Hi!
> > I am not sure I agree with this series.
> > Removing support for UCLINUX from LTP is almost a guarantee for
> > not noticing when more breakage is introduced.

> > How exactly is UCLINUX broken in LTP?

> As far as we know noone is using it and nobody is maintaing it for a
> decade, so it's bitrotting and we do not have manpower to fix it, or
> rather we do not want to invest the scarcely limited resources we have
> into something that is niche at best. We asked repeatedly if anyone want
> to invest time into keeping it alive, but nobody answered the call so
> far and I doubt that it will happen at this point.

Also, UCLINUX was used in tests which used the legacy LTP API, which was buggy.
We slowly rewrite tests into new API [1], which is more reliable and do cleanup
and bug fixes during test rewrites. But because nobody stand to maintain UCLINUX
support, it's not in the new API. Thus we have actively deleted it's support
during the rewrite in past years.

I wonder myself if anybody is even using LTP on UCLINUX platforms. Nearly 25% of
the syscalls tests use fork(), thus will not work on UCLINUX. First tests were
rewritten in 2016 (first release in 20160510) and nobody complained.

All tests C based tests (both new and legacy API):
$ git grep -l  -e 'include .tst_test.h' -e 'include .test.h' testcases/ |wc -l
1494

Tests, which use fork(), i.e. not working in UCLINUX:
$ git grep -l  '\.forks_child.*1' testcases/ |wc -l
334

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/C-Test-API

