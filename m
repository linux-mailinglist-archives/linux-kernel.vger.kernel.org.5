Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED33D778C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjHKLAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjHKLA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:00:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E74E5D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:00:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F4CA645BA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4088C433CA;
        Fri, 11 Aug 2023 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691751627;
        bh=UzjF6fh1YEK5/Z7ZLL0bXEOg58ckSlnmV1gS8Ge9gaE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EJ0ebWAdYKQrUcrnnCiX1XaqGD0fbsnaFK01wOmdknt8jSKxfT7L4CUjX+DyXZSy6
         B6ckyazoZniMATUh7qxA4gmQ0xrscDzLdfZmpFm1fMgeidkxQ0ElSRStFNwlQaUi4B
         ylPadHPHBxC43kVmSbyFOrs+c04JK/bfaEoeNt13AfYqRMKA1SHqlMP7cKSdEpBmQC
         Sf4Gw7dH9kRXoodNTTNhv+aePEfMYjgfSTiVcEgZxP4YuP46S8hd8XVXjvWOuSYkTd
         U5fOL36hDvSOBUj/OGmLLPWTtpdrQlJK8FhSjXE5J7SnwubfdAsFZ8P5tlu07tr5NW
         EU4jzs9V6r/Tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6676C395C5;
        Fri, 11 Aug 2023 11:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next Patch] octeontx2-pf: Allow both ntuple and TC features on
 the interface
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169175162774.30809.2069762629972609202.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Aug 2023 11:00:27 +0000
References: <20230810171119.23600-1-hkelam@marvell.com>
In-Reply-To: <20230810171119.23600-1-hkelam@marvell.com>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, sgoutham@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, sbhatta@marvell.com,
        naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com
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

On Thu, 10 Aug 2023 22:41:19 +0530 you wrote:
> The current implementation does not allow the user to enable both
> hw-tc-offload and ntuple features on the interface. These checks
> are added as TC flower offload and ntuple features internally configures
> the same hardware resource MCAM. But TC HTB offload configures the
> transmit scheduler which can be safely enabled on the interface with
> ntuple feature.
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: Allow both ntuple and TC features on the interface
    https://git.kernel.org/netdev/net-next/c/61f98da46984

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


