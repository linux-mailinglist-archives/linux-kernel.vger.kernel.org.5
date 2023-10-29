Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659A67DAA7F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 03:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjJ2CUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 22:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2CUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 22:20:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD81C1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 19:20:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7E9FC433C9;
        Sun, 29 Oct 2023 02:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698546021;
        bh=mHqrtotLhVYixBi6DdxWrP1feYoRLltHdF408c+SDzI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SRB6T5xQ6BtuBgG3zjbj1IO83AEJ1IPv9igpVFKR5uDDIIEXdlGKuzXjGFKNy/V0k
         WgHLKi31UXScu54vNvMlF+CGdH12KFRK8M2/G1f24mAi6bqwyxbwRQYBLWLEw0eJlv
         E7oWWOkPZViOa0T4RTHUYh275G8xojJOAsTzgT9oLL7Wz2wC+Ti8rx6DTjTSoP5+ga
         4a0bBglvTMudjdG7C/A2zXJ+fWz/Fcj8pFzFNe7rP7xe3+q1LE+P7y73V/7SGBgQ8d
         klwqhPJ28njrMhKDaYRzZlSaRhfFgm1jOfFH+ptC8j2jYxiMHZiy8/AHQNK2MbqRVT
         YPVHd7QCCcOSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EB76C04E32;
        Sun, 29 Oct 2023 02:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] platform/chrome: cros_ec_lpc: Separate host command and
 irq disable
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169854602158.20472.60935674192148715.git-patchwork-notify@kernel.org>
Date:   Sun, 29 Oct 2023 02:20:21 +0000
References: <20231027160221.v4.1.I1725c3ed27eb7cd9836904e49e8bfa9fb0200a97@changeid>
In-Reply-To: <20231027160221.v4.1.I1725c3ed27eb7cd9836904e49e8bfa9fb0200a97@changeid>
To:     Lalith Rajendran <lalithkraj@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org,
        groeck@chromium.org, rrangel@chromium.org, timvp@chromium.org,
        tzungbi@kernel.org, chrome-platform@lists.linux.dev
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

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Fri, 27 Oct 2023 16:02:22 -0500 you wrote:
> From: Lalith Rajendran <lalithkraj@chromium.org>
> 
> Both cros host command and irq disable were moved to suspend
> prepare stage from late suspend recently. This is causing EC
> to report MKBP event timeouts during suspend stress testing.
> When the MKBP event timeouts happen during suspend, subsequent
> wakeup of AP by EC using MKBP doesn't happen properly. Move the
> irq disabling part back to late suspend stage which is a general
> suggestion from the suspend kernel documentaiton to do irq
> disable as late as possible.
> 
> [...]

Here is the summary with links:
  - [v4] platform/chrome: cros_ec_lpc: Separate host command and irq disable
    https://git.kernel.org/chrome-platform/c/47ea0ddb1f56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


