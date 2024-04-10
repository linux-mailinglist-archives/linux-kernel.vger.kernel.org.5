Return-Path: <linux-kernel+bounces-138287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EB389EF44
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05DD6B217EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B148A156F2F;
	Wed, 10 Apr 2024 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rviyhv8P"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462DF1553AC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742819; cv=none; b=CUeFXGSCBSH5vL133GpWFgE57b40fMLc/mX75mqzHX6zDfo3v4cqSTCA6iy60l9H3OJRqNEktdwdH3dVVxaWoOy+PhstmX7kNJrD8zR3kRCUoc4SbWJA4Q8CsAi/cNmwVcgdURcKcF6ULKoiaazUGuVjVJh7Zb2Szlg+0MBwiZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742819; c=relaxed/simple;
	bh=ZfZs2OEOLT/Lt0O35IJPmq35XOrtA4O0leIUv8gpuzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pnh7bdX3hpdsWpwH57L6+mlUD7h2TmsCyNyakDt49k/m7lUbCCKKMCpKx3sqMqLi961e4AvxWYt1v1UyYmED4xKBAYxOxjlWnB7FhRBbNpnEHqtcCxKXPCztzEulEoEK/MU2hN4is1MwLBuHOQI7wG3c+Fr/esYmxknTL1DZXmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rviyhv8P; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so61495431fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712742815; x=1713347615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5V6Ab5KYZlb0KtyTlJwyIxL2QcpWe2gp9lR05o6q98=;
        b=Rviyhv8PyX8wumneQ06fiJZf7V9RuvpPiRiBp+wsVcvj+K1Rnbf1Wm3sC7H6q1KqCS
         pKa+DZQX7dJnNNQ1WEOLxizwLEfVSrkfDQtNk7c/JjfkKq9S79vtEbLabRc9BzCwN7W0
         uwb3HlB+FyoCtiTcjRh/ZqF6nrtkMXZbsaKKLJ98a1Z4M9EfpGvfsEnDGHbl0uKLbQsZ
         OhWi9RxyvqHr2HlwsclHDtZlnK8C/Z1hNhqj0LjYRoBvZ8BwSQJWX90rauGvDC6SaDP/
         ASm/cjPxuDNfyCsZodzYZbAhlVzi3VcErRYPWvntxjCBQuusDd97Ul4yg3sqzLQC5uSW
         WCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712742815; x=1713347615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5V6Ab5KYZlb0KtyTlJwyIxL2QcpWe2gp9lR05o6q98=;
        b=AjGKv1CW3ishUIwtNz0cEE2sLMC1QDhi2GtzU/8qto+xiWGsdz/efWUzNdElQGCEfC
         1rkcEBbgDM3wAR2fqUubxBTlT3GowyjJLSFKOlapv4p0zig3giMYPo2pTbGhI5wCIXUU
         ucSp6o1gNGtUBqtZb3Vd5/+h4NKpgLKyBUh1b3qjkGXoNz0hkniF4hbGpuffdkcTXdMi
         mB7ujGGx6hqrNfULig6Ky8z8oWlKs77/Yhy6PykwmLzzbrZtLJ3J1gVqKym9xoGM0iC6
         WdzPtW2WSHeywjIOmhEiI6odEImMURpGwyvPB6oYPpBmImLe72sUWJoAuN7rtTHswBzs
         V6oA==
X-Forwarded-Encrypted: i=1; AJvYcCUiYOhPuPvULygDGVI1PJ+12Uop5J3OxnCABkUiJtg8P7D6B+8J3n8ogpFIgZGfTaOqNU+4e7c84XkmRah7Qa2R6uCJxLT5Bta3Mpax
X-Gm-Message-State: AOJu0Yzmyk7o0RrLzu2bOJ33cO9hK6WccZXYiVRSEk8VlXanlj2dcteJ
	kWkD2HiSdVM/Au9MAPhcix4FAPkkRHGDFnhbo/fM3QW0MdES0ZkU2V/Turyh9A==
