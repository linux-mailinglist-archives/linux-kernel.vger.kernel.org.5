Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1541B7894E8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 10:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjHZIpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 04:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjHZIpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 04:45:30 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4E5213A;
        Sat, 26 Aug 2023 01:45:27 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so24365781fa.2;
        Sat, 26 Aug 2023 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693039525; x=1693644325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBPeLGUAtVO0USbU1Yk7uoBTmd4OjEFwwRL+82RfIoU=;
        b=I+hNkSebw7bIjmSdswc4ETvWrfjQhIqqY+AzDHmp9zFCeMNWaVgsoY8i/SRQOvrGuV
         b3JnxqtDDyzX2Kt1PThI2M905f+tlLAY0nyXfocWLTW/OEDyW9R8OXLDjOHpNv7g+ewS
         DAypWh0w7Q/Z0Jbn/x65RVdMo+UHYQpplrP8u7k+iEjxRxHnNuyuWmXJLl0zdyrte9Ed
         q48hqzmZCvbqXi2nSNObFJjihjdATpkFNl77hVfruJ2tTYjItUzggpQ0lNXVoBjZ4h0u
         nUrfd2YP9SS84IuSp/IaK2ZSGFPf1dAOwCcnkGEEGhAg5iLIge4tAkaWXELqT/l+vXvW
         uLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693039525; x=1693644325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBPeLGUAtVO0USbU1Yk7uoBTmd4OjEFwwRL+82RfIoU=;
        b=RjAUtFScX72dp7k9Tr0QodLmM2oYXJAK0dylkQd6tuX+11bDxBPR5QFYoqizR0KYQx
         3rh44+nM2jCyQ4sNF0kv/B+23DwHB+114dG1xp82FqEeDnNVmx6Q7wq0CWtphnatabNS
         ps94fhShCY/igKoD/qmNs91UMrer9n9AteyJU/uih7f/VnncB40o+z+ovoOMxz+ib/xF
         bBCdHRc66uJKEz3s2/1nGBWmDaWNDlhXT+igsSDJz1IW3xUm3wnL34S2X3CAGrEj5+nE
         o7v+jej/kPSNTbEkiqFV7CB9itqq92U/6JAuMU08Kq6pereWXG9Rju0GZjOdOr6Ok3gF
         YQGQ==
X-Gm-Message-State: AOJu0YxN5Sde4Rz4owYHkeZURzsPYMJ+yAACdRbEBvKHzwhItBm3Fpgm
        YI2cvrA81ILHYW83bj3yZNw=
X-Google-Smtp-Source: AGHT+IHJ5zcjFrIN0QeJxxkD/ZHmLjGuxoaGhiieRGHGeCha2xLp4jN/svXjDeyG9xlQkN75QRRrZg==
X-Received: by 2002:a2e:9e09:0:b0:2b6:dac0:affe with SMTP id e9-20020a2e9e09000000b002b6dac0affemr15375800ljk.31.1693039525121;
        Sat, 26 Aug 2023 01:45:25 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id y24-20020a1c4b18000000b003fc01189b0dsm4306875wma.42.2023.08.26.01.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 01:45:23 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id E5A50BE2DE0; Sat, 26 Aug 2023 10:45:22 +0200 (CEST)
Date:   Sat, 26 Aug 2023 10:45:22 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, peterz@infradead.org
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
Message-ID: <ZOm7oqwTJiVW6Uvu@eldamar.lan>
References: <20230824141447.155846739@linuxfoundation.org>
 <ZOhz4/8Q8XjIqpCy@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOhz4/8Q8XjIqpCy@debian>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
