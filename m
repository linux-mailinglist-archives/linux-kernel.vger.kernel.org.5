Return-Path: <linux-kernel+bounces-16966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE5C824697
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F150A287D29
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658182555F;
	Thu,  4 Jan 2024 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p0AqSnqT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NNkinVml";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p0AqSnqT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NNkinVml"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501EB25112
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83F0B22107;
	Thu,  4 Jan 2024 16:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704386913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMkmAPhcPjvKxvKZFqZlKDOHukAHlkKNHo4AtY2SdSU=;
	b=p0AqSnqTuyDBtzbY3Mj1tGNveGJ1CWkBq8FnRONXiTf58pkPr8AjFn1lbIik9JpPV+39lQ
	L4zYPMk8a1eFqC14qji9VhJTcPr4QNCf58MjFFNzxIlmUZAkAUF4hNFJ8fIJ8Aylmec0ll
	QJNFitMppWgSqYXnIGqBRDvO1KD4Eng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704386913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMkmAPhcPjvKxvKZFqZlKDOHukAHlkKNHo4AtY2SdSU=;
	b=NNkinVmlvXRhrfjDo3Rjxv4fpEQLkul6wwEm1xrQLOJeLUYxC8XukXU8UXAJHsggcjdwY+
	zekhTgnk1M3tPSBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704386913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMkmAPhcPjvKxvKZFqZlKDOHukAHlkKNHo4AtY2SdSU=;
	b=p0AqSnqTuyDBtzbY3Mj1tGNveGJ1CWkBq8FnRONXiTf58pkPr8AjFn1lbIik9JpPV+39lQ
	L4zYPMk8a1eFqC14qji9VhJTcPr4QNCf58MjFFNzxIlmUZAkAUF4hNFJ8fIJ8Aylmec0ll
	QJNFitMppWgSqYXnIGqBRDvO1KD4Eng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704386913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pMkmAPhcPjvKxvKZFqZlKDOHukAHlkKNHo4AtY2SdSU=;
	b=NNkinVmlvXRhrfjDo3Rjxv4fpEQLkul6wwEm1xrQLOJeLUYxC8XukXU8UXAJHsggcjdwY+
	zekhTgnk1M3tPSBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78903137E8;
	Thu,  4 Jan 2024 16:48:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yWVpHWHhlmUzZAAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Thu, 04 Jan 2024 16:48:33 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id 0DD1A9BD87; Thu,  4 Jan 2024 17:48:29 +0100 (CET)
Date: Thu, 4 Jan 2024 17:48:29 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: Feng Tang <feng.tang@intel.com>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <20240104164828.GD3303@incl>
References: <20240103112113.GA6108@incl>
 <ZZZISRg9YGyT2eQ+@feng-clx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZZISRg9YGyT2eQ+@feng-clx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.45 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.65)[92.77%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.45

On Thu, Jan 04, 2024 at 01:55:21PM +0800, Feng Tang wrote:
> On Wed, Jan 03, 2024 at 12:21:13PM +0100, Jiri Wiesner wrote:
> > Fixes: 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")
> 
> IIUC, the issue could happen even before this commit? Though I do think 
> this is good stuff for stable kernel.

Yes, it could happen before 2e27e793e280 but the threshold was so loose 
that it probably was an extremely rare event. Commit 2e27e793e280 lowered 
the threshold and this significantly increased the likelihood of skew 
detection failing for large watchdog intervals. We got a report of a 
kernel with 2e27e793e280 switching to the HPET but there were no failures 
with a kernel without 2e27e793e280 on the same fleet of 8 NUMA node machines.

> 0Day robot reported some compiling issue.

I am going to submit a v2 of the patch fixing the error after we clarify 
the jiffies concern.
-- 
Jiri Wiesner
SUSE Labs

