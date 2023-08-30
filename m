Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6CC78DF4E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242247AbjH3TLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244560AbjH3NUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE0DCDC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F149662162
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D91CC4167D;
        Wed, 30 Aug 2023 13:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693401635;
        bh=NnXmR/Vu6hliz+knSoM4OBxXMSCfHdJvn6wZbCXV08E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WoCIcd/7Gz8XtAUKrRT3tTeOudTLfwwuW/6gEZWiftCpN3XML53ZmVmHKEGrndces
         OFtSQE48zpmuEgvNuaSrirq5FD9epTiGQjpRrsdYRvP23U/KRg0jhqBmxc/JZMvBIN
         RyslOVWlvKijZmru4s6tUAZpw2E7IBpCo8SJALVpGb+J3fhnqiWIKgXjHWLoWYOC86
         DkrEoYTTemGDayVtGmU2SBfjIC4YNO/pV8fbOuxHqKggL5MsY0G4Aj8bZSrXeavDXZ
         s+iKHzyPnPmgFtMYX/GTBfmxQjVT5DCOOd5BjPPpZhcWxbOcfFRlSMR0nq3YSqiTdm
         840H18kjxU9Qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC584E49BBF;
        Wed, 30 Aug 2023 13:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: remove redundant mv instructions
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169340163496.19859.7165962151794268511.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Aug 2023 13:20:34 +0000
References: <20230725053835.138910-1-namcaov@gmail.com>
In-Reply-To: <20230725053835.138910-1-namcaov@gmail.com>
To:     Nam Cao <namcaov@gmail.com>
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

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 25 Jul 2023 07:38:35 +0200 you wrote:
> Some mv instructions were useful when first introduced to preserve a0 and
> a1 before function calls. However the code has changed and they are now
> redundant. Remove them.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  arch/riscv/kernel/head.S | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Here is the summary with links:
  - riscv: remove redundant mv instructions
    https://git.kernel.org/riscv/c/10f763532d58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


