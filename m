Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BAF7E27F5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjKFPAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjKFPAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:00:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52521F4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:00:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D85EC433C9;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699282829;
        bh=jvQKi09JFh+xECjRmHqfonml/yTiggDMNwY2KkFuUvk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gUnImXw2ZZD+b8Tnrv7wW4WA7lgCTfR1z1Rpv/iHn+QpCFwG8JFeXfXV1UHwoyw6n
         MTvJjKmA1VzjX5/e69RamPQDqaEkNQ8VwXuHJiITVGVPsew6sly4666s3s+h8U+jSH
         M8U+FMvtbp/f03EDV3DF4V7TASd6bwZTyeFSwEIL0wggciwjjYXiMAcJLyCFDTZgdk
         Lgh0wJ1y6PJL/UW0CeCahDlQvcLd+cBSvJ2500m9KAD2hkUDdYQgPiHmYIehVUZ5sQ
         myWIhqqM+HxL9jU0rHyEDra80o9XcxqX0a/fIr9nJ7Fm0oZ3GBdT+qzCaUOoI0VTds
         4t7h3CT+Nwi4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03871C04DD9;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH 0/3] riscv: vdso.lds.S: some improvement
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169928282901.16503.13019808692096300065.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Nov 2023 15:00:29 +0000
References: <20230912072015.2424-1-jszhang@kernel.org>
In-Reply-To: <20230912072015.2424-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        linux-kernel@vger.kernel.org
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

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 12 Sep 2023 15:20:12 +0800 you wrote:
> This series renews one of my last year RFC patch[1], tries to improve
> the vdso layout a bit.
> 
> patch1 removes useless symbols
> patch2 merges .data section of vdso into .rodata because they are
> readonly
> patch3 is the real renew patch, it removes hardcoded 0x800 .text start
> addr. But I rewrite the commit msg per Andrew's suggestions and move
> move .note, .eh_frame_hdr, and .eh_frame between .rodata and .text to
> keep the actual code well away from the non-instruction data.
> 
> [...]

Here is the summary with links:
  - [RESEND,1/3] riscv: vdso.lds.S: drop __alt_start and __alt_end symbols
    https://git.kernel.org/riscv/c/ddcc7d9bf531
  - [RESEND,2/3] riscv: vdso.lds.S: merge .data section into .rodata section
    https://git.kernel.org/riscv/c/49cfbdc21faf
  - [RESEND,3/3] riscv: vdso.lds.S: remove hardcoded 0x800 .text start addr
    https://git.kernel.org/riscv/c/8f8c1ff879fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


