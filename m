Return-Path: <linux-kernel+bounces-16936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF1F824641
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE561C20E97
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711A5250F2;
	Thu,  4 Jan 2024 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IguwM/Rt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Iqzz7IPx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IguwM/Rt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Iqzz7IPx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30249225D8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 30720220D1;
	Thu,  4 Jan 2024 16:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704385851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K097X3kyBI0qKEETeboAFR0vzwa5YHkJaPrDUXK5nNM=;
	b=IguwM/RtRJMcIw7Yc/xGd4wOtgWcJIEFnz1To9Q8DLSPIp35LW5+b0twLE1J4+qTh2fAN4
	hnhDXC9WPfdHEIwWyuiwlF1jL5RuF6k7iOKq/JmIzNT4wwHk0Q3ojbB6k3sqpdNpROk85z
	Y6ZU/3dw6a5hLDlZizuW8TDNQMAXr40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704385851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K097X3kyBI0qKEETeboAFR0vzwa5YHkJaPrDUXK5nNM=;
	b=Iqzz7IPxZFfDckXHSoery3Tn4peGfoLoqnIGzZ8I8iLipVLX1vgcxQh4f4nOSwJtDx6+zk
	6jOFqmURd3EdgMCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704385851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K097X3kyBI0qKEETeboAFR0vzwa5YHkJaPrDUXK5nNM=;
	b=IguwM/RtRJMcIw7Yc/xGd4wOtgWcJIEFnz1To9Q8DLSPIp35LW5+b0twLE1J4+qTh2fAN4
	hnhDXC9WPfdHEIwWyuiwlF1jL5RuF6k7iOKq/JmIzNT4wwHk0Q3ojbB6k3sqpdNpROk85z
	Y6ZU/3dw6a5hLDlZizuW8TDNQMAXr40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704385851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K097X3kyBI0qKEETeboAFR0vzwa5YHkJaPrDUXK5nNM=;
	b=Iqzz7IPxZFfDckXHSoery3Tn4peGfoLoqnIGzZ8I8iLipVLX1vgcxQh4f4nOSwJtDx6+zk
	6jOFqmURd3EdgMCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21999137E8;
	Thu,  4 Jan 2024 16:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mzMnCDvdlmWvXwAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Thu, 04 Jan 2024 16:30:51 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id A80CE9BD82; Thu,  4 Jan 2024 17:30:50 +0100 (CET)
Date: Thu, 4 Jan 2024 17:30:50 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <20240104163050.GC3303@incl>
References: <20240103112113.GA6108@incl>
 <5b8fd9ba-1622-4ec7-b3cc-2db3a78122f1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b8fd9ba-1622-4ec7-b3cc-2db3a78122f1@paulmck-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="IguwM/Rt";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Iqzz7IPx
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.43 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 URIBL_BLOCKED(0.00)[suse.de:dkim];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.42)[78.11%]
X-Spam-Score: -3.43
X-Rspamd-Queue-Id: 30720220D1
X-Spam-Flag: NO

On Wed, Jan 03, 2024 at 02:08:08PM -0800, Paul E. McKenney wrote:
> I believe that there were concerns about a similar approach in the case
> where the jiffies counter is the clocksource

I ran a few simple tests on a 2 NUMA node Intel machine and found nothing 
so far. I tried booting with clocksource=jiffies and I changed the 
"nr_online_nodes <= 4" check in tsc_clocksource_as_watchdog() to enable 
the watchdog on my machine. I have a debugging module that monitors 
clocksource and watchdog reads in clocksource_watchdog() with kprobes. I 
see the cs/wd reads executed roughly every 0.5 second, as expected. When 
the machine is idle the average watchdog interval is 501.61 milliseconds 
(+-15.57 ms, with a minimum of 477.07 ms and a maximum of 517.93 ms). The 
result is similar when the CPUs of the machine are fully saturated with 
netperf processes. I also tried booting with clocksource=jiffies and 
tsc=watchdog. The watchdog interval was similar to the previous test.

AFAIK, the jiffies clocksource does get checked by the watchdog itself. 
And with that, I have run out of ideas.
-- 
Jiri Wiesner
SUSE Labs

