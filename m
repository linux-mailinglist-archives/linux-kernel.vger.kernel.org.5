Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC997F8C0E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjKYP2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjKYP2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:28:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B67F10D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:28:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F402BC433CD;
        Sat, 25 Nov 2023 15:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700926126;
        bh=1KRaU8TeoE9R72zXc6PRzxHhQWJkjHiZQSnThUh/uXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wKxrMxyIxupNOzJYPbr7vxyQKCRFvF1GhWt/ObgAa4sCBcjvm4By+TFneQH+3vRfY
         VPh41O1aJT8Xet92ixoYidWAuyHZ/Rw7bCZWpOLc+POmkatBCvEn/f/d9zNjutTaKS
         7NEj26T1nUWT0ql+V+SIrBGpBTjCEzF4GG4Wy4Ow=
Date:   Sat, 25 Nov 2023 15:28:43 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nam Cao <namcao@linutronix.de>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 000/372] 6.1.64-rc1 review
Message-ID: <2023112529-another-defrost-0851@gregkh>
References: <20231124172010.413667921@linuxfoundation.org>
 <20231124222543.qaM-plhi@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124222543.qaM-plhi@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:25:43PM +0100, Nam Cao wrote:
> On Fri, Nov 24, 2023 at 05:46:27PM +0000, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.64 release.
> > There are 372 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.64-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> I got the following build error with riscv64 defconfig:
> 
>   CC      drivers/perf/riscv_pmu_sbi.o
> In file included from /home/namcao/linux-deb/linux/arch/riscv/include/asm/ptrace.h:10,
>                  from /home/namcao/linux-deb/linux/arch/riscv/include/uapi/asm/bpf_perf_event.h:5,
>                  from /home/namcao/linux-deb/linux/include/uapi/linux/bpf_perf_event.h:11,
>                  from /home/namcao/linux-deb/linux/include/linux/perf_event.h:18,
>                  from /home/namcao/linux-deb/linux/include/linux/perf/riscv_pmu.h:12,
>                  from /home/namcao/linux-deb/linux/drivers/perf/riscv_pmu_sbi.c:14:
> /home/namcao/linux-deb/linux/drivers/perf/riscv_pmu_sbi.c: In function ‘pmu_sbi_ovf_handler’:
> /home/namcao/linux-deb/linux/drivers/perf/riscv_pmu_sbi.c:582:40: error: ‘riscv_pmu_irq_num’ undeclared (first use in this function); did you mean ‘riscv_pmu_irq’?
>   582 |                 csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
>       |                                        ^~~~~~~~~~~~~~~~~
> /home/namcao/linux-deb/linux/arch/riscv/include/asm/csr.h:400:45: note: in definition of macro ‘csr_clear’
>   400 |         unsigned long __v = (unsigned long)(val);               \
>       |                                             ^~~
> /home/namcao/linux-deb/linux/drivers/perf/riscv_pmu_sbi.c:582:36: note: in expansion of macro ‘BIT’
>   582 |                 csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
>       |                                    ^~~
> /home/namcao/linux-deb/linux/drivers/perf/riscv_pmu_sbi.c:582:40: note: each undeclared identifier is reported only once for each function it appears in
>   582 |                 csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
>       |                                        ^~~~~~~~~~~~~~~~~
> /home/namcao/linux-deb/linux/arch/riscv/include/asm/csr.h:400:45: note: in definition of macro ‘csr_clear’
>   400 |         unsigned long __v = (unsigned long)(val);               \
>       |                                             ^~~
> /home/namcao/linux-deb/linux/drivers/perf/riscv_pmu_sbi.c:582:36: note: in expansion of macro ‘BIT’
>   582 |                 csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
>       |                                    ^~~

Should now be fixed, I'll push out a -rc2 soon to verify.

thanks,

greg k-h
