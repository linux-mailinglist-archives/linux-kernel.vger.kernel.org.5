Return-Path: <linux-kernel+bounces-111103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9794A8867F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529D82819CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8E4168D9;
	Fri, 22 Mar 2024 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="B9InOQ+P"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADBE14AAE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094994; cv=none; b=bQOrXSU51XSaeTofaLrJrXHc6IbvdBi6bQN0frj6snqAygpzdyCJW4ea74oe4SY4leG2vOb+27cOHFnuHCA1wQsanXPPyFLflquKfE5Ta848PqbTStxbvTu/Dpu8GwgJ/wIUplxzVlwGCbpbkMeLklJ+ZNgpfJJBcaN1WIFqUX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094994; c=relaxed/simple;
	bh=RXpY8uaT9EOvBi9I6yC5dPQJDGkDvO2f0RD5A5oINvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUnjpkf7aI0LQRfNU7oZo6B2Ma/vqNB4afSj2FSfWDVmoSMnuxXWVPh3+JhYrE4DcS5SNoHlBuuw0Zlg2SIabzsiTAJgABXMHbo7sTQ27T5SCid3R/B0IwTLvtiUT95YCXsTy8mE7Dk33g7BMt4tvEYf9Xw0qZcOSlFyu8Mjkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=B9InOQ+P; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4147e283d1cso104345e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1711094991; x=1711699791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GE5LhZmpwjg/Vlr/58M0lzDTSb9NjpNMdXrf3nX1bH4=;
        b=B9InOQ+PPsQ4o98v6jbhqxusFM6ok4lzPoiplSY06dm5w1ilqY8EhDCfhNBiS9pvTA
         iAZlf/9iraFY47KZXYHnhMl3m1P3YjZsTiOmpuyCMjkyBpa5pw7SdJL2ownJJiuDhqD1
         8ahLsiAbIsgN0HXOqZ8vdbCFwvcCm9JlbFtYlc9Z/HIoae/mZwsGJcQFjTuOjJDkOxxP
         qGAZMrOs8Cwm58s6c1XRf7hD8AT1CEvSveKp7sP7iEbI+FmvlOBmwMEIA1sJ/MsDKyqz
         A6ABXwaxk22ujwn2lZxF54JaQZM1Cxbwzwdnd0WgDrvT8MWXjL6G1ZgBgjz7pTcxTBsD
         /cdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711094991; x=1711699791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE5LhZmpwjg/Vlr/58M0lzDTSb9NjpNMdXrf3nX1bH4=;
        b=T112gPMj8rSy6EOiW+WUDUgM3KU+jODQSlJDVOgWZ82jl+FcJbcvG9yG9eJ4zEi7ne
         APFPScFhIi1w13+uYH967nsYmJp6w9iBA5wya4nfSjmvBuqnzeqZgC8S7dF4Y2EBZcVF
         lxW8+TB9coBXergPkG87hKOUoNCVMeFBB9ZwKyAYggK5SEie2dUm7BUVGERLI3Wl76nq
         MEAEQ6AuM+ZQ6NdW7fnriqRWxGTjyHCL7WV/uO3FL+CoRMS2wR0fQvRsJJrWKxN0iIiD
         iblPc9AKCICQln8tu3IPhDgbpFrItP1mMjwtQgHl+1qHlNG1WVcGpOnuL+Ngg9zl8jGp
         iRZw==
X-Forwarded-Encrypted: i=1; AJvYcCXRBjfQliB69/vpqUseTEN2VCdAeyJQeuWoFbpk1RNE/LbT9bvDJApymlYf9LnZkvYcxbkLf9YAyArsff5TUP2cyeel60rtAE/UQKll
X-Gm-Message-State: AOJu0Ywo0c4WBu/Gq9DmY1qVuP2ilLXQs0OhZWe8uy8AV1SSN9Qqqzlq
	MIpRHQDIN263Gee63B0fzWz2d0kYo6XHwqRP+sEHQy6+1byDvN3jXf9KW4FMNZc=
X-Google-Smtp-Source: AGHT+IHLQHBi7qQwYV/Vh2cMH5xV/FtpkfvFnaz2JqA5AbMTziv+62cDRdiytui2Ed6ojUwu7J0rsg==
X-Received: by 2002:a05:600c:1c26:b0:414:a89:3443 with SMTP id j38-20020a05600c1c2600b004140a893443mr902935wms.25.1711094990861;
        Fri, 22 Mar 2024 01:09:50 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id s16-20020a05600c45d000b00413f4cb62e1sm2291207wmo.23.2024.03.22.01.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:09:50 -0700 (PDT)
Date: Fri, 22 Mar 2024 09:09:49 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Samuel Holland <samuel.holland@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, tech-j-ext@lists.risc-v.org, 
	Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com, 
	Evgenii Stepanov <eugenis@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [RISC-V] [tech-j-ext] [RFC PATCH 5/9] riscv: Split per-CPU and
 per-thread envcfg bits
Message-ID: <20240322-3c32873c4021477383a15f7d@orel>
References: <20240319215915.832127-1-samuel.holland@sifive.com>
 <20240319215915.832127-6-samuel.holland@sifive.com>
 <CAKC1njSg9-hJo6hibcM9a-=FUmMWyR39QUYqQ1uwiWhpBZQb9A@mail.gmail.com>
 <40ab1ce5-8700-4a63-b182-1e864f6c9225@sifive.com>
 <CAKC1njQYZHbQJ71mapeG1DEw=A+aGx77xsuQGecsNFpoJ=tzGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKC1njQYZHbQJ71mapeG1DEw=A+aGx77xsuQGecsNFpoJ=tzGQ@mail.gmail.com>

On Tue, Mar 19, 2024 at 09:39:52PM -0700, Deepak Gupta wrote:
..
> I am not sure of the practicality of this heterogeneity for Zicboz and
> for that matter any of the upcoming
> features that'll be enabled via senvcfg (control flow integrity,
> pointer masking, etc).
> 
> As an example if cache zeroing instructions are used by app binary, I
> expect it to be used in following
> manner
> 
>  - Explicitly inserting cbo.zero by application developer
>  - Some compiler flag which ensures that structures larger than cache
> line gets zeroed by cbo.zero
> 
> In either of the cases, the developer is not expecting to target it to
> a specific hart on SoC and instead expect it to work.
> There might be libraries (installed via sudo apt get) with cache zero
> support in them which may run in different address spaces.
> Should the library be aware of the CPU on which it's running. Now
> whoever is running these binaries should be aware which CPUs
> they get assigned to in order to avoid faults?
> 
> That seems excessive, doesn't it?
>

It might be safe to assume extensions like Zicboz will be on all harts if
any, but I wouldn't expect all extensions in the future to be present on
all available harts. For example, some Arm big.LITTLE boards only have
virt extensions on big CPUs. When a VMM wants to launch a guest it must
be aware of which CPUs it will use for the VCPU threads. For riscv, we
have the which-cpus variant of the hwprobe syscall to try and make this
type of thing easier to manage, but I agree it will still be a pain for
software since it will need to make that query and then set its affinity,
which is something it hasn't needed to do before.

Thanks,
drew

