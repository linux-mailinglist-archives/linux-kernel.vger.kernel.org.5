Return-Path: <linux-kernel+bounces-118473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBF788BB75
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0741C30F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9A01311B9;
	Tue, 26 Mar 2024 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HoibRsy6"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141091804F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438771; cv=none; b=TdpvGd0oZzMlLVvJwnfDDV4LHnUW5nc8fWugGFSyXo3tCFZ7GlvRFVxB3nfy03PdV7cvXQ1HXWOllezvVGfXZx4ruxIELV3jkU2VClxRhS98q9lW92ay9x/psn9lFQ+GT8lLFjY9bQBvhRKGu46PFHTHkAFeFJUiiZTHJJraEZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438771; c=relaxed/simple;
	bh=8w7YyVfPHHkt9fsS4UfjXvhYBgUF6vCR2H6M+19LWqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD/cehTxH9bpLF+KWCE5+6xgZ7nAy1bPmEqRHYSrWMLgKx+7H1yMbW3PVnL71BPbF0ESt2+lckeeub/yk98HTm0Y80pvYbYd3fkv6HBCvpi1wA2GBqHA1q5lFcOMXo1R7oBxu5JGgeOU3EhWlriaY4vdPEpvRq/tGl3x7kUmMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HoibRsy6; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513e6777af4so9329308e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711438768; x=1712043568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvzSmPDSw/R6lc39rz+OtlP8UbFNqiP5ETVlhBX4TNw=;
        b=HoibRsy6UtpDwFNCez+1lDYP/1iiB7LZHztplVucHyJxrKkTC9TPSxBk0hJYA35Ctw
         bU4dOHAIU74V6ZNN4VXwhgKNuAF7mjHob2zZSw/cHGe4S0I7MlgtvIRWbfXDKa+qwrxe
         0VnaExHy/IPvIaxa3mbkeqBFTAIzj7TjiG0aW5MrYj1PY8lpFcfja37XMpLotLXz2wKE
         VdUJwjIzcP0uOKs6BqRzfXwRa6kOpCvfa7FgXkMDppLvJODwctG+sr16uMgCk805+aD5
         Dm+zRmdq3kjU6VEuzqSSNGMMYoxJUcx7a2IqyoxqxsCl7KJeJr+dqrRALr8cNJZ+ejIG
         RJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711438768; x=1712043568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvzSmPDSw/R6lc39rz+OtlP8UbFNqiP5ETVlhBX4TNw=;
        b=jkTPQBxVxswhqdR9C485/X1icoR+eb1AD2FdqZ7LCW1HeKdlhWvApA5I+vpFAlc1Zr
         bbfonYTiERgUchiOK+EAsmsBteZxVCAXTJ3t+WeLs/aTalKx5OLIIYKzuDIcW+fP/scv
         FIH1HAGutKYMq52pPOqa8/6/Y+PfEIgPWPBXbC1jqC/7wgdEU1pFdb146yFtzHKdJQJg
         zz2Uy0MNXNV4gLR3oIaQj2Huo5lcmEYYXFOmAx2wsGHU1tpybbl6PjKm9/+wNnDdoSmd
         XIg7yZIaOcAIiY1+n+3YTWJaCOmvntnRftqeXkUpLE0DNVYmsJcIRtkGAkIwfh1sbLU3
         1S7A==
X-Forwarded-Encrypted: i=1; AJvYcCVgRhQL6Jdu8rJCh0ylxJLIZGsRUJxImhX9OHJ+kfNHPdNS9AG+QinlLcd4Mu+CYsjYSJy6BHcJ0sMHtqXuTusFSGlWkE2iRFSS6AdW
X-Gm-Message-State: AOJu0YzDCG8G3u4fh4r9lY6nJYYniO4GpXVhouUuBHxNz5Ly7lO7EUiJ
	UkpWUoSbh5pyoTbAZVcAak+1low1fB41Yb3oSkG4TMjYxDlP2GChJIvltunLO2cuRKZ3P/f7/J+
	1
X-Google-Smtp-Source: AGHT+IGLSL8WSBOQSKMFrBI50DzQHW/xu5ntChH4sQ0Wb7e369aYGWd5yEuyf5pb37QsBxA2rIRsyQ==
X-Received: by 2002:a05:6512:3b90:b0:515:b02b:ce81 with SMTP id g16-20020a0565123b9000b00515b02bce81mr4136910lfv.30.1711438768009;
        Tue, 26 Mar 2024 00:39:28 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id js20-20020a170906ca9400b00a474b7bbc76sm3115297ejb.56.2024.03.26.00.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 00:39:27 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:39:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] rcu: mollify sparse with RCU guard
Message-ID: <04081c65-f9bf-404c-8557-7af72f6a72de@moroto.mountain>
References: <20240325101626.41584-2-johannes@sipsolutions.net>
 <ZgGnuFJiTX5laS7c@boqun-archlinux>
 <055111792727869a98c1fa693014e0b6f5d256ea.camel@sipsolutions.net>
 <35355d02-3eef-4860-847b-b7bbf05f4a31@moroto.mountain>
 <48034addaeb6c33ca8b3e636262b6c043ddc5359.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48034addaeb6c33ca8b3e636262b6c043ddc5359.camel@sipsolutions.net>

On Mon, Mar 25, 2024 at 07:43:18PM +0100, Johannes Berg wrote:
> On Mon, 2024-03-25 at 21:28 +0300, Dan Carpenter wrote:
> > On Mon, Mar 25, 2024 at 05:41:22PM +0100, Johannes Berg wrote:
> > > Also __acquire()/__release() are just empty macros without __CHECKER__.
> > > So not sure the indirection really is warranted for this special case.
> > > 
> > > I can add a comment in there, I guess, something like
> > > 
> > >  /* sparse doesn't actually "call" cleanup functions */
> > > 
> > > perhaps. That reminds me I forgot to CC Dan ...
> > > 
> > 
> > These are Sparse warnings, not Smatch warning... Smatch doesn't use any
> > of the Sparse locking annotations.
> 
> Sure, of course. I just saw that you added cleanup stuff to sparse to
> allow using it in smatch.
> 
> > Smatch handles cleanup basically correctly at this point.
> 
> Do you "run" / "emit" the cleanup function calls there?

Yes.

> I briefly look
> at doing that in sparse but it felt ... complicated, and then I saw the
> condition in the cleanup function which I thought sparse could probably
> not see through anyway.

The if (_T->lock) statements are a problem.  For those, I have to
manually add them to check_locking.c as an unlock function and to
check_preempt.c as a decrement the preempt count function.  The other
place that I have to add them is to smatch_data/db/kernel.return_fixes
because the scoped_guard() macros checks them as well.  I had to do
quite a bit of patching things up when the sound subsystem started using
cleanup.h so here is an example of what that looks like:

https://github.com/error27/smatch/commit/a2f68c96f70a0cdc581beff81eb6d412ac8dfc4f

regards,
dan carpenter

