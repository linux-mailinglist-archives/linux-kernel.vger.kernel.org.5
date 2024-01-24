Return-Path: <linux-kernel+bounces-37067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C666C83AAF1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A3A1F22B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4687777F22;
	Wed, 24 Jan 2024 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qjOyloRV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pgXzbAZV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xWOlS2gL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bldeGUB2"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C562460BB3;
	Wed, 24 Jan 2024 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706103070; cv=none; b=k1DeZ0WmFAyu3t3bZHSshEKCW2esX8UGNr6b88miz71U+GLggGrvG4823NNe3hsNt0LbsGSe44WOCvn+Z6NqA7Uy2yFAQiCfWBnnqtdXObZ0qeosQsKpkWEtkLpXRrFGTlytm/BS7NrDNyeEK42WlB38VKYpYQ2dZsBfwmZmId0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706103070; c=relaxed/simple;
	bh=vAqDi+vVxpKp210whUk+ZkZ5gre88h21F7Am5Kqm9JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyFgG95+CZDnvq0uy3rD7V4bVy7nMoLlp4Gx9WiBsLeNQ40L4ICFnmXHfKNP+I5ePuGJ/SozbpNgKiWblY2O0PX+PBaN08O1jciY9682N01YxNuB5Po2U8dn2WEIQVv9OTUjw22CTpXK6A0uRVIrEwk6iA8rlNAZcrAq7331Cxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qjOyloRV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pgXzbAZV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xWOlS2gL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bldeGUB2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E843E1FD6C;
	Wed, 24 Jan 2024 13:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706103066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DXciBWw20DN+rLboKZP42GK0PIh68SPmpXnsrkv2XF0=;
	b=qjOyloRVW+Tpvo3YqaPOOkfoJRQ5mCpHUHm2ShQGaA6x/Ybs1lZSUMEf/s9f7X4FHrOdSl
	bsRRnP34u67W7I/ufZJEDXemIxEfilB6Aqqoj2T2pH9RMqdY/6Nz5JtjGpDmOxUS5JLsTu
	oxp/b8MOgRrG/hcMjd19QJvX254iC6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706103066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DXciBWw20DN+rLboKZP42GK0PIh68SPmpXnsrkv2XF0=;
	b=pgXzbAZVZp0oL+XYl5ymriKDdDVFriXIGQ3YffOpg8Shi6XKaGlBxIFwL5M5fbkCSmKvHu
	aXNZar8k35d+AXDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706103065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DXciBWw20DN+rLboKZP42GK0PIh68SPmpXnsrkv2XF0=;
	b=xWOlS2gLEZmzlC3E8qPyT7+C640CMazNrHx+AxNgHheiMGYkTlS51CKQ09/g69Tb2Tn5HR
	xc8nm7vjawLJdLBbkqvNsRdWetHTBF6Ndwv0y7J5/lwndxP18g7F3NIBvO0J/fh+DqbG5g
	5yqXgAp1XTucFToiy8MzVOVJ5JG1jOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706103065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DXciBWw20DN+rLboKZP42GK0PIh68SPmpXnsrkv2XF0=;
	b=bldeGUB2lI5ibBHhC7aflBAlWMrQ4BLONUxybzqf1NUacOOHMEd0OcmC7OxzBsdJ7mf1Ow
	BqCuzqdYd2ED/2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7A89139CB;
	Wed, 24 Jan 2024 13:31:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VaihNBkRsWXnRgAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Wed, 24 Jan 2024 13:31:05 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id 8BDBD9C970; Wed, 24 Jan 2024 14:31:05 +0100 (CET)
Date: Wed, 24 Jan 2024 14:31:05 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rcu tree
Message-ID: <20240124133105.GM3303@incl>
References: <20240124151743.052082af@canb.auug.org.au>
 <20240124094954.GL3303@incl>
 <6b5c4acc-f184-4ad9-9029-dd7967fe4a04@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b5c4acc-f184-4ad9-9029-dd7967fe4a04@paulmck-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xWOlS2gL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bldeGUB2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-7.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -7.51
X-Rspamd-Queue-Id: E843E1FD6C
X-Spam-Flag: NO

On Wed, Jan 24, 2024 at 04:12:23AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 24, 2024 at 10:49:54AM +0100, Jiri Wiesner wrote:
> > On Wed, Jan 24, 2024 at 03:17:43PM +1100, Stephen Rothwell wrote:
> > > After merging the rcu tree, today's linux-next build (i386 defconfig)
> > > failed like this:
> > > In file included from include/linux/dev_printk.h:14,
> > >                  from include/linux/device.h:15,
> > >                  from kernel/time/clocksource.c:10:
> > > kernel/time/clocksource.c: In function 'clocksource_watchdog':
> > > kernel/time/clocksource.c:103:34: error: integer overflow in expression of type 'long int' results in '-1619276800' [-Werror=overflow]
> > >   103 |                                  * NSEC_PER_SEC / HZ)
> > >       |                                  ^
> > > Caused by commit
> > >   1a4545025600 ("clocksource: Skip watchdog check for large watchdog intervals")
> > > I have used the rcu tree from next-20240123 for today.
> > 
> > This particular patch is still beging discussed on the LKML. This is the 
> > latest submission with improved variable naming, increased threshold and 
> > changes to the log and the warning message (as proposed by tglx):
> > https://lore.kernel.org/lkml/20240122172350.GA740@incl/
> > Especially the change to the message is important. I think this message 
> > will be commonplace on 8 NUMA node (and larger) machines. If there is 
> > anything else I can do to assist please let me know.
> 
> Here is the offending #define:
> 
> #define WATCHDOG_INTR_MAX_NS	((WATCHDOG_INTERVAL + (WATCHDOG_INTERVAL >> 1))\
> 				 * NSEC_PER_SEC / HZ)
> 
> The problem is that these things are int or long, and on i386, that
> is only 32 bits.  NSEC_PER_SEC is one billion, and WATCHDOG_INTERVAL
> is often 1000, which overflows.  The division by HZ gets this back in
> range at about 1.5x10^9.

Exactly.

> So this computation must be done in 64 bits even on 32-bit systems.
> My thought would be a cast to u64, then back to long for the result.

This will be a more precise solution than enclosing NSEC_PER_SEC / HZ in 
brackets, which I chose to do in the v2 of this patch.

> Whatever approach, Jiri, would you like to send an updated patch?

Yes, I can incorporate the casting to u64 and back to long into the patch. 
At this point, I am not sure which version to use. There are:
* v1 (submitted to the LKML on Jan 3rd): the patch that got merged into linux-next
* v2 (submitted to the LKML on Jan 10th): that has an alternative fix for the interger overflow
* v3 (submitted to the LKML on Jan 22nd): that incoporates suggestions by Thomas Gleixner

I could update the v3 of this patch with casting to u64 and back to long. 
WATCHDOG_INTERVAL_MAX_NS got set to 2 * WATCHDOG_INTERVAL in v3 - a change 
I do not entirely agree with. I think WATCHDOG_INTERVAL_MAX_NS should be 
kept narrow so as not to impose a limit on time skew that is too strict 
for readout intervals approaching 2 * WATCHDOG_INTERVAL in their length. 
The question is what is too strict.
-- 
Jiri Wiesner
SUSE Labs

