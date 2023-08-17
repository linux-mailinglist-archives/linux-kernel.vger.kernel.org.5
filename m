Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39C977FA9F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353154AbjHQPUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353158AbjHQPU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E444B30E3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76EEE65862
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7298C433CD;
        Thu, 17 Aug 2023 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692285624;
        bh=54jSAxQsEgLssz13NsAAtywsNx0kXc+SSq2W5eBTFP0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QsnyW9XADwnvJTdjkajzdDkn88kCCSpnJCjXp/B92LUSgDpNJra51PJqsR01WP2dd
         SPoPmOB/gWBcwRDORlzqu8MXv09VPD/KbakRS+Xfud5E6Z1/KCqoZvBoe9ds/MrsCe
         eVnKW3pIG4WFbD4l4JIzTxn/5KL1IHwUzxrkwUOoZ10sgEfc5ASqP5VbSBEg6NF9/p
         vkcgtgZDjA9yI5o0YwRscsRZr4N3BUhU3XFAWtrPxTCrrR6ookYrriUrw2JbehMEqP
         /lGVjVLEru7v2+xbOeouIAeOcENR+X8+RkTKUvU/k2DGi0r44FX20FtO8HX/WQMqLG
         XdnbPwJDcyg3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD9D6E26D3A;
        Thu, 17 Aug 2023 15:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes v2] riscv: uaccess: Return the number of bytes
 effectively not copied
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169228562477.20811.12846984495723558384.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Aug 2023 15:20:24 +0000
References: <20230811150604.1621784-1-alexghiti@rivosinc.com>
In-Reply-To: <20230811150604.1621784-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alankao@andestech.com,
        linux-kernel@vger.kernel.org, tsu.yubo@gmail.com,
        aurelien@aurel32.net, bjorn@rivosinc.com
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

On Fri, 11 Aug 2023 17:06:04 +0200 you wrote:
> It was reported that the riscv kernel hangs while executing the test
> in [1].
> 
> Indeed, the test hangs when trying to write a buffer to a file. The
> problem is that the riscv implementation of raw_copy_from_user() does not
> return the correct number of bytes not written when an exception happens
> and is fixed up, instead it always returns the initial size to copy,
> even if some bytes were actually copied.
> 
> [...]

Here is the summary with links:
  - [-fixes,v2] riscv: uaccess: Return the number of bytes effectively not copied
    https://git.kernel.org/riscv/c/4b05b993900d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


