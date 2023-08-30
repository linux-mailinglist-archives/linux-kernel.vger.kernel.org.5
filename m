Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D339C78DD93
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245155AbjH3Sv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244384AbjH3NHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:07:14 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83909194;
        Wed, 30 Aug 2023 06:07:08 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qbKuS-0005EG-Bb; Wed, 30 Aug 2023 15:07:00 +0200
Message-ID: <527df158-7d32-42ba-d5f1-9dad30704cc1@leemhuis.info>
Date:   Wed, 30 Aug 2023 15:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mainline build failure due to c8171a86b274 ("csky: Fixup
 -Wmissing-prototypes warning")
Content-Language: en-US, de-DE
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Oleg Nesterov <oleg@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
References: <ZO8qkS0Skg9L4xzr@debian>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZO8qkS0Skg9L4xzr@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693400828;a4a70b60;
X-HE-SMSGID: 1qbKuS-0005EG-Bb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.23 13:40, Sudip Mukherjee (Codethink) wrote:
> 
> The latest mainline kernel branch fails to build csky allmodconfig with
> the error:

Thx for the report and involving regzbot. To make one thing more obvious:

Guo Ren, it seems to be caused by a commit of yours.

And fun fact: seem 0day bot found the same problem nearly thee weeks
ago, but nobody cared afaics:
https://lore.kernel.org/all/202308120502.MXpchFC1-lkp@intel.com/

Ciao, Thorsten

> In file included from ./arch/csky/include/asm/ptrace.h:7,
>                  from ./arch/csky/include/asm/processor.h:8,
>                  from ./include/linux/prefetch.h:15,
>                  from drivers/net/ethernet/intel/i40e/i40e_txrx.c:4:
> ./arch/csky/include/asm/traps.h:43:11: error: expected ';' before 'void'
>    43 | asmlinkage void do_trap_unknown(struct pt_regs *regs);
>       |           ^~~~~
>       |           ;
> ./arch/csky/include/asm/traps.h:44:11: error: expected ';' before 'void'
>    44 | asmlinkage void do_trap_zdiv(struct pt_regs *regs);
>       |           ^~~~~
>       |           ;
> ./arch/csky/include/asm/traps.h:45:11: error: expected ';' before 'void'
>    45 | asmlinkage void do_trap_buserr(struct pt_regs *regs);
>       |           ^~~~~
>       |           ;
> ./arch/csky/include/asm/traps.h:46:11: error: expected ';' before 'void'
>    46 | asmlinkage void do_trap_misaligned(struct pt_regs *regs);
>       |           ^~~~~
>       |           ;
> ./arch/csky/include/asm/traps.h:47:11: error: expected ';' before 'void'
>    47 | asmlinkage void do_trap_bkpt(struct pt_regs *regs);
>       |           ^~~~~
>       |           ;
> ./arch/csky/include/asm/traps.h:48:11: error: expected ';' before 'void'
>    48 | asmlinkage void do_trap_illinsn(struct pt_regs *regs);
>       |           ^~~~~
>       |           ;
> ./arch/csky/include/asm/traps.h:49:11: error: expected ';' before 'void'
>    49 | asmlinkage void do_trap_fpe(struct pt_regs *regs);
>       |           ^~~~~
>       |           ;
> ./arch/csky/include/asm/traps.h:50:11: error: expected ';' before 'void'
>    50 | asmlinkage void do_trap_priv(struct pt_regs *regs);
>       |           ^~~~~
>       |           ;
> ./arch/csky/include/asm/traps.h:51:11: error: expected ';' before 'void'
>    51 | asmlinkage void trap_c(struct pt_regs *regs);
>       |           ^~~~~
>       |           ;
> ./arch/csky/include/asm/traps.h:53:11: error: expected ';' before 'void'
>    53 | asmlinkage void do_notify_resume(struct pt_regs *regs,
>       |           ^~~~~
>       |           ;
> In file included from ./arch/csky/include/asm/processor.h:8,
>                  from ./include/linux/prefetch.h:15,
>                  from drivers/net/ethernet/intel/i40e/i40e_txrx.c:4:
> ./arch/csky/include/asm/ptrace.h:99:11: error: expected ';' before 'int'
>    99 | asmlinkage int syscall_trace_enter(struct pt_regs *regs);
>       |           ^~~~
>       |           ;
> ./arch/csky/include/asm/ptrace.h:100:11: error: expected ';' before 'void'
>   100 | asmlinkage void syscall_trace_exit(struct pt_regs *regs);
>       |           ^~~~~
>       |           ;
> 
> git bisect pointed to c8171a86b274 ("csky: Fixup -Wmissing-prototypes warning").
> 
> Reverting the commit has fixed the build failure.
> 
> I will be happy to test any patch or provide any extra log if needed.
> 
> #regzbot introduced: c8171a86b27401aa1f492dd1f080f3102264f1ab

#regzbot monitor:
https://lore.kernel.org/all/202308120502.MXpchFC1-lkp@intel.com/
