Return-Path: <linux-kernel+bounces-37354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E1483AEAD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCFE1C221C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E2F7E56D;
	Wed, 24 Jan 2024 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VjLsKW8e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y5akeZec";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n3rHKEOI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VUm2Bo5F"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D47CF1C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114888; cv=none; b=dMJ08FUij8UjIel+CVX71fhveagaJcACia6lR/GUl9E+1khk8D6h0BIkdDFTgv6yVxKrnw4pGhkb0K3LIopvlvNJ1b+UCGuLrZXm26yBT1yeC8/Mfy5/HVSPg4wOm/h9OJO2TEFtGmmrub+cU1rzWac1kHMQiV8tRIdqTTRhiLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114888; c=relaxed/simple;
	bh=hWmCZIpPN2us1XGyAgS1SXD2VMgRqqSnFVFB7++XIsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YItIn469hXgift5zJlbsIwwxZ6froBH3y8fXvKFavjoDeodzqCiF04cwMjsbx0Tr1vDgFPcPVYceyXivMKNWfzugjbnLWHD4dJ9RdB+24YyMzzMmu2kDCuXpvQEx95DRgUTCLJEJ00o/ir37/Ln+CrIVP170ZlVxSSEyUnNcVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VjLsKW8e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y5akeZec; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n3rHKEOI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VUm2Bo5F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9CDE1FD7F;
	Wed, 24 Jan 2024 16:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706114885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=deYdVLn3EVvqbbVHh0i0wtu2QgPNSehyZazTApJhKrg=;
	b=VjLsKW8e5EPEbuhjj8KaEYARrveb7pltz8WOa/t50vMZq0RC50cmcwJhFJahvCYz0zKb0R
	EMqeWCabn4qhXZbfceA61xMmUUZb7JUpuNp99kbSNeRPd61Xz3V8YNpsf3qzURRvbkZsEa
	2ozLYC7KmNNaIoc7GA/1yj9gNpPmjxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706114885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=deYdVLn3EVvqbbVHh0i0wtu2QgPNSehyZazTApJhKrg=;
	b=y5akeZecYCJTgBXh0WymglY9yUNbxf/kWMvPN2wHN4crsyCwChg/UeXRBeztZ2UyLT1MNP
	KAiLuzRI83gWzxBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706114884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=deYdVLn3EVvqbbVHh0i0wtu2QgPNSehyZazTApJhKrg=;
	b=n3rHKEOIwjFMCKSJOmcR+ynCMfv9lIRBpxe0dwFy0F0d1P3Y1tQAue4Et42BHkiLIQH+Sa
	S1Eg9pbGwOwf2hqhIJZ6wJBQro4MlGyffrOi1meEuwcE8cd+Zd7NJY1aH3X5680z3g+4cA
	swhK1QpQzMZjqtw4vlPz2Dikk0DjdlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706114884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=deYdVLn3EVvqbbVHh0i0wtu2QgPNSehyZazTApJhKrg=;
	b=VUm2Bo5FCbkFkainJTn81ZmquvCQ7FT+Vhm7FLkFYHAJtr4iczVYJrDIJ3KcB2FUijIxyH
	XxWAvN5hU6mKIcCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D60081333E;
	Wed, 24 Jan 2024 16:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qlg7NEQ/sWUqKgAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Wed, 24 Jan 2024 16:48:04 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id E34359C97B; Wed, 24 Jan 2024 17:48:03 +0100 (CET)
Date: Wed, 24 Jan 2024 17:48:03 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v3] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <20240124164803.GN3303@incl>
References: <20240122172350.GA740@incl>
 <616658ba-0e69-447b-8b52-5051a5aa9bc0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <616658ba-0e69-447b-8b52-5051a5aa9bc0@paulmck-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: **
X-Spam-Score: 2.15
X-Spamd-Result: default: False [2.15 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.75)[0.918];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[24.19%]
X-Spam-Flag: NO

On Wed, Jan 24, 2024 at 08:03:42AM -0800, Paul E. McKenney wrote:
> On Mon, Jan 22, 2024 at 06:23:50PM +0100, Jiri Wiesner wrote:
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index c108ed8a9804..3052b1f1168e 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -99,6 +99,7 @@ static u64 suspend_start;
> >   * Interval: 0.5sec.
> >   */
> >  #define WATCHDOG_INTERVAL (HZ >> 1)
> > +#define WATCHDOG_INTERVAL_MAX_NS ((2 * WATCHDOG_INTERVAL) * (NSEC_PER_SEC / HZ))
> 
> We need something here to force 64-bit arithmetic on 32-bit systems
> correct?

I think it is not strictly necessary because
(2 * HZ / 2) * (NSEC_PER_SEC / HZ) = HZ * (NSEC_PER_SEC / HZ)
so even a 32-bit integer would not overflow when NSEC_PER_SEC / HZ is 
bracketed. But I could make a change to:
+#define WATCHDOG_INTERVAL_MAX_NS ((int64_t)(2ULL * WATCHDOG_INTERVAL * NSEC_PER_SEC / HZ))
to make it explicit and remove the risk of overflow if the constant was 
increased (for testing purposes for instance).
-- 
Jiri Wiesner
SUSE Labs

