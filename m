Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552CA7762B2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjHIOk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjHIOkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2038C1FD8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B47DD63C51
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 249C1C433C7;
        Wed,  9 Aug 2023 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691592021;
        bh=i1JWSflPdqOgo9iVvVkyXxpaihCf7DdLtWvHlPRFT9k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nXtqhW3DuHCFC0CYBRT0A8Ksdmx57EAdUKTtkspK8GmQ18QMimhh8OXjQxzPrIqQC
         aK6Iu1UFsW1iimnCd2v1iF/l1uokDItgmnayW5VTy0PA/TSxIRhItHHIvUcuN0j8oe
         DmzI/qqH/yseJ1ZkYZgWl4zPQgIZQtj2jPkNL6bJVD4KTudcZrvXJ7gb6QGu+ASP2g
         4D/L9+omdNEksx+UceML5emstl/+WpeYzzT3wIRQsISzgHfQkA2SblXdKCln/IjC1B
         RUIMrxhO12Lc7ZCvS5xyAUZgTL5PTdONZQ/W3PKbTMssSRuNH2zlwdZuJ59Rbwn+Gy
         RZTk2THWrbbGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08ACFE505D5;
        Wed,  9 Aug 2023 14:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix CPU feature detection with SMP disabled
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169159202103.17533.11526116831336443716.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Aug 2023 14:40:21 +0000
References: <20230803012608.3540081-1-samuel.holland@sifive.com>
In-Reply-To: <20230803012608.3540081-1-samuel.holland@sifive.com>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        palmer@rivosinc.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  2 Aug 2023 18:26:06 -0700 you wrote:
> commit 914d6f44fc50 ("RISC-V: only iterate over possible CPUs in ISA
> string parser") changed riscv_fill_hwcap() from iterating over CPU DT
> nodes to iterating over logical CPU IDs. Since this function runs long
> before cpu_dev_init() creates CPU devices, it hits the fallback path in
> of_cpu_device_node_get(), which itself iterates over the DT nodes,
> searching for a node with the requested CPU ID. (Incidentally, this
> makes riscv_fill_hwcap() now take quadratic time.)
> 
> [...]

Here is the summary with links:
  - riscv: Fix CPU feature detection with SMP disabled
    https://git.kernel.org/riscv/c/6514f81e1bd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


