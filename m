Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0CE7762B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjHIOk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjHIOkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344952109
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF47563C5A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A5F0C433CA;
        Wed,  9 Aug 2023 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691592021;
        bh=Lhf4dunGaMpKTl1uQVkZSCuLWY2zJMjBo+ZX8A0Oqjw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cxdBtGOm8WaqOeYDsX3kOYWYgVzDTFN2+fgQRKIFZ40YmzzhvhjVYEk9Dg4GilQTQ
         /y/DqonMpDL3YdF+bnWLJDW3/klJWLLD1mXHB7Q3h7FgxFXmwWi13LdaI0uGgNDLgQ
         zDyAOjWTHTEHMvd1CZ+5XGpb7A6YxfCRNQrgqX6oYrGHuabSnBqo5NwC3mQPYqGR5y
         Da9f/tQTt1eKlu6szvE2RM2+n4TbK9kyxQZqfL/2MTRFJVu+Gz6ipC++ujUkPgzr5C
         wabbRumTznfJX3fGi+a02sGnOgjugXGKx2e6a1VbYH2xcdpzArzlmGVuH9MjovvNM0
         QH0MVNRUE1zHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1178EE33090;
        Wed,  9 Aug 2023 14:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] riscv,mmio: I/O barriers fixes and cleanups
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169159202106.17533.2222118881302041934.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Aug 2023 14:40:21 +0000
References: <20230711133348.151383-1-parri.andrea@gmail.com>
In-Reply-To: <20230711133348.151383-1-parri.andrea@gmail.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 11 Jul 2023 15:33:46 +0200 you wrote:
> Andrea Parri (2):
>   riscv,mmio: Fix readX()-to-delay() ordering
>   riscv,mmio: Use the generic implementation for the I/O accesses
> 
>  arch/riscv/include/asm/mmio.h | 72 ++++-------------------------------
>  1 file changed, 8 insertions(+), 64 deletions(-)

Here is the summary with links:
  - [1/2] riscv,mmio: Fix readX()-to-delay() ordering
    https://git.kernel.org/riscv/c/4eb2eb1b4c0e
  - [2/2] riscv,mmio: Use the generic implementation for the I/O accesses
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


