Return-Path: <linux-kernel+bounces-117609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE1088AD25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EA11C3C7F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C295E13247D;
	Mon, 25 Mar 2024 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMMvTKAx"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC5362A02;
	Mon, 25 Mar 2024 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388066; cv=none; b=lbO0/IfcL2mEcKFuCCtFxKFJD23JINgI7dNpoTVIi2XSCSbIAJA8uTEdU2uxHWRTFNKhDxRUEQyJi4WpFMPDKS43OIGSOhxC3I9M4bxIlCTHlSZb+zkpEE8aru25qvniVwU8KrrkO16n2oZfL9inFlWSYzqKOnB3zFd5hxv9oAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388066; c=relaxed/simple;
	bh=IyLfgGbcXo+iMp57mJ4Zi44P1XLcuNEIFvnCYa2iwcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdH3vyu+UET7SMDFKL7cdua05NQdRg4FDP7xM6Asahee04cgxosjmWqBFrjVNYMsWFs/mFyjgx1odjWIEivUZmdYjArskBP6OLc7yyl5lREloJNxNrov4WiKQTiEuuWlzhRmx1IPR/O7xhq9nAWh3eCYxUmQpdTz92fcxPcIoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMMvTKAx; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6114c9b4d83so12656987b3.3;
        Mon, 25 Mar 2024 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711388064; x=1711992864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z1q/4B6HZUcPPwvqc/E0mzOzgVa7O8gmXhiV8qGFNc=;
        b=PMMvTKAxAg2MXXAqTVYOuYShIYRoZeNU9/x9z80WZ+NgknRK8abgqa0VvFLpSOfk/O
         SO9PFVoMywOj1Px+XMoFv0fhxyLLHJy089knkBV5mm91oXMzO3jFQWsOC/P1jY9nYtrM
         XLKO5DPVYwPpTsbTRbwSW/9GsKf4YfxNmWeB8FCdl7Sawd2j+A6IJrh/7xYI4odQWiUs
         STdBblMX3VO59z72xeZ1NXMoptM1IRyxrnqxdk5G4nKzrcz3/vc/N3zKrxotKuZuDGKf
         WFiUiXZSD8aWqolbljGLHW8Q/eltwN4JjdUlmrhoyOgXBmSU8I8lvluwHi70UoHdwi2P
         3YRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711388064; x=1711992864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Z1q/4B6HZUcPPwvqc/E0mzOzgVa7O8gmXhiV8qGFNc=;
        b=Q3ldMd5FRWhc1f3wOF8CF7vp1OxywqQmP4F7woZgyIB1Nen/VGX3Wye1bagb5gniLq
         zaeK0jlFyZECvmpswaQzoN5C80TR6S5QQt4cAUzlP4/JLywQGwhuVPNbMiFNN+HnD3Df
         pLtdyOZ/sNzX33dS3czAOJiU6cJkrTkfUFbbg/IB3g/H7t6xb1LlLMHGc5/bun2IYBCV
         cKzX96V0iNZEOmANUbYhQF7U6HkwSUBvBdPS2rSkRKgyyZT53affrCr9yIK3HdVtqizx
         +BCPIjoIPhoSmYjmUuYlZn/tcgqplvuYN93kNNAwaLabZE9Z92ANB6UNiFfa1TC+gshY
         NHkg==
X-Forwarded-Encrypted: i=1; AJvYcCV0By0uaF4fmgJjsnlGNExdcgPist0ESgADvdtZ7jDo2lFyY9wVPZveoLQJLAT3+NMsw3qsfflUhxrUPy8vyzXq8TVUAGXkb9lsL2h1
X-Gm-Message-State: AOJu0Yzex0AHU+gWpxr53vDzCqw+HBWiKcilSLWeTNZKKa+44KqDelbp
	x9CvedykaxlYs0iQmif7a8tni9Vc9lDR07sM2UIqHOSxh2ZrmZjP
X-Google-Smtp-Source: AGHT+IHY4U5VRneiw9e3Lo2PZKlPyH54/Unwa8yFYYs0rDRBa6PVHIXRiEK18Eg7yx7kkctQhY6ASA==
X-Received: by 2002:a05:690c:c07:b0:611:30d8:9fcf with SMTP id cl7-20020a05690c0c0700b0061130d89fcfmr6365038ywb.31.1711388064354;
        Mon, 25 Mar 2024 10:34:24 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id t11-20020a05621421ab00b00696903f7d25sm1084625qvc.28.2024.03.25.10.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:34:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 6DC831200068;
	Mon, 25 Mar 2024 13:34:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Mar 2024 13:34:23 -0400
