Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7204805BA8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjLEQVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjLEQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:21:10 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E57C3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:21:15 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7c45280b1a9so1352897241.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 08:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701793275; x=1702398075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OmAkQb/1MroERVIyIw0Fp7+C3+mpW6FbekfkXqQHOdM=;
        b=pQ6JbyMViiQbya7DJlcbzP+MxXkqlRZm+Xqrc1//HKmCJNpiRDs94SUgfCYzT2e4T+
         XB5ODBO42EMj7l03RPJoNsZHBpIqTT7LbHpUq0D4HFqFYv5I3r9KP+Z98ami8Zj240Dq
         8acqoMwvvwBh6NnEc26GR7EusUxq6iBwr2GsCrHjkeVB1EBy27oJOEfVYM2m10OcDYWB
         dtUfkqXDmdUIhGCHOg7La8Vx3V2wjqRocz1h41G5dbXkJKlU4pUWYACHZZk25/mXVJgS
         iOe73OZI0tmIx0l26Xxl7DxAaxKmoxyXZ0s8h7woMJTxeDsPLgv2V+MC2aZhNHCl2IvP
         kqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701793275; x=1702398075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmAkQb/1MroERVIyIw0Fp7+C3+mpW6FbekfkXqQHOdM=;
        b=qsQVBFyxFcSm1PrKEeo1vGE3WJxSIxGbfuDMig3RpQyIsdYMBD7g9956P3D6nzCHJD
         PNauBqqXUiuO7enx2D0Jec1keE69Exp54EZ+PfMkUclnYrhST5F168B8L1O8RlRjtkbx
         f8xvBVJPn09hYum1SFqfPQx9VtJQxUzyZTXNrvPz5pj9Q67sVKtGRtuhOwnm3sG8NcGx
         DKEig6fLE7ATZT1JkaNdX6lo9MC2e0o0RN2NSPBHuPWyppRpAy6AnWKoR6VdegmhPvC5
         cUU+OjOGSOkgakmbYel6cZKAc+H03bNXTCMr7iyaeXp4HAgwJVPlbtLwxqqS0uDvk9Ns
         sGJA==
X-Gm-Message-State: AOJu0Yz6pfg/zDauGHeLTFXLe6pdwkGqXsetx9bOvcU7eysae3Fr6c7V
        Cay2aCQj4BVIJGAsnF90VVjYZCabFmUCWiYzNguVGQ==
X-Google-Smtp-Source: AGHT+IFKdDeq0ZdVTclJaBsMXkTDIpAHb7IkgfNh+LabXJK2B4KIqFMn7aJn4bBqzsCyBRaPx1Kd+vEDBP9x2g3onY0=
X-Received: by 2002:a05:6122:90e:b0:4ac:2316:5afa with SMTP id
 j14-20020a056122090e00b004ac23165afamr4338177vka.12.1701793275028; Tue, 05
 Dec 2023 08:21:15 -0800 (PST)
MIME-Version: 1.0
References: <20231205031531.426872356@linuxfoundation.org>
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Dec 2023 21:51:03 +0530
Message-ID: <CA+G9fYt4DSUQA-zcuZUxVnoSx+DUo0ZB1sX=d2SSwBaD0s_a+w@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/107] 6.1.66-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2023 at 08:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.66-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Powerpc, s390 and riscv allmodconfig failed on stable-rc linux-6.1.y

 - s390: gcc-13-allmodconfig: FAILED
 - Powerpc: gcc-13-allmodconfig: FAILED
 - riscv: gcc-13-allmodconfig: FAILED

S390 build error:
arch/s390/mm/page-states.c:198:23: error: 'invalid_pg_dir' undeclared
(first use in this function); did you mean 'is_valid_bugaddr'?
  page = virt_to_page(&invalid_pg_dir);
                       ^~~~~~~~~~~~~~

s390/cmma: fix handling of swapper_pg_dir and invalid_pg_dir
 [ Upstream commit 84bb41d5df48868055d159d9247b80927f1f70f9 ]


Powerpc build error:
arch/powerpc/platforms/pseries/iommu.c:926:28: error: 'struct dma_win'
has no member named 'direct'
    *direct_mapping = window->direct;
                            ^~

powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping
for SR-IOV device
 [ Upstream commit 3bf983e4e93ce8e6d69e9d63f52a66ec0856672e ]


riscv: gcc-13-allmodconfig: FAILED

drivers/perf/riscv_pmu_sbi.c: In function 'pmu_sbi_ovf_handler':
drivers/perf/riscv_pmu_sbi.c:582:40: error: 'riscv_pmu_irq_num'
undeclared (first use in this function); did you mean 'riscv_pmu_irq'?
  582 |                 csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
      |                                        ^~~~~~~~~~~~~~~~~

drivers: perf: Check find_first_bit() return value
 [ Upstream commit c6e316ac05532febb0c966fa9b55f5258ed037be ]


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2Z6hXBQ5SQY07zKJyG6c3B1W9M0/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/2Z6hXGJFTdSPKZSutAt0vOOcDd1
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.65-108-gc1e513337d8b/testrun/21509082/suite/build/test/gcc-13-allmodconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.65-108-gc1e513337d8b/testrun/21509040/suite/build/test/gcc-13-allmodconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.65-108-gc1e513337d8b/testrun/21509172/suite/build/test/gcc-13-allmodconfig/history/

--
Linaro LKFT
https://lkft.linaro.org
