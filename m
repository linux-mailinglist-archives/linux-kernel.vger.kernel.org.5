Return-Path: <linux-kernel+bounces-15465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4A6822C5D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343381C22740
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8890618EAF;
	Wed,  3 Jan 2024 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lxh76lr9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NJsmI7fr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lxh76lr9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NJsmI7fr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADA518EA0;
	Wed,  3 Jan 2024 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A2631FD11;
	Wed,  3 Jan 2024 11:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704282603;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Zgez0zMWtIyb5Ng80nLKb/YRtWuLRDBmlGiyWt1MzQ=;
	b=lxh76lr9a6cbz3B6qoyE8LPDLwWWQF1FeaeqZtfPa/v5e6hKcT1b41M7ERVBjkC/xW5t+r
	4PtniK6PAw1bQ0db6TZzy63bS9Xy3ljX3Bv8tYmBzteLBuXl69jIDgXZrgOuDOwqbgy7g/
	ZpeFoPPMW1U6qu9iyy8bt74Z3LIk5Ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704282603;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Zgez0zMWtIyb5Ng80nLKb/YRtWuLRDBmlGiyWt1MzQ=;
	b=NJsmI7frp5883kcBjR9Ni4dpvu/+KpdWksbvv1Sb9NSv14BCefu6tmpAky9P06OONciofG
	3TywemivWGyh+vCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704282603;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Zgez0zMWtIyb5Ng80nLKb/YRtWuLRDBmlGiyWt1MzQ=;
	b=lxh76lr9a6cbz3B6qoyE8LPDLwWWQF1FeaeqZtfPa/v5e6hKcT1b41M7ERVBjkC/xW5t+r
	4PtniK6PAw1bQ0db6TZzy63bS9Xy3ljX3Bv8tYmBzteLBuXl69jIDgXZrgOuDOwqbgy7g/
	ZpeFoPPMW1U6qu9iyy8bt74Z3LIk5Ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704282603;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Zgez0zMWtIyb5Ng80nLKb/YRtWuLRDBmlGiyWt1MzQ=;
	b=NJsmI7frp5883kcBjR9Ni4dpvu/+KpdWksbvv1Sb9NSv14BCefu6tmpAky9P06OONciofG
	3TywemivWGyh+vCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C665C13AA6;
	Wed,  3 Jan 2024 11:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /EQSL+pJlWU9GAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 03 Jan 2024 11:50:02 +0000
Date: Wed, 3 Jan 2024 12:49:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>,
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
Message-ID: <20240103114957.GD1073466@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [0.55 / 50.00];
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
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.15)[68.61%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.55
X-Spam-Flag: NO

Hi Geert,

> Hi Petr,

> CC other uClinux arch lists

> On Wed, Jan 3, 2024 at 2:52 AM Petr Vorel <pvorel@suse.cz> wrote:
> > UCLINUX is broken in LTP and nobody really cares. Actually I dare to
> > say UCLINUX is dead. Therefore I prepared patchset to remove UCLINUX
> > from LTP. We have been actively removing UCLINUX from LTP during rewrite
> > tests to new LTP API. This removes the rest from the old tests (which
> > will be sooner or later rewritten to new API).

> > Because the patchset is quite big, I did not want to send it to mailing
> > lists (but I can do it if you want).

> > Can you please have look at my fork on gitlab, branch: remove-UCLINUX
> > https://gitlab.com/pevik/ltp/-/commits/remove-UCLINUX?ref_type=heads

> > Build test:
> > https://github.com/pevik/ltp/actions/runs/7392470215

> Thanks for your series!

Thank you for your feedback.  May I add your Acked-by: tag to the series when we
agree to merge?

> I see you only CCed linux-m68k, but AFAIK, uClinux is not restricted
> to m68k/coldfire, but also available on arm32, riscv, sh, and xtensa.

Good point, I'll reply to their lists as well.

Kind regards,
Petr

> Gr{oetje,eeting}s,

>                         Geert

