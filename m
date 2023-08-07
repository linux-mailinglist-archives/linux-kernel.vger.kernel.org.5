Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF48773317
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjHGWu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjHGWuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D81FE;
        Mon,  7 Aug 2023 15:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E12AC622E5;
        Mon,  7 Aug 2023 22:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C4E5C433CA;
        Mon,  7 Aug 2023 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691448622;
        bh=t5NB6uwW31i0MvsVToZP8xQ3VwikVrgrUEwsxvH6Ops=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=puW1cLVOBtyu5bqwud5VjqvQN7qU+JKicPZtff6IaQUoYt/f6ILsEqUDU4BD63wYC
         qPq3Fu1ZNv8it0aHvSi4PMwtuxcl5LAZ1rGNHTg1if7K82Y3oATXsy70+Oz/uk4WiZ
         uUUBqbLKlKhPreKCh/xPjymigJLPlL7dZxb6pE1+Za9VajrJTaaajgw07Sf8y83Mwb
         N5cz1F3pHvtfdIy4DOzExu1fhGFCylTtxhr2c0wrrY+W8b87D+xQzU2+WhDoFiopyV
         jetT0Tt1FuyVGxm05urjSyOuxF8cT7K7Jjd+BVtLVe92KQ2dIj48cMOlpEaVqipctr
         nAHjJJxfmW6xA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C6A4E33096;
        Mon,  7 Aug 2023 22:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix potential use-after-free when clear keys
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169144862217.1999.6884974256778823590.git-patchwork-notify@kernel.org>
Date:   Mon, 07 Aug 2023 22:50:22 +0000
References: <20230807110741.85859-1-lm0963hack@gmail.com>
In-Reply-To: <20230807110741.85859-1-lm0963hack@gmail.com>
To:     Min Li <lm0963hack@gmail.com>
Cc:     luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  7 Aug 2023 19:07:41 +0800 you wrote:
> Similar to commit c5d2b6fa26b5 ("Bluetooth: Fix use-after-free in
> hci_remove_ltk/hci_remove_irk"). We can not access k after kfree_rcu()
> call.
> 
> Fixes: d7d41682efc2 ("Bluetooth: Fix Suspicious RCU usage warnings")
> Signed-off-by: Min Li <lm0963hack@gmail.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: Fix potential use-after-free when clear keys
    https://git.kernel.org/bluetooth/bluetooth-next/c/2e4504460992

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


