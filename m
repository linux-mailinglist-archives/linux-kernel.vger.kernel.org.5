Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5BB7D99A0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345960AbjJ0NUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345851AbjJ0NUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:20:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06074C2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:20:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73F93C433AB;
        Fri, 27 Oct 2023 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698412829;
        bh=ME6i0P8eAkHzBzv+sYV1AJcwVSLm9n7ARrAeJ0zcVEg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CW+nRb4Hh66y7aJFoJM93D549ZnLPRNByRLJNX/4uxoAdHZ/Tv/WgIuJXx6TibAG1
         cDF22UvNLS6a8o3iq9Y5BXtffx1IZxymbR/w8BEzS69w7dSSFLPFyq4fuU0UJKtbfl
         B+blOTOpPdEc0QDbu0ttMpxfYInbfreSiy6/0HFGvMGtW7ao7zYpXATgZg0RT2ed/H
         Atzyr/DpRAotd0uF5hCwu4khHJuuCODCXbWuzWeeacqgQ1lxOwnIL5rj/8/dicXKi5
         pn9etk4EgxDDiVcT/vfvCkbhbjomlpwMXyoiXP99l+k79L14nrIT7MEu9gqXu8eJ9d
         66gC6P2TzbhFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46BBCE19E24;
        Fri, 27 Oct 2023 13:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: kexec: Cleanup riscv_kexec_relocate
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169841282928.15670.14115558235021829851.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Oct 2023 13:20:29 +0000
References: <20230830063435.1105726-1-songshuaishuai@tinylab.org>
In-Reply-To: <20230830063435.1105726-1-songshuaishuai@tinylab.org>
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, mick@ics.forth.gr,
        alex@ghiti.fr, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 30 Aug 2023 14:34:35 +0800 you wrote:
> For readability and simplicity, cleanup the riscv_kexec_relocate code:
> 
> - Re-sort the first 4 `mv` instructions against `riscv_kexec_method()`
> - Eliminate registers for debugging (s9,s10,s11) and storing const-value (s5,s6)
> - Replace `jalr` with `jr` for no-link jump
> 
> I tested this on Qemu virt machine and works as it was.
> 
> [...]

Here is the summary with links:
  - riscv: kexec: Cleanup riscv_kexec_relocate
    https://git.kernel.org/riscv/c/04a6a8eb1375

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


