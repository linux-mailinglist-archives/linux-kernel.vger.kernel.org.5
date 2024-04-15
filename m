Return-Path: <linux-kernel+bounces-145552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B44F8A57C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260292850CD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7352D225DA;
	Mon, 15 Apr 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E9iKxGqG"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AED36B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198659; cv=none; b=YTbjcua11gYg2OVXDEh6kDXNVrMTMDt6T+FLygI6ItaSLpbQln05jpX+NSaT62oI53bvZDTTDQ6NiFdYAoItJSrRqc+ysZsm8MVJe3yff7Vqms/vNF5WGMkFwg2ocyO1FjOJwtx2ORNCKIi8zodzDj3tPUhqcL7Ww+4+bQd6/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198659; c=relaxed/simple;
	bh=asWqn6TIhxSjIZMFjKT2DKFcQXaURrA4gtx1BOtUuWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkBIlGPRKsfZQ8rfbqYecrzpMS6mLwTo63ZDvQs1v8FIehhXQLq2LDDnMoi1VATJ1Rd6AJbEUDhsk3ioMAtG9YMIlE9d2FD5iaXiNzcNiQU9jggYGD8QzIabE4MCUc7doW4Jh19+5IC9Zjm21N7vjCmGf9LKpu5/XKEePlY6u+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=E9iKxGqG; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69b59c10720so12750446d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713198657; x=1713803457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzc9rltK+fu/nhD7W5oUEoxEFESmeqODhdUk35ZmiiA=;
        b=E9iKxGqGfS9cXcR0FzbYv/l/hDVLPEWc+DNkne0mEWPwkjbt4PZfIbK5QWPaVACY1/
         adM+IGqJLQlscT/rxKkKbedvOVhMTPks3pkfUlhP2YwVKncaYI4iWaduZ3dFtOkyE9mJ
         J6a61AtEtP0seDMAS2PybJfxgHVjOoqxCrmSdkt6NDuoq5vY2WJCNiD8y3ovrSCz78Yt
         v9L7V1dd/8iLRSOFwjiXqWFcdHluXhBPhIpfgqwi2SmgC7lZ8nR4lp3+m3gTkRdjGvlW
         ameHn/InKMyLwtvfJ/ICHbSDRlo+NW2od45OHwG3kJW6jtloGFRaN2hrX73bb6iBqbQP
         9IVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198657; x=1713803457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzc9rltK+fu/nhD7W5oUEoxEFESmeqODhdUk35ZmiiA=;
        b=e30JzK/+xwGwsTGq73lfdW7tMVnmyCDHW3YLodkG4qJWTsWfKERkDk4yqur1F/zDvq
         G/KjS0Qwib8CmiGzPtdgpwFITM50qbufKCgGJVND/dn8fTS7xdI/6F9XCS7AN9KDeKAN
         0ZJw5em634B76G6YwemXn8bViPUWL6jA9xUKxOn3mPTOov8z6QkHVkcR0otfkNzyMvNk
         B6dtF4Y+VnOJl3VwB9XrS45RbgHMVV6FS+b5ZdRYcnDuolCRP3a1UH1kzdy/Iu9zr/G1
         XloQQtssEObsQb59q5ALdJnMcN8KD97twKY8K50MbTTWTgErbcyH0lq9PlVi7P4/Ltad
         7NfA==
X-Forwarded-Encrypted: i=1; AJvYcCXy6wua9CyLM+0Q+z/I97875in+Rm+xvaVd3j9UHAKRXdkoAtFh0obpzsPVOpojUdRC52SPFOvj0tjFBaAqL7qVP+GSas6Iw1v5onhC
X-Gm-Message-State: AOJu0YzNSvmxHhMETAHxaXkm4fk5DzKB8EigZhHDdu7NIuyeWt5hYCOI
	/7YJLCqYgOGoW+RfsWa9p9OVtaKvUwZFzaOqobYurupzcDuiY8exNpnm3U5mjoA=
X-Google-Smtp-Source: AGHT+IHXFvoxwiWd5lcr4u7SqXDpMn5e4jKuccR6FL/kVfQg2GGqoREZaOdhq5QkrOLzi98bqkhgtQ==
X-Received: by 2002:a05:6214:18e6:b0:699:2443:bcea with SMTP id ep6-20020a05621418e600b006992443bceamr9858534qvb.22.1713198657049;
        Mon, 15 Apr 2024 09:30:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ej2-20020ad45a42000000b0069b7bc51271sm1549668qvb.123.2024.04.15.09.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:30:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rwPEO-006EFV-4c;
	Mon, 15 Apr 2024 13:30:56 -0300
