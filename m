Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD9975BB54
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 01:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjGTXu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 19:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGTXuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 19:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86780273A;
        Thu, 20 Jul 2023 16:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C07661CCC;
        Thu, 20 Jul 2023 23:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FB79C433C8;
        Thu, 20 Jul 2023 23:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689897021;
        bh=feJewLUTFiUeftAknY22nUa7pWdY5sIWSFqpthJJNOs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tXBDZOgsmTJnhGz7BNLECINsPd6ybEu+oBNJSilrewRog3SQz9ZhoqJNRumFvO4/n
         VSUvaCzLsE5VtAri9r/PYG8eni8lspd28m2qrse6zvuwLwG1ca1zB7ZO4+i4RY+8N1
         fuyg3ODxaGveVsJTfgwXlZOG5Qjm875XmS34ksuLnsuTwdcKyotEF+G/+wK0PoBXw4
         PRSuYZTbu/W5ZE7qdLvCUN3HqdMMfPaV4fmkrlX9t/Qea3XbNOhxYls0a4Qw/L1fBA
         WdoJJOUixdLOUu76cur/wiw+GU3f6EjTo45m2ecPEookHgzSM758bOGPCt9pdWKaYg
         /8NhzLAUWTxLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41E98C595C3;
        Thu, 20 Jul 2023 23:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bluetooth: Explicitly include correct DT includes
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168989702126.8881.8720051222737802178.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Jul 2023 23:50:21 +0000
References: <20230714174057.4041063-1-robh@kernel.org>
In-Reply-To: <20230714174057.4041063-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     sean.wang@mediatek.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 14 Jul 2023 11:40:57 -0600 you wrote:
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
  - bluetooth: Explicitly include correct DT includes
    https://git.kernel.org/bluetooth/bluetooth-next/c/f0eecb651f96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


