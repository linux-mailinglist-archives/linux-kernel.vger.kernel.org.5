Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158987762AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjHIOkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjHIOkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F4F210A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1D1263C5F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C576C433CB;
        Wed,  9 Aug 2023 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691592021;
        bh=N5b3QpnRXEbEvS3LF0AebqdApk09psCS7jK2pqPZUTI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VNIN3s5jdfPZOzxslfRuIIRYew7DOlrDSHRUHrCkbbB5BnviEk3InN9NqyVqsWwv3
         JBInBc4E/ZwYjK3v0PrPV4xDMEnfL8Pl8XmPbFi7+nkDsxdnay5A5LeTy5vtQoy789
         WNVWcE6J9JQr9GpQTSY0kIXoV5rAprjlRB9ZG50ASqC9KkvZMHv0SMbjwDJbrZ5Kis
         n28ZW9B/O0gQnb+TMgkApC97Qg4/m+ELbu7+hpfsVZAM1axcwEk28z1AhCzABOcj3U
         Cnw/BSPHHQL7rVtO//vOocq7iDgvt+qvSwn6NcJPhRhYl38Mvg27wWD1LMSoV/Cq5Y
         GGqhoF8+1KPWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A546C64459;
        Wed,  9 Aug 2023 14:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv,mmio: Fix readX()-to-delay() ordering
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169159202110.17533.11320910350713867941.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Aug 2023 14:40:21 +0000
References: <20230803042738.5937-1-parri.andrea@gmail.com>
In-Reply-To: <20230803042738.5937-1-parri.andrea@gmail.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu,  3 Aug 2023 06:27:38 +0200 you wrote:
> Section 2.1 of the Platform Specification [1] states:
> 
>   Unless otherwise specified by a given I/O device, I/O devices are on
>   ordering channel 0 (i.e., they are point-to-point strongly ordered).
> 
> which is not sufficient to guarantee that a readX() by a hart completes
> before a subsequent delay() on the same hart (cf. memory-barriers.txt,
> "Kernel I/O barrier effects").
> 
> [...]

Here is the summary with links:
  - [v2] riscv,mmio: Fix readX()-to-delay() ordering
    https://git.kernel.org/riscv/c/4eb2eb1b4c0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


