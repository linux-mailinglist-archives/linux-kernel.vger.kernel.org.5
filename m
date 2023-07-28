Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3521A7678FC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 01:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjG1XaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 19:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjG1XaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 19:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4233AB4;
        Fri, 28 Jul 2023 16:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BD5062213;
        Fri, 28 Jul 2023 23:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9497C433C9;
        Fri, 28 Jul 2023 23:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690587020;
        bh=FWGOuJNnxQ8LB9TJesHkFzsgcZFxtmGm/CpqXJd8ZKA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jp97ag3wlFuxtpF5a4YX3rzTtqnUPDCRUsde2RyxeYUumvbkNFW1uDl2a7XgvHe+e
         oL5bYqFQTSirdBl8usT3ZM0kOdZu//BSc5Y1QA8aBAorgFfbkzAyFBxBg3QsH5ziH+
         LLGq8gtId+lh9KOisRVwk4B5zPoa96QBN3qUQJ/PP6p+Z4V6IfzVTAdnp6v+nt1xup
         1MHz9wE1CNpfZowr05Q8pciIa5jyBbDPixUV/4XBEdHtA2uwC57mrE0Y8DWHyG9Clh
         CL96fLSkTgvT67u9gYsljxyXnagAsbIv743S0i3VBIgxFoGoeOActgkMy0SjWsLvky
         DwuAOG97vYrqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEB1BC4166F;
        Fri, 28 Jul 2023 23:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: ethernet: slicoss: remove redundant increment of
 pointer data
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169058702071.6177.8877758938708395588.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Jul 2023 23:30:20 +0000
References: <20230726164522.369206-1-colin.i.king@gmail.com>
In-Reply-To: <20230726164522.369206-1-colin.i.king@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     LinoSanfilippo@gmx.de, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 17:45:22 +0100 you wrote:
> The pointer data is being incremented but this change to the pointer
> is not used afterwards. The increment is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/alacritech/slicoss.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Here is the summary with links:
  - [next] net: ethernet: slicoss: remove redundant increment of pointer data
    https://git.kernel.org/netdev/net-next/c/3bdd85e2e350

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


