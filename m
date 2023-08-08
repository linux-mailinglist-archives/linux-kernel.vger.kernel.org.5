Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB9C7736D9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjHHCkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjHHCkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023C6170B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 741616239F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 02:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA80BC433CB;
        Tue,  8 Aug 2023 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691462421;
        bh=BN9+ePxVNwK7cqg1QyCXov5dgrH8UzbVwNEQziN+fww=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WR+961DXUuIYtN04mxMrhm9ujAQc+OEc3EyWYFhzD5QgteD0Vwd2qUsNVl1+rn2TH
         AoTZipABI8JVjaSm9ZYMJp1PwinKMam30nGOpxAT7XMsrkwwMva0mBcRppkPUOU2DP
         SXEO6xTfJIAcQncORtJvgPMxOkxi6c8FOnRzRz7pVH9Lj09HYtMo1HUaCzRShTOgtt
         bgsh56J7adUdh2wGgU4TKkS5ensBiRY7/fGHkV+xwrnF95ByMoTXW0aK4hdqCVIFRX
         CampdgyZJssjwima0QSCpO4qcRHJJbiyZZvWdEuQP7Z94on0LjQqkn1Pt3MjB6Q7mh
         i/jt2eNZ7E5WQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B01F4E270C3;
        Tue,  8 Aug 2023 02:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Remove EC panic shutdown
 timeout
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169146242171.22152.16707437625793558172.git-patchwork-notify@kernel.org>
Date:   Tue, 08 Aug 2023 02:40:21 +0000
References: <20230802175847.1.Ie9fc53b6a1f4c6661c5376286a50e0cf51b3e961@changeid>
In-Reply-To: <20230802175847.1.Ie9fc53b6a1f4c6661c5376286a50e0cf51b3e961@changeid>
To:     Rob Barnes <robbarnes@google.com>
Cc:     bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
        dtor@chromium.org, chrome-platform@lists.linux.dev,
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

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed,  2 Aug 2023 17:58:48 +0000 you wrote:
> Remove the 1 second timeout applied to hw_protection_shutdown after an
> EC panic. On some platforms this 1 second timeout is insufficient to
> allow the filesystem to fully sync. Independently the EC will force a
> full system reset after a short period. So this backup timeout is
> unnecessary.
> 
> Signed-off-by: Rob Barnes <robbarnes@google.com>
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_ec_lpc: Remove EC panic shutdown timeout
    https://git.kernel.org/chrome-platform/c/f2d4dced9a58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


