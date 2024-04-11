Return-Path: <linux-kernel+bounces-140129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51F18A0BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D217B2523E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46AD14264F;
	Thu, 11 Apr 2024 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RXIRIN1z"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9231411FE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826199; cv=none; b=DkTIqFE/2UYomboQpnulsnzOnlyLF85Aj/LcVM57Oe6nI41dzXgPmRE0pQ4soQsPcuKWlBwwt3pETqbGZ99u/y8yQ1wQp2Yc5xnGV+g1GYg1hf7I2hPaSA9vJASWr+MNY9WbE3cZ9PqdlnP/4ZAHOLf22KhKl3JubORHe6tj38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826199; c=relaxed/simple;
	bh=+pzbJC+YgKM6sW4DExjI1R1UL5aMJjWWQiNOgEkYM2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQBEdrzES6Jwynh3fTGHpYZwNEOkfqJDE3n40fM8pszHGZMz3EXXocGdPsoLpgiKmh2adGwkVbZk56KeFd/LTN6TjzTsApGeQjJsNzps+3/0SgP8ZpHn9LpG4aiGAeXfYb2YC4mxjxJJ1azLFoTmH/YQF+mhxvrW7vaonCjJ+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RXIRIN1z; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41699bbfb91so61155e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712826195; x=1713430995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqfSLSB/AB48WWgXAVHlYTdSSFdUvK5wajBEFofuXQg=;
        b=RXIRIN1zSYQxfj3PByqBLDJp2o/9JcUSQq+lviUcYv2ZLm0tkEiVyxEmvDbsBq5x7j
         TumNRForGL6EISwrU04nnXvIYZyaKy1k+t/7XgfFsSr2hH8Jlb/EXl3GL3yCl7Wv2zb2
         u/XWYi6pjzn2tEax15gmN1pEnWyRn5O7MaDhuFPemANdS7GYvtr8dvy2s5t+3j4jJvgT
         V1OaBHB2tmCHzt+YVc3aeztZyBBalMdKaYkXNzn7yQdMenOMqDkJKSNVaqE9VSfkh83P
         t9KjKZiXfvbfeNUFPic6eqGB2IxbPwEpMD4EzxpZj+Ot4FcFqoNkFyNWzUtFB0uX19V2
         0flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712826195; x=1713430995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqfSLSB/AB48WWgXAVHlYTdSSFdUvK5wajBEFofuXQg=;
        b=Aui7Fz/BFBjAxodbZ0cjG7l9WJPBfqU6Cr4DwYiUxS1fx8KBeXz9ingZ7kw2Yckt6v
         4ksl2ab8BQXFAR/FoyLYAtcBzDbzbmJDYYQakTjSyO/Us4BTiET4Ec9DTGAfzcf5jdc2
         t/xwDMucuneW3pTrHJwZ9Y4SuzRgQJXZbQqtxsKWzNJ85qbtMEEk+Zp/cUZQTbZUyaVP
         MVWN0+CmmG3bMZz2y1RSBCekeJl/6icfPokHtGMvoA4Ye58BKN3uDqPQZZJtimW5mrf5
         SbuqtMwV7g7+z6k5fCi1NunPO1jFRjW3i0kA84IeO0DhiNN5gqloRJHlAIzLCi4+oBFw
         KPxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF8p2/Kh3w1jLKZcDK57JiXxKjLLhxsdgTJr+ipVQUAviXNxIWzSQC3o4jabW86289y6CVkS2nyXqQUCL37dWg8t5H7QizPz9vkTeh
X-Gm-Message-State: AOJu0Yw7WUKJhM3lZBjMz+/gRtV7R+b3/a9qc2Sy/PDY8LT8VvqSffgc
	J+mPz6Q7GBHsWlEioW1JVqlXRMovrITqYHs2j6lc/yctivCjxapHfcayg3i3DA==
X-Google-Smtp-Source: AGHT+IH78w0bgEGjDyrKEfk+d9ic/SSQTwVwM1da8T9d732zT8YK/kjBPq2FLqf/BbcoknBcTcJF2A==
X-Received: by 2002:a05:600c:3d93:b0:417:d73e:b3de with SMTP id bi19-20020a05600c3d9300b00417d73eb3demr95804wmb.0.1712826195396;
        Thu, 11 Apr 2024 02:03:15 -0700 (PDT)
Received: from google.com (248.199.140.34.bc.googleusercontent.com. [34.140.199.248])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d5292000000b00341b451a31asm1271306wrv.36.2024.04.11.02.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 02:03:15 -0700 (PDT)
Date: Thu, 11 Apr 2024 09:03:13 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com,
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
	tabba@google.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Add support for FFA_PARTITION_INFO_GET
