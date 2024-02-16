Return-Path: <linux-kernel+bounces-69326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE7785876B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4FA28EC25
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD991420B8;
	Fri, 16 Feb 2024 20:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al09wcvj"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E242FE28;
	Fri, 16 Feb 2024 20:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115896; cv=none; b=Z+bRk7RFGdqBnK5RMrBKub99FWSWpKHSWCTVT5+5xze99eIXNn9YpAt2InsjsPQ7WrMYRcLsnPjEFDPY2JC7hZESOp9w9F16P4Gz+7OM6jU/eEnuJ6rkWm8e+b8SjCdJzbfQU7W4MZrLem8B8xu199d/mfWOMx9Qq/PnA+vz3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115896; c=relaxed/simple;
	bh=aCZcH8fszw7qR+61YyPnRZipuFbPNFiyW8hLk9tUXSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTgHet8cLfo/J+xyYnV1DlY3DuJQ7+impJ0byGS/dPIlRuohFLOeWxzO3NQvu+nqj7NHiWETP2JVDh1QUy/jXHUbwcj2Oe5bJxKfqLyL5XFWk2T6xtFm+Sw58YoIDZ1q3wnMexvZEr1Z8IeirB2XVlygkruSyOYSDHwNqx7najs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al09wcvj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3d82926ed2so147643866b.0;
        Fri, 16 Feb 2024 12:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708115893; x=1708720693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfPB1/+5F5DyI++pK4eDy8fIIfFFi6TagAxUR6YQgHQ=;
        b=al09wcvjeD9CqhyUxwFHV/omp7R7XdRsbv96gdM1XrpfLrPfyaW6PFpppvLHM+evni
         Qh5qfbbkPlkOw+2eyaL/vBAC9f0s8nqMaSDzNPYG9u4qqwuUipLa2tGEgT15qtuvJQyb
         bvDY4oG9W/ngmOpWe1D7N3hPyJP0cU50YW/rzF9ix7QoY92zCGGLZf58IOQekhL6xD2M
         MvO1P1AOITVWR9inL2AkhlrC0eyyyMbbtBYIhUlEJV8pnTZwvf1VrsPKmqpTiASihQAc
         LUnM2KFcQKpoJ6+0xSECI+DSSrjs5NdMIhyHzp7cVcn19CISsIr98d5GI3GlUXGphl+h
         VJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115893; x=1708720693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfPB1/+5F5DyI++pK4eDy8fIIfFFi6TagAxUR6YQgHQ=;
        b=abcennlNg89j/PQ9ov+HmqV1+HNjGZmI+qDFpbttXPiVDL4I02rUrmn8NtdQWhUtKV
         CAvqnhhVg6LutzUiqwI3+WlFGsjcuS5/yeDYU2qaevCnonZG2GtSBw9iq6vVVMqC4S+u
         gTb4VrMxQ9+Si9H5LrSRQ/I2XmbBw16wpdxJPJ/V/KJw60y9C9+vTu7dV2RXBxAp8un6
         ArOeuLtZ3bXfvSBrfM/iFwZpcSP0p3QjRjL/AGlJ/ZgrN2y/jTT20iJ6E4vzagn9vriY
         Q/tzqcwmh8jTIrrBBkylP7ns7l8KZWtegHpzLdV1IQ9t0Tn+Fcw5+yAwDGSguYs2GHYX
         AIOA==
X-Forwarded-Encrypted: i=1; AJvYcCUgv6eVO0/8GhTLVarHNV4NeQ21Vvo+7ANJSnxvZLZ7yqg0yYzelTvA+zOTkCOkQ6fJUJIwQJV+y1ZHKZNjITgAB/heaBZ+wYFdGWgl516gMWaey5HQZKJQg3SBogO9uYXHmPoSXPMk
X-Gm-Message-State: AOJu0Yy6bgU1n5trV3DJVhKHaFZlfIn7x/5ziFIFsQjuNZ3hI6GEvEK8
	lrNFkFhry9zIfVgAHSrx9q0sDZd+l3aaCmZUiEJiQw6o1DHDnKuQ
X-Google-Smtp-Source: AGHT+IFEzxu1hDsBnaaTtvfBiM39mG3OKF0gqz/i1fYKRjsb+mktblXXVa+WgxndfGQMRrgxef0wyg==
X-Received: by 2002:a17:906:46da:b0:a3c:f6dc:ea46 with SMTP id k26-20020a17090646da00b00a3cf6dcea46mr4005815ejs.49.1708115893187;
        Fri, 16 Feb 2024 12:38:13 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id x14-20020a170906134e00b00a3d828c54f1sm316852ejb.135.2024.02.16.12.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:38:12 -0800 (PST)
Date: Fri, 16 Feb 2024 21:38:10 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iio: humidity: hdc3020: add threshold events
 support
Message-ID: <20240216203810.GB3873@debian>
References: <20240214085350.19382-1-dima.fedrau@gmail.com>
 <20240216131721.745f039e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216131721.745f039e@jic23-huawei>

Am Fri, Feb 16, 2024 at 01:17:21PM +0000 schrieb Jonathan Cameron:
> On Wed, 14 Feb 2024 09:53:42 +0100
> Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> 
> > Based on Fix:
> > a69eeaad093d "iio: humidity: hdc3020: fix temperature offset" in branch
> > fixes-togreg
> 
> This applies fine independent of that (they will meet each other upstream!)
> so I'll take this via my tree now rather than waiting to get that dependency
> after a pull request  / rebase.  It will also actually get built in next
> where the missing Kconfig / Makefile fix is in place.
> 
> Applied to the togreg branch of iio.git. Normally I'd push it out as testing but
> given I haven't yet queued anything up today and this won't get built
> until it hits next I've pushed it out as togreg directly after a quick local
> build test.
>
Great, thanks for reviewing. :)

Best regards,
Dimitri Fedrau

