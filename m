Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE10758B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjGSCKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGSCKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:10:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D124E1FDB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63D38616C9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B88ECC433B7;
        Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689732622;
        bh=/qxqKDN+VTBagSXNiDocGJj67ckmM0Hk3yG0wfM16Sw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QmCszSNljwNBeFtPHzBjA6a/ocdr6mO2IlwtPyONUV5ct47+6tVEcI5IAIe8wiEPb
         ReGzSbxV1BUJJkSLqOjDfY2QeQXx0cD6qExpS6pM3oURnAX4kVWGk/+AKwTUNNSCGP
         HmtpOD5gFWWPML9Z5Zc6MZzvBD1VP1iu7wK9LjphPZpGhS7sixjLq0RSQIXLvk2R5N
         ZP4Q80B4n+7kzT0ykag6YTNdrCIrZqK02hGimPl3Td8NwZTbaEQNKsL1KlnN8mvLuZ
         1w/QFf6i8p/h8Xj6NVVpcfHn/boNJV9W2wcGvwfma/NzlmTjV2PmbNW1CJfX5P/VJ0
         /9GYH4BE0vRJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BFDDE22AE5;
        Wed, 19 Jul 2023 02:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] drivers/cros_ec: Emergency sync filesystem on EC panic
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <168973262262.24960.14264135195868218640.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jul 2023 02:10:22 +0000
References: <20230717232932.1.I361812b405bd07772f66660624188339ab158772@changeid>
In-Reply-To: <20230717232932.1.I361812b405bd07772f66660624188339ab158772@changeid>
To:     Rob Barnes <robbarnes@google.com>
Cc:     pmalani@chromium.org, chrome-platform@lists.linux.dev,
        briannorris@chromium.org, bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Mon, 17 Jul 2023 23:29:32 +0000 you wrote:
> Perform an emergency filesystem sync when an EC panic is reported. An
> emergency sync actually performs two syncs internally in case some
> inodes or pages are temporarily locked.
> 
> hw_protection_shutdown is replaced for a few reasons. It is unnecessary
> because the EC will force reset either way. hw_protection_shutdown does
> not reliably sync filesystem before shutting down. emergency_sync is not
> synchronous so hw_protection_shutdown may interrupt emergency_sync.
> 
> [...]

Here is the summary with links:
  - drivers/cros_ec: Emergency sync filesystem on EC panic
    https://git.kernel.org/chrome-platform/c/a6edd5f5d9cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


