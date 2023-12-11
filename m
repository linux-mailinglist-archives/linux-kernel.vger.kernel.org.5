Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEFB80C602
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjLKKKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbjLKKKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:10:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0AFE3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:10:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEB18C433CA;
        Mon, 11 Dec 2023 10:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702289423;
        bh=ffn8uW06JTrptlAAlDI07539aIHmkGLZC3SCDTDmUlU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dYw1vjqQ+oeyEu8j4U68mkRREvxt2WCSaV/rPMAJTc/JVeT7yshGxQEm2T6HT+wSh
         jdh8vUXxfTioQloajvsrkz5OBXJT/bL6MaBzvCA1S8/fQl0BGYzvcktZ5ByerjE9Z6
         SIcdzAeSIbC2Su0M+J5RqUXGQemy/CYE0In20Gbp2JAYHcRUyscBI4yZzHRb4hsLn6
         bc0PQmpezmvMvj8ukOpKMF8DpgT29dhNlZYP6NPAOtcPt/PRboV5YJ+gfedvw4V8FE
         QSRJvrfnWiaHjQ9R6Uo5pQyDNa3m/HE9reDTciXcqFTTxn5itEFcfYN2ec5fq+5C+D
         AL+i6PSiTFHWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96A3EDD4F10;
        Mon, 11 Dec 2023 10:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net 0/2] octeontx2: Fix issues with promisc/allmulti mode
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170228942361.26769.3231506778434195901.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Dec 2023 10:10:23 +0000
References: <20231208065610.16086-1-hkelam@marvell.com>
In-Reply-To: <20231208065610.16086-1-hkelam@marvell.com>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, sgoutham@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, lcherian@marvell.com,
        sbhatta@marvell.com, naveenm@marvell.com, edumazet@google.com,
        pabeni@redhat.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 8 Dec 2023 12:26:08 +0530 you wrote:
> When interface is configured in promisc/all multi mode, low network
> performance observed. This series patches address the same.
> 
> Patch1: Change the promisc/all multi mcam entry action to unicast if
> there are no trusted vfs associated with PF.
> 
> Patch2: Configures RSS flow algorithm in promisc/all multi mcam entries
> to address flow distribution issues.
> 
> [...]

Here is the summary with links:
  - [net,1/2] octeontx2-pf: Fix promisc mcam entry action
    https://git.kernel.org/netdev/net/c/dbda436824de
  - [net,2/2] octeontx2-af: Update RSS algorithm index
    https://git.kernel.org/netdev/net/c/570ba37898ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


