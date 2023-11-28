Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F897FB953
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344124AbjK1LU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344564AbjK1LUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:20:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1B9D60
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:20:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF679C433CA;
        Tue, 28 Nov 2023 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701170425;
        bh=urPJ4vOJ76R60Bbw9R055iOzZ5pzXSFIvAM6WcsmwOU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VkinbTfpjETTMtxSNDuhNEZjy8WF5A5l5TDTfxisiOTD18nJifwg9L5X92OGyDQzy
         IzPlX8+ymSluUnRVxgYNQM/+KZOjYfQvcvHtiYl8nXIeDMG6auDB6jya+wCobGeOEG
         qQotkBZ/YvmFWR7DUi55rRs3RW1wfSse4iCqHxxKVEu5z/NUtq6pRRyhSG4cspsg2i
         iQD2DxX55FTfT4BbCgNjRD2Z7++hSdJtJg5ZqalgABybFe5NW9321r9ZeHOJlH5N+L
         XUvM6ztc7EcMM5ZLzfGsfI00pslFCNiahOYqc8of2bKn78TeBQXHL1wRLq4jBz8BEc
         Z9oAgnFi0lWpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FF05C39562;
        Tue, 28 Nov 2023 11:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: Fix adding mbox work queue entry when
 num_vfs > 64
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170117042558.17319.13811133588326696769.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Nov 2023 11:20:25 +0000
References: <1700930042-5400-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1700930042-5400-1-git-send-email-sbhatta@marvell.com>
To:     Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, sgoutham@marvell.com, gakula@marvell.com,
        hkelam@marvell.com
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

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 25 Nov 2023 22:04:02 +0530 you wrote:
> From: Geetha sowjanya <gakula@marvell.com>
> 
> When more than 64 VFs are enabled for a PF then mbox communication
> between VF and PF is not working as mbox work queueing for few VFs
> are skipped due to wrong calculation of VF numbers.
> 
> Fixes: d424b6c02415 ("octeontx2-pf: Enable SRIOV and added VF mbox handling")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Fix adding mbox work queue entry when num_vfs > 64
    https://git.kernel.org/netdev/net/c/51597219e0cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


