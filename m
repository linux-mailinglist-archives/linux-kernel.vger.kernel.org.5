Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEC57D839B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345037AbjJZNab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjJZNa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:30:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B02112A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C53DC433C8;
        Thu, 26 Oct 2023 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698327026;
        bh=pFp2YBd4VyYE7lA/RZtlxRg6vfQXE6WJqS+if9pEY+o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D+XU9HB7BRRP6sB4v41mdsFp5k4taEv0LgLyGCvaxonqB1qfaV4Stj9rWh56IHVY1
         +dkBvs0WvWSiT+999vUHAafREuhDEIprUTiS4CtnnC3UI2CK8BpEnGIqCKQp6hbN4w
         oS/U2ugIHvB4Fin/OZOIAlxlcrgI92yAAskseClrUAs2B3srH3RPYGaMLTeUk5TXDj
         tmIlkUABO0rklTeLT9Zqt8ez2c+ktzEC5Nu/Wf8sgsQ/pEUEUB8h2FHFAu7AOpMOy8
         i7kPwPsWKEZux8FJfpYVrnNypAoJQJx7KTpEdmXyi2CoS44IE6QijOUJbmDKbrRw+O
         iN8lLuLYxm6bQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7ADE2C3959F;
        Thu, 26 Oct 2023 13:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bareudp: use ports to lookup route
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169832702649.29524.3769483651661946849.git-patchwork-notify@kernel.org>
Date:   Thu, 26 Oct 2023 13:30:26 +0000
References: <20231025094441.417464-1-b.galvani@gmail.com>
In-Reply-To: <20231025094441.417464-1-b.galvani@gmail.com>
To:     Beniamino Galvani <b.galvani@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
        gnault@redhat.com, linux-kernel@vger.kernel.org
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
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 25 Oct 2023 11:44:41 +0200 you wrote:
> The source and destination ports should be taken into account when
> determining the route destination; they can affect the result, for
> example in case there are routing rules defined.
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/bareudp.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Here is the summary with links:
  - [net-next] bareudp: use ports to lookup route
    https://git.kernel.org/netdev/net-next/c/ef113733c288

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


