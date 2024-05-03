Return-Path: <linux-kernel+bounces-167821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BFD8BAFCD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76036B21D9D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1D5153BD1;
	Fri,  3 May 2024 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1t2ZlkV"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD52815359B
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750175; cv=none; b=KJIyS0n/xPWODuiMcz+3i869eLwDuH8J5InXxej/oPP6WRBcnPCMzga/cOwFT73+Xbs+61Pa+rAUGDnCXcVWVP4nzvcFR1/xvWurYETxHkCjeT5FMOHoi3aJpMhG5DvO6A3oGt0pqMyvUxD1bU9b/SAU1m7d3230f60/0H7OB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750175; c=relaxed/simple;
	bh=WbRm3BN/7aDmUpsI+si1v6pmj88t02uPAANA6pvK8wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBNyKU/mneuw+HH1Q7HJ3Urqoi9s5/06RkCVbp1bhiA92GvuFIqSmwysRkSymyee6h65dy7kgVIFgnjC3MHEFNTXlDn1ADz9jwCY0cy5nEwxvE/x1teEWEEzA01YRChgSiKP97agMyXBoo6ESr3Vcqp3Lhu9LvbOyp+ZBZSMgTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1t2ZlkV; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b432ae7dabso240885a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 08:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714750173; x=1715354973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sUTFXo5p/UB+N0nZof6O9wQMHpQw0r/mugXKb0b3Hgs=;
        b=e1t2ZlkVdlIoTprKsaVY0jcsUz8VGqNfcCjcnowwlielLKP/dSlty8/FUjbOoyXJNn
         3sp8bMYjgCmzsLpcVnICqSkhCjYQ9YNl3OvsWMkirnUmSYWW4gvAYQs/EzdOzqX9cy/t
         lbAaAXD4GfX9os69j4rZl6vp+hPaXLxVyRO2GSdFpe7ZKJrXz2+agItqGoxdVCaMw4Cs
         ygqLnqjG+gy5lqwfz6UIZWLSgmGctKFty1/F8bDrei45wnfbminBMd5ezbGb9mWx58Qk
         CjnXEtzP+1NnAqGuBf70UKMB2nHDtfOwLnKmtv//cwJEJAxevnSQCVe/XetQHXHBTW9P
         ZyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714750173; x=1715354973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUTFXo5p/UB+N0nZof6O9wQMHpQw0r/mugXKb0b3Hgs=;
        b=FyZGismS63xbApCo4ThwA15uI0PUMHeNj7FNpRQePJpc5suoUKToOZesR2HS0OM9dG
         mGYPQcR1fAFVQDsnGMzdYy6xBcV9kMIVMkVv3FmQnQfCdJLG7iMgfId8fs/GcSkBnz3i
         UcQQkucMIjwESxfS8MXhmiD8VDNDJjCAEyoqjWgKBgae/Fm85D6BGU4caRqpewq4lOEL
         /47SDG63GQXCVlDf6Pwa1m29nnLc8tZpFS9OSIxsbL9N4RqW+heF48tUUu07pIoVzxlV
         e0PtJJoAh68hbOjoXnml+ZZrvGLVF1BcOMxgcH6Xt/0ABrHULtmdIDDnhE4vSPC6lU1V
         iwKA==
X-Gm-Message-State: AOJu0Yw2RT8MUaHX37aZ87Ht8bL1dNFaM0oPctDn7SjkM/f3v7a5MpgQ
	Y2hPCjQd13nYOF47aCsbRmMvu3fNrht5bCcrMVCQUa39GsXdIvwFbEzGPbpH
X-Google-Smtp-Source: AGHT+IFj6cNa4wcFi+zSrj/uSab2DA+1VkgehcREh7Ks1fISNHWW8uXb4PmF81nlZC4hVxpYVPYbjA==
X-Received: by 2002:a17:902:e551:b0:1dd:b883:3398 with SMTP id n17-20020a170902e55100b001ddb8833398mr3136161plf.4.1714750172862;
        Fri, 03 May 2024 08:29:32 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b001eab26889a7sm3395697plh.136.2024.05.03.08.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:29:32 -0700 (PDT)
Date: Fri, 3 May 2024 23:29:29 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] lib: make test_bitops compilable into the kernel
 image
Message-ID: <ZjUC2RWfUH3ZVesW@visitorckw-System-Product-Name>
References: <20240502233204.2255158-1-yury.norov@gmail.com>
 <20240502233204.2255158-2-yury.norov@gmail.com>
 <ZjRFJ2Kig7l+hieS@visitorckw-System-Product-Name>
 <ZjRIcp7tFadFLGIc@yury-ThinkPad>
 <ZjRK1+Td32rx8r9Q@visitorckw-System-Product-Name>
 <ZjT/AeqiVj/n5v/W@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjT/AeqiVj/n5v/W@yury-ThinkPad>

On Fri, May 03, 2024 at 08:13:05AM -0700, Yury Norov wrote:
> On Fri, May 03, 2024 at 10:24:23AM +0800, Kuan-Wei Chiu wrote:
> > On Thu, May 02, 2024 at 07:14:10PM -0700, Yury Norov wrote:
> > > On Fri, May 03, 2024 at 10:00:07AM +0800, Kuan-Wei Chiu wrote:
> > > > On Thu, May 02, 2024 at 04:32:01PM -0700, Yury Norov wrote:
> > > > > The test is limited to be compiled as a module. There's no technical
> > > > > reason for it. Now that the test bears performance benchmark, it would
> > > > > be reasonable to allow running it at kernel load time, before userspace
> > > > > starts, to reduce possible jitter.
> > > > > 
> > > > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > > > ---
> > > > >  lib/Kconfig.debug | 1 -
> > > > >  1 file changed, 1 deletion(-)
> > > > > 
> > > > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > > > index c63a5fbf1f1c..fc8fe1ea5b49 100644
> > > > > --- a/lib/Kconfig.debug
> > > > > +++ b/lib/Kconfig.debug
> > > > > @@ -2436,7 +2436,6 @@ config TEST_LKM
> > > > >  
> > > > >  config TEST_BITOPS
> > > > >  	tristate "Test module for compilation of bitops operations"
> > > > > -	depends on m
> > > > 
> > > > 
> > > > Perhaps it would be better to modify the description in the following
> > > > help section at the same time?
> > > 
> > > What exactly you want to change?
> > >
> > It seems to me that the entire description is written specifically for
> > the module. For instance, "doesn't run or load unless explicitly
> > requested by name. for example: modprobe test_bitops." In my view, this
> > description is no longer accurate.
> 
> In-kernel module is still module. Everything is the same as for .ko,
> except that it's loaded automatically and earlier for you. To me this
> part of the description is correct.
> 
> If you feel it should be reworded - feel free to submit a patch. Now
> that we add more functionality in that, it's probably worth to do. Not
> in this series, though.
> 
> Thanks,
> Yury

Got it, thank you for the explanation! :)

Regards,
Kuan-Wei

