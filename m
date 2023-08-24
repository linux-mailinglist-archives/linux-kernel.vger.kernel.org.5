Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAE8786566
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbjHXCax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbjHXCaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:30:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454FA10FE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C69DC652DB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 234E8C433C9;
        Thu, 24 Aug 2023 02:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692844224;
        bh=j9Kq4dl/5gc0BMf02DLNfYW3rJC8KZrnvYrZOv6vb8M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NfbCXITbNg19Kl/LbJM+qPkLVoZHd6EC12JJWuh7UUBkWGJA1Jtt9ErjNLjb0KnaS
         zd+IP2O6+tfpbfe1oAjZ8G81YC3crF+Qu1921jTb5W71xzlEgfB+YF5UkyGRrU/aP1
         bdVNimPoOcs+m+RXe6osstFoR7v6RQ25k7dGkBwRDvNxGTxvzNpI7Uaml4aSFJl4aQ
         LQOkFQWs8nNr/hynpK9pBQCg7RRTH4vy5d0zpgLilGV26jC5+0Tqx9hwHg3Gmuk2rb
         fDxcOPdI0v9XI3h1gB9kP1d3idqytVnNi8p6VDVhc8Hs6/PYtwQNNf3FxLb42QPBRd
         kUSRuK1oXlqdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05F92E330A0;
        Thu, 24 Aug 2023 02:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fec: add exception tracing for XDP
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169284422401.2546.2123988345748875298.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Aug 2023 02:30:24 +0000
References: <20230822065255.606739-1-wei.fang@nxp.com>
In-Reply-To: <20230822065255.606739-1-wei.fang@nxp.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, shenwei.wang@nxp.com,
        xiaoning.wang@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-imx@nxp.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Aug 2023 14:52:55 +0800 you wrote:
> As we already added the exception tracing for XDP_TX, I think it is
> necessary to add the exception tracing for other XDP actions, such
> as XDP_REDIRECT, XDP_ABORTED and unknown error actions.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: fec: add exception tracing for XDP
    https://git.kernel.org/netdev/net-next/c/e83fabb797b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


