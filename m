Return-Path: <linux-kernel+bounces-77404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9D58604D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374481F28DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E8D73F39;
	Thu, 22 Feb 2024 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjtoY/GP"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126CB6AF97
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637481; cv=none; b=EjHbTvnA2fWH0YqklzemRVVquM6CEQRiop5xXscCqQbY4Gz5CnjKHhKbUW7IkjM9V0zUkpRsu4CYdULdrk5HhSZV2X40BvgPFJxTA3inbcFGxN58ZSC/ihdDBWUfhzPhKikgXDF7SP48H5olTHA0GSGoQ84dtMQAFQ/zkeJMHzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637481; c=relaxed/simple;
	bh=xAanuVIzGPNFptuV54Hc6FdgHRzcb9KawKfKsoO4UBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX0x/3gjv224N7ixgS+c4WGhkYmDpfYA8AxCcdxiMCo1VrxpJD+lbeznUzsB0vHWyyHsj3lPtHMKg408n8YlvaRL4mG5o5XZLXUMUupIc+QiAJ3e7P84vUi9zi4geQrqz1J0NMdm/Tgo06we+DrZOmaalHGuRsdos4lkiKQwhJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjtoY/GP; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6083befe2a7so2626787b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708637479; x=1709242279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUw2xYuDibxwJNkicWQfSsXUxs7Znk2YsGnDeUj+5YE=;
        b=NjtoY/GPCXwUmJja7uxX5oM5qWQE/T0wIckU5bu3be/2uHzJr3+o4dx6//iLkJOjDJ
         jWti1378vDD46ZDTtoneUT6k8xUDqxmeU0eG+dQOgWRQZnK9P4TrD6wk+NDRv+ULcTp1
         iTz70T8G86BylNNtiazhHDtFjrzZT8phQ8MO3xPnBGQdEP0p+ZhYUIbD8mPH5xEFnmcr
         Vs7gKdji4CAW08jcKCJJKRWgcd/lpWy3U9fvmjUqsQFaaBJu/rqVj+ZuDbp9xfgG6jvK
         MdI1ex3TYRtVNTj6xo++tmwwZhdHgzosMcBISGbXFNLRch+R+rQno+5ivCx6aEy79cUU
         Ssuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708637479; x=1709242279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUw2xYuDibxwJNkicWQfSsXUxs7Znk2YsGnDeUj+5YE=;
        b=YPOS/oQQS7jfXKwwO0dK36ya4xQNF0bQKLfdQIwtAxXRjnUKQMifdgYCoaVItZ/R6W
         74nXXQWF3XJX8II2jrLimaOObu2UDftCuub8KfN1m3u/einsMS+oq5s6xOK1PqR+8+dn
         FVLbFxnoxMbRNORu9DFUfNUPMP78A7CslNApAxzomuk2I/hwgDnbtCxu3iOKAsCI9IZT
         JXyvKZ65tlmGebNs4SwTwDEXaDt/7sIcySDnQscmo0fhvwJY3mjg85Xc4WL3cNhMKX/D
         9GSVlUTXTvp8O4MY4z7X3qVipe6e/anqO2gDUi9kmF/15RSDV++AgmcPVqI11aPL5WVe
         Cdvg==
X-Forwarded-Encrypted: i=1; AJvYcCUZSMePFIN4qeRf38HM6OsmGPYoYOmEFsnovRvKYYpzOv+/wpL1CV+iACEMJxHMJsqJUB28cf4z1f+tuBX5Era1NxD752y+nAHTVzsB
X-Gm-Message-State: AOJu0YxMwQvPxz2U5h2cnL9njfkuBwur875cD4ZQDC4nvbz+lnX/HxpW
	xXo6180gHXV4cc0QsEh8WBU4idfokuJzG5Md406du8/Q6Yn9R4Yx
X-Google-Smtp-Source: AGHT+IEJzEq+ITFpoFT5d2FCW0FabJu/wW6r9SFjgCowaIPDswaadHMeAEHodcDXQSdliSMncRMnMA==
X-Received: by 2002:a81:451d:0:b0:608:b15e:4686 with SMTP id s29-20020a81451d000000b00608b15e4686mr380500ywa.16.1708637478751;
        Thu, 22 Feb 2024 13:31:18 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:6d56:5106:b1c5:46d5])
        by smtp.gmail.com with ESMTPSA id u129-20020a816087000000b006083c19ea91sm2041632ywb.66.2024.02.22.13.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 13:31:18 -0800 (PST)
Date: Thu, 22 Feb 2024 13:31:17 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: Re: [PATCH v3 1/3] bits: introduce fixed-type genmasks
Message-ID: <Zde9Je1C0LLbXE6z@yury-ThinkPad>
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
 <20240208074521.577076-2-lucas.demarchi@intel.com>
 <CAA8EJpprfrtOjNzT6TFhV1n6MXzLdTahanfxcRW4uVjeHaBduA@mail.gmail.com>
 <ZdZlVn9BI-0q1Xdn@smile.fi.intel.com>
 <btssirjumey2kcp5dyhe6m3embdwd5bswjz3c6swrhxfijfhld@lztxaptkegw6>
 <ZddfF7kb54o2c/QR@yury-ThinkPad>
 <Zddiav19kX8FGKY9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zddiav19kX8FGKY9@smile.fi.intel.com>

On Thu, Feb 22, 2024 at 05:04:10PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 22, 2024 at 06:49:59AM -0800, Yury Norov wrote:
> > On Wed, Feb 21, 2024 at 03:59:06PM -0600, Lucas De Marchi wrote:
> 
> ...
> 
> > +#define __GENMASK(t, h, l) \
> > +	((~0 - (1 << (l)) + 1) & (~0 >> (BITS_PER_LONG - 1 - (h))))
> 
> What's wrong on using the UL/ULL() macros?

Nothing wrong except that in the !__ASSEMBLY section they all are
useless. And having that in mind, useless macros may hurt readability.
 
> Also it would be really good to avoid bifurcation of the implementations of
> __GENMASK() for both cases.

Not exactly. It would be really good if GENMASK_XX() will share the
implementation (and they do). The underscored helper macro is not
intended to be used directly, and I think nobody cares.

> ...
> 
> > -#define __GENMASK(h, l) \
> > -	(((~UL(0)) - (UL(1) << (l)) + 1) & \
> > -	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> 
> This at bare minimum can be left untouched for asm case, no?

As soon as we have to have different versions for the macro depending
on __ASSEMBLY__, I would prefer to remove all compatibility black
magic. After all, the <linux/bits.h> machinery to me is about the same
level of abstraction as the stuff in <linux/const.h>, and in future we
can try to remove dependency on it.

This all is not a big deal to me. I can keep the old implementation
for the asm, if you think it's really important.

What are you thinking guys?

Thanks,
Yury