X-Google-Smtp-Source: AGHT+IFI7ac6E7BZYOo32rnOqFa6a7C6UIEWBLNvFOj/PVUT5To2IkCy5/i4IwMhkFIMY9cwo/mWyA==
X-Received: by 2002:a2e:a9a6:0:b0:2d8:be29:4ca9 with SMTP id x38-20020a2ea9a6000000b002d8be294ca9mr2001820ljq.39.1712742815139;
        Wed, 10 Apr 2024 02:53:35 -0700 (PDT)
Received: from google.com (161.126.77.34.bc.googleusercontent.com. [34.77.126.161])
        by smtp.gmail.com with ESMTPSA id he8-20020a05600c540800b00416a08788a5sm1757388wmb.27.2024.04.10.02.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:53:34 -0700 (PDT)
Date: Wed, 10 Apr 2024 10:53:31 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com,
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
	tabba@google.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Add support for FFA_PARTITION_INFO_GET
Message-ID: <ZhZhm4UXyClAqXDM@google.com>
References: <20240409151908.541589-1-sebastianene@google.com>
 <ZhVpmF2js1NJp1qF@google.com>
 <ZhZYsuqggl_Hzv8X@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhZYsuqggl_Hzv8X@google.com>

[...]

> > > +static void do_ffa_part_get(struct arm_smccc_res *res,
> > > +			    struct kvm_cpu_context *ctxt)
> > > +{
> > > +	DECLARE_REG(u32, uuid0, ctxt, 1);
> > > +	DECLARE_REG(u32, uuid1, ctxt, 2);
> > > +	DECLARE_REG(u32, uuid2, ctxt, 3);
> > > +	DECLARE_REG(u32, uuid3, ctxt, 4);
> > > +	DECLARE_REG(u32, flags, ctxt, 5);
> > > +	u32 off, count, sz, buf_sz;
> > > +
> > > +	hyp_spin_lock(&host_buffers.lock);
> > > +	if (!host_buffers.rx) {
> > > +		ffa_to_smccc_res(res, FFA_RET_INVALID_PARAMETERS);
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	arm_smccc_1_1_smc(FFA_PARTITION_INFO_GET, uuid0, uuid1,
> > > +			  uuid2, uuid3, flags, 0, 0,
> > > +			  res);
> > > +
> > > +	if (res->a0 != FFA_SUCCESS)
> > > +		goto out_unlock;
> > > +
> > > +	count = res->a2;
> > > +	if (!count)
> > > +		goto out_unlock;
> > 
> > Looking at the table 13.34, it seems what's in "count" depends on the flag.
> > Shouldn't we check its value, and only memcpy into the host buffers if the flag
> > is 0?
> > 
> 
> When the flag is `1` the count referes to the number of partitions
> deployed. In both cases we have to copy something unless count == 0.

I see "Return the count of partitions deployed in the system corresponding to
the specified UUID in w2"

Which I believe means nothing has been copied in the buffer?

> 
> > > +
> > > +	if (ffa_version > FFA_VERSION_1_0) {
> > > +		buf_sz = sz = res->a3;
> > > +		if (sz > sizeof(struct ffa_partition_info))
> > > +			buf_sz = sizeof(struct ffa_partition_info);
> > 
> > What are you trying to protect against here? We have to trust EL3 anyway, (as
> > other functions do).
> > 
> > The WARN() could be kept though to make sure we won't overflow our buffer. But
> > it could be transformed into an error? FFA_RET_ABORTED?
> > 
> >
> 
> I think we can keep it as a WARN_ON because it is not expected to have
> a return code of FFA_SUCCESS but the buffer to be overflown. The TEE is
> expected to return NO_MEMORY in w2 if the results cannot fit in the RX
> buffer.

WARN() is crashing the hypervisor. It'd be a shame here as we can easily recover
by just sending an error back to the caller.

