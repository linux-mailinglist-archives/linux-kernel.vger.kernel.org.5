Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9717BDF7B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377051AbjJINaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376901AbjJINa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:30:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AEAB7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:30:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1135BC433CB;
        Mon,  9 Oct 2023 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696858226;
        bh=C39SPpzW99vurbXbnnvIqZlQvyv6UcGtJqYlt3AsiaU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KXDAW8bqXCIGms7jk5QAOFHZd2FZbviViTXgR5WMHGGl8Qxd5MXTHhJGS+27kOzC2
         vXuPUOi3QVwJWRBH87coO+uUp8ifGFD4thAJoTtyxwxck3Bgg+mwPR1YB35rPl7C/5
         ypRUmyLRSuwc4CWpa7XVXIQWrVsr03NMXAcXA6Tja6liZGY2BDou003VnYJd6FMnvx
         Qd+tmyXnPR5oB36DVJqOVqi4+P/pg4QEoYnMpgjW0e/xrV8LAznH+c1kf48cC8xgyd
         TvxBmz/OB7BeZUwCdUksPIw+wvpSjV6CSyn9lYh94ocSq30j4VsWlpslNzE8hThmf0
         ruAWACqdmhm0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7E12E11F46;
        Mon,  9 Oct 2023 13:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/2] riscv, bpf: Properly sign-extend return values
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169685822594.15728.14523871698572342357.git-patchwork-notify@kernel.org>
Date:   Mon, 09 Oct 2023 13:30:25 +0000
References: <20231004120706.52848-1-bjorn@kernel.org>
In-Reply-To: <20231004120706.52848-1-bjorn@kernel.org>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@ci.codeaurora.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org, pulehui@huawei.com,
        bjorn@rivosinc.com, linux-kernel@vger.kernel.org,
        luke.r.nels@gmail.com, xi.wang@gmail.com,
        linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  4 Oct 2023 14:07:04 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> The RISC-V architecture does not expose sub-registers, and hold all
> 32-bit values in a sign-extended format [1] [2]:
> 
>   | The compiler and calling convention maintain an invariant that all
>   | 32-bit values are held in a sign-extended format in 64-bit
>   | registers. Even 32-bit unsigned integers extend bit 31 into bits
>   | 63 through 32. Consequently, conversion between unsigned and
>   | signed 32-bit integers is a no-op, as is conversion from a signed
>   | 32-bit integer to a signed 64-bit integer.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] riscv, bpf: Sign-extend return values
    https://git.kernel.org/bpf/bpf/c/2f1b0d3d7331
  - [bpf,2/2] riscv, bpf: Track both a0 (RISC-V ABI) and a5 (BPF) return values
    https://git.kernel.org/bpf/bpf/c/7112cd26e606

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


