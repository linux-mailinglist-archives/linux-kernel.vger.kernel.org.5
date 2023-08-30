Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B151278E379
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243362AbjH3Xso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239883AbjH3Xsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:48:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C83ECFF;
        Wed, 30 Aug 2023 16:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 012B7B8201D;
        Wed, 30 Aug 2023 20:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AEADC433CB;
        Wed, 30 Aug 2023 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693427428;
        bh=J99XxASS8MmKe2/gO43aMZ+Un5+TXB8wEPpwOaGhpCQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=r4k6u8fm3WK2aKVWG3uAITlLCq8SU1Ei8fX9yVN2vSq3Mv3l6LkTBe4YD2auhKTHU
         YtjEkoKcRGiHBWg43z78GDBRZDcqF9xTOWNkec80MD0j0Oixa0QEVWpoh38DC6VNjl
         FzH7V64THeRo8cwNfGcUmV+Ijlg3lpg8SbrFCrx1ZfwD7H5E4IF0RF6IKrNGGt5mMw
         jpe/kAie9i2uwVorQFk7mXSLVn8pqpMdewJ9hvjrK6KjUixgAeT8KuYPCiUdX76vk3
         F4hfDl2tLLpW/Z0Y+DGq/AZJl0zT3n+oKXEbe54u2jTI/MkejD+a8wPswd0czLiw5+
         Qmk/QZi42dx4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F9FCE29F3A;
        Wed, 30 Aug 2023 20:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] RISC-V: Probe for misaligned access speed
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169342742851.1913.116474602408550824.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Aug 2023 20:30:28 +0000
References: <20230818194136.4084400-1-evan@rivosinc.com>
In-Reply-To: <20230818194136.4084400-1-evan@rivosinc.com>
To:     Evan Green <evan@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        rdunlap@infradead.org, heiko@sntech.de, linux-doc@vger.kernel.org,
        bjorn@rivosinc.com, conor.dooley@microchip.com, guoren@kernel.org,
        jszhang@kernel.org, samuel@sholland.org,
        jeeheng.sia@starfivetech.com, maz@kernel.org, masahiroy@kernel.org,
        greentime.hu@sifive.com, shosie@rivosinc.com,
        ajones@ventanamicro.com, aou@eecs.berkeley.edu,
        alexghiti@rivosinc.com, leyfoon.tan@starfivetech.com,
        paul.walmsley@sifive.com, apatel@ventanamicro.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, xianting.tian@linux.alibaba.com,
        David.Laight@aculab.com, palmer@dabbelt.com, andy.chiu@sifive.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 18 Aug 2023 12:41:34 -0700 you wrote:
> The current setting for the hwprobe bit indicating misaligned access
> speed is controlled by a vendor-specific feature probe function. This is
> essentially a per-SoC table we have to maintain on behalf of each vendor
> going forward. Let's convert that instead to something we detect at
> runtime.
> 
> We have two assembly routines at the heart of our probe: one that
> does a bunch of word-sized accesses (without aligning its input buffer),
> and the other that does byte accesses. If we can move a larger number of
> bytes using misaligned word accesses than we can with the same amount of
> time doing byte accesses, then we can declare misaligned accesses as
> "fast".
> 
> [...]

Here is the summary with links:
  - [v4,1/2] RISC-V: Probe for unaligned access speed
    https://git.kernel.org/riscv/c/b98673c5b037
  - [v4,2/2] RISC-V: alternative: Remove feature_probe_func
    https://git.kernel.org/riscv/c/b6e3f6e009a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


