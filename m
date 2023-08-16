Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACD977D6EE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240766AbjHPAKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240736AbjHPAK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:10:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD051FF9;
        Tue, 15 Aug 2023 17:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4CC961880;
        Wed, 16 Aug 2023 00:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04ACDC433C9;
        Wed, 16 Aug 2023 00:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692144628;
        bh=PFERWxFe0pV2t+pXvFf/AlJyFRD48CblFwfyjMNOvPE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Dzrz2OhbVgGkdAx7y/nLBVHTuVULiZQp1nxalxJjnCj+bn0Nr4IikB9cHoXqH7Ofk
         MsoAksl+1npQ0Ruw3nEUnHQf5g5oBYqkM2X4jJsTPTXS7kgJ1TqqJvatoU4k2EEFX5
         FwvVVtY+Obk3Q1Nf8uzxqK8bHWh2r1nOhxTdseJrAshZN8BNy2Z8oKcFhubi72BuFC
         DkeY/IRyuGryRZxa2fd4f1+HbPBQt4k9dGNuIMFnjNPrNU0YbmTp3z3KCMnV7y7Ajl
         sBrxxdW/bMNRnFww+crFbbCNh3tqVjphy1WXarNz7nAAFBUju/Gfhs7wzWPaVnJ2qk
         EIadnxkHCfTbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBD87C39562;
        Wed, 16 Aug 2023 00:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Bluetooth: btnxpuart: Add support for IW624 chipset
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169214462789.26309.9496972962553175060.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Aug 2023 00:10:27 +0000
References: <20230811101232.844769-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20230811101232.844769-1-neeraj.sanjaykale@nxp.com>
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 11 Aug 2023 15:42:30 +0530 you wrote:
> This patch series adds support for IW624 in btnxpuart driver.
> 
> The first patch removes check for CTS low after FW downloaded as
> it was found to be redundant. It increases the delay from 1000msec
> to 1200msec after FW download as IW624 requires more time to complete
> FW initialization.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: btnxpuart: Remove check for CTS low after FW download
    https://git.kernel.org/bluetooth/bluetooth-next/c/8f24666933f1
  - [v2,2/2] Bluetooth: btnxpuart: Add support for IW624 chipset
    https://git.kernel.org/bluetooth/bluetooth-next/c/f6b00a4fae83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


