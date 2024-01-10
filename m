Return-Path: <linux-kernel+bounces-22605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3560682A052
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4151C2245A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1C64D580;
	Wed, 10 Jan 2024 18:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZuvixDev";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FGELZhzK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zW6RmUf2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pvlGl9Vy"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7937F495C1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D14A01FDF7;
	Wed, 10 Jan 2024 18:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704911765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1C/6nVrkazDL3vofZ6DMrhFSQHXwRYIyDZ0gn1Si83g=;
	b=ZuvixDevB7TtNQ01YjA3bXL1ngX8kHyw+vFp2QxZ0+itkApfg9ht2BtKcX7kyH1etL3l9u
	LPqR8nsc7alYTLflOXTN4SrVx6PkJLIQz0ExKYPC2GyDeHOi/40gt03Xqav4OJH7AS31AH
	eeml3vQGIKnTT3d1epDNbxmlYH4fevs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704911765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1C/6nVrkazDL3vofZ6DMrhFSQHXwRYIyDZ0gn1Si83g=;
	b=FGELZhzKylJyXG9DCI5zdjUsC9Z7TARtrtOp2mUst21QT0lRWSUYY8OvuAogARzXXVyded
	o0zQ2/s8gL1kpHBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704911764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1C/6nVrkazDL3vofZ6DMrhFSQHXwRYIyDZ0gn1Si83g=;
	b=zW6RmUf2axVM4Eru9DUbg82hLTsUsVrT6CVyrOLoBEApoivKuNng5zsPNiuTH8E5tTPOXZ
	iu31N/FpdN+CtnUk/DUA3QESxDyKafAHeb+vmUDuWvYV22CNxSmN2DRg09N1K6x/6gpneD
	9zGjYAzuE/qURrzS0i0xIC6jWtWy0lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704911764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1C/6nVrkazDL3vofZ6DMrhFSQHXwRYIyDZ0gn1Si83g=;
	b=pvlGl9Vy7jh5R2wUKPgMjt5xxxmObf4j9XlvQrgBW/R9YTBqCY1x6Sulqd7q3MwmEtBWiz
	aCtrWZKY4DuYPDDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A59EE13306;
	Wed, 10 Jan 2024 18:34:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dN0aKEjjnmVuLwAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Wed, 10 Jan 2024 18:34:48 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id BB8FB9C468; Wed, 10 Jan 2024 19:36:18 +0100 (CET)
Date: Wed, 10 Jan 2024 19:36:18 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: linux-kernel@vger.kernel.org
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Feng Tang <feng.tang@intel.com>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <20240110183618.GG3303@incl>
References: <20240103112113.GA6108@incl>
 <202401082125.4ec42f71-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401082125.4ec42f71-oliver.sang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zW6RmUf2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pvlGl9Vy
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.37 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.36)[76.80%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -2.37
X-Rspamd-Queue-Id: D14A01FDF7
X-Spam-Flag: NO

On Mon, Jan 08, 2024 at 09:44:31PM +0800, kernel test robot wrote:
> commit: ceacf0b27b5d9cdc574f8d0a0bcb11d3272e7b9f ("[PATCH] clocksource: Skip watchdog check for large watchdog intervals")
> url: https://github.com/intel-lab-lkp/linux/commits/Jiri-Wiesner/clocksource-Skip-watchdog-check-for-large-watchdog-intervals/20240103-192257
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git da65f29dada7f7cbbf0d6375b88a0316f5f7d6f5
> patch link: https://lore.kernel.org/all/20240103112113.GA6108@incl/
> patch subject: [PATCH] clocksource: Skip watchdog check for large watchdog intervals
> 
> [   54.778895][   T41] ------------[ cut here ]------------
> [ 54.781279][ T41] WARNING: CPU: 0 PID: 41 at kernel/time/clocksource-wdtest.c:162 wdtest_func (kernel/time/clocksource-wdtest.c:162 (discriminator 1)) 
> [   54.785405][   T41] Modules linked in:
> [   54.787152][   T41] CPU: 0 PID: 41 Comm: wdtest Tainted: G                 N 6.7.0-rc2-00014-gceacf0b27b5d #1 30e4ebd22e7da702dfdab1313ae74e5a246df970
> [   54.791633][   T41] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 54.795124][ T41] EIP: wdtest_func (kernel/time/clocksource-wdtest.c:162 (discriminator 1)) 

The code:
        pr_info("--- Watchdog clock-value-fuzz error injection, expect clock skew and per-CPU mismatches.\n");
        WRITE_ONCE(wdtest_ktime_read_fuzz, true);
        schedule_timeout_uninterruptible(2 * HZ);
        WARN_ON_ONCE(!(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));

The warning is the consequence of the watchdog not running on i386 builds of the kernel. The watchdog does not run because the "interval > WATCHDOG_INTR_MAX_NS" check is always true on account of the WATCHDOG_INTR_MAX_NS constant evaluating to a negative number on account of integer overflow.

> [   54.801794][   T41] EAX: c4a1fe8c EBX: 00000004 ECX: 00000000 EDX: 00000000
> [   54.803569][   T41] ESI: c4a1ff2e EDI: 00000000 EBP: c74aff70 ESP: c74aff60
> [   54.805314][   T41] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010246
> [   54.807278][   T41] CR0: 80050033 CR2: ffda9000 CR3: 05979000 CR4: 000406d0
> [   54.808856][   T41] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   54.810216][   T41] DR6: fffe0ff0 DR7: 00000400
> [   54.811218][   T41] Call Trace:

-- 
Jiri Wiesner
SUSE Labs

