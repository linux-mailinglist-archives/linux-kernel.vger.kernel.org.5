Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D39F787144
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241534AbjHXOPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbjHXOPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:15:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E031311F;
        Thu, 24 Aug 2023 07:15:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E86466D89;
        Thu, 24 Aug 2023 14:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CC1C433CA;
        Thu, 24 Aug 2023 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692886519;
        bh=3Wqno6RgI+vOlKjniGktCHYNmHd4A0HX3224LcWaxSI=;
        h=From:To:Cc:Subject:Date:From;
        b=EJXvIoKjzerkEaWFcbMx//3QE+fbT1XiRG6LQbCOFvWl5GL8HOTjIKzxnTxn2Wq8c
         tCInKx3l2mfe9N+dRVCE1I42Aqhn+c/nTRyRylI+4eL97LVV77HLUgeHJcutPeEM6Y
         RhLxrqWAfFyabbJ7HxbUqGKMJcpksjkqI8HEjKX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.1 00/15] 6.1.48-rc1 review
Date:   Thu, 24 Aug 2023 16:14:56 +0200
Message-ID: <20230824141447.155846739@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.48-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.48-rc1
X-KernelTest-Deadline: 2023-08-26T14:14+00:00
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.1.48 release.
There are 15 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.48-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.48-rc1

Borislav Petkov (AMD) <bp@alien8.de>
    x86/srso: Correct the mitigation status when SMT is disabled

Peter Zijlstra <peterz@infradead.org>
    objtool/x86: Fixup frame-pointer vs rethunk

Petr Pavlu <petr.pavlu@suse.com>
    x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG

Borislav Petkov (AMD) <bp@alien8.de>
    x86/srso: Disable the mitigation on unaffected configurations

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Fix the DIV(0) initial fix attempt

Sean Christopherson <seanjc@google.com>
    x86/retpoline: Don't clobber RFLAGS during srso_safe_ret()

Peter Zijlstra <peterz@infradead.org>
    x86/static_call: Fix __static_call_fixup()

Borislav Petkov (AMD) <bp@alien8.de>
    x86/srso: Explain the untraining sequences a bit more

Peter Zijlstra <peterz@infradead.org>
    x86/cpu: Cleanup the untrain mess

Peter Zijlstra <peterz@infradead.org>
    x86/cpu: Rename srso_(.*)_alias to srso_alias_\1

Peter Zijlstra <peterz@infradead.org>
    x86/cpu: Rename original retbleed methods

Peter Zijlstra <peterz@infradead.org>
    x86/cpu: Clean up SRSO return thunk mess

Peter Zijlstra <peterz@infradead.org>
    x86/alternative: Make custom return thunk unconditional

Peter Zijlstra <peterz@infradead.org>
    x86/cpu: Fix up srso_safe_ret() and __x86_return_thunk()

Peter Zijlstra <peterz@infradead.org>
    x86/cpu: Fix __x86_return_thunk symbol type


-------------

Diffstat:

 Documentation/admin-guide/hw-vuln/srso.rst |   4 +-
 Makefile                                   |   4 +-
 arch/x86/include/asm/entry-common.h        |   1 +
 arch/x86/include/asm/nospec-branch.h       |  28 +++---
 arch/x86/kernel/cpu/amd.c                  |   1 +
 arch/x86/kernel/cpu/bugs.c                 |  28 +++++-
 arch/x86/kernel/static_call.c              |  13 +++
 arch/x86/kernel/traps.c                    |   2 -
 arch/x86/kernel/vmlinux.lds.S              |  20 ++--
 arch/x86/kvm/svm/svm.c                     |   2 +
 arch/x86/lib/retpoline.S                   | 141 ++++++++++++++++++++---------
 tools/objtool/arch/x86/decode.c            |   2 +-
 tools/objtool/check.c                      |  21 +++--
 13 files changed, 182 insertions(+), 85 deletions(-)