Message-ID: <ZhenUTPeAF7i_i-3@google.com>
References: <20240409151908.541589-1-sebastianene@google.com>
 <ZhVpmF2js1NJp1qF@google.com>
 <ZhZYsuqggl_Hzv8X@google.com>
 <ZhZhm4UXyClAqXDM@google.com>
 <ZhZnaibTBaa2J4a5@google.com>
 <ZhbIDUO9BULaiSh3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhbIDUO9BULaiSh3@google.com>

On Wed, Apr 10, 2024 at 06:10:37PM +0100, Vincent Donnefort wrote:

Hi Vincent,

> On Wed, Apr 10, 2024 at 10:18:18AM +0000, Sebastian Ene wrote:
> > On Wed, Apr 10, 2024 at 10:53:31AM +0100, Vincent Donnefort wrote:
> > > [...]
> > > 
> > > > > > +static void do_ffa_part_get(struct arm_smccc_res *res,
> > > > > > +			    struct kvm_cpu_context *ctxt)
> > > > > > +{
> > > > > > +	DECLARE_REG(u32, uuid0, ctxt, 1);
> > > > > > +	DECLARE_REG(u32, uuid1, ctxt, 2);
> > > > > > +	DECLARE_REG(u32, uuid2, ctxt, 3);
> > > > > > +	DECLARE_REG(u32, uuid3, ctxt, 4);
> > > > > > +	DECLARE_REG(u32, flags, ctxt, 5);
> > > > > > +	u32 off, count, sz, buf_sz;
> > > > > > +
> > > > > > +	hyp_spin_lock(&host_buffers.lock);
> > > > > > +	if (!host_buffers.rx) {
> > > > > > +		ffa_to_smccc_res(res, FFA_RET_INVALID_PARAMETERS);
> > > > > > +		goto out_unlock;
> > > > > > +	}
> > > > > > +
> > > > > > +	arm_smccc_1_1_smc(FFA_PARTITION_INFO_GET, uuid0, uuid1,
> > > > > > +			  uuid2, uuid3, flags, 0, 0,
> > > > > > +			  res);
> > > > > > +
> > > > > > +	if (res->a0 != FFA_SUCCESS)
> > > > > > +		goto out_unlock;
> > > > > > +
> > > > > > +	count = res->a2;
> > > > > > +	if (!count)
> > > > > > +		goto out_unlock;
> > > > > 
> > > > > Looking at the table 13.34, it seems what's in "count" depends on the flag.
> > > > > Shouldn't we check its value, and only memcpy into the host buffers if the flag
> > > > > is 0?
> > > > > 
> > > > 
> > > > When the flag is `1` the count referes to the number of partitions
> > > > deployed. In both cases we have to copy something unless count == 0.
> > > 
> > > I see "Return the count of partitions deployed in the system corresponding to
> > > the specified UUID in w2"
> > > 
> > > Which I believe means nothing has been copied in the buffer?
> > > 
> > 
> > When the flag in w5 is 1 the size argument stored in w3 will be zero and
> > the loop will not be executed, so nothing will be copied to the host
> > buffers.
> 
> Ha right, all good here then.
> 
> > 
> > > > 
> > > > > > +
> > > > > > +	if (ffa_version > FFA_VERSION_1_0) {
> > > > > > +		buf_sz = sz = res->a3;
> > > > > > +		if (sz > sizeof(struct ffa_partition_info))
> > > > > > +			buf_sz = sizeof(struct ffa_partition_info);
> > > > > 
> > > > > What are you trying to protect against here? We have to trust EL3 anyway, (as
> > > > > other functions do).
> > > > > 
> > > > > The WARN() could be kept though to make sure we won't overflow our buffer. But
> > > > > it could be transformed into an error? FFA_RET_ABORTED?
> > > > > 
> > > > >
> > > > 
> > > > I think we can keep it as a WARN_ON because it is not expected to have
> > > > a return code of FFA_SUCCESS but the buffer to be overflown. The TEE is
> > > > expected to return NO_MEMORY in w2 if the results cannot fit in the RX
> > > > buffer.
> > > 
> > > WARN() is crashing the hypervisor. It'd be a shame here as we can easily recover
> > > by just sending an error back to the caller.
> > 
> > I agree with you but this is not expected to happen unless TZ messes up
> > something/is not complaint with the spec, in which case I would like to
> > catch this.
> 
> Hum, still I don't see the point in crashing anything here, nothing is
> compromised. The driver can then decide what to do based on that reported
> failure.

I still think we should keep this (as we discussed offilne). We do WARN_ON 
when the behaviour doesn't follow the spec guidelines. For this
particular case, if the result doesn't fit in the caller's buffer the TEE
is expected to return FFA_ERROR in w0 with NO_MEMORY in w2. If it
returns success but the caller doesn't have enough space to copy then
something is going horribly wrong on the TEE side.

Thanks,
Seb

