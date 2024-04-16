Return-Path: <linux-kernel+bounces-146811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769018A6B56
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329D328250A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C0912BE8C;
	Tue, 16 Apr 2024 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O73sQCdT"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E275A10B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271350; cv=none; b=IZh2s1hJMnof3XhLVTTdVuoIXkxKYv4/AcWEy+fLAWkxEcp7vIIyPHvjPuPFduLCGZ2/RVuXYG9i969viUNGR+LJbDzjE7zjn2awxeYF6ulRxYwuR1zZE3CQVJNYT1VEvZiqrY5Xbz7287K1tqNFuv89uEFE8LH0euXENBFcj4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271350; c=relaxed/simple;
	bh=7vKkklm2j+8MBw3agiSUc9CHX8zKs9lEzFNQV7tgc7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXuozQHVcXaAw+n7AQ623Pycc4SjduzrcKzAiHl2H1qVVR/yTPk4B/epoyrd/ifGyp8/ixBKCzvMen+8OfGXL6zthzJCNYQpY7Vn0h1UlyqYE963X7XjSNiXP45v6lUbr/TaXfcEy+nsZuft8xmX8+WGd60f+esCFn/hX7NDI/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O73sQCdT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56fe7dc7f58so3923379a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713271347; x=1713876147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mUOtU228tYtJyPue/rn/IW891GZXpSSOmG4AvHGZ5go=;
        b=O73sQCdTK7Qg7MQRn2dWXdQXvQR1px+BizjNYqk+xf6TSXT5erAkqX8aZO6yo/nlpq
         D0aFZKJlpv5nDuMpc0kJ0qVOeQFl/2DhV+uBapEOtH+izGsMHmL1r0iAQUtKnhNEUbWc
         fl6axChUV+fGd/YBRUio8fCF3pDU1HKg8cwjsxj81AqKbIMdyPcX95qvsEtlM3Hxc6W5
         iLb/KcyQmhXJQNyD+DPlfrCjXaiomr4mrWzKKZzvh58SrD282EQ6L3aU0d7y5v2UkmFK
         oB0PVGZyB4ZyNMIt2ASviGCOH9SGeaDgL6L/HeKxBB75gDAluKtzLO1pNm8Opmeh6/ce
         iOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713271347; x=1713876147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUOtU228tYtJyPue/rn/IW891GZXpSSOmG4AvHGZ5go=;
        b=oi2hOk/81M2rTsrY89jqqETPhUBygxFnYm/wkwtwbHkhdH4X7ybzbLt/EHAJZL4Qs0
         K1GwPXtKoiDZfxKSvhIrqsW1+k+6Ylo9OENvv/DnPTKuUHix38b0e8p60yokAGyx/BjV
         /vVf19LorOOLIVAuIK7UNF78pE6dv6GzG5lyqp0P8qGSq06S5m4kkdtOPaNqtOIbd746
         Qltq/jcYXElXB4gRDaZJxwC59T6dWE0s2ihO7NXFB6uPqgxV9N599W11vCsf6wmGfmJ5
         HNn4tdm2Gw77TYt8LydZHXhGSmlqOIc1K/Rle6tKb5yTcL65UmYdZRISMwcjLrmziJva
         w9Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUyMI9M6p2Rns3PmP9pp/ptBo4BO6cjVJA4XjLHVXpd5c1BrGvf+xTipoRQyH+m4CKGOdKhyY9mLY7qoYypgJrnIcAJyVz65f+aoERI
X-Gm-Message-State: AOJu0YwtyoF7FFmtZ5M4F3yrxiKCEbjBeSXGqvqJ/JU7BcT2LEaQJYoF
	eR30O2iGxMdcgllGPzoXCnx8JZdd6Pdqh1/dBkC2vifIDPWF+lWpHzILHvp4ATU=
X-Google-Smtp-Source: AGHT+IFJ6u/xajiCUpxE33tmeqjHHiAL2wmL+dnoci+VQnEehXgtJ/Q5xPBX57jTU1Obt4QXb9tI5g==
X-Received: by 2002:a17:907:940e:b0:a52:277d:c1c9 with SMTP id dk14-20020a170907940e00b00a52277dc1c9mr12180603ejc.50.1713271347185;
        Tue, 16 Apr 2024 05:42:27 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id go36-20020a1709070da400b00a51fea47897sm6775453ejc.214.2024.04.16.05.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:42:26 -0700 (PDT)
Date: Tue, 16 Apr 2024 15:42:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	clang-built-linux <llvm@lists.linux.dev>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: powerpc: io-defs.h:43:1: error: performing pointer arithmetic on
 a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
Message-ID: <402a5e3b-bdb5-40a4-8a44-2de497849c3f@moroto.mountain>
References: <CA+G9fYtEh8zmq8k8wE-8RZwW-Qr927RLTn+KqGnq1F=ptaaNsA@mail.gmail.com>
 <3d139886-9549-4384-918a-2d18480eb758@app.fastmail.com>
 <f7d8cd55-5a14-4391-884f-0b072790fa41@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7d8cd55-5a14-4391-884f-0b072790fa41@app.fastmail.com>

On Tue, Apr 16, 2024 at 01:55:57PM +0200, Arnd Bergmann wrote:
> On Tue, Apr 16, 2024, at 13:01, Arnd Bergmann wrote:
> > On Tue, Apr 16, 2024, at 11:32, Naresh Kamboju wrote:
> >> The Powerpc clang builds failed due to following warnings / errors on the
> >> Linux next-20240416 tag.
> >>
> >> Powerpc:
> >>  - tqm8xx_defconfig + clang-17 - Failed
> >>  - allnoconfig + clang-17 - Failed
> >>  - tinyconfig + clang-17 - Failed
> >>
> >> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > I'm not sure why this showed up now, but there is a series from
> > in progress that will avoid this in the future, as the same
> > issue is present on a couple of other architectures.
> >
> 
> I see now, it was introduced by my patch to turn on -Wextra
> by default. I had tested that patch on all architectures
> with allmodconfig and defconfig, but I did not test any
> powerpc configs with PCI disabled.

I think this warning is clang specific as well...  (Maybe clang was
included in all architectures but I'm not sure).

regards,
dan carpenter


