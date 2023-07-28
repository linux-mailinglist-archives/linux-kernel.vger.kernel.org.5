Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC0476699E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjG1KA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjG1KAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E09935A2;
        Fri, 28 Jul 2023 03:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BA8562099;
        Fri, 28 Jul 2023 10:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CAD5C433C9;
        Fri, 28 Jul 2023 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690538422;
        bh=ZIcz/QLug4MnlRNXI4CQ6phjwPWDIizZBNVnXkgRYWE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SgqvEM5JS7Fi6F7g6KpyoR1eSK4KPZRUOyvBMBoTDiTfxVs9cJjfig2iiYPYIECAj
         jPHq0H8MQQM/qMlX/3WYnBjg1m4Smv61CoomLHQgntHCdh03e2FJk/VPz7+ns0aI89
         FGSAmq4tM9rrgOWnkTHqiTz6l7IF8MU15IcOnG5nH2/KcKQV8axMFi7Eqh/V8j27K2
         0uD6Qtv4r1wxr44neXUAyUtOapVrkNi+ITpGv9xIycBaL8ZBw52UpRdzc5xh38nmLe
         hxfxjLFDRlSVMbNwj3PDAcUQArnhjODZtb8GSxu73qnxNzjVI+zveqqDCYJfbYuIU4
         UPh3l/5R/XnAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E0D9C64459;
        Fri, 28 Jul 2023 10:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dt-bindings: net: rockchip-dwmac: fix {tx|rx}-delay
 defaults/range in schema
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169053842237.6578.2445331118496951237.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Jul 2023 10:00:22 +0000
References: <20230726070615.673564-1-eugen.hristev@collabora.com>
In-Reply-To: <20230726070615.673564-1-eugen.hristev@collabora.com>
To:     Eugen Hristev <eugen.hristev@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, david.wu@rock-chips.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 26 Jul 2023 10:06:15 +0300 you wrote:
> The range and the defaults are specified in the description instead of
> being specified in the schema.
> Fix it by adding the default value in the `default` field and specifying
> the range as `minimum` and `maximum`.
> 
> Fixes: b331b8ef86f0 ("dt-bindings: net: convert rockchip-dwmac to json-schema")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> 
> [...]

Here is the summary with links:
  - [v2] dt-bindings: net: rockchip-dwmac: fix {tx|rx}-delay defaults/range in schema
    https://git.kernel.org/netdev/net/c/5416d7925e6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


