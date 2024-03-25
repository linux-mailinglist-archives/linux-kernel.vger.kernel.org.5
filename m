Return-Path: <linux-kernel+bounces-116777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7687B88A3D0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5551F39904
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF38D14D43D;
	Mon, 25 Mar 2024 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fekZIf+e"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D618C9EC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360696; cv=none; b=oAArLM5KnxQZ2OH7maz+kUIJmNhqR1Ja+vLwWrxBbf83XLFAdqaI3xhBUxPLDm4rXGmYapENStivMoxQxyEALHNFqlchZ0A73Lxatwj6fgkifZ+vFmT3noYIMG/qkBNcuyYuXEB6nqI0voMUXkRD32UQStpnL5blTGE9vYB/2lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360696; c=relaxed/simple;
	bh=NqK30dWvMkhMRQos+zh5Gvc0n9gWQPd9IHznIn2q9gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9rVjnSVfXlKdf0suc6prD3nhNH2Ci3W8vwRolZoOq4CCJDcpBGXCPA4vy0dKPl+MMBdVcumW4sM0ccY9++u9PRPjdXYMhVNLUYRWqN6YRm04lN5afXYvDdEbeogTaSFGJ4B/xh6uyPVJbcS0uYEcstgIn0cukUOkFFs/3Fp8j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fekZIf+e; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7dfacd39b9eso2765525241.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711360693; x=1711965493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kyd2fUcre4Z3NgmLnaLMJzBCVzXb0Ngoj6fneWetwoo=;
        b=fekZIf+eTMoIADWtxEEnssf42KVI+8wW08HN+gUZaFMvoYZLt+KGaRUfA8f3CwBKRR
         /FYl6YnP+2Cn+chYSyiwJz7elP0P6EOU0XpYHVBSVQpWtazWzmyewrdZkFFqPLbFstgC
         NZJtYr72wxQIdxHMeBhUgE2y4peQphvEfEQa4ry7Is67KknfClDOJ27DM2cfDqQdhto5
         riuCV42LVF1rud54rqBxn75LyZ/Ib/gYEsmlHp1uXcnsevJne0RS4dopVk/ZJ204tENn
         BYDM7CxLUjUIJ9o3uPmY0R0cd+yYddPwVMAw91lwJxYN0/0JaeqRNRUtUpCjRnAyzZDr
         twlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711360693; x=1711965493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kyd2fUcre4Z3NgmLnaLMJzBCVzXb0Ngoj6fneWetwoo=;
        b=DSOPMKSZTEqFy97QrQgfCqQD399h7TA6C0dUPXJ155bDEBvGE1bd6tfUoULjD2368g
         SUNSwB5VwF1vagGAFZtG1QfxmHR4vxHjzrL38DMW2mD2z2YrpXlQX7WR4bkSZbIahnIG
         COzNKL4m36dNhxucW2/oKHelGJjX6gS1fqKsulgvZuqc10WEeYzeuwFrxcNhKRpHYE93
         EC3nI8Eo66gf5sZQ5HLyIDyqEBqHIcQLqkLXj9V7AlYAjEX8jC94eeSmtUAO9ydT/rpD
         Ca+oPSO4Wc4iadK3RHFld40tvCD3jFIGYacHPcWrGgPDyeOuqNVDYm0ICx19H9sWY7KA
         NUmw==
X-Gm-Message-State: AOJu0YxGO+6uoi3v+nm5ysMPufy1byrw2JlQS8SLvIUv9GhhJq8nDgvp
	piTjBojlvmVwBcohbzL5kpvOANv3TN65dVd/xli9JTsVH1sUGxFmcXnR9Xi73zuJU/ChdcBHFkc
	d4b/j6+To0lOsjIDwaEYkMCDu1AKmL/x2gwq94A==
X-Google-Smtp-Source: AGHT+IH/LXe+pZI6T4dYPbrCnIOWYVWHu5aykoWck8P1W1r3msju/rhgAo9E+tewJPXWPjjlSAuDIOssGzyy23FEb/U=
X-Received: by 2002:a67:fd67:0:b0:476:71f:dc62 with SMTP id
 h7-20020a67fd67000000b00476071fdc62mr2935823vsa.9.1711360692786; Mon, 25 Mar
 2024 02:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324230116.1348576-1-sashal@kernel.org>
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Mar 2024 15:28:01 +0530
Message-ID: <CA+G9fYueiBdV-uRVbX+JB2_nt831_+8fnyoQ6v62rAsyLQne6g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/638] 6.6.23-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 04:31, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 6.6.23 release.
> There are 638 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Mar 26 11:01:10 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.6.y&id2=v6.6.22
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha


The regression detected while building allmodconfig builds with clang-17
failed on all the architectures.

> Andrii Nakryiko (3):
>   libbpf: Fix faccessat() usage on Android
>   libbpf: Add missing LIBBPF_API annotation to libbpf_set_memlock_rlim
>     API
>   bpf: don't infer PTR_TO_CTX for programs with unnamed context type

arm64 gcc-13 - FAILED (other architectures passed)
arm64 clang-17 - FAILED (All other architectures failed))

The 2 errors are only noticed on arm64.

> Jason Gunthorpe (1):
>   iommu/arm-smmu-v3: Check that the RID domain is S1 in SVA

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
------------
kernel/bpf/btf.c:5660:10: error: expression which evaluates to zero
treated as a null pointer constant of type 'const struct btf_member *'
[-Werror,-Wnon-literal-null-conversion]
 5660 |                 return false;
      |                        ^~~~~
1 error generated.

<trim>

drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c:358:10: error:
incompatible integer to pointer conversion returning 'int' from a
function with result type 'struct iommu_sva *' [-Wint-conversion]
  358 |                 return -ENODEV;
      |                        ^~~~~~~
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c:361:10: error:
incompatible integer to pointer conversion returning 'int' from a
function with result type 'struct iommu_sva *' [-Wint-conversion]
  361 |                 return -ENODEV;
      |                        ^~~~~~~
2 errors generated.


Steps to reproduce:
 # tuxmake --runtime podman --target-arch arm64 --toolchain clang-17
--kconfig allmodconfig LLVM=1 LLVM_IAS=1

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.22-638-ga02ac18a4590/testrun/23156094/suite/build/test/gcc-13-allmodconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.22-638-ga02ac18a4590/testrun/23156063/suite/build/test/gcc-13-allmodconfig/history/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2eAPALK4lPo78E8K7ZPm0ayDbfA/

 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.22-638-ga02ac18a4590/testrun/23156063/suite/build/test/clang-17-allmodconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.22-638-ga02ac18a4590/testrun/23156063/suite/build/test/clang-17-allmodconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2eAPANvCAoQEpSXaT8nzxKxI0Ft/

--
Linaro LKFT
https://lkft.linaro.org

