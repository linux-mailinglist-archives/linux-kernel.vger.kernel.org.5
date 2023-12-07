Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54792808BA6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443441AbjLGPUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443440AbjLGPUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:20:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FCB10D8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:20:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6AE8C433C9;
        Thu,  7 Dec 2023 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701962425;
        bh=bIRBhYwK1IRegs4X3EsVItjloLp8U3gwV50+Gg5hIzA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t3NtVgeHiTsppyAp0gHK0kJxrJUiHzc6HXgdcdZZD/jHdie74bWA2+hmwb+eL+aSk
         r0gNBOvnOxStuDB8cNxPd7G7KCC/RgZk22Abz9ZUuwA/yPENfrIMPGJYaG/WOTOrId
         5b0vLc1ogkXDjLXpHAc/nEHBz7NZx35CvzbObvNwqw8XIebkZ4ca0uJOQXGZBKpPAM
         FscKy7hTLtiyrvnGQKw7MEczwOXsG5lKPza/y/MhY/hZ/+ix4MVbtFFszXqxL+GleG
         oA6M1Sr84iA5T8sKxj9vj0zUdc0nor8fe50brQEwv7CYY1VZ6ZJw6eP2im6smpJGEQ
         42A2er0/flTJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE9C2C40C5E;
        Thu,  7 Dec 2023 15:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix SMP when shadow call stacks are enabled
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <170196242571.12999.13645791686392638982.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Dec 2023 15:20:25 +0000
References: <20231121211958.3158576-1-samuel.holland@sifive.com>
In-Reply-To: <20231121211958.3158576-1-samuel.holland@sifive.com>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, andy.chiu@sifive.com, cleger@rivosinc.com,
        conor.dooley@microchip.com, greentime.hu@sifive.com,
        guoren@kernel.org, heiko@sntech.de, masahiroy@kernel.org,
        namcaov@gmail.com, paul.walmsley@sifive.com,
        samitolvanen@google.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 21 Nov 2023 13:19:29 -0800 you wrote:
> This fixes two bugs in SCS initialization for secondary CPUs. First,
> the SCS was not initialized at all in the spinwait boot path. Second,
> the code for the SBI HSM path attempted to initialize the SCS before
> enabling the MMU. However, that involves dereferencing the thread
> pointer, which requires the MMU to be enabled.
> 
> Fix both issues by setting up the SCS in the common secondary entry
> path, after enabling the MMU.
> 
> [...]

Here is the summary with links:
  - riscv: Fix SMP when shadow call stacks are enabled
    https://git.kernel.org/riscv/c/f40cab8e18ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


