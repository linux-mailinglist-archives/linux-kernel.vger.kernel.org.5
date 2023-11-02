Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BD67DFB68
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbjKBUU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjKBUUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:20:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E41D6D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 13:20:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B03A8C433CD;
        Thu,  2 Nov 2023 20:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698956430;
        bh=LJ143qQumSwJ+frQ2lgaKZNiAUVef0ohgDMpkllbi6c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sop1YtMvm+UqaKpq81oh8SDoseVahc+Y5vvsVVe+fQcl0QiuMLCeJj5mrAcC3YJ1i
         UsP6zD+a/6Or5rMI5kWTseDv7lmP91npEuoFZoHyWxNgbujJ7F7oDMJWrSkaUj599d
         7C9W1uANcMrrRcsdAkHAjXdDOBPSu/hHIr6TSfkMOK0zPq1KtuAHQmeq2/ZpsIxU6g
         +EGzHUpSoDhiAyC3UN7NIMQkHqFmMHUPejrCUVUXOUjvBVQC7C/3Yyfr2+iyIPUft5
         dRM24b8yDOuzYR7ayMWhIfLUVJnQl2qFzuDZhI55TTEXNs9WMoM/ygoFKNTklLWZuP
         4xhJ1695PEq9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B38DE00089;
        Thu,  2 Nov 2023 20:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] RISC-V: Probe misaligned access speed in parallel
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169895643056.22248.6956745778026886386.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Nov 2023 20:20:30 +0000
References: <20230920193801.3035093-1-evan@rivosinc.com>
In-Reply-To: <20230920193801.3035093-1-evan@rivosinc.com>
To:     Evan Green <evan@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        apatel@ventanamicro.com, aou@eecs.berkeley.edu, heiko@sntech.de,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        conor.dooley@microchip.com, David.Laight@aculab.com,
        palmer@dabbelt.com, jszhang@kernel.org, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, ajones@ventanamicro.com
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

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 20 Sep 2023 12:38:01 -0700 you wrote:
> Probing for misaligned access speed takes about 0.06 seconds. On a
> system with 64 cores, doing this in smp_callin() means it's done
> serially, extending boot time by 3.8 seconds. That's a lot of boot time.
> 
> Instead of measuring each CPU serially, let's do the measurements on
> all CPUs in parallel. If we disable preemption on all CPUs, the
> jiffies stop ticking, so we can do this in stages of 1) everybody
> except core 0, then 2) core 0.
> 
> [...]

Here is the summary with links:
  - [v2] RISC-V: Probe misaligned access speed in parallel
    https://git.kernel.org/riscv/c/0c37376609da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


