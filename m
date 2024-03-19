Return-Path: <linux-kernel+bounces-107952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88158803F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 268D3B23599
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B812375B;
	Tue, 19 Mar 2024 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WPJEz9SG"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A2A20DC8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870869; cv=none; b=PvSH+x3ir8XE8bNkW4VAggcu9oFUeE62pbBbk8MEfs8567LrO3yuLZV1D4EKjtpz0WIa3kahU5mzYSUVoJpUvpP3+BnTdrGBB/3MjpuujJ9q2Dmzt2TjTSVGLENiV/K0ihhqPJP7ysPEcZBfua0UN231TClwZ2GopptX/WTr3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870869; c=relaxed/simple;
	bh=B9HuiwQg7X+0lbII8qyF6ES+SfD7F1pHs2MmLusxi84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrL0y4HtgAzYw7r0p5JD5bYUy13ZjhwadNgSUoUlDrR0PvsG6IZ+klJN30GexSRajuwv23kbV9kcuwSn73mcJLOaZLiF12Kph3+Y4qdZJ3L5Q7DduI7e8IXcHbM3ZWBHt6iLg81SNtuAq9UUEt0eHDjFOTurIadSzG7jUvT5k00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WPJEz9SG; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2220a3b3871so2597021fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1710870866; x=1711475666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B9HuiwQg7X+0lbII8qyF6ES+SfD7F1pHs2MmLusxi84=;
        b=WPJEz9SGaGxWfXrSjYp8a6um1xt0Nh7D0PgzOKoPv4tUrB07npQC8t0o4sHUlYzsr/
         jV5IAg4bjlLbnvTwJNr/vXZjjJY1FWMcxPPfPAl9ncouIcaE5shloDQgx+Iljixyk9jf
         S0Zzy+QTtsE3ULClsbMBvZV45T+wRwbw4ozuk7DWLysH0ggz99fSzqkC8bYAqUB4uAnD
         I8rzgCj05tL9HDqH/1fjmPcgoP7Q7I4Kk/aYpNM0CMw+pfwRPo0KKpeHxy3kjZdFPim2
         /cYNbGR5qWFjnkRWm83OvojpzetTCwy+nMOqjZhIyha1qc+zmvDVdxt01adVtan6AITr
         +2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870866; x=1711475666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9HuiwQg7X+0lbII8qyF6ES+SfD7F1pHs2MmLusxi84=;
        b=hF46Z78sgrakYMGqcA8jU2Pc3hAoYqqWg25TiCU8ZUJXG64kwtgUhgDemvXFwN4HpL
         yiPn3/knWgIMhP1j9V/ExkHSiN57ajThc3mBSOOmiKaRVRmiWOVPkoDq2BKliK1OSi5u
         UPHNO+/qfm7hQ06TUZGYPSaDyFnGWih7X32JM/yARAEeGeXnm16m1cl8XriFQgGmEGiS
         c6aqhKMcdxLquSzlnEMRkQlTf2SEiTLwmjrU369/eFY/HhpebvStxML6opFjAnPvJs+E
         kKy+KvJWRNVRDz1pTh7aHaQWccPh17SH1V+YoP2yPHSpeZ5DA/WK6JqzdHTTWWxejZxb
         pckg==
X-Forwarded-Encrypted: i=1; AJvYcCXXhra6eYPO10Dcw+WAyG+mITEitrC26UdkiXP21Jv1JHXk4CqMohWZGwoCD8/2JbJXNr45yi2XXw6tKaAZL9OkTY9O0riuO2VEohsG
X-Gm-Message-State: AOJu0YzH03KZSqHYGO9LunwbRECFseIg+9b+MSfSQT5IAAdRYgp5Obg2
	PzT0MpnCLZj4QcFu72hVXZRia587pZ3tnTeXsF0jXkun0ALVVYHhda5yRw2R9f0=
X-Google-Smtp-Source: AGHT+IEd8KsCy6GqIl+1n0Sol2b9f0f/25EaZRJ80XDCZoyr9TJbEhweqbC03Izk0lN9FbayxSp4fw==
X-Received: by 2002:a05:6870:524f:b0:221:bf42:cf76 with SMTP id o15-20020a056870524f00b00221bf42cf76mr16367906oai.10.1710870866557;
        Tue, 19 Mar 2024 10:54:26 -0700 (PDT)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id gh11-20020a056638698b00b00477716fcbb8sm2429986jab.40.2024.03.19.10.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:54:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rmdbD-001kiW-EG;
	Tue, 19 Mar 2024 14:50:07 -0300
Date: Tue, 19 Mar 2024 14:50:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Tyler Hicks <code@tyhicks.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: Why is the ARM SMMU v1/v2 put into bypass mode on kexec?
Message-ID: <20240319175007.GC66976@ziepe.ca>
References: <ZfKsAIt8RY/JcL/V@sequoia>
 <ZfNKv70oqqwMwIeS@sequoia>
 <120d0dec-450f-41f8-9e05-fd763e84f6dd@arm.com>
 <20240319154756.GB2901@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319154756.GB2901@willie-the-truck>

On Tue, Mar 19, 2024 at 03:47:56PM +0000, Will Deacon wrote:

> Right, it's hard to win if DMA-active devices weren't quiesced properly
> by the outgoing kernel. Either the SMMU was left in abort (leading to the
> problems you list above) or the SMMU is left in bypass (leading to possible
> data corruption). Which is better?

For whatever reason (and I really don't like this design) alot of work
was done on x86 so that device continues to work as-was right up until
the crash kernel does the first DMA operation. Including having the
crash kernel non disruptively inherit and retain the IOMMU
configuration. (eg see translation_pre_enabled() stuff in intel
driver)

I think the idea was that the crash kernel driver will recover control
of the device prior to trying to do DMA. Devices without a driver or
devices that are not operated by the crash kernel just keep going as
they were.

In general practice this is unworkable as some devices can't be
recovered without doing DMA in the first place creating a catch-22.

So now lots of devices use their shutdown handler to quiet the device
before handing over to the crash kernel.

I think this emerged as some 'small work' to try and make crash
kernels functional at all. Implementing every shutdown handler would
be pretty hard, but many (?) devices seem to work OK if the crash
kernel drivers runs for a bit before destroying their DMA setup. We
don't trigger weird platform crashes or anything due to failing DMA
operations either.

Now we have all kinds of infrastructure and deployed crash kernels
that have this assumption baked in. :( It sure would be nice to not
spread this full complexity to ARM.

If the original kernel could signal to the crash kernel that specific
devices are quieted and then the crash kernel could simply ignore
unquieted devices and set the IOMMU to abort them and don't allow any
crash drivers to attach. (or maybe FLR them?) If someone wants a
device to be usuable in the crash kernel then the original kernel
needs to implement the shutdown handler.

Regardless, I think if your goal is to support crash kernels then you
have to do at least a bit of the x86 'keep the iommu unchanged'. The
iommu shutdown should do less like x86 does and the iommu startup
should detect the special case and try to atomic switch to the new STE
table that aborts unquieted devices.

Booting a non-crash OS is a different matter and in that case you
really want every bit of HW put back to a clean "just booted" state,
and arguably it can't work unless the original kernel implements all
the shutdown handlers... I don't know if x86 kexec actually support
this, it looks like it only works on Linux OS and things like the
Linux iommu driver have code to support the crash focused hand over
even in non crash cases.

Jason