Date: Mon, 15 Apr 2024 13:30:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Eric Wagner <ewagner12@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
Message-ID: <20240415163056.GP223006@ziepe.ca>
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>

On Sat, Apr 13, 2024 at 06:04:12PM -0400, Eric Wagner wrote:
>    On my Thinkpad T14s G3 AMD (Ryzen 7 6850U) laptop connected to an AMD
>    RX 580 in Akitio Node Thunderbolt 3 eGPU. Booting with the eGPU
>    connected hangs on kernels 6.7 and 6.8, but worked on 6.6. For
>    debugging, I find that adding the kernel parameter amd_iommu=off seems
>    to fix the issue and allows booting with the eGPU on 6.7.
>    I tried bisecting the issue between 6.6 and 6.7 and ended up with:
>    "e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2 is the first bad commit" in
>    the attached. This seems to indicate an amd iommu issue.
>    Two others also reported the same issue on AMD Ryzen 7 7840 with AMD RX
>    6000 connected as eGPU
>    ([1]https://gitlab.freedesktop.org/drm/amd/-/issues/3182).
>    Let me know if you need more information.
> 
> References
> 
>    1. https://gitlab.freedesktop.org/drm/amd/-/issues/3182

> Bisecting: 366 revisions left to test after this (roughly 9 steps)
> [74e9347ebc5be452935fe4f3eddb150aa5a6f4fe] Merge tag 'loongarch-fixes-6.6-3' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson
> Bisecting: 182 revisions left to test after this (roughly 8 steps)
> [f6176471542d991137543af2ef1c18dae3286079] Merge tag 'mtd/fixes-for-6.6-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
> Bisecting: 87 revisions left to test after this (roughly 7 steps)
> [fe3cfe869d5e0453754cf2b4c75110276b5e8527] Merge tag 'phy-fixes-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy
> Bisecting: 43 revisions left to test after this (roughly 6 steps)
> [c76c067e488ccd55734c3e750799caf2c5956db6] s390/pci: Use dma-iommu layer
> Bisecting: 27 revisions left to test after this (roughly 5 steps)
> [aa5cabc4ce8e6b45d170d162dc54b1bac1767c47] Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
> Bisecting: 14 revisions left to test after this (roughly 4 steps)
> [bbc70e0aec287e164344b1a071bd46466a4f29b3] iommu/dart: Remove the force_bypass variable
> Bisecting: 9 revisions left to test after this (roughly 3 steps)
> [e82c175e63229ea495a0a0b5305a98b5b6ee5346] Revert "iommu/vt-d: Remove unused function"
> Bisecting: 5 revisions left to test after this (roughly 2 steps)
> [92bce97f0c341d3037b0f364b6839483f6a41cae] s390/pci: Fix reset of IOMMU software counters
> Bisecting: 3 revisions left to test after this (roughly 2 steps)
> [3613047280ec42a4e1350fdc1a6dd161ff4008cc] Merge tag 'v6.6-rc7' into core
> Bisecting: 2 revisions left to test after this (roughly 1 step)
> [f7da9c081517daba70f9f9342e09d7a6322ba323] iommu/tegra-smmu: Drop unnecessary error check for for debugfs_create_dir()
> Bisecting: 1 revision left to test after this (roughly 1 step)
> [9e13ec61de2a51195b122a79461431d8cb99d7b5] iommu/virtio: Add __counted_by for struct viommu_request and use struct_size()
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3] iommu: Avoid unnecessary cache invalidations
> e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2 is the first bad commit
> commit e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
> Merge: 6e6c6d6bc6 f7da9c0815 aa5cabc4ce 9e13ec61de e82c175e63 cedc811c76 3613047280 92bce97f0c
> Author: Joerg Roedel <jroedel@suse.de>
> Date:   Fri Oct 27 09:13:40 2023 +0200
> 
>     Merge branches 'iommu/fixes', 'arm/tegra', 'arm/smmu', 'virtio', 'x86/vt-d', 'x86/amd', 'core' and 's390' into next

Do you have the good/bad log on this? It doesn't look like bisect
tested enough stuff to really conclude the merge is the bad thing, at
a minimum it should be testing all the bases of the merge. Do you have
--first-parent set or something?

I would test cedc811c76778bdef91d405717acee0de54d8db5 (x86/amd) and
3613047280ec42a4e1350fdc1a6dd161ff4008cc (core) directly. Most likely
cedc will be bad problem.

If one of them is bad then restart the bisection with that as the bad
and 6e6c6d6bc6 as the good.

(or run bisect again with e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2 as
the bad and 6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3 as the good
without --first-parent)

Jason

