Return-Path: <linux-kernel+bounces-138315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0691589EFB5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F991C20D69
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE04158D62;
	Wed, 10 Apr 2024 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKC+a3Ye"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63EE158204
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744304; cv=none; b=DjRlIrMlZwwzjR9Dx518stkni/n6R9zWHuUjCEyGsenpAFtGynA1BxxM44yUvZJMFeGGXYkE1ln7l0/KxADCLmjStI0ZiBxqo9Xt8E8M8Lz4kzjsHBoIdFlKMEV6lf84xGS6ajGOJr0FMcdXwF9Lfu412BZ6BCjd43mqemegni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744304; c=relaxed/simple;
	bh=QNa9q7fl0QpNcL5PdvTdh8BoZUPCJ2zBMZ3FZ5JDDRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpnIYcn2nCKvjfSYDQzHDJh0GAUqZOxhcyswp3YaTwF0AezdXups4QGRDrQmwdO+ieioPODEmIsjguZV6JbhcEBx80egq0KnFhp/4HBnP6eDhGTrONtL2n8mVmn2r6G4kqwD84UVWDgIyghYPxDoPpPCpW67vtdfCkOY3CXUzYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BKC+a3Ye; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41641a889ccso48865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712744301; x=1713349101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vT68oS4RVQULaWAEFFaBC6rqDsXdkDc5eppWUMWD6Io=;
        b=BKC+a3YefzFPDPuWK8dTQhZP1Tu8aSyDCJK8i8Io41ZMGrGc2W0zM/5+s8b5OCus+0
         Y04nu3tOihfOdy+mVWlgUQDeYnbR/KohQHWCLWi/3vBK7+aPLIww/NI7uot8mzvGWOW7
         GL266Dfhu90eK6J4HekL1iEKku11Fz95Z2aUnYAMJ2eByTvuZ6C1n1n/MGP+DvlOwB4g
         vYan8h2Tvu4+aERFiykhewNXZLTlo7PIufK7S7XIsIM7/gQKR8DiJR6YMqJRzA1LxYB3
         SrCYib8SlojVOclpMW3TsoEt9NQkVFwDcq5OiY5uBG+KwnodcCrEG9CTjGFHgJRDYcTn
         K/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712744301; x=1713349101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vT68oS4RVQULaWAEFFaBC6rqDsXdkDc5eppWUMWD6Io=;
        b=MF18hIt8+tWuWPx+Q3scQhwpNkVdmeh9i9fUMph6A/doAafuDqNUZHGyUHe3fSBUex
         iQMU9orW6WwnpZW+BEOKTMMsZP1xuK8zgfMDkGtnap2cmPsHULqELUVJ/wTygmf1MxN5
         KCnwcbFix2RPfy0C5HBCF1WKwwjJNm37aIuQhMz051YAfe63XdWceFm/3SgkaZGfTZ5J
         JtdQp3oov3Io14ZRLIXNVj+pWseY1NRkDah8JYz2KRa3oIixFPm2qOfbW+Q91opXeSt6
         D1ha0D7zjqQl25lPBgJnsjM6k4kmiCzNQ5tyoXdTAO4IgiSXTDi1yY1dC8AKlL6N5qCa
         BYQA==
X-Forwarded-Encrypted: i=1; AJvYcCWCGvNtksnSf+aMzl9prZPkhA54JdiuTcPUjuyxAucgztW9OUlhphtOWldZqOSXCvEt57rJu3z8pEfzksjo7q+gtfPDIBU4rK6S/Wvl
X-Gm-Message-State: AOJu0YygZaVJJWV4pM6HhfynTcK4CDeDjmRhL1y6iO1kY5f76vt1fPZ3
	IqSx4BnK68RJe3GzOgpzhDRj6dQJ60hw75fEf0Et0WB79Qkl9qbmz0uLJDmw/A==
X-Google-Smtp-Source: AGHT+IF04oIgLfak4zpgaHX/QvWLj2Gry8uOBqaulhtF8YFr4xta0pvMXzu6sMK/eZd+mX/Vi1I/5w==
X-Received: by 2002:a05:600c:5105:b0:414:1400:a776 with SMTP id o5-20020a05600c510500b004141400a776mr111247wms.5.1712744300762;
        Wed, 10 Apr 2024 03:18:20 -0700 (PDT)
