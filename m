Return-Path: <linux-kernel+bounces-167173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CADE78BA538
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802261F22482
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17E614277;
	Fri,  3 May 2024 02:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3cNsCy5"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A9E556
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 02:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702455; cv=none; b=NiePCf6T1oRza18vGo9Al8WeN4Oz1UKoDVYdYqSZ/xg6fsmiqp9Z6nANCJ6Ut0UdsCfBzHduF29vCAG0u11lCEsa4OuntIGCI/XhaET8tpObTKBL0gMNTeUUJS9lgbMiKuE5SISJ8QUFCw8u57w+QTbeuH7r3P9SxaOMmiH4N3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702455; c=relaxed/simple;
	bh=pIXilwK8tz3+bt82kJmVb9uFfaMi1XapX8xGpw6kAtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c174UdpgcklmStOZUfxDtShZaKn4QhbeQDUTGmbu30kUi5iEtSZFXSlK7bBcSO0UY+J5v7btlLpaUutLnERjOKQ1+I4Oedtxv9O+WC74y+24HQS9/2QpCxHg+ve5ImfKvi2og96c4Sx0t79UgIoWJ8+KHsAyMqraOMkNHU2mmZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3cNsCy5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ac9b225a91so6601358a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 19:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714702453; x=1715307253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKDBBJr9fJT2Ev+EpZJ84HxC5EtuTkSSVpqWAo0rquc=;
        b=c3cNsCy5Dul7YGpLrJfy3pstljebu1xrjDW1iE9W/D3WhDlNVwyr/ZiwWxdaL34ML8
         1VaYtFQ3p+CduOtpjJcAWIxZKLx5qXavZXDmr7ZCafytURjO37caAG11a+d+9ArT3IAr
         VofiTBBI7mdkXSre1pcWFKir5VMk5IXZsKXubgOPH8sXSS6jPZWsVJE/B2iGZ3VGVoZ1
         TO2xEY6VB2E4DOWtAxGTasFZCY5vopBOabrWP64C7GkSRxqUmtNKSlcYzellwE8JZjkK
         ZDNL7HEOcOe6CCwbIxxsDvhXioix47+htqCFsrH+XHu5+6/UysFu+WisHGkPc69XeGVb
         MaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714702453; x=1715307253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKDBBJr9fJT2Ev+EpZJ84HxC5EtuTkSSVpqWAo0rquc=;
        b=s+1DirHb951HQ8Nl9/quHvJRmP+u3oT2eQjMf08jt2bwRyRkjbJpIFR6L1ACbVHQo5
         E+8oKG9suu9dLRYzmHhZbOj+C3Hs+tfRXWnR8oXYg98muS4DBFUjuzk4X02VApIhj5Wo
         G0b2gVj+vL+3x4EejuksloFCB6JEGjP+ReR0AOkydSf9ItthsAbQblcO35ucIDLScyu2
         v8yAue5GmyKhUpihlF7Xgp12l+h78n0KFgdWiHW2Q4WR9cDWzhO7iwDewZeC3OMC/0wL
         lLVV+T219FtzshNhFpMi6bGb8lBnw47ostrio1tuum/JWhkbfrTM3GCk3nxOYTNjqch0
         xSdw==
X-Gm-Message-State: AOJu0Yx82E9RBEw1QGNF4o+CPxYZwbo+lzSsZ9EKNYFzsgma8+Vvmof/
	VOaibcDW4WCsD6uAoDctthKWBFgXw1tZKjjTAopTY4900ErqBhn7
X-Google-Smtp-Source: AGHT+IF2coJfp4jzIQvn1Si3wUiZ8I7P4X6dzwWx+OISNtWaotCnSiWAfFB95CMD7C4Nut/JQmRskA==
X-Received: by 2002:a17:90a:7781:b0:2b2:bccc:5681 with SMTP id v1-20020a17090a778100b002b2bccc5681mr1541987pjk.33.1714702453076;
        Thu, 02 May 2024 19:14:13 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id pv7-20020a17090b3c8700b002a5f44353d2sm3970627pjb.7.2024.05.02.19.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 19:14:12 -0700 (PDT)
Date: Thu, 2 May 2024 19:14:10 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] lib: make test_bitops compilable into the kernel
 image
Message-ID: <ZjRIcp7tFadFLGIc@yury-ThinkPad>
References: <20240502233204.2255158-1-yury.norov@gmail.com>
 <20240502233204.2255158-2-yury.norov@gmail.com>
 <ZjRFJ2Kig7l+hieS@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjRFJ2Kig7l+hieS@visitorckw-System-Product-Name>

On Fri, May 03, 2024 at 10:00:07AM +0800, Kuan-Wei Chiu wrote:
> On Thu, May 02, 2024 at 04:32:01PM -0700, Yury Norov wrote:
> > The test is limited to be compiled as a module. There's no technical
> > reason for it. Now that the test bears performance benchmark, it would
> > be reasonable to allow running it at kernel load time, before userspace
> > starts, to reduce possible jitter.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  lib/Kconfig.debug | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index c63a5fbf1f1c..fc8fe1ea5b49 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2436,7 +2436,6 @@ config TEST_LKM
> >  
> >  config TEST_BITOPS
> >  	tristate "Test module for compilation of bitops operations"
> > -	depends on m
> 
> 
> Perhaps it would be better to modify the description in the following
> help section at the same time?

What exactly you want to change?
 
> Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> >  	help
> >  	  This builds the "test_bitops" module that is much like the
> >  	  TEST_LKM module except that it does a basic exercise of the
> > -- 
> > 2.40.1
> > 

