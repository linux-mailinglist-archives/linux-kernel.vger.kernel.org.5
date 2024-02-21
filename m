Return-Path: <linux-kernel+bounces-74253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA56E85D1A5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2E41C245AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AAC3B1A4;
	Wed, 21 Feb 2024 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DEJL3B37";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DEJL3B37"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E73B187;
	Wed, 21 Feb 2024 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501453; cv=none; b=T5bcxGeh3/XC5AOFBuW8aMTPfx9CorPe5xwuGUUUp7pjXIlwmg78Fk0TgnECPfUJwXT9jq2FzrouYODiyXTrOLfIoH4R7NXpkD7aHCGVzsNwtmnhtM0bKVFFk421mbhVzUBj0WnOvpP7wkYpB9XXj7nkm9kJdzHPHRued0/riFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501453; c=relaxed/simple;
	bh=rj3zLjFnMfv2OhoWX2qU1w327mhq2Hez7PD1Y5hzPlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srbErmtZjrntTFq5nt+Ovzeix9xM8ypgQs81XiyFe7UU6LOy20CJW30X+0yeeI6UyF9jTVIN6BBH+IWHUp+SqiWIb6AQHEvBN/5OhGB72sutgaSplVIUjwpgZIDR3gaufYM4BzCm8PI+DMtr59zu0MVzmP3W29q91RfBASQZExY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DEJL3B37; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DEJL3B37; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 84DBC1FB46;
	Wed, 21 Feb 2024 07:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708501449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/QEk4HUS4tR1rBRcACEpzWgLgUlK+CJgCIzsVAuTmA=;
	b=DEJL3B37JhVkcQM8p6IeKRxEpLWZNprAWiP1qFyGeA7IST671NnPj1zW1Gc5x2S9Yzw8d5
	EdRekehg1awR2rbCDDyCZ+oqEo6tJjO+rCrQA8hvOg6XWldFQ4Og59WszoLc7CzvBOTSp7
	ARHr4dgNhkfOrXk/7bYEx32yhP/1RLU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708501449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/QEk4HUS4tR1rBRcACEpzWgLgUlK+CJgCIzsVAuTmA=;
	b=DEJL3B37JhVkcQM8p6IeKRxEpLWZNprAWiP1qFyGeA7IST671NnPj1zW1Gc5x2S9Yzw8d5
	EdRekehg1awR2rbCDDyCZ+oqEo6tJjO+rCrQA8hvOg6XWldFQ4Og59WszoLc7CzvBOTSp7
	ARHr4dgNhkfOrXk/7bYEx32yhP/1RLU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65BD113A69;
	Wed, 21 Feb 2024 07:44:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MYn8Fcmp1WV9HAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 21 Feb 2024 07:44:09 +0000
Date: Wed, 21 Feb 2024 08:44:08 +0100
From: Michal Hocko <mhocko@suse.com>
To: Bixuan Cui <cuibixuan@vivo.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, akpm@linux-foundation.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, opensource.kernel@vivo.com
Subject: Re: [PATCH -next v6 0/2] Make memory reclamation measurable
Message-ID: <ZdWpyN_8Z6dvDQ48@tiehlicka>
References: <20240105013607.2868-1-cuibixuan@vivo.com>
 <fac8d079-100e-4b8d-9a35-db8219b28b51@vivo.com>
 <20240220212202.59ddc123@gandalf.local.home>
 <3d4f44ee-f533-446f-a9e6-7f58afc78d65@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d4f44ee-f533-446f-a9e6-7f58afc78d65@vivo.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.39 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[45.20%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.39

On Wed 21-02-24 11:00:53, Bixuan Cui wrote:
> 
> 
> 在 2024/2/21 10:22, Steven Rostedt 写道:
> > It's up to the memory management folks to decide on this. -- Steve
> Noted with thanks.

It would be really helpful to have more details on why we need those
trace points.

It is my understanding that you would like to have a more fine grained
numbers for the time duration of different parts of the reclaim process.
I can imagine this could be useful in some cases but is it useful enough
and for a wider variety of workloads? Is that worth a dedicated static
tracepoints? Why an add-hoc dynamic tracepoints or BPF for a very
special situation is not sufficient?

In other words, tell us more about the usecases and why is this
generally useful.

Thanks!
-- 
Michal Hocko
SUSE Labs