On Fri, Aug 25, 2023 at 10:26:59AM +0100, Sudip Mukherjee (Codethink) wrote:
> Hi Greg,
> 
> On Thu, Aug 24, 2023 at 04:14:56PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.48 release.
> > There are 15 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> > Anything received after that time might be too late.
> 
> Build test (gcc version 12.3.1 20230625):
> mips: 52 configs -> no failure
> arm: 100 configs -> no failure
> arm64: 3 configs -> no failure
> x86_64: 4 configs -> no failure
> alpha allmodconfig -> no failure
> csky allmodconfig -> no failure
> powerpc allmodconfig -> no failure
> riscv allmodconfig -> no failure
> s390 allmodconfig -> no failure
> xtensa allmodconfig -> no failure
> 
> Boot test:
> x86_64: Booted on my test laptop. Warning on boot.
> x86_64: Booted on qemu. Warning on boot. [1]
> arm64: Booted on rpi4b (4GB model). No regression. [2]
> mips: Booted on ci20 board. No regression. [3]
> 
> [1]. https://openqa.qa.codethink.co.uk/tests/4787
> [2]. https://openqa.qa.codethink.co.uk/tests/4796
> [3]. https://openqa.qa.codethink.co.uk/tests/4795
> 
> Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> 
> 
> [    0.154501] ------------[ cut here ]------------
> [    0.154505] missing return thunk: __alt_instructions_end+0x21b2/0x21d0-srso_untrain_ret+0x0/0x2: e9 17 81 f8 fe
> [    0.154517] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:572 apply_returns+0x1cb/0x200
> [    0.154524] Modules linked in:
> [    0.154526] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.48-rc1-c079d0dd788a+ #1
> [    0.154529] Hardware name: LENOVO 4287CTO/4287CTO, BIOS 8DET68WW (1.38 ) 04/11/2013
> [    0.154531] RIP: 0010:apply_returns+0x1cb/0x200
> [    0.154534] Code: 5b 01 00 0f 85 0b ff ff ff 49 89 e8 b9 05 00 00 00 4c 89 f2 48 89 ee 48 c7 c7 38 16 4f b8 c6 05 f5 d1 5b 01 01 e8 85 8e 05 00 <0f> 0b e9 e3 fe ff ff c7 84 24 81 00 00 00 cc cc cc cc 42 c7 44 38
> [    0.154536] RSP: 0000:ffffffffb8803e30 EFLAGS: 00010282
> [    0.154539] RAX: 0000000000000000 RBX: ffffffffb906d7b4 RCX: 0000000000000000
> [    0.154541] RDX: 0000000000000003 RSI: 0000000000004ffb RDI: 00000000ffffffff
> [    0.154542] RBP: ffffffffb9079962 R08: 0000000000000000 R09: 00000000ffffefff
> [    0.154544] R10: ffffffffb8803cc0 R11: ffffffffb88cc1e8 R12: ffffffffb906d7d4
> [    0.154545] R13: cccccccccccccccc R14: ffffffffb8001a7e R15: 0000000000000004
> [    0.154547] FS:  0000000000000000(0000) GS:ffff936dd6200000(0000) knlGS:0000000000000000
> [    0.154549] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.154551] CR2: ffff936dde5ff000 CR3: 000000013b40a001 CR4: 00000000000606f0
> [    0.154553] Call Trace:
> [    0.154556]  <TASK>
> [    0.154559]  ? __warn+0x79/0xc0
> [    0.154565]  ? apply_returns+0x1cb/0x200
> [    0.154567]  ? report_bug+0xee/0x170
> [    0.154572]  ? prb_read_valid+0x17/0x20
> [    0.154578]  ? handle_bug+0x42/0x70
> [    0.154581]  ? exc_invalid_op+0x14/0x70
> [    0.154583]  ? asm_exc_invalid_op+0x16/0x20
> [    0.154586]  ? retbleed_return_thunk+0x7e/0x7e
> [    0.154591]  ? apply_returns+0x1cb/0x200
> [    0.154594]  ? apply_retpolines+0x1f5/0x2c0
> [    0.154598]  alternative_instructions+0x4d/0xfc
> [    0.154604]  arch_cpu_finalize_init+0x28/0x47
> [    0.154607]  start_kernel+0x66c/0x70e
> [    0.154612]  secondary_startup_64_no_verify+0xce/0xdb
> [    0.154618]  </TASK>
> [    0.154619] ---[ end trace 0000000000000000 ]---

Seeing this as well, but see some context in the thread in the
previous cycle (where then those patches were not included);

https://lore.kernel.org/stable/2023082212-pregnant-lizard-80e0@gregkh/

Apart for the above regression, no other regressions spotted. 

Tested-by: Salvatore Bonaccorso <carnil@debian.org> 

Regards,
Salvatore
