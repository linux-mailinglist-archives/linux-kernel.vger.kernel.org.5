Return-Path: <linux-kernel+bounces-91198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E6E870B1A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248711C21942
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB8A7A15C;
	Mon,  4 Mar 2024 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adHhjFIK"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B0779DDC;
	Mon,  4 Mar 2024 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709582443; cv=none; b=aDzLB6rqq5RiGgPgwahz5CHqF2sxoQ2OQipdPvfrLPBt9K50w7gS6Xl4UcGXJ2M7ixHmYkwkRZ4ZzDbgMMhvUAHh5yeFA3a/6tP/7ST0mHLkI9Pv/WvajScnfFuNut9M25izaahK14LMjihsEbrBV/O8/0FMivXytDx2qbqp7A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709582443; c=relaxed/simple;
	bh=XvM+66VhbbeNHen8cDDRkVqqLC5Yo36gqh2E2nY94W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2umr7jkIOvi60dCSSRzsB2GjHcuJglFQJDhqLgNKFxVV2j/DfO5lvYolGWpuWUhah9KgC4h6GHGNNDtBECynIPv3H+wo+hBuuZNN9hbxJQOLjSAI2JzI5DNjoQ6EUehaT/pJC2j9acr4lHXDBnejUUk/5bl2h374ZGOdv61UXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adHhjFIK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412e7fe4497so6242165e9.1;
        Mon, 04 Mar 2024 12:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709582440; x=1710187240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgHCyC+Ikfdy07nvjol19ApsqbmdnmuhNond4BBAt+Y=;
        b=adHhjFIKterQ/D3wdaFNB4olqMlOZzaCE5jH/5OwX3h4nKC7erINpOOHd4kZXvfS29
         uq8tFVO6LpfNSKUBrKPAfsmFPvIrdTzpTpQktVsfEdRl5dfsBs/rH2Up+FTOhPlCdFRM
         8IhqJ/jA9ZLtJHi9PqYS5HqFNJbTVbDztfEgIBKkqxhRvWwGi64LroF/blqsM0d/e+8x
         WXGx/he0dOiccJOzOEBJVTXeFXINxLsVeP34mDRKNUOlZZhAgDCJcQ6KMQ2VU/lN9dP7
         k4i7eodXk3qdo+/Aa3lfwd+t6WnDvDX11u9Fdbus6z0Ywo7YWE64HFOYThjs4BcpcX/e
         4wZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709582440; x=1710187240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgHCyC+Ikfdy07nvjol19ApsqbmdnmuhNond4BBAt+Y=;
        b=ckYGJ85Na1jK/MnUmTdf1MBt627CS9tE6i0qMs+3pi+qEaEYmxvfnZjwpmtJxJwSeU
         c4AnBGdFEpLfJf74gan2EE4MkS00Ka16uk8joEbQwUYC0JySkB2SiQ3wwsiDE3JRRZjF
         DhKuNXVuwYLwK4Cw5+57DLPN2U8LYKpOrCYEJwfLulCdlRKxWoi/h8em5wYl/Wsuq+q6
         DHnyWXIqThVTEHErKLQOvOkSJd1umnVJW/8NXIi6/y4mn8WxphRTuNeZt5eJVE/cmIah
         YXh9+iWGuw0aDMProKDZJSfHRZR9rpDBG+fG2RSjCZbh7amlBidIR/lEK19LDOpi3HPe
         FKjA==
X-Forwarded-Encrypted: i=1; AJvYcCUnxZm1pt1eSgFcHTj/z5bUAuBiVdFfzupE4vEQz3rkTna/NijVAbzJY1tUlvFV3j7ppX2xWrkBQZnzdL5Y7cMofdwttuz09Zuw4xoJM43HVG75C6Rr8UIcUoTIIWndb0JIejnVSVGgeVYm7S20D8RjLomyY94hq+JU/ZNhocHF
X-Gm-Message-State: AOJu0YzX7YySpUEznzgbQMVxKr3wcXIO18E8Lg6O+gldjTDP1Lo7apFc
	Wpu0MaE+aYCLXZVSRd9sym1YD5JKJCl2B4TtOvIp8dyDiQpwmVJT
