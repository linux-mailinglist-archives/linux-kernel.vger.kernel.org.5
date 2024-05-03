Return-Path: <linux-kernel+bounces-167813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA5D8BAF90
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A5FB21757
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416794D9FD;
	Fri,  3 May 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2wehOd5"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592D4AEFE
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714749192; cv=none; b=BPJVwlRPTtIJVPBeT9AyEt6b/P58ike/CMNaW0U0tvrvGFL15OvdzI8QzMBbkMBJrJsEqyCCh9IO09cydBAqnsUILAWxy64xehSSKgl07cpfkCBkOMKPILEQiYYxFmyVUgF7saXZnvbbay2s/jQKAbzazVr99CbK6wjyBcDFdZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714749192; c=relaxed/simple;
	bh=MtOV16US9OOPVT6yc/4gvRUr6dERERtu6jNTTBEhL/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA+cGZjvGvHV8786mCFzVBcSwGYmTHsedTHoWS3fh/Big0m/piFP7m4je5+lxSrfwrjFyrvL5QlreRBHF7uddPx0K6rwpmAAoRiLASTFDKCZ/17HjQ8ykp/RlFlZl3dToa2qjh+M63pYPi/TZTNZbsMtLwgnKoi3C3varhPA7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2wehOd5; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b1e962fde1so206636eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714749189; x=1715353989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0E75BNad58i/+8lefPGC1oKY9AkzjRMB+ho54nCF1QE=;
        b=l2wehOd5TY160nINQm5RK0CXQSqSQxRoEhLCbfrSio2vLAsJDmIAy0PfaZSWrCpIid
         iX3Zf9wLL0o0Vb9jjG27el0G5IeeiKRjEuRzAxg7XcKflvgDzdcpjGVJmTJ6KGSI6Bd4
         gNX52m19X34oOiZzE7WLdKAIApIq3Lo6OlXZb3IigtUmfA60IfJObKUFuO5OLuwFGbkK
         xH0NiZ0o1hPfZG6sTyCQE5AuL7WYXAM9XyUfp7Rr7f5NyvjPX8VE8JalH8vM+mnJYepL
         nTgBzwXa6KkrujmB6RK0AZBdtFCjLfn8SulrA5e4e4AbLg+7DUcXewsit7Y7oJm4bM35
         xX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714749189; x=1715353989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0E75BNad58i/+8lefPGC1oKY9AkzjRMB+ho54nCF1QE=;
        b=tcs/vStuOaK/e7Zqyb6BcIhf+613gqW/KZ99x2Ztm6H2h7qbPKNDHy1txh/nLHqUhx
         fiBPcRU+qUBFZYTyJpPLtBRAqQDx1Rzs5ix2L7WyYWz4hVqoPLrnN36f7TdL0OXqeVfz
         jlC7NAXIBVKJ+PcHwQJKG03zzpRCjBxk+BeGTH5NY3bUopDOPF7+hs+iZswKyY8VZXGc
         uNHBuEvHM/QdpUS8IXe7M0kywOm1ayiqNKLNhDPFK3T8C4XkvCEpvFtbaIf6gpsCyOZ2
         wnUWP3Gz896dssuaHxW8EbJtaqVB3Ugi4Qbh0/3suGkJQaQ0AcoHhM6hpYkDygdv6Ilt
         gzvw==
X-Gm-Message-State: AOJu0Yy7MkzsPVpGTsVuCoolom0NQM2JBKKodTD0A6SueOUsaWGhszX8
	GGo1YJ7m0iTYbSmcGk92YRkAq86L0+DO6DhSHWrpRfwwH2ofxUjY
X-Google-Smtp-Source: AGHT+IFkdjnjtFRWLZi+MoTQekf+FSH/HdLuPb1m6XeCfCP6c/peyTWy4gBI8GYYLYI+KL6YfrKwgg==
X-Received: by 2002:a05:6358:3127:b0:186:26e2:62b6 with SMTP id c39-20020a056358312700b0018626e262b6mr3123947rwe.19.1714749189116;
        Fri, 03 May 2024 08:13:09 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id bx18-20020a056a02051200b005cd835182c5sm2887557pgb.79.2024.05.03.08.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:13:08 -0700 (PDT)
Date: Fri, 3 May 2024 08:13:05 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] lib: make test_bitops compilable into the kernel
 image
Message-ID: <ZjT/AeqiVj/n5v/W@yury-ThinkPad>
References: <20240502233204.2255158-1-yury.norov@gmail.com>
 <20240502233204.2255158-2-yury.norov@gmail.com>
 <ZjRFJ2Kig7l+hieS@visitorckw-System-Product-Name>
 <ZjRIcp7tFadFLGIc@yury-ThinkPad>
 <ZjRK1+Td32rx8r9Q@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjRK1+Td32rx8r9Q@visitorckw-System-Product-Name>

On Fri, May 03, 2024 at 10:24:23AM +0800, Kuan-Wei Chiu wrote:
> On Thu, May 02, 2024 at 07:14:10PM -0700, Yury Norov wrote:
> > On Fri, May 03, 2024 at 10:00:07AM +0800, Kuan-Wei Chiu wrote:
> > > On Thu, May 02, 2024 at 04:32:01PM -0700, Yury Norov wrote:
> > > > The test is limited to be compiled as a module. There's no technical
> > > > reason for it. Now that the test bears performance benchmark, it would
> > > > be reasonable to allow running it at kernel load time, before userspace
> > > > starts, to reduce possible jitter.
> > > > 
> > > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > > ---
> > > >  lib/Kconfig.debug | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > > 
> > > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > > index c63a5fbf1f1c..fc8fe1ea5b49 100644
> > > > --- a/lib/Kconfig.debug
> > > > +++ b/lib/Kconfig.debug
> > > > @@ -2436,7 +2436,6 @@ config TEST_LKM
> > > >  
> > > >  config TEST_BITOPS
> > > >  	tristate "Test module for compilation of bitops operations"
> > > > -	depends on m
> > > 
> > > 
> > > Perhaps it would be better to modify the description in the following
> > > help section at the same time?
> > 
> > What exactly you want to change?
> >
> It seems to me that the entire description is written specifically for
> the module. For instance, "doesn't run or load unless explicitly
> requested by name. for example: modprobe test_bitops." In my view, this
> description is no longer accurate.

In-kernel module is still module. Everything is the same as for .ko,
except that it's loaded automatically and earlier for you. To me this
part of the description is correct.

If you feel it should be reworded - feel free to submit a patch. Now
that we add more functionality in that, it's probably worth to do. Not
in this series, though.

Thanks,
Yury

