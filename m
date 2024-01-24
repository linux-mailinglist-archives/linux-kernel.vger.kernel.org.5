Return-Path: <linux-kernel+bounces-36743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C64C83A5E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C28828D556
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBCA18044;
	Wed, 24 Jan 2024 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="plVXj33N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8NOeRL7J";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EkjUfdhv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IYh+iPhq"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA811802E;
	Wed, 24 Jan 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089798; cv=none; b=lKNEQ89IgsgqC8Lf50DYxo3w8BSpBMAGY8ZAC6xmclLGyoqk6wnKATHQ3uRHGh1vkxPuccqMTxIk4WRIeIvL5gW344QJCf9lBt5lGZCch/Sq9m39Rcgxq23QO0DaK9GFobwJq4hfrx4nMJpSwNYA1Xs8boYNo8c0qfc3ohS7OT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089798; c=relaxed/simple;
	bh=QtUmb7bF5lqtB54Oi4kwEmOv9BMGiSvIpAQTEP1oKgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0SlwQOd6eL8HHqxg9LfxDX4a1F1UcvlWpMAMaB4TmKD4uyz9hdIUz1BGdP8rnYwYONck9uZeyTuCFAPDHE19fy1/moIOgYc099v0xixfsy3LhuK11aw652844DuSuUIpuGaaVgpo4uVzQV5G/g7uuOq9G15l8ZIaibXEegGZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=plVXj33N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8NOeRL7J; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EkjUfdhv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IYh+iPhq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D45891F7E0;
	Wed, 24 Jan 2024 09:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706089795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8pUPEXhsLWkmAp/YcEXVzNst1axBoeCLZ68AwUjacU=;
	b=plVXj33NOKMEc23VA0O27a0NmWgCspDE6QmsMl4xrFJvkqOF1nE6TaoVWBqjm4L/4xK6Hn
	w0yZ+N0bDpegsG/7b4UgYFH2NbNrAFaBA0TjqxJ/tblMVpoloEhEGazoqj9JN60+scpyJN
	TaY6nRqG6k0+S4Rk2NSWnwkQQ4WKvPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706089795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8pUPEXhsLWkmAp/YcEXVzNst1axBoeCLZ68AwUjacU=;
	b=8NOeRL7JDL069Aozqko0gC7l9akF1MoBAVNKsfmhHPuLKxxkXWcVHc2Jo2B5lJiMtcWmTR
	9Xa2uE9n8Ygkh9Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706089794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8pUPEXhsLWkmAp/YcEXVzNst1axBoeCLZ68AwUjacU=;
	b=EkjUfdhvsL8giyQ70j8+UjthxdbydodJK42dtYpYztORfSTg99s2L/ddjW8pMImkYnMv6T
	XbNTTfi5w1gXqL21fWdBKg5o2XaaOb66cwd8MqAayoljmA8R/NUAZObw9KwpXJIlUC2/r3
	lp0+Hy592NmqVIr4W7SZZVmIKUiT05w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706089794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l8pUPEXhsLWkmAp/YcEXVzNst1axBoeCLZ68AwUjacU=;
	b=IYh+iPhqXnc5KE+ScJkeAFvcsd5aLFQNGdwSAuosyOLOmv0bYTgFB92hYrNJXhpuhvSwIX
	BMakY3mwbAN53WDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB6561333E;
	Wed, 24 Jan 2024 09:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6DamMULdsGVyfQAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Wed, 24 Jan 2024 09:49:54 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id 771389C965; Wed, 24 Jan 2024 10:49:54 +0100 (CET)
Date: Wed, 24 Jan 2024 10:49:54 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rcu tree
Message-ID: <20240124094954.GL3303@incl>
References: <20240124151743.052082af@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124151743.052082af@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EkjUfdhv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IYh+iPhq
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.06 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-0.978];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 TO_DN_ALL(0.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.05)[60.36%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -1.06
X-Rspamd-Queue-Id: D45891F7E0
X-Spam-Flag: NO

On Wed, Jan 24, 2024 at 03:17:43PM +1100, Stephen Rothwell wrote:
> After merging the rcu tree, today's linux-next build (i386 defconfig)
> failed like this:
> In file included from include/linux/dev_printk.h:14,
>                  from include/linux/device.h:15,
>                  from kernel/time/clocksource.c:10:
> kernel/time/clocksource.c: In function 'clocksource_watchdog':
> kernel/time/clocksource.c:103:34: error: integer overflow in expression of type 'long int' results in '-1619276800' [-Werror=overflow]
>   103 |                                  * NSEC_PER_SEC / HZ)
>       |                                  ^
> Caused by commit
>   1a4545025600 ("clocksource: Skip watchdog check for large watchdog intervals")
> I have used the rcu tree from next-20240123 for today.

This particular patch is still beging discussed on the LKML. This is the 
latest submission with improved variable naming, increased threshold and 
changes to the log and the warning message (as proposed by tglx):
https://lore.kernel.org/lkml/20240122172350.GA740@incl/
Especially the change to the message is important. I think this message 
will be commonplace on 8 NUMA node (and larger) machines. If there is 
anything else I can do to assist please let me know.
-- 
Jiri Wiesner
SUSE Labs

