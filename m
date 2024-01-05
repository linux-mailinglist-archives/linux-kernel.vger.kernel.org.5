Return-Path: <linux-kernel+bounces-17995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D2A82568B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29FA1F22999
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9598D2E63A;
	Fri,  5 Jan 2024 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g7t5q+CV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23362E62C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28a6cef709so185881866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 07:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704468236; x=1705073036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C8cTJ9cF7f7kjCtZvPbtjoizYwOtu5qwKSGBqgmK7tc=;
        b=g7t5q+CVqeZp1q4d83VHDDjnuwIBAiBJJjV4Sr7gPQsJS7bzTEEl20LI8afEGjKo1i
         MDu2pj902Xuq4iRgVsDwxyYsztBc9d+kOtU3mRJo5VKEhaasltrirbXliDAabdsa+emo
         sLe/L2Bqt9h/97mCPgI0kDzu23Q+3Mo6RirhS4hN7SeXMuflG2YOJTl1cle86Qh9pEi6
         ME23YGG3ihPwcbw8e9x9LSdbvQcYk+zXQ5tt0tRLzw+ThPxJULA+TFoCMOLZlMVYErf0
         3ZC7pbu39JKSW56zSX9XsoPmJXzXiuQjSVNyRrwngDW5nb/oVZt00oFa8tLn+HVpZWK4
         N1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704468236; x=1705073036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8cTJ9cF7f7kjCtZvPbtjoizYwOtu5qwKSGBqgmK7tc=;
        b=LUzwgdKDtBrwNtEzI1tOiWiS3mD8qtSZPzkM2/lpfFbosL9RUaWdHwz1GWFSkc1Y5d
         rr/baoS0ls3bfnA44uZd0YfOP+82hNDeO6pqlvMKn8f4i2n2d+7jk8Z/bP2LLpaChL9K
         2YjeT3HZM56iSKUoMoEjy43YUPoMMvfWK+rOYCHH/EQuWoLypnI28UyBnjvv3ZECQVkm
         cpwbesCkeoExVnjuIbkOJXpDE163cDxcp8GfGUbULgKaARA8yQWJmqL2WqbOAWRnNTEI
         yd5c34qLAyJY4f7bkqTgO8VdM1+9d3kqptm9eKrhDOjY3izKc1EBPtvOrwHx97Zn586x
         4oNQ==
X-Gm-Message-State: AOJu0YwdEGhi0bQYdRw+Ya+libwPKMG4dEPmlt1UzAPJwFLdTnZ/dRgd
	iQNWLKtc+VNXce7mLfaiWAb0KkotV+VifQ==
X-Google-Smtp-Source: AGHT+IF/AVMkZdTEK7dBssPlRgpCIZizx+1xhClxtSNldAJa4a7E/wC2JkLpvL+QSwvvBaItTWdiBQ==
X-Received: by 2002:a17:907:928b:b0:a27:5343:d3e8 with SMTP id bw11-20020a170907928b00b00a275343d3e8mr1511305ejc.97.1704468235960;
        Fri, 05 Jan 2024 07:23:55 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id h26-20020a1709066d9a00b00a26aea4942dsm966126ejt.123.2024.01.05.07.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:23:55 -0800 (PST)
Date: Fri, 5 Jan 2024 16:23:53 +0100
From: Petr Mladek <pmladek@suse.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Jingzi Meng <mengjingzi@iie.ac.cn>, gregkh@linuxfoundation.org,
	gpiccoli@igalia.com, john.ogness@linutronix.de,
	keescook@chromium.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	senozhatsky@chromium.org, tony.luck@intel.com
Subject: Re: [PATCH] cap_syslog: remove CAP_SYS_ADMIN when dmesg_restrict
Message-ID: <ZZgfCZKho2Dsv7VM@alley>
References: <2024010306-tweezers-skinhead-083e@gregkh>
 <20240105062007.26965-1-mengjingzi@iie.ac.cn>
 <20240105144944.GA246367@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240105144944.GA246367@mit.edu>

On Fri 2024-01-05 09:49:44, Theodore Ts'o wrote:
> On Fri, Jan 05, 2024 at 02:20:07PM +0800, Jingzi Meng wrote:
> > CAP_SYSLOG was separated from CAP_SYS_ADMIN and introduced in Linux
> > 2.6.37 (2010-11). For a long time, certain syslog actions required
> > CAP_SYS_ADMIN or CAP_SYSLOG. Maybe it’s time to officially remove
> > CAP_SYS_ADMIN for more fine-grained control.
> > 
> > CAP_SYS_ADMIN was once removed but added back for backwards
> > compatibility reasons. In commit 38ef4c2e437d ("syslog: check cap_syslog
> > when dmesg_restrict") (2010-12), CAP_SYS_ADMIN was no longer needed. And
> > in commit ee24aebffb75 ("cap_syslog: accept CAP_SYS_ADMIN for now")
> > (2011-02), it was accepted again. Since then, CAP_SYS_ADMIN has been
> > preserved.
> > 
> > Now that almost 13 years have passed, the legacy application may have
> > had enough time to be updated.
> 
> What testing have you done to make sure that this is OK?  "May have
> had enough time"?  That's not very reassuring?
> 
> Also, note that we can't actually reuse the bit position of
> CAP_SYS_ADMIN since it's likely that there may be pre-existing
> capability masks that are still using that position.  So there isn't
> all that much upside in trying to retire CAP_SYS_ADMIN --- if you as a
> system administrator think it's not too course, then just don't use
> it.
> 
> It's unclear to me what goal you have in trying to mess with the
> capability definitions?  Perhaps it might be useful if you were to
> explicitly state your goals in these proposals?

My understanding is that this patch is about reducing overlap of
capabilities.

Allowing the same thing with more capabilities seems to go against
the idea of separate capabilities.

Kernel has printed the warning for 13 years. It is a long
time to fix configuration for newly installed systems. And I doubt
that anyone is installing a new kernel on 13 year's old system.

IMHO, this fits into the category that it should be OK until
anyone complains. But I might miss something.

Best Regards,
Petr

