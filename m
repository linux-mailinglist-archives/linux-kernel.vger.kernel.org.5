Return-Path: <linux-kernel+bounces-167182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908318BA54D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5BA01C21CDF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA44B168B8;
	Fri,  3 May 2024 02:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzlJPqKN"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E852A168C7
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 02:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714703068; cv=none; b=QWPsyv2ZKLjZNeUCTFlhw+OajdnZ7jMTbr7SghydCSpYYDkLh34g7uktfCD9h9FFHlPodIubjuHqTcTvzAbbTKrbv+1C8RxgZ7cNO125m6EZ+5UpanBmq4MpPVW0sD/wHXK6+3i0m+oyxFtXL5H92u4GFKO5132/Y1S/ghr0wqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714703068; c=relaxed/simple;
	bh=9GAp7pi9gBTKvVhQ4/inUy8g5V8kQO9u5zc4aiHeq2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqNtXWvW5hbntwlETCpcfa15Yw1KdMedh6uq7DPCz2zr63X7AQrILKMhI9tITmauJNUQ/Wm7hj7Uw9KPWRRTyKSzcLou/3XC6pD15p64YyIGrPoDE8lXu9UJksMgURmqQF0sEARsyxYasnWucgMa4OC/W1OqY9WsYGICJHyCC/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzlJPqKN; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2b432d0252cso63493a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 19:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714703066; x=1715307866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHXS7qrB3gFkTxbxknf5YZ8HGBZ3Vcp+86kvqH0nj5E=;
        b=AzlJPqKNEnQIgby0qC2YNRDR145A4q0Le9/Lt/c/w2UDGgG/a5pCj6Q9Fbq7Za6HhJ
         QyGUhWeC0EEoXaOd7H1WQkqTgGE61t/6kPRle7KGE+pS6RfzwGtTS3BSyHno2jXaxu2e
         l3DPnGGwR+SWW3zDZ4euhwsgpouvZHAIYj4XcwLd/RcobsYajeeEesUiBLcYF3os2r/0
         HMU2eVwGPUo5Aifddix6GWFRNzAfmW15dkNdfFUhfeQCXp+gI9siRl1GkzscPO+nyL7o
         WsIuQnIgOeeqq7RjkXXg3rV1454PocZE6GQQBZN9GD9X/FTNOEgyZR6OhQE5cqa5IPKu
         roZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714703066; x=1715307866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHXS7qrB3gFkTxbxknf5YZ8HGBZ3Vcp+86kvqH0nj5E=;
        b=agUv/F3LqCaoJ5AJ/1yAuIWrebrUgrQFDL0qw3G3mmGqIQnlJNw6KmW0jvee/azh2C
         ovhTKMlJAtXZPoogIPkNuBauNex6JHjzlZUx1fMew/ZzN70xCCN5cN9RpIZYDJrTEiyU
         YBC5WY98GbA1+3TX1TZV3IzZwdEi02Y9gMq3fYkRDl/teMdzyx0a+DZvwyhD5JtLgQYx
         fxcYbMeTYAky4k9U0M4d4mV1WGhCsyT3zZxFZSPcI/zf+FtB7XrNrZbFOgT8d+1RGHwb
         LEkbrsFG9Q9UZlIdkoWR8jwU1tgm8TvLiaKEbJPe7Ch341YkRyrKoEvm5U0+ZXUxi/YS
         UfUA==
X-Gm-Message-State: AOJu0YwexPq/XRvaURczcAfD8oPA4E+gD4lFjXc1vQwGNm5XUGl7JHT7
	ZjpFOlCXhhuhDBz3amWP2kK57P4Vl5QEQ8mjlWH8ktxIH+3z5T30
X-Google-Smtp-Source: AGHT+IHI/7sHu7Ero3ZhVqRS3pK7as1wVD0TW5XqvDVIfgFErKLrqAuNKY3oTpFl4bAel/MGNk/H6w==
X-Received: by 2002:a17:902:ecc7:b0:1e9:a06a:c3c3 with SMTP id a7-20020a170902ecc700b001e9a06ac3c3mr1606291plh.5.1714703066116;
        Thu, 02 May 2024 19:24:26 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b001e49bce9d40sm2062735plg.128.2024.05.02.19.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 19:24:25 -0700 (PDT)
Date: Fri, 3 May 2024 10:24:23 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] lib: make test_bitops compilable into the kernel
 image
Message-ID: <ZjRK1+Td32rx8r9Q@visitorckw-System-Product-Name>
References: <20240502233204.2255158-1-yury.norov@gmail.com>
 <20240502233204.2255158-2-yury.norov@gmail.com>
 <ZjRFJ2Kig7l+hieS@visitorckw-System-Product-Name>
 <ZjRIcp7tFadFLGIc@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjRIcp7tFadFLGIc@yury-ThinkPad>

On Thu, May 02, 2024 at 07:14:10PM -0700, Yury Norov wrote:
> On Fri, May 03, 2024 at 10:00:07AM +0800, Kuan-Wei Chiu wrote:
> > On Thu, May 02, 2024 at 04:32:01PM -0700, Yury Norov wrote:
> > > The test is limited to be compiled as a module. There's no technical
> > > reason for it. Now that the test bears performance benchmark, it would
> > > be reasonable to allow running it at kernel load time, before userspace
> > > starts, to reduce possible jitter.
> > > 
> > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > ---
> > >  lib/Kconfig.debug | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index c63a5fbf1f1c..fc8fe1ea5b49 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -2436,7 +2436,6 @@ config TEST_LKM
> > >  
> > >  config TEST_BITOPS
> > >  	tristate "Test module for compilation of bitops operations"
> > > -	depends on m
> > 
> > 
> > Perhaps it would be better to modify the description in the following
> > help section at the same time?
> 
> What exactly you want to change?
>
It seems to me that the entire description is written specifically for
the module. For instance, "doesn't run or load unless explicitly
requested by name. for example: modprobe test_bitops." In my view, this
description is no longer accurate.

Regards,
Kuan-Wei

> > Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > 
> > >  	help
> > >  	  This builds the "test_bitops" module that is much like the
> > >  	  TEST_LKM module except that it does a basic exercise of the
> > > -- 
> > > 2.40.1
> > > 

