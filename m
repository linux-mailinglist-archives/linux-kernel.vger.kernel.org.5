Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA6B7F861F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjKXWZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjKXWZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:25:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3852D10E2;
        Fri, 24 Nov 2023 14:25:49 -0800 (PST)
Date:   Fri, 24 Nov 2023 23:25:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700864747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pjK//es4pOpFFz/bh43rjOi9YkWqlRYW7jAMIvjvv2I=;
        b=AYA5haNcxStID8qNnIP60oq9ZWsVawqG/G7RWvfx8pl5kk3/tIol0ZQnIP5roBZuxpaECJ
        gUQXQWvMPYAgqV8KIHhdcWyhFF+lihuu3Y2bLhKIxcr6FRmA825Id3coA6aPVHHpNPagFR
        RjfugoX62E3ntizsCCvoz2T3MR74siWPNiuCUXdv4886B2MwL3PsyLY4TXN++hrOqOFW0Z
        00Jk82nStq9LJYLebRj136OQn080w5zIVbcJuJOY4wQfc+2XksOk+5toIhJ8tvMu/QzhKs
        yqGyjVhn+XRQWdrwk81Y23BXVHHBrds1yyZdnkRaeRE0bMQQrNUKrSUi+UHrow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700864747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pjK//es4pOpFFz/bh43rjOi9YkWqlRYW7jAMIvjvv2I=;
        b=aTAVhNbUuzcvwaX63Q+Wx5HCkg60jz8hNEUdFm0HdKPcIu5Xalwtg8zmp+XsEgoWgDe8p8
        pR8VXDABHlF6t+Cg==
From:   Nam Cao <namcao@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 000/372] 6.1.64-rc1 review
Message-ID: <20231124222543.qaM-plhi@linutronix.de>
References: <20231124172010.413667921@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 05:46:27PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.64 release.
> There are 372 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.64-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

I got the following build error with riscv64 defconfig:

  CC      drivers/perf/riscv_pmu_sbi.o
In file included from /home/namcao/linux-deb/linux/arch/riscv/include/asm/ptrace.h:10,
                 from /home/namcao/linux-deb/linux/arch/riscv/include/uapi/asm/bpf_perf_event.h:5,
                 from /home/namcao/linux-deb/linux/include/uapi/linux/bpf_perf_event.h:11,
                 from /home/namcao/linux-deb/linux/include/linux/perf_event.h:18,
                 from /home/namcao/linux-deb/linux/include/linux/perf/riscv_pmu.h:12,
                 from /home/namcao/linux-deb/linux/drivers/perf/riscv_pmu_sbi.c:14:
/home/namcao/linux-deb/linux/drivers/perf/riscv_pmu_sbi.c: In function ‘pmu_sbi_ovf_handler’:
/home/namcao/linux-deb/linux/drivers/perf/riscv_pmu_sbi.c:582:40: error: ‘riscv_pmu_irq_num’ undeclared (first use in this function); did you mean ‘riscv_pmu_irq’?
  582 |                 csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
      |                                        ^~~~~~~~~~~~~~~~~
/home/namcao/linux-deb/linux/arch/riscv/include/asm/csr.h:400:45: note: in definition of macro ‘csr_clear’
  400 |         unsigned long __v = (unsigned long)(val);               \
      |                                             ^~~
/home/namcao/linux-deb/linux/drivers/perf/riscv_pmu_sbi.c:582:36: note: in expansion of macro ‘BIT’
  582 |                 csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
      |                                    ^~~
/home/namcao/linux-deb/linux/drivers/perf/riscv_pmu_sbi.c:582:40: note: each undeclared identifier is reported only once for each function it appears in
  582 |                 csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
      |                                        ^~~~~~~~~~~~~~~~~
/home/namcao/linux-deb/linux/arch/riscv/include/asm/csr.h:400:45: note: in definition of macro ‘csr_clear’
  400 |         unsigned long __v = (unsigned long)(val);               \
      |                                             ^~~
/home/namcao/linux-deb/linux/drivers/perf/riscv_pmu_sbi.c:582:36: note: in expansion of macro ‘BIT’
  582 |                 csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
      |                                    ^~~


Best regards,
Nam
