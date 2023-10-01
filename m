Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066C27B4906
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 20:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbjJASK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 14:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjJASK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 14:10:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F349CBC
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 11:10:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8448EC433C9;
        Sun,  1 Oct 2023 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696183824;
        bh=qUjOQ1NO/389X856xo2f7ZphJPr5J5BqTviNC+jbX3s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=O6yyyQawzDFnonculnvgu30p1d39wHGPnQXD/TALW6KNatgxtOZZYfciUvpX/aS1d
         XxqeKlbeUYFJXuK50gezACXd5Rp4Zf6GozJTQRyKXVjpKjtgXscLJGMLF5spQQICrx
         MZBt9sLUrc6fKg+QirgJH+w79pnlixh0l/EP8o6/56mRJNbVg7Z9TLu/AUV3OGTXMS
         SscOK0Xc2Y9jbXYN9rcRfEvFac/xOCVmrT6vXVWZ255Bw5Jdt7yAb2Y+Ts9FJCeRu/
         MJT6Mg+8YSky4eRVLfoIpxaFKk3BqCTI58tEKhhCfYc/Y1wtyb0wFUrAXxf3Ybhob4
         +IVCztUoD6DtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 675DCC43170;
        Sun,  1 Oct 2023 18:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] openvswitch: reduce stack usage in
 do_execute_actions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169618382441.7639.12391501552902895614.git-patchwork-notify@kernel.org>
Date:   Sun, 01 Oct 2023 18:10:24 +0000
References: <20230921194314.1976605-1-i.maximets@ovn.org>
In-Reply-To: <20230921194314.1976605-1-i.maximets@ovn.org>
To:     Ilya Maximets <i.maximets@ovn.org>
Cc:     netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, dev@openvswitch.org, pshelar@ovn.org,
        echaudro@redhat.com
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Sep 2023 21:42:35 +0200 you wrote:
> do_execute_actions() function can be called recursively multiple
> times while executing actions that require pipeline forking or
> recirculations.  It may also be re-entered multiple times if the packet
> leaves openvswitch module and re-enters it through a different port.
> 
> Currently, there is a 256-byte array allocated on stack in this
> function that is supposed to hold NSH header.  Compilers tend to
> pre-allocate that space right at the beginning of the function:
> 
> [...]

Here is the summary with links:
  - [net-next,v2] openvswitch: reduce stack usage in do_execute_actions
    https://git.kernel.org/netdev/net-next/c/06bc3668cc2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


