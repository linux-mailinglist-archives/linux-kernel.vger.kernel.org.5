Return-Path: <linux-kernel+bounces-150821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEE78AA53B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE4E1F21D13
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B2F199E9B;
	Thu, 18 Apr 2024 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="yhDIjSCf"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036B318410C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477746; cv=none; b=HkGFiUkYoyfJj4njMVZo85OR+uhbhvOwNrqJF/vMUrq7a/7ZVqmPINICYcAd1PhNM7Cmtrx29rAZHS7DUB6ypMBWHwf73JXZ1OFPADlFGAtkyS2KUJj8es2Sliq1xO28j44jyciopJ444Q/PpSWnY68EzCVJ7eCrGX6XsZKz+bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477746; c=relaxed/simple;
	bh=2KtLpJRU0HsaSqlz2Y10nezDIfUmdPYgVpJ+jZy+oLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hrt4yGbc5vaUDUORi1/4iQUvO4fHzt7kwQuyV4f3GegIIkdE48J4VWIw20uUYpcjaGY4l4uqq6tB4W7/gGJc2aUhQRuBFZaelmUQwmxS+wevIWcgHlJ/SHiZYSFF5D/4eqEailiXI63P0tJp+MjYQbrCRlcI/7xH64PKfPxjuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=yhDIjSCf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e5c7d087e1so12463735ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1713477744; x=1714082544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZYz10+Jw+FR7sul9xPuAP8wXTGwjfGPNnrnHfyc5Dc=;
        b=yhDIjSCf9fLtK1yfcvWPgXihQErTIZanMk9/z4Z1WelgTC52oML6Y7uEh04NO8BXG7
         U/JWSTx54WhJMkPdDRVE1zfolCtWjFHJr5ck65klMG6bV+ZKJujiFRZ0WoEP4BLdO34F
         Z2x1rbPAQfgYykrBdQUUKqExePFO+apiPp8MYynTXMfbzRrekJPfY1QjPiFIttXHjlnb
         SjezpqASa/6Ri+qyizD5N5GGu50RbRV8QhTLnc0Q9bvLDOKP1dySvetjvvjLqjttidvY
         vLnWjfSwlwSopROjnQHBdiPsHE8sRXsK1GbWrzHqpeOi/EPAyo025Xfcj5eQH8LBDMRB
         CEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477744; x=1714082544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZYz10+Jw+FR7sul9xPuAP8wXTGwjfGPNnrnHfyc5Dc=;
        b=cH2WDrHHws7r+l25iEGFyeegk3uZak3ES0WV6e8aEbTjRZLS8wWvT4d7pZGb9rwtyd
         qs+YXdd8Aqr2ZT42W7u1DfB7Nm1Waq8cljdXM34r10OBGKj/Lp5aJPY0L5CWHpVzhU59
         EmMa15ns+bdQ0x3uSxBQNaKoc+L9y2PA7ffo6YEfPTXdkkHl01SblmQD+s4zDPUpcKOr
         i+LV9opWf9kCF06KJZ/gz+L4NTyNifz3ZlySQ5ZKxRRuvGlJvIztnLyRyRFAc5QnnXoZ
         666z/jCfziZE+E2ABQOWTRjiPszxkThSoVdYXCltdgdJkiOONRXoxW7ZT1wtXyk3TH8M
         fX9w==
X-Forwarded-Encrypted: i=1; AJvYcCXgM1Vehi5K4XO7shUkznQo03TW1xqUpG4Wm9hYb+7GhSWypt4vaSBj2oO9XVRIRE9zjZHRMjGVg1qjM6kG1uqYaBOZtKTT24jywOWn
X-Gm-Message-State: AOJu0YyMJY6yeYqr3pUbNkneB5CYdhJ7KoqyshmYmKuALyuV9Ch9OCVE
	3DL3aMIVcQ7Y7KYZX3rY78RuerEsvwlcbVGgvonAD/1CaO6LESFPFfHm1TuawZ4=
X-Google-Smtp-Source: AGHT+IER+kTbbVmdy9MQUy1me5vErNGRvApsdwLZkDjapYFIa0b1eYMVC9uuTaJmbYXsJ+hibuvWGA==
X-Received: by 2002:a17:902:b688:b0:1e0:c567:bb42 with SMTP id c8-20020a170902b68800b001e0c567bb42mr371131pls.59.1713477743940;
        Thu, 18 Apr 2024 15:02:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-56-237.pa.nsw.optusnet.com.au. [49.181.56.237])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902820600b001e43df03096sm2018047pln.30.2024.04.18.15.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 15:02:23 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rxZpk-002mfW-08;
	Fri, 19 Apr 2024 08:02:20 +1000
Date: Fri, 19 Apr 2024 08:02:20 +1000
From: Dave Chinner <david@fromorbit.com>
To: Marius Fleischer <fleischermarius@gmail.com>
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, harrisonmichaelgreen@gmail.com,
	syzkaller@googlegroups.com
Subject: Re: KASAN: null-ptr-deref Write in xlog_cil_commit
Message-ID: <ZiGYbJezGZg6tGgq@dread.disaster.area>
References: <CAJg=8jz0X=CKR1POvF41oEumrq1z=MVWPdF2ECbzV6-rhht8-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJg=8jz0X=CKR1POvF41oEumrq1z=MVWPdF2ECbzV6-rhht8-g@mail.gmail.com>

On Thu, Apr 18, 2024 at 11:03:30AM -0700, Marius Fleischer wrote:
> Hi,
> 
> 
> We would like to report the following bug which has been found by our
> modified version of syzkaller.
> 
> ======================================================
> 
> description: KASAN: null-ptr-deref Write in xlog_cil_commit
> 
> affected file: fs/xfs/xfs_log_cil.c
> 
> kernel version: 5.15.156

Really old kernel.

> We took a very brief look at the code. Is it possible that there is a check
> missing for the return value of kvmalloc at fs/xfs/xfs_log_cil.c:224?
> 
> lv = kvmalloc(buf_size, GFP_KERNEL);
> memset(lv, 0, xlog_cil_iovec_space(niovecs));

I've never seen that memory allocation fail there, and that code has
been using an unchecked, open coded kvmalloc() for well over a
decade. We replaced it with a direct call to kvmalloc() in 5.15,
but the failure semantics here never changed.

But I guess it could fail if error injection is enabled,
and because we used to call __vmalloc() directly it may never have
had errors injected?

But, regardless, that's completely irrelevant.

We replaced the kvmalloc() call there with a guaranteed "no fail"
open coded loop in 5.17 for performance reasons, so this open coded
kvmalloc() call only existed in 5.15 and 5.16. See commit
8dc9384b7d75 ("xfs: reduce kvmalloc overhead for CIL shadow
buffers").

-Dave.
-- 
Dave Chinner
david@fromorbit.com

