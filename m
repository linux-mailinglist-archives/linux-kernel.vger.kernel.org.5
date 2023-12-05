Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50AB805DC9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346305AbjLES1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbjLES04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:26:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229E7D5A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:26:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22905C433C8;
        Tue,  5 Dec 2023 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701800810;
        bh=2mfKanFkogJhg5GS7uiih9vRq6rMLvZxLLzKfDwTSOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eq5ubZJbG/oYLlDsgWMVhqwLT4MqfFyl2rhcyPFp8R4r5HlFMWb4FplGLSbxUaZYF
         8cOCvV/yeseq8r9qtQiCtVztE2UqpaKTWFylx0H/0m9u9EUiy/IA1CAQlM5M6EzyLx
         jFuZuQ/JnhO44O94KKn2R0OlQM28Rie5EwS6fnZg=
Date:   Wed, 6 Dec 2023 03:26:47 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/107] 6.1.66-rc1 review
Message-ID: <2023120628-reprint-coronary-ba73@gregkh>
References: <20231205031531.426872356@linuxfoundation.org>
 <CA+G9fYt4DSUQA-zcuZUxVnoSx+DUo0ZB1sX=d2SSwBaD0s_a+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYt4DSUQA-zcuZUxVnoSx+DUo0ZB1sX=d2SSwBaD0s_a+w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:51:03PM +0530, Naresh Kamboju wrote:
> On Tue, 5 Dec 2023 at 08:59, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.1.66 release.
> > There are 107 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.66-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Powerpc, s390 and riscv allmodconfig failed on stable-rc linux-6.1.y
> 
>  - s390: gcc-13-allmodconfig: FAILED
>  - Powerpc: gcc-13-allmodconfig: FAILED
>  - riscv: gcc-13-allmodconfig: FAILED
> 
> S390 build error:
> arch/s390/mm/page-states.c:198:23: error: 'invalid_pg_dir' undeclared
> (first use in this function); did you mean 'is_valid_bugaddr'?
>   page = virt_to_page(&invalid_pg_dir);
>                        ^~~~~~~~~~~~~~
> 
> s390/cmma: fix handling of swapper_pg_dir and invalid_pg_dir
>  [ Upstream commit 84bb41d5df48868055d159d9247b80927f1f70f9 ]
> 
> 
> Powerpc build error:
> arch/powerpc/platforms/pseries/iommu.c:926:28: error: 'struct dma_win'
> has no member named 'direct'
>     *direct_mapping = window->direct;
>                             ^~
> 
> powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping
> for SR-IOV device
>  [ Upstream commit 3bf983e4e93ce8e6d69e9d63f52a66ec0856672e ]
> 
> 
> riscv: gcc-13-allmodconfig: FAILED
> 
> drivers/perf/riscv_pmu_sbi.c: In function 'pmu_sbi_ovf_handler':
> drivers/perf/riscv_pmu_sbi.c:582:40: error: 'riscv_pmu_irq_num'
> undeclared (first use in this function); did you mean 'riscv_pmu_irq'?
>   582 |                 csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
>       |                                        ^~~~~~~~~~~~~~~~~
> 
> drivers: perf: Check find_first_bit() return value
>  [ Upstream commit c6e316ac05532febb0c966fa9b55f5258ed037be ]

Thanks, all should now be dropped.  I'll push out new -rc releases in a
bit...

greg k-h
