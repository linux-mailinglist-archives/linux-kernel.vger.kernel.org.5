Return-Path: <linux-kernel+bounces-97601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F96D876C64
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046EC1F2142E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370845F879;
	Fri,  8 Mar 2024 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fieBYV4b"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9395A0E9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933368; cv=none; b=P+Rp9CHp/eG8CvxDF2JJMQYRSardk/JZXlC+r2fZofPP7d5a97DTIslZoOgER2VQtYIvDEupfJ7FcuieFXkEq/jecVQpq5/6Si1MtV5nhlL1gi3CCskAPZ1gCvx9V8Pse4XY5oobMCsm9se2glHgwycBAhZ3czXHE8Sfv6IjRiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933368; c=relaxed/simple;
	bh=enbOfX48AZcV/R3bohKaaCBNPl2vKkKF1NeVvwrUD2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4fP7GgP4guM8HXbOXb0ZrEv/U6oS61E4d2pogycbL1fNTPxVqL2+Ap+OcqZ5IFclWv25gMHpnK6kJHkUyYkA02rh9kQlcbKdtnmrtm/nTFyuJvzWki4q7LOcDJtTANiVXgprl5xJ5TiqBS5jchmp7Eu3SWNU2jtrRTKCYMK66o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fieBYV4b; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a456ab934eeso367988666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 13:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709933365; x=1710538165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XxAN82VZIFEPcZxBPzCoGsB8df9KbUJlKh3u8U3jeiA=;
        b=fieBYV4b2ZzCeiPq2V8XIsoQqSI4jtfHh/+kWqJ3CJlI6cWfehXE7Wq3leCmOHvGzB
         8PW/3YICVOlBqpZNCdpronwfyLDFTWzJx7UMdP7ituemM2uqqOKFVPY4Mw3Miz930aaI
         LJqCwt8SRKYs3hoXPc88QgBK6jdk7RRJ9dL6J9oUOFVK56yBNNM1K/YqAFg6hVzdPHBw
         jRvkTB/TraR0/289FjmosHo2FXdOexvHjxxQ24Usyfmv2/6/H0ZaGYk3pXUPAl+D5vVV
         zmgkOm6/GYOPk/OtFd/+sqoQgBM6gmFwR1H5cPcYblyLE0aiIYiwDybeNUOuitMbm0zv
         S1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709933365; x=1710538165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxAN82VZIFEPcZxBPzCoGsB8df9KbUJlKh3u8U3jeiA=;
        b=reBE6b1/ItPZaliaU1Ec81NhmvxNV6PXc4b+w+jNCiOOy5sR77dSYmz96F6y3i1OYM
         6Fh2U3lYNV4k55BIaC8SjP+QZ2wqxa9Ps9K+GIjLfX3o/2KKaS77Iowpol4Do5ikxVFK
         3HC/hOGKBdCjvq2k68OeW9UoWa2UYyh/OAkm9sRkBRrc1PmhvYKeeXNIssRoPsX07jiN
         s5uA/yni1ntbGnPxffuP5uw0gMcPZOGwM8juwFJTmyavMGPOIUk4ButfMZP/ogpAtdVJ
         Q+mR3u0LjUsNHeCen5UOvoec4TyNOEmwlfGRkaLTZuzTT5m9nCqQmUnV80yGUhcy08of
         /Jfw==
X-Forwarded-Encrypted: i=1; AJvYcCWm17jNQBmJSSh/XmBMvWkYqguNroDmqEOfp2MhmUuOc0GidWlG6HLlygr4gbynVHF0g0uOBZD0+i738YLL7FDHk0Qi4DARRe3p1mGx
X-Gm-Message-State: AOJu0Yxb2wiy15hhiuxifADMVJagPNZl7p7rK9K8Tih7DL3TpPlynnfV
	91DGA24mnY4Cmku/emaMdCwO40WrTt6Ig0TwGt6d6utGplShBEkCtTGUMaSd
X-Google-Smtp-Source: AGHT+IHUiMGiGki9uDXvWYbkzmIrC+FesuYkoxkdC4LBV4LlZIWPap6lovHGuB5E2nKmDCZuPsa14w==
X-Received: by 2002:a17:907:c310:b0:a45:f262:bc2f with SMTP id tl16-20020a170907c31000b00a45f262bc2fmr240724ejc.5.1709933364868;
        Fri, 08 Mar 2024 13:29:24 -0800 (PST)
Received: from andrea ([31.189.122.3])
        by smtp.gmail.com with ESMTPSA id gc3-20020a170906c8c300b00a45deac10fdsm180273ejb.207.2024.03.08.13.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 13:29:24 -0800 (PST)
Date: Fri, 8 Mar 2024 22:29:20 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kenneth-Lee-2012@foxmail.com, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
Message-ID: <ZeuDMKtVotRefSm3@andrea>
References: <e05fa6a9-c810-46cb-b033-b91ae7a5c382@rowland.harvard.edu>
 <ZejC+lutRuwXQrMz@andrea>
 <Zenip+8BDM3p+MUh@andrea>
 <eb8f2a21-d388-424d-8504-ccd7bdb53a93@rowland.harvard.edu>
 <ZeoFBkB1BeTdEQsn@andrea>
 <bde188b0-1c5b-4b3b-94de-395a52fc37ce@rowland.harvard.edu>
 <ZeoQvj3l6moF9KdQ@andrea>
 <b3137a9b-0776-421f-8b3b-b5ddd6bce96a@rowland.harvard.edu>
 <ZeosQDNK8hN/KgJR@andrea>
 <198f16f6-1d61-4868-b522-1bc5d34bf7af@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <198f16f6-1d61-4868-b522-1bc5d34bf7af@rowland.harvard.edu>

> I can't tell which aspect of this bothers you more: the fact that the 
> text uses an argument by contradiction, or the fact that it ignores the 
> possibility of two instructions executing at the same time.
> 
> If it's the latter, consider this: Although the text doesn't say so, 
> the reasoning it gives also covers the case where F executes at the same 
> time as E.  You can still deduce that W must have propagated to E's 
> CPU before E executed, because W must propagate to every CPU before F 
> executes.

Agreed.  I suspect this exchange would have been much shorter if we did
say/write so, but I'll leave it up to you.


> (In fact, that sentence isn't entirely accurate.  It should say "... not 
> to propagate W (or a co-later store)...".)
> 
> Let's consider coe instead of fre.  The description of how the 
> operational model manages the coherence order of stores is found in 
> section 13 (AN OPERATIONAL MODEL):
> 
> 	When CPU C executes a store instruction, it tells the memory 
> 	subsystem to store a certain value at a certain location.  The 
> 	memory subsystem propagates the store to all the other CPUs as 
> 	well as to RAM.  (As a special case, we say that the store 
> 	propagates to its own CPU at the time it is executed.)  The 
> 	memory subsystem also determines where the store falls in the 
> 	location's coherence order.  In particular, it must arrange for 
> 	the store to be co-later than (i.e., to overwrite) any other 
> 	store to the same location which has already propagated to CPU 
> 	C.
> 
> So now if E is a store and is co-before W, how do we know that W didn't 
> propagate to E's CPU before E executed?  It's clear from the last 
> sentence of the text above: If W had propagated to E's CPU before E 
> executed then the memory subsystem would have arranged for E to be 
> co-later than W.  That's an argument by contradiction, and there's no 
> way to avoid it here.

I can live with that.

  Andrea

