Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124C97DFB67
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjKBUUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjKBUUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:20:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE887D67
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 13:20:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83A3BC433C8;
        Thu,  2 Nov 2023 20:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698956430;
        bh=HVj+Q5gWy9MekQe/rtqFld2BFOsZW6hBXf8kTSaTucM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NIrTMaAFDU3yln3xrYTrgfd5aZiLkFgShBQJhoAzuVqRSTp76a0JsPlTQR/HKhd6o
         HnEWZSV3+xtUBBWwfHF7Z1eaZgf1QZpOK+vpwxkUpnuslmmqRZROH4GL+mlpWqE/Su
         DPRA6yoWPuVfPM22g3i0EO/T/2fE1ehvvr4D4KXCg5VlImxZh5M+c6JbhZtZKUxSIA
         cwvnVBbADp7KXA0W4BwO/GFydP6xw1DJtgGSEyjEO9HZj9WN90oPKRCCRsjPHWC55r
         36R44ci9EdAcmQNt6k4ig32cB/Kg1wp8+wlUXTRu9zEHuEmxfYqA6ODbjpjw6H54od
         twLONEAGtqw8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67951C4316B;
        Thu,  2 Nov 2023 20:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/8] Add support to handle misaligned accesses in S-mode
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169895643042.22248.9341176488317872120.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Nov 2023 20:20:30 +0000
References: <20231004151405.521596-1-cleger@rivosinc.com>
In-Reply-To: <20231004151405.521596-1-cleger@rivosinc.com>
To:     =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@ci.codeaurora.org
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, atishp@rivosinc.com,
        ajones@ventanamicro.com, evan@rivosinc.com, bjorn@rivosinc.com,
        linux-kernel@vger.kernel.org, rminnich@gmail.com,
        cyrevolt@googlemail.com, conor@kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  4 Oct 2023 17:13:57 +0200 you wrote:
> Since commit 61cadb9 ("Provide new description of misaligned load/store
> behavior compatible with privileged architecture.") in the RISC-V ISA
> manual, it is stated that misaligned load/store might not be supported.
> However, the RISC-V kernel uABI describes that misaligned accesses are
> supported. In order to support that, this series adds support for S-mode
> handling of misaligned accesses as well support for prctl(PR_UNALIGN).
> 
> [...]

Here is the summary with links:
  - [v2,1/8] riscv: remove unused functions in traps_misaligned.c
    https://git.kernel.org/riscv/c/f19c3b4239f5
  - [v2,2/8] riscv: add support for misaligned trap handling in S-mode
    https://git.kernel.org/riscv/c/7c83232161f6
  - [v2,3/8] riscv: report perf event for misaligned fault
    https://git.kernel.org/riscv/c/89c12fecdc4d
  - [v2,4/8] riscv: add floating point insn support to misaligned access emulation
    https://git.kernel.org/riscv/c/7c586a555a48
  - [v2,5/8] riscv: add support for sysctl unaligned_enabled control
    https://git.kernel.org/riscv/c/bc38f61313d3
  - [v2,6/8] riscv: annotate check_unaligned_access_boot_cpu() with __init
    https://git.kernel.org/riscv/c/90b11b470b2e
  - [v2,7/8] riscv: report misaligned accesses emulation to hwprobe
    https://git.kernel.org/riscv/c/71c54b3d169d
  - [v2,8/8] riscv: add support for PR_SET_UNALIGN and PR_GET_UNALIGN
    https://git.kernel.org/riscv/c/9f23a5d2f6b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


