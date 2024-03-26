Return-Path: <linux-kernel+bounces-118528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B9B88BC30
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B67B2242F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9947613340F;
	Tue, 26 Mar 2024 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="favx9+wr"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28221A0D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441265; cv=none; b=LZ99P95zrMI1dxDTxwl/Wi5K7Pp4p/vUBexUapWjsP4oyxWsfCc0MJkseqrlYDkDeWT/gWUK8FWgKAV51j0xUW2JvEcUSESPideC1bO7YVfdBUUExi7+p+8s5MKzTcswziiRdcnW65gHkLXqOsiX4K22uA68PFVc7JXfzYMygL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441265; c=relaxed/simple;
	bh=jboa17Bqb5WllmRTGqb31G7IV0WbmA1oyRk6l7R3FRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOehTcO/BKXe8MBkJ4dYM+2JSdL8yfWYls7wT0y1ES7974nmgwa3r+dHPipuZZbYkGGa0PEQxHuj+lcGAAq2fqBLSdD/4QOgV8WZFJBregmdeQO2WuTDCaJ0q3H3rBA6iXYdaoESki1d/g1Voy0Uj3e2SCjGWFIjseHc66QBPew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=favx9+wr; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d28051376eso97048391fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711441262; x=1712046062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=00JwIZOKDi6DgcTTzWf7UC+/MLGQH40tfxsFcdx+KHA=;
        b=favx9+wrphaQE7G2yz/4FgQLuap1caT+7bDZhJE5iwKiphX5HzdtreDkLpfjTkR8bw
         eqpDLghPE68G0HWZPpYbSWV5kW83uWQQqGbKxMs2gIY+gueGmjCXnked/lt2Ahlpn4KQ
         asMgJjea0l3H25xD2PtW5WEPdUWdWD7GeMi2McYOA8uxX9RkZqEMzy97lYCPhewFkbPj
         3BZ41aeS3+kHX56VnKahqtmquFEn2bqG25fA2ppbhKFCtJI7njdvYoCNnnEyG+BpA9Ch
         XgB8ubofP+h39wvykP+rHGERtnRUCXV1Agyo15IiNM2HzEVI89wvyq73IdxcUpoD0NPG
         S1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711441262; x=1712046062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00JwIZOKDi6DgcTTzWf7UC+/MLGQH40tfxsFcdx+KHA=;
        b=KKwm4wMb2mV3VHMpIje+Bt51rOzFJKcF7NFXsLVfXoanXt+1fDi5GbzqrO7wi6oD+U
         lNccdaT8cy7GU9PzPoUEZRSVr+7DpwwpXFjsMr07d3pYRoSQvy7jKekxC3AEGnuJl28p
         lhrjGvCM2U/j6i/1gPAb+td1Ny5HdbyX3fC/IKlUB98CrlC6ham6TkbcK3b0vjKueq17
         y+v2XUWiHLeJsbeFXL/S++tzRAVBp4/PsiCTz092gP2n8COYIynClq1932VXOw7MjBoK
         oWtTGLFzPeSucdX9Ln7Y0vzqrJg4NvpP8ZlwMz9qZmp0KeD7gEzQSommY5By17sGWYk2
         Npgg==
X-Forwarded-Encrypted: i=1; AJvYcCVFaaUq9sN4Vf2H4aC2F282o24+JDs+vRryyGVjAO6hdp8BBQZUUnYYskGBX1nglCVaiH+39tidoMiqdRYJ5VKi8/+P7brJW7/1Y3lU
X-Gm-Message-State: AOJu0Yz5hvITAyn0GsEkZZdgbhM9hoMcv+RNL2QItNdETC9jq0U0eFe6
	mgFJUWxjDDSnVvTgoS4Al1CRr6u2jazSLAXvNMYRUHXqUVdl4O/E7Kod+WJOUC/p/Pkwp/c2ZJ5
	i
X-Google-Smtp-Source: AGHT+IEKeRjWVSgxleOc3X7DFjdvs83YGcwvY5YwNXdOYuR97pxt/y/kAPWdrWiNS6PSA3txiCjmgA==
X-Received: by 2002:a05:6512:613:b0:513:e8a0:2d85 with SMTP id b19-20020a056512061300b00513e8a02d85mr7935392lfe.44.1711441262130;
        Tue, 26 Mar 2024 01:21:02 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id c22-20020a1709060fd600b00a4dacd6b8b3sm1034040ejk.68.2024.03.26.01.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:21:01 -0700 (PDT)
Date: Tue, 26 Mar 2024 11:20:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] rcu: mollify sparse with RCU guard
Message-ID: <619df5e7-13bb-4cb4-9018-e4611a0bac8c@moroto.mountain>
References: <20240325101626.41584-2-johannes@sipsolutions.net>
 <ZgGnuFJiTX5laS7c@boqun-archlinux>
 <055111792727869a98c1fa693014e0b6f5d256ea.camel@sipsolutions.net>
 <35355d02-3eef-4860-847b-b7bbf05f4a31@moroto.mountain>
 <48034addaeb6c33ca8b3e636262b6c043ddc5359.camel@sipsolutions.net>
 <04081c65-f9bf-404c-8557-7af72f6a72de@moroto.mountain>
 <0659e47eb33c4159168abe392764a1de44e9bc71.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0659e47eb33c4159168abe392764a1de44e9bc71.camel@sipsolutions.net>

On Tue, Mar 26, 2024 at 08:53:39AM +0100, Johannes Berg wrote:
> On Tue, 2024-03-26 at 10:39 +0300, Dan Carpenter wrote:
> > On Mon, Mar 25, 2024 at 07:43:18PM +0100, Johannes Berg wrote:
> > > On Mon, 2024-03-25 at 21:28 +0300, Dan Carpenter wrote:
> > > > On Mon, Mar 25, 2024 at 05:41:22PM +0100, Johannes Berg wrote:
> > > > > Also __acquire()/__release() are just empty macros without __CHECKER__.
> > > > > So not sure the indirection really is warranted for this special case.
> > > > > 
> > > > > I can add a comment in there, I guess, something like
> > > > > 
> > > > >  /* sparse doesn't actually "call" cleanup functions */
> > > > > 
> > > > > perhaps. That reminds me I forgot to CC Dan ...
> > > > > 
> > > > 
> > > > These are Sparse warnings, not Smatch warning... Smatch doesn't use any
> > > > of the Sparse locking annotations.
> > > 
> > > Sure, of course. I just saw that you added cleanup stuff to sparse to
> > > allow using it in smatch.
> > > 
> > > > Smatch handles cleanup basically correctly at this point.
> > > 
> > > Do you "run" / "emit" the cleanup function calls there?
> > 
> > Yes.
> 
> I see. I guess that doesn't work for sparse. You write:
> 
>    This shouldn't really have been needed if I had written the parse.c
>    code correctly to create new scopes for every __cleanup__.
> 
> Would that maybe be a way to handle it in sparse? Though not sure how to
> return then.

I think I was just wrong when I wrote that.  But I'm not really sure how
this is normally handled by the compiler.

regards,
dan carpenter