X-ME-Sender: <xms:n7UBZg97nRd4EKfw9kfmuEISlrOQbU5YSxo5D2NyVKdlY7IJ4RTvHg>
    <xme:n7UBZov7ZkY8N6weG-JRkDGJOhWlS7OoqWwuBypXH8N6Js0zxERGYdvAA20ENSbUV
    KK2dqDATOT3EfUnKQ>
X-ME-Received: <xmr:n7UBZmBUXOXLDj2ifVm3ckjUTtdNAXcl4dMmIN5cNITKk9ej1lHzkrapx7ZgYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:n7UBZgeZgelMsMqlzKT4DI4KRzF_BqpUVeJ3KdXw_GP53N8ZTDPgVA>
    <xmx:n7UBZlM2YjyNcodl534nfOIgHi-2DDHPQV66DFR1Y2wQEQkRsAccMg>
    <xmx:n7UBZqlPCoKEVNIw-dhwm785RUvJ1a1lwNRihLBL1J76uZZXu2yvPQ>
    <xmx:n7UBZntSXxI4vTppAcyvZo_4x_Mg6CcozjWoWWDehWSiHef98h9s9w>
    <xmx:n7UBZooJW2FBaxaVbb7qMH3Zu0UZy_fir3dU6x1is7gqy0oZbNdLGco4_bw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 13:34:22 -0400 (EDT)
Date: Mon, 25 Mar 2024 10:33:52 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] rcu: mollify sparse with RCU guard
Message-ID: <ZgG1gO9gRJFluTFy@boqun-archlinux>
References: <20240325101626.41584-2-johannes@sipsolutions.net>
 <ZgGnuFJiTX5laS7c@boqun-archlinux>
 <055111792727869a98c1fa693014e0b6f5d256ea.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <055111792727869a98c1fa693014e0b6f5d256ea.camel@sipsolutions.net>

On Mon, Mar 25, 2024 at 05:41:22PM +0100, Johannes Berg wrote:
> On Mon, 2024-03-25 at 09:35 -0700, Boqun Feng wrote: 
> > > -DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
> > > +DEFINE_LOCK_GUARD_0(rcu, do { rcu_read_lock(); __release(RCU); } while(0), rcu_read_unlock())
> > >  
> > 
> > Hmm.. not a big fan of this. __release(RCU) following a rcu_read_lock()
> > is really confusing. Maybe we can introduce a _rcu_read_lock():
> > 
> > 	void _rcu_read_lock(bool guard) {
> > 		__rcu_read_lock();
> > 		// Skip sparse annotation in "guard(rcu)()" to work
> > 		// around sparse's lack of support of cleanup.
> > 		if (!guard)
> > 			__acquire(RCU);
> > 		rcu_lock_acquire(...);
> > 		...
> > 	}
> > 
> > and normal rcu_read_lock() is just a _rcu_read_lock(false), RCU guard is
> > a _rcu_read_lock(true)?
> 
> Not sure I see any value in that, that's pretty much equivalent but
> seems IMHO less specific, where here we know we really want this only in
> this case. I don't see any other case where we'd want to ever "call"
> _rcu_read_lock(true).
> 
> Also __acquire()/__release() are just empty macros without __CHECKER__.
> So not sure the indirection really is warranted for this special case.
> 

Fair enough.

> I can add a comment in there, I guess, something like
> 
>  /* sparse doesn't actually "call" cleanup functions */
> 

Yeah, that's helpful.

> perhaps. That reminds me I forgot to CC Dan ...
> 
> > But before that how does it looks if we don't fix this entirely? ;-)
> 
> Well basically every time you write
> 
> void myfunc(void)
> {
>   guard(rcu)();
>   ...
> }
> 
> sparse will complain about mismatched locks, which is _really_ annoying
> for e.g. networking where there's (a) a kind of "no new warnings" rule,
> and (b) sparse is actually important for all the endian annotations etc.
> 
> Which right now means that we can't use all this new machinery, which is
> a shame.
> 

Indeed.

Regards,
Boqun

> johannes

