Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9FC78613D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 22:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbjHWUK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 16:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbjHWUK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 16:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481E210CC;
        Wed, 23 Aug 2023 13:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D432463C16;
        Wed, 23 Aug 2023 20:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A485C433C8;
        Wed, 23 Aug 2023 20:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692821423;
        bh=K2KpJdKf6FScElKO4BDQjTIMS7VSEO2o1DADSC7q+R4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TgwAtISaI/NB71xFkrQ3QjMKmZldGjqpQuWnPbPjBjCNJjufUyJ7O8+3z+EIo9RxL
         SPQqUSxskHRNNuOqKTNu0Mkz33efiQJy9/bKynhadhdIalsJeodvJBIO1oR9KSa+MC
         c7FStgmt2dsOcI47W/0DbuL5naWT8X0G7wH3PCr0H6ANlrjnGio088oEuK6KRd99+c
         jeWECy3scIe6qg9hEDT5Afb36ZA/6PzVj6gutNdWD/rqoEHpNZJGRsyP/6zF5g4/TH
         SHCPAS5ZgBeA2uCWH27xOTkO6PlF9LLdDoaUT3weaI8V0XBmHkf0mZyywK4x9ATjQr
         QjZPuJcqHlfhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2800C595CE;
        Wed, 23 Aug 2023 20:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Require FRAME_POINTER for some configurations
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169282142292.4166.3281543334488200075.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Aug 2023 20:10:22 +0000
References: <20230823082845.354839-1-bjorn@kernel.org>
In-Reply-To: <20230823082845.354839-1-bjorn@kernel.org>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@ci.codeaurora.org
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, rdunlap@infradead.org,
        bjorn@rivosinc.com, linux-kernel@vger.kernel.org,
        guoren@kernel.org, dfustini@baylibre.com,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 23 Aug 2023 10:28:45 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Some V configurations implicitly turn on '-fno-omit-frame-pointer',
> but leaving FRAME_POINTER disabled. This makes it hard to reason about
> the FRAME_POINTER config, and also triggers build failures introduced
> in by the commit in the Fixes: tag.
> 
> [...]

Here is the summary with links:
  - riscv: Require FRAME_POINTER for some configurations
    https://git.kernel.org/riscv/c/9f944d2e0ab3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


