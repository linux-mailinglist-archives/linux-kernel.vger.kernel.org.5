Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B907900B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346415AbjIAQZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345362AbjIAQZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:25:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E0D10D4;
        Fri,  1 Sep 2023 09:25:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39797B82519;
        Fri,  1 Sep 2023 16:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7CDFC43391;
        Fri,  1 Sep 2023 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693585515;
        bh=V8XH4cIvHWrSs/u5pfHFkWBm7960Sk/XsLtEUa1DSQA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BzksYAGVttU96YQgR8k5uPURSLS9LxrDL3vCUmVWVd45VRtBL/9kKNPEEGelVZhxc
         Oc/b4siJEVLM1MxOshBWjoNsfwpV/l5oYYAlrdYh8JJWyRWPW55lIZtKj1rUPixmP5
         I3QIn7BAV56Jw4ujVvpUR+GqHQH9eU8LgHFpqAQaE1eK8kCFgQhtHk0hJH7B8A18Ci
         GqfEXh5Qx6Iw6MmoeBeILSTb9jQuOVFf8FUDPolZBe9kvmn8N7D6b0q6Dtuj8cKbPS
         GQIybfMcQcwTtqXXSwbdaiTR3re0BpZE9MKbAdCwWZeu5iafX9qtUdTXs61O4Md7MD
         pMwVI/9NU8lZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1CF0E4509E;
        Fri,  1 Sep 2023 16:25:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/4] Add support for Allwinner D1 CAN controllers
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169358551565.8276.3801944999733958707.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Sep 2023 16:25:15 +0000
References: <20230721221552.1973203-2-contact@jookia.org>
In-Reply-To: <20230721221552.1973203-2-contact@jookia.org>
To:     John Watts <contact@jookia.org>
Cc:     linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
        wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

This series was applied to riscv/linux.git (fixes)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Sat, 22 Jul 2023 08:15:49 +1000 you wrote:
> This patch series adds support for the Allwinner D1 CAN controllers.
> It requires adding a new device tree compatible and driver support to
> work around some hardware quirks.
> 
> This has been tested on the Mango Pi MQ Dual running a T113 and a Lichee
> Panel 86 running a D1.
> 
> [...]

Here is the summary with links:
  - [v2,1/4] dt-bindings: net: can: Add support for Allwinner D1 CAN controller
    (no matching commit)
  - [v2,2/4] riscv: dts: allwinner: d1: Add CAN controller nodes
    https://git.kernel.org/riscv/c/6ea1ad888f59
  - [v2,3/4] can: sun4i_can: Add acceptance register quirk
    (no matching commit)
  - [v2,4/4] can: sun4i_can: Add support for the Allwinner D1
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


