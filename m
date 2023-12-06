Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214ED806F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377994AbjLFMKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377980AbjLFMKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:10:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59421181
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:10:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF7C0C433C8;
        Wed,  6 Dec 2023 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701864623;
        bh=gn8ZFivOx3JYbnVo0rAf9BMy03aMxyahn+MLX+I+GU0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ko2fyFjFPFkwPUVVczU0M1B8A1inpi10GUzx9K+UKGHWCnCpcVlFXT6dozPSAesYD
         X8TZk1Q7enwo6BdNbLkj5r05Ncsf40Fgj5dag4gVv/jDLaxpEnT9p7JF6goKEPfs43
         vGXpEtV5FfmAxCXrx+K/8VXlOkcV0lQ/3ZxFn983HGK6T1IqVZjJ3V6/CFZJeqyfFP
         LAxCPUClaVAUz+rqXZNn8dO2XN9Wr2GEHGnBtZp8D1JsQAYyxLf/Z9IDIC2aQ7Vv3d
         mlSSlbuq6QfZm2xugFK46bzpEI7DRCyi43OrLh2jilNY1YQrWmPOG57msmtqTvoMCW
         1fNUpdVa2vUww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6D47DD4F1F;
        Wed,  6 Dec 2023 12:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] riscv: Fix issues with module loading
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <170186462381.31416.3360582134576570262.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Dec 2023 12:10:23 +0000
References: <20231127-module_linking_freeing-v4-0-a2ca1d7027d0@rivosinc.com>
In-Reply-To: <20231127-module_linking_freeing-v4-0-a2ca1d7027d0@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, re@w6rz.net,
        samuel.holland@sifive.com, schwab@linux-m68k.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 27 Nov 2023 14:04:58 -0800 you wrote:
> Module loading did not account for multiple threads concurrently loading
> modules. This patch fixes that issue. There is also a small patch to fix
> the type of a __le16 variable.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Changes in v4:
> - Make functions only used internally static
> - Free data structures on kmalloc failure (Andreas)
> - Link to v3: https://lore.kernel.org/r/20231122-module_linking_freeing-v3-0-8e9e412a3305@rivosinc.com
> 
> [...]

Here is the summary with links:
  - [v4,1/2] riscv: Safely remove entries from relocation list
    https://git.kernel.org/riscv/c/d8792a5734b0
  - [v4,2/2] riscv: Correct type casting in module loading
    https://git.kernel.org/riscv/c/4a92a87950c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