Received: from google.com (248.199.140.34.bc.googleusercontent.com. [34.140.199.248])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b004162a9f03a6sm1832887wmo.7.2024.04.10.03.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 03:18:19 -0700 (PDT)
Date: Wed, 10 Apr 2024 10:18:18 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com,
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
	tabba@google.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Add support for FFA_PARTITION_INFO_GET
Message-ID: <ZhZnaibTBaa2J4a5@google.com>
References: <20240409151908.541589-1-sebastianene@google.com>
 <ZhVpmF2js1NJp1qF@google.com>
 <ZhZYsuqggl_Hzv8X@google.com>
 <ZhZhm4UXyClAqXDM@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhZhm4UXyClAqXDM@google.com>

On Wed, Apr 10, 2024 at 10:53:31AM +0100, Vincent Donnefort wrote:
> [...]
> 
> > > > +static void do_ffa_part_get(struct arm_smccc_res *res,
> > > > +			    struct kvm_cpu_context *ctxt)
> > > > +{
> > > > +	DECLARE_REG(u32, uuid0, ctxt, 1);
> > > > +	DECLARE_REG(u32, uuid1, ctxt, 2);
> > > > +	DECLARE_REG(u32, uuid2, ctxt, 3);
> > > > +	DECLARE_REG(u32, uuid3, ctxt, 4);
> > > > +	DECLARE_REG(u32, flags, ctxt, 5);
> > > > +	u32 off, count, sz, buf_sz;
> > > > +
> > > > +	hyp_spin_lock(&host_buffers.lock);
> > > > +	if (!host_buffers.rx) {
> > > > +		ffa_to_smccc_res(res, FFA_RET_INVALID_PARAMETERS);
> > > > +		goto out_unlock;
> > > > +	}
> > > > +
> > > > +	arm_smccc_1_1_smc(FFA_PARTITION_INFO_GET, uuid0, uuid1,
> > > > +			  uuid2, uuid3, flags, 0, 0,
> > > > +			  res);
> > > > +
> > > > +	if (res->a0 != FFA_SUCCESS)
> > > > +		goto out_unlock;
> > > > +
> > > > +	count = res->a2;
> > > > +	if (!count)
> > > > +		goto out_unlock;
> > > 
> > > Looking at the table 13.34, it seems what's in "count" depends on the flag.
> > > Shouldn't we check its value, and only memcpy into the host buffers if the flag
> > > is 0?
> > > 
> > 
> > When the flag is `1` the count referes to the number of partitions
> > deployed. In both cases we have to copy something unless count == 0.
> 
> I see "Return the count of partitions deployed in the system corresponding to
> the specified UUID in w2"
> 
> Which I believe means nothing has been copied in the buffer?
> 

When the flag in w5 is 1 the size argument stored in w3 will be zero and
the loop will not be executed, so nothing will be copied to the host
buffers.

> > 
> > > > +
> > > > +	if (ffa_version > FFA_VERSION_1_0) {
> > > > +		buf_sz = sz = res->a3;
> > > > +		if (sz > sizeof(struct ffa_partition_info))
> > > > +			buf_sz = sizeof(struct ffa_partition_info);
> > > 
> > > What are you trying to protect against here? We have to trust EL3 anyway, (as
> > > other functions do).
> > > 
> > > The WARN() could be kept though to make sure we won't overflow our buffer. But
> > > it could be transformed into an error? FFA_RET_ABORTED?
> > > 
> > >
> > 
> > I think we can keep it as a WARN_ON because it is not expected to have
> > a return code of FFA_SUCCESS but the buffer to be overflown. The TEE is
> > expected to return NO_MEMORY in w2 if the results cannot fit in the RX
> > buffer.
> 
> WARN() is crashing the hypervisor. It'd be a shame here as we can easily recover
> by just sending an error back to the caller.

I agree with you but this is not expected to happen unless TZ messes up
something/is not complaint with the spec, in which case I would like to
catch this.

