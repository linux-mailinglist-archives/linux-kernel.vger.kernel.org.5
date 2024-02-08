Return-Path: <linux-kernel+bounces-58257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F060984E390
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53872B224C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A896BB36;
	Thu,  8 Feb 2024 14:59:33 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6631D79940
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404373; cv=none; b=AHjrZokEb1k81L0G9ZWnSvyaEujyHklqwq83opyviUQLdZJ6etHzY2XOffQ/ZDf3mENA/itG7aXSiOc4oLv3VMFL/8wNe5+YCn1bFxVmAbHPD9Pgo9poodT1vi6MvOyqSyKRSiiEh+VfcHbKf4WNmOi0IoyUHrBMVlu46yzo1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404373; c=relaxed/simple;
	bh=Y3pFY2f5tHAZ/j/rcQJobj/DvdkCARa8U8rRPl+PpLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmLOrr69wJ2UQKNuKCoqOFWufobNa0TGxVk+rq4zRtHGdcQLPw6MguccO5tbos6QSSx+QYllKl+4AoPBgC/yy+LUjw9nwHoGFodRD7TgOaCln/QMKxgCorlSeAaVXaKJyHCpZ160YrMx/GdTLMAExnYzbQDJV4SilkE1k+jPEug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5116063585aso2437212e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 06:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707404369; x=1708009169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIBZVDVF6Z81oQ3eYA9Y9+23PKDxW9nhh51NQVQiUH8=;
        b=SWXw2sqsYj54JWPTFbUpW4clyYQ0wti/MImTW8jI5EeYk5wo7ZpsuFFvVePOJtAu/9
         wey89hQoBfifUR9Yc5lwyyyJvrhf+ErxFxTEJClMkzW7UEwe1wnYUPj5O6vwsA9YNf3b
         Q9hCKamKpgE1oUtVQ+qvXJDFiDvnAP3hupInG7igsuLUzAR5JygDJLtDhC/y1qyOim5g
         P9mvh9w9Tp6GouQK9POjXmlmQcyNBA+ZtKWuJtTjxuG86Ssma3t1h1MZ5Gdhr5eZXJEl
         gJUtEMhXG2QLgSTExvlY/GdACxGtVLGOspbxQyg3Gxginj5M++8p6gJnQbhh4G97ck8p
         t5QA==
X-Forwarded-Encrypted: i=1; AJvYcCXFT4aEWNCHfrwEyV2K9p0xBhMppYelga0n0cpWOJCGl3tVD3AxijK15KRxdeH40/ZIoglzKEXhUV5J/WVhKZr2/KdE0xDyF9xY5CcD
X-Gm-Message-State: AOJu0Yw1t+kUkjznMdbYlaSsp0leaHpKPL7DdEpX9C5dMaWg18FYiZMx
	r3rTtPPZCQJvRlQ0lsxaBilmj4yUPdmQoDzSV9AZylP/1jeGxsFG
X-Google-Smtp-Source: AGHT+IESDtiseDJgVgOeIlREV0qdfOaepsLhH3oAsN7Z8uprdNGUF3NikFdRdSeVU+RRtwmRUDWy3w==
X-Received: by 2002:a2e:b172:0:b0:2d0:a10e:1312 with SMTP id a18-20020a2eb172000000b002d0a10e1312mr6247096ljm.51.1707404368497;
        Thu, 08 Feb 2024 06:59:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRxCKN3yHSiQHJTj9O9QqF4TrQ8hoyy6RaJkbZLMidCuYNgE7pxUwm7lpXB29L+qImb9Hk6mh7ew31D5BiYK2+OEJlCi5yjsUcWFvlofXUjDhMODr2adulRYd5KL42os/Z5dLs1D+lhXTiIsQMU1356jm0gtGNjQKiC84g+0jLSaYpB0vewfHvQvUuj0PUN+agdQsKwr0DVOGRasKQ3YR8/xnO/5amGhyayOvNgEQiQOaLcSnnMUTEJKqRIMNObMizsUso+ZQzydNcOm912/ZI4cdxY/g5WpprBRoEb6/ZD0UNPk1a8jRt6wM7V9LzKH6cLN8=
Received: from gmail.com (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id q28-20020a50aa9c000000b005611cc6a5d5sm260786edc.83.2024.02.08.06.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 06:59:28 -0800 (PST)
Date: Thu, 8 Feb 2024 06:59:25 -0800
From: Breno Leitao <leitao@debian.org>
To: Xin Li <xin@zytor.com>
Cc: paulmck@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, leit@meta.com,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/nmi: Fix "in NMI handler" check
Message-ID: <ZcTqXjztgECvJSlW@gmail.com>
References: <20240207165237.1048837-1-leitao@debian.org>
 <c128c9b0-6bfa-4d62-9bc9-1215ee12ce2b@paulmck-laptop>
 <0fabf792-3a9e-48c9-9f83-286905b5b2d3@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fabf792-3a9e-48c9-9f83-286905b5b2d3@zytor.com>

On Wed, Feb 07, 2024 at 10:44:57AM -0800, Xin Li wrote:
> On 2/7/2024 10:30 AM, Paul E. McKenney wrote:
> > On Wed, Feb 07, 2024 at 08:52:35AM -0800, Breno Leitao wrote:
> > > Commit 344da544f177 ("x86/nmi: Print reasons why backtrace NMIs are
> > > ignored") creates a super nice framework to diagnose NMIs.
> > > 
> > > Every time nmi_exc() is called, it increments a per_cpu counter
> > > (nsp->idt_nmi_seq). At its exit, it also increments the same counter.
> > > Looking at this counter, you can see how many times that function was
> > > called (dividing by 2), and, if the function is still being executed, by
> > > checking the idt_nmi_seq's last bit.
> > > 
> > > On the check side (nmi_backtrace_stall_check()), that variable is
> > > queried to check if the NMI is still being executed, but, there is a
> > > mistake in the bitwise operation. That code wants to check if the last
> > > bit of the idt_nmi_seq is set or not, but, does the opposite, and check
> > > for all the other bits, which will always be true after the first
> > > exc_nmi() executed successfully.
> > > 
> > > This appends the misleading string to the dump "(CPU currently in NMI
> > > handler function)"
> > > 
> > > Fix it by checking the last bit, and if it is set, append the string.
> > > 
> > > Fixes: 344da544f177 ("x86/nmi: Print reasons why backtrace NMIs are ignored")
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > 
> > If someone else is taking this:
> > 
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > (I am queueing it for testing in any case.)
> 
> Does this fix need to be backported?
> 
> Commit 344da544f177 has a date on Dec 16 2022.

I would say so, if users are using this detection mechanism and want to
trust the messages being displayed by the kernel.

