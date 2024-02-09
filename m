Return-Path: <linux-kernel+bounces-58936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572FF84EED7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BD41C24CAF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5564C523B;
	Fri,  9 Feb 2024 02:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="cdE+pwHr"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E714C87
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707445666; cv=none; b=mH983GI/hoc+5dpp94/4IZcZugF5rrCDlW8AsTNjWAXDTVpmGKdIuZ7AMjBMXMLRdGVaOlyd/ZyGcX7Fl4pAAEuOXC2ZhKh66D0wqHDMwMYBPbHy2xeqYsvP/6uGBm0bDr5IJhY/qFoqYj2c6G94VqCYEOIKYnrkPLNrMZf1hSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707445666; c=relaxed/simple;
	bh=5AR09vifAbcehrf7gx8Ei50PegxqI0q3yOSI87I8RuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNf8Bx18GfekU9niF32uRfhzMWpXUDPWYWMvlvQ9D2plvyHPrKmMilhdSGuGK4+ejYmJL5rDtFvEr/Y9YT4z2yJ3KU0n1XC2CFPB+3UL3HdVPPPP4qW2thz7TQi1gp3W57TVq8V4JNhaWJbOTqmFw1q8g0JoDsOwIvJzXaVh2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=cdE+pwHr; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-363b5bcec8fso1552965ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 18:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707445664; x=1708050464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l9iGOFLZSVzWcbEp3u2tWxEn4n0pUonqnkzcROu4x5E=;
        b=cdE+pwHrfmb2HEidUXf+L00kAZftuKILZ+wonUskDUhpHAYdYtmOAiwGfk5hLTTBuV
         IXVNAyP5D3o+GC0dpoY9woZ5WR0oj7H31CTELZ5iK3iMi3+eOSTyn6POrdaRdEFKEEm1
         GkIEqIRWcZjV0SosLf8dhPJOwHdDyfSTLv04giQg1+jPQsBiGOqUqf2H8aunwhYjG7JX
         bO1MKTjzNmcjGhkRF3K2M3ev8gt6X/Gr3U6767RMEyTqqavXCmUC525PUDCCkszcIbEg
         WyJAwVk8T6gm7/bEfizFIZ/6xZHm7jBiYCKlluuJWnPgzwvmh5WCEBGxM/ryyEELIvmV
         cotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707445664; x=1708050464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9iGOFLZSVzWcbEp3u2tWxEn4n0pUonqnkzcROu4x5E=;
        b=aZ/YLFUQaU4moWk5M5KScitgfRstOrw/9oh9qUqYNUid7ykwfHqyhc9CXgcpYKRyLA
         lyBpTmcY7mmazeXoy+QrrT/HSzzRIdUYUr5TPbgJ24vr2jZr6fEXJmzcdJeRuIt2+A+T
         BzNCwovUKaDQHAOrRJMYAeb5f4qJ6hZ9lKMKLIrlX9BfGUNwtnuqKiwo3GOn2Q2NEJ56
         ygWLgaRwybbuLDG362lD2QRSc5uEjdSVTSvNIrMEfIeXFwVo5Ey6pjhgpuAj3VfEfHlb
         /nlYjmfIWiEeS47zrMoXmsXem/e1kVBdh3fjjEqYN32nlVOknZWEqVms4LdzvP0DbSTr
         bEBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC/SLev8HDd8SpFNt3A1+FKE0jnpS0XpMT96pXGWLTbFgmACS9X+ScNAlryjwBPMi9hptMImJXYfZSdKBK+3oEnwh+slj7OzEgg2cX
X-Gm-Message-State: AOJu0YwLB4Qmoon7r5wCrDV8QPmtcZ0uMvlzopTqHNwxgeFW+8gJenTC
	AT/MroP8e5k8wMEqjYz835rA1iX/Drf66MLLeLh5TsD/Z/CLN24R3XLskFyl1lKNQWJ3mDy7qh5
	2
X-Google-Smtp-Source: AGHT+IGa2YNtYlA1PT16QcP3wkyWFHARvZuFfpeZDNMbi+WZgzVKq7JNQ7ISvyCZrCOv1lyVInCCFQ==
X-Received: by 2002:a05:6e02:1284:b0:363:d9c7:a7e3 with SMTP id y4-20020a056e02128400b00363d9c7a7e3mr456032ilq.6.1707445663915;
        Thu, 08 Feb 2024 18:27:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrOTG8bIYqrCf4S5bziCLrJCoiw0wt55umSD4gRYBXbvRD6EWty8J2oBfxMSXmdC5GVG7bfjooMKku+NsxWIeDis7skKqfERCnhGUWOPUS6dyiQ6xhR6qYzdHikcghzzC9RALz/jkl1Zh2Lg==
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id i2-20020a639d02000000b005b7dd356f75sm570675pgd.32.2024.02.08.18.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 18:27:43 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rYGc8-003ypn-0S;
	Fri, 09 Feb 2024 13:27:40 +1100
Date: Fri, 9 Feb 2024 13:27:40 +1100
From: Dave Chinner <david@fromorbit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] tracing the source of errors
Message-ID: <ZcWNnIY7DQTqqj96@dread.disaster.area>
References: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
 <ZcP4GewZ9jPw5NbA@dread.disaster.area>
 <CAJfpeguTGdAuQ+5Ai0ZXL7p-UeCyk2spBDhm6bkdTC-0UAKenQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguTGdAuQ+5Ai0ZXL7p-UeCyk2spBDhm6bkdTC-0UAKenQ@mail.gmail.com>

On Thu, Feb 08, 2024 at 10:09:36AM +0100, Miklos Szeredi wrote:
> On Wed, 7 Feb 2024 at 22:37, Dave Chinner <david@fromorbit.com> wrote:
> 
> > ftrace using the function_graph tracer will emit the return values
> > of the functions if you use it with the 'funcgraph-retval' option.
> >
> > Seems like a solved problem?
> 
> Except
> 
> a) this seems exceedingly difficult to set up for non-developers,
> which is often where this is needed.  Even strace is pretty verbose
> and the generated output too big, let alone all function calls across
> the whole system.

trace-cmd is your friend.

# trace-cmd record -p function_graph -l vfs_statx sleep 1
# trace-cmd report
...

There's also 'perf ftrace ...' as another wrapper for ftrace based
profiling, though I have never used that at all.

> b) can only point to the function was generated.  But the same error
> is often generated for several different reasons within the same
> function and the return value doesn't help there.

In most cases knowing waht the function call parameters are
and the return value is enough to determine which error check
failed. Seems like that's within the scope of what ftrace could
provide us with...

> I think a) is the critical one, and possibly the ftrace infrastructure
> could be used for something more friendly that just pointed to the
> function where the error was generated without having to go through
> hoops.

*nod*

I don't use ftrace directly - never have. trace-cmd has been around
for a long time and does pretty much everything I've ever needed
over the past 15 years. That said, trace-cmd does not export all of
ftrace's features, but most of them are there and there are a lot of
users and developers already familiar with trace-cmd as a way of
seeing what is going on inside the kernel when things go wrong....

Hence I just don't see the "ftrace is difficult to use" argument as
being relevant to "how do we trace the source of the error"
discussions.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