X-Google-Smtp-Source: AGHT+IEG6VFBumkdiKt3bV/gFyaWTxyNPWjZ8t9eO9T+jnNpADN4tBLH9fymg1RHv/pFVFu+3LqEsw==
X-Received: by 2002:a05:600c:4e8b:b0:412:b83c:d97d with SMTP id f11-20020a05600c4e8b00b00412b83cd97dmr8154909wmq.16.1709582439907;
        Mon, 04 Mar 2024 12:00:39 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id m11-20020a7bcb8b000000b00412dd56e0desm2428259wmi.1.2024.03.04.12.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:00:37 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id C6ECABE2EE8; Mon,  4 Mar 2024 21:00:36 +0100 (CET)
Date: Mon, 4 Mar 2024 21:00:36 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Srivastava <yashsri421@gmail.com>, 1064035@bugs.debian.org
Subject: Re: [regression 5.10.y] linux-doc builds: Global symbol "$args"
 requires explicit package name (did you forget to declare "my $args"?) at
 ./scripts/kernel-doc line 1236.
Message-ID: <ZeYoZNJaZ4ejONTZ@eldamar.lan>
References: <ZeHKjjPGoyv_b2Tg@eldamar.lan>
 <877ciiw1yp.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ciiw1yp.fsf@meer.lwn.net>

Hi Jonathan,

On Mon, Mar 04, 2024 at 06:39:26AM -0700, Jonathan Corbet wrote:
> Salvatore Bonaccorso <carnil@debian.org> writes:
> 
> > Hi,
> >
> > Ben Hutchings reported in https://bugs.debian.org/1064035 a problem
> > with the kernel-doc builds once 3080ea5553cc ("stddef: Introduce
> > DECLARE_FLEX_ARRAY() helper") got applied in 5.10.210 (as
> > prerequisite of another fix in 5.10.y):
> >
> >> The backport of commit 3080ea5553cc "stddef: Introduce
> >> DECLARE_FLEX_ARRAY() helper" modified scripts/kernel-doc and
> >> introduced a syntax error:
> >> 
> >> Global symbol "$args" requires explicit package name (did you forget to declare "my $args"?) at ./scripts/kernel-doc line 1236.
> >> Global symbol "$args" requires explicit package name (did you forget to declare "my $args"?) at ./scripts/kernel-doc line 1236.
> >> Execution of ./scripts/kernel-doc aborted due to compilation errors.
> >> 
> >> This doesn't stop the documentation build process, but causes the
> >> documentation that should be extracted by kernel-doc to be missing
> >> from linux-doc-5.10.
> >> 
> >> We should be able to fix this by eithering backport commit
> >> e86bdb24375a "scripts: kernel-doc: reduce repeated regex expressions
> >> into variables" or replacing /$args/ with /([^,)]+)/.
> >> 
> >> Ben.
> >
> > What would be prefered here from stable maintainers point of view?
> > AFAICS e86bdb24375a ("scripts: kernel-doc: reduce repeated regex
> > expressions into variables") won't apply cleanly and needs some
> > refactoring. The alternative pointed out by Ben would be to replace
> > the /$args/ with  /([^,)]+)/.
> 
> Hmm...this is the first I see of any of this...
> 
> The latter fix seems like the more straightforward of the two.  The only
> concern might be if there are other kernel-doc backports that might run
> afoul of the same problem, hopefully not.

Ok. In the sprit of the stable series rules we might try the later and
if it's not feasible pick the first variant?

> But this makes me wonder if there are other stable kernels that are
> affected as well.  I guess that, despite all of the testing being done
> on stable updates, nobody is testing the docs build?

Only 5.10.y is affected AFAICT, and the reaso nis that the cherry-pick
of ("stddef: Introduce DECLARE_FLEX_ARRAY() helper") in 5.10.y (as
requisite of the smb fixes) requires as well e86bdb24375a ("scripts:
kernel-doc: reduce repeated regex expressions into variables").

3080ea5553cc ("stddef: Introduce DECLARE_FLEX_ARRAY() helper") is in 
5.10.210, 5.15.54 and 5.16-rc1.

e86bdb24375a ("scripts: kernel-doc: reduce repeated regex expressions
into variables") is in 5.14-rc1.

So it's covered for the later series, but causes problems in the
5.10.y.

Regards,
Salvatore

