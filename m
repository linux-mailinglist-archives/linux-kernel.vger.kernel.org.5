Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798F679A285
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 06:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjIKEbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 00:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjIKEbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 00:31:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F810C;
        Sun, 10 Sep 2023 21:31:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58BE2C433B9;
        Mon, 11 Sep 2023 04:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694406700;
        bh=zdcZgXW0ruaLVCHmFcQtUtGqAyV2q7CuqMdsj8JHKuo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=COLJDnyyEjxhCZBFxpK7LIlk1XtdvbEadTmHY9z4p8ki/idJTloI7wpINVoJOl3by
         uTAkOWhbvR8voDbwNZSWAXynKhe2amo7pFjTN65/RT/UgjUf9WMolSih5tSxL1CJH5
         fJfQN0885GhuWGN3TAiTL0dp6urQ9wytnuAPc3cVnok1SdrW9Aw9q4Kr8fuX4JbuVn
         4/O3QhEYGcwsjY2y0RJoMMELYEfBbyS4Nxxmr9lCzUdmw0NcUCz0t7biZ4FIZeBiPH
         zrVtmDo0ptK8bDfJdJHOb1cHgHoxgE+semYfT3RCWBYU4uza6q7+vIDg+2z8TAm4QP
         Jex7WtsQb5JNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 456BEE22AFF;
        Mon, 11 Sep 2023 04:31:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform: Explicitly include correct DT includes
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169440670028.22573.1520676346126156762.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Sep 2023 04:31:40 +0000
References: <20230714174909.4062739-1-robh@kernel.org>
In-Reply-To: <20230714174909.4062739-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, hdegoede@redhat.com,
        markgross@kernel.org, vadimp@nvidia.com,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
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

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Hans de Goede <hdegoede@redhat.com>:

On Fri, 14 Jul 2023 11:49:09 -0600 you wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Here is the summary with links:
  - platform: Explicitly include correct DT includes
    https://git.kernel.org/chrome-platform/c/b9fe9c9ef97d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


