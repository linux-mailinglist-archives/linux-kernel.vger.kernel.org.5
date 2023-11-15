Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60307EC045
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbjKOKKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjKOKK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:10:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E340B101
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:10:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73A92C433C9;
        Wed, 15 Nov 2023 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700043024;
        bh=8oGuqu5H/DBhBeQLLHGDX/9Rsdie9PSLVreZfLiiFIM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=L+qN/UxCrdtRNJJDcBJXDOwCRFBVRKv9m6TsLvb+R0G2/1VBaxdxIul2q1IrQrSl7
         x2MDHOxL8Z8qKQmdEWv9+jRYRcGLFFHnmpVZFlwHr4PgKvXoNSj5jBCxkvOQHYjuBE
         N6q2mIOIilx1UvD4uzAGXauWqobBByAV35Q91A7JZdRDr/W99cPuR6mWTFPHz7buqO
         92loz2GhcC7nz/F1AKzKe9t/j+ZluH5hNPHj6ffqMafbZWMYNGBdp/Kp/ybLItCIQO
         Co+eoujo6LAJsqW7wf458uVo428BfSthGKtSk+hKslkCPx7m7A+h5jCfl75jXtVa6h
         7xExxEnc9ck9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B0F0E1F66F;
        Wed, 15 Nov 2023 10:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] Revert ncsi: Propagate carrier gain/loss events to the
 NCSI controller
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170004302436.28811.7446869431926384259.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Nov 2023 10:10:24 +0000
References: <20231113163029.106912-1-johnathanx.mantey@intel.com>
In-Reply-To: <20231113163029.106912-1-johnathanx.mantey@intel.com>
To:     Johnathan Mantey <johnathanx.mantey@intel.com>
Cc:     netdev@vger.kernel.org, sam@mendozajonas.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

On Mon, 13 Nov 2023 08:30:29 -0800 you wrote:
> This reverts commit 3780bb29311eccb7a1c9641032a112eed237f7e3.
> 
> The cited commit introduced unwanted behavior.
> 
> The intent for the commit was to be able to detect carrier loss/gain
> for just the NIC connected to the BMC. The unwanted effect is a
> carrier loss for auxiliary paths also causes the BMC to lose
> carrier. The BMC never regains carrier despite the secondary NIC
> regaining a link.
> 
> [...]

Here is the summary with links:
  - [net,v3] Revert ncsi: Propagate carrier gain/loss events to the NCSI controller
    https://git.kernel.org/netdev/net/c/9e2e7efbbbff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


