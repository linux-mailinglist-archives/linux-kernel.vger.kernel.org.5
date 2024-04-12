Return-Path: <linux-kernel+bounces-143096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4968A340D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA351F22901
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC82E14B098;
	Fri, 12 Apr 2024 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rw/V2yri"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB36214B073
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940736; cv=none; b=aJIbf9K07XVxIMwSWVLi9OeCCDGUvqWmmYahtDWt1MZrChg86CknAZBjlT7L9DBj0gQOo28ukY6rfDn22XBuICYS1lvU6Byttgj/iUx/Ngj0DGpgJc05m/IgJ02bExRzAcMoD/BtXj8+iL4MOe6WOWbTtCgJ81BE0GB3MaBHgTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940736; c=relaxed/simple;
	bh=JEVa4ex2ZDcngKNJsXDeM2lwaJ7PKNt/9rGEMEiRKOI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XS9CdBnbOOpjR45eQee6eC1g0WzMrFsA4rjES7/QCPe/NapARhRqDROVSdpdzHCPMKk4mClYPhCuLb3uRveXixQdXj5ErsIs1jRB5wSOubV62kWDGHiKq004iqT0K5XkuyrO4WGBNPZRyS1A7rCQSNUIUBP0nv2G2RGXmf0xWSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rw/V2yri; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d9fe2b37acso13345221fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712940733; x=1713545533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F129E/qMOIsRNJvcD537N8BPcYpqI13fs6vRxipyLXs=;
        b=Rw/V2yriWqv/AZKsihsTM1444GfquRK3pD3IMxStklXaUCWBkkmAhhgjllHSLHw+Lh
         N1jRhCSmBDqce/2b/2HnsAiQVoSKp0CooFXPJ3FXjl4woU7/GPCV2iI9kvZOT2LrM4Wc
         HvCUufg9UQE8b7Kp4WjAHD8+MMHbmA9oPl2pE32dVrwhRS8qrOW03oSIlmgT3nroz87u
         mmMuCtBC8IfIHbPJ4brRHKLMMGVuyRWqvX308q9SdeAFN7CKNRtj8/GOr6cAPwcPq9c0
         yqfuYDebKbsxhDvWKDjRp+FYXmbsNurAqH7ifDdhbhK2z6pU+9Ks6JxBRcB9abd/mSmw
         8vuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712940733; x=1713545533;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F129E/qMOIsRNJvcD537N8BPcYpqI13fs6vRxipyLXs=;
        b=iTkMoXj5XQccXkjS3KLLbX7zbdoJ9ktljvOdtCdbXFkBjyDRb8/r1RUTLbbHnM1L7C
         VKb7+GnF/m6t8JKH6c981nq/IbizKspjNpda19o1lsERFcfAPXjnugFlFjlVy3G+7PxA
         sW9udj+Msy261NjMX93WphIRh+yGXj17PHkiLNtid8TknlLJy97ZQy68Zf7iRoWVq7yP
         8uj8g4vt61wTk8FR1QOoRHb/DeUQw4JbWAAe/2dGClVrSvfsqAKcKNbx6d8OmDbFNmT5
         NAc6eqBnZ0cuozu53wmuJMWe7K4kskdfb/B/IzZJ2q96w88zICMyewCgAvOR4JQ1IaDJ
         qmiw==
X-Forwarded-Encrypted: i=1; AJvYcCVppQEuat1AFIjmIRNxD49UNGs+/i0h+cDq5QZ617Uxh4Q84NWRWg/XLE8nToxY+rhMGUd4Ti/YmX3lsgVIbtQFFyJSYxoaTwXYE2u/
X-Gm-Message-State: AOJu0YyG9upPs3VzeaaWNnbkAnZI5XEYuQDfLe+T9uLIKvCgpj9cSzEk
	nFVgDejvC/Ez1dUKuztENN3Raxie9gpsiUNFiPX/02Z3gGeBj9OG/vQaFKZsYqU=
X-Google-Smtp-Source: AGHT+IFM2/dXuGXELLLfc+flbBb9xsmkA1SIJGRaZWidPMq1PtFsBq8OiGD0hOU+ZU8oOVk804e3sg==
X-Received: by 2002:a05:651c:93:b0:2d8:3e60:b9c9 with SMTP id 19-20020a05651c009300b002d83e60b9c9mr1767624ljq.33.1712940732768;
        Fri, 12 Apr 2024 09:52:12 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id fc18-20020a05600c525200b0041563096e15sm9497631wmb.5.2024.04.12.09.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 09:52:12 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:52:24 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joey Gouly <joey.gouly@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Thomas Fossati <thomas.fossati@linaro.org>,
	Kevin Zhao <kevin.zhao@linaro.org>,
	Leonardo Augusto =?utf-8?Q?Guimar=C3=A3es?= Garcia <leonardo.garcia@linaro.org>
Subject: Re: [v2] Support for Arm CCA VMs on Linux
Message-ID: <20240412165224.GA357251@myrica>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412084056.1733704-1-steven.price@arm.com>

On Fri, Apr 12, 2024 at 09:40:56AM +0100, Steven Price wrote:
> We are happy to announce the second version of the Arm Confidential
> Compute Architecture (CCA) support for the Linux stack. The intention is
> to seek early feedback in the following areas:
>  * KVM integration of the Arm CCA;
>  * KVM UABI for managing the Realms, seeking to generalise the
>    operations where possible with other Confidential Compute solutions;
>  * Linux Guest support for Realms.
> 
> See the previous RFC[1] for a more detailed overview of Arm's CCA
> solution, or visible the Arm CCA Landing page[2].
> 
> This series is based on the final RMM v1.0 (EAC5) specification[3].

Instructions for building and running the CCA stack on QEMU, both as
system emulation and VMM, are available here:
https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/Building+an+RME+stack+for+QEMU

I'll send out the QEMU VMM patches shortly:
https://git.codelinaro.org/linaro/dcap/qemu.git branch cca/v2

Thanks,
Jean

> [1] Previous RFC
>     https://lore.kernel.org/r/20230127112248.136810-1-suzuki.poulose%40arm.com
> [2] Arm CCA Landing page (See Key Resources section for various documentation)
>     https://www.arm.com/architecture/security-features/arm-confidential-compute-architecture
> [3] RMM v1.0-EAC5 specification
>     https://developer.arm.com/documentation/den0137/1-0eac5/
> [4] Shrinkwrap
>     https://git.gitlab.arm.com/tooling/shrinkwrap
> [5] Linux support for Arm CCA RMM v1.0-EAC5
>     https://lore.kernel.org/r/fb259449-026e-4083-a02b-f8a4ebea1f87%40arm.com


> 

