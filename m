Return-Path: <linux-kernel+bounces-14447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F210821D2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C9B1C2217B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC419125BE;
	Tue,  2 Jan 2024 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pH77WpVf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uYPM/HH2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pH77WpVf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uYPM/HH2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CD411C8A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1E281FCFA;
	Tue,  2 Jan 2024 13:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704203781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SxQTooAvGuSW0JmLCmpxf2XqjJdjSqsHNMv553fBvHQ=;
	b=pH77WpVfdmQXScvCkEeKH8q0Q/P3MwuY3idduUqyLYEME5jHYZksWmsjclNJPOBxYk1VQ5
	ivg5G249mRORmFkqwchTqXlcHiYKCNxLF1LmxHE+yDrEiUbNXr7NOyacNGutlleup79xhs
	DzwUavcTYZISQIdtj3OaIRVs4K/9ayY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704203781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SxQTooAvGuSW0JmLCmpxf2XqjJdjSqsHNMv553fBvHQ=;
	b=uYPM/HH2YszJrNw4uTNJcHWPijKTbeaYzbdxfPVZr8W0UWqoux2s3/qgUqloDmcA8WLcgo
	nZTcsuPRb/lFG9Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704203781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SxQTooAvGuSW0JmLCmpxf2XqjJdjSqsHNMv553fBvHQ=;
	b=pH77WpVfdmQXScvCkEeKH8q0Q/P3MwuY3idduUqyLYEME5jHYZksWmsjclNJPOBxYk1VQ5
	ivg5G249mRORmFkqwchTqXlcHiYKCNxLF1LmxHE+yDrEiUbNXr7NOyacNGutlleup79xhs
	DzwUavcTYZISQIdtj3OaIRVs4K/9ayY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704203781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SxQTooAvGuSW0JmLCmpxf2XqjJdjSqsHNMv553fBvHQ=;
	b=uYPM/HH2YszJrNw4uTNJcHWPijKTbeaYzbdxfPVZr8W0UWqoux2s3/qgUqloDmcA8WLcgo
	nZTcsuPRb/lFG9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AF1613AC6;
	Tue,  2 Jan 2024 13:56:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zcejIQUWlGXcVwAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Tue, 02 Jan 2024 13:56:21 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id 267D19BAD3; Tue,  2 Jan 2024 14:56:20 +0100 (CET)
Date: Tue, 2 Jan 2024 14:56:20 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: Feng Tang <feng.tang@intel.com>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] clocksource: Use proportional clocksource skew threshold
Message-ID: <20240102135620.GB3303@incl>
References: <20231221160517.GA22919@incl>
 <ZYrgQUTB3ayTtMqK@feng-clx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYrgQUTB3ayTtMqK@feng-clx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pH77WpVf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="uYPM/HH2"
X-Spam-Score: -2.81
X-Rspamd-Queue-Id: A1E281FCFA

On Tue, Dec 26, 2023 at 10:16:33PM +0800, Feng Tang wrote:
> We've seen similar reports on LKML that the watchdog timer was delayed
> for a very long time (some was 100+ seconds). As you said, the
> scheduling issue should be addressed.

CFS was the scheduling policy when the delays happened. Hopefully, EEVDF 
will prove to be an improvement in this area.

> Meanwhile, instead of adding new complex logic to clocksource watchdog
> code, can we just printk_once a warning message and skip the current
> watchdog check if the duration is too long. ACPI_PM timer only has a
> 24 bit counter which will wrap around every 3~4 seconds, when the
> duration is too long, like 14.5 seconds here, the check is already
> meaningless.

Skipping the current watchdog check would solve the issue. It has also the 
advantage that clocksources would not get marked unstable on account of 
increased scheduling delays and the clocksource or watchdog counter 
wrapping around. With the CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE option 
enabled, the maximum clocksource_delta is only be half of the whole range 
(4.68 -> 2.34 secs for acpi_pm and 179.0 -> 89.5 secs for the HPET), which 
makes acpi_pm getting marked unstable even more probable.

Skipping the current watchdog check will require a threshold for evaluting 
watchdog intervals. I guess WATCHDOG_INTERVAL + (WATCHDOG_INTERVAL >> 1) 
would not be completely amiss. Depending on how tight a threshold is 
chosen, the printk_once message might become commonplace on busy systems. 
It would attract attention of customers, which is not necessarily a bad 
thing because the vendor would learn about the cases where the scheduling 
policy does not perform well.

I am not sure how much of a problem is the fact that stricter limits on 
skews will be imposed for watchdog intervals that are close to the 
threshold. The reality of production system is that the corner case that 
causes the watchdog interval to get stretched is not uncommon. Considering 
the proposed threshold, WATCHDOG_INTERVAL + (WATCHDOG_INTERVAL >> 1), the 
current uncertainty margins (of the TSC and HPET) correspond to 333 ppm 
(microseconds of skew per second). So, I am still in favour of scaling the 
margins proportionally to the watchdog interval. I am going send a new 
patch implementing skipping the current watchdog check. I could send a 
modified version of the margin scaling patch later if there was interest.
-- 
Jiri Wiesner
SUSE Labs

