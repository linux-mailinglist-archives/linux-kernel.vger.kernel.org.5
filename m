Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3798759266
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGSKK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjGSKKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E66E69
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88C2D6137C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AF98C433C9;
        Wed, 19 Jul 2023 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689761420;
        bh=uN5Jay7MKpbUM1GRLyRl2cdt0YFB0Pis7GeiMlnYI84=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IB9JwgrIvLgcALCglDKAMO8nH21yU+oQMGyWOAXSaG7bMzw+9O47eaXbqnzegN6Io
         uG4mlf5wsKM5y0jdCpOJFROS0Ou57L23MA0hbibsOGud0Fc5ccBsR5JSLExinOp1F7
         YaihazEcVfT47eCfIRTgI3l5kA9Mw3mWa/JE6+47f8TW5DlS88m59nZOhEMi32ZYNz
         EfiZhED6u5/NKrGDHh6CxoEPia1N7lJtEUNUQncfTyCpqunlFmgW8f+rRv7zrDy32d
         THBCphb4cECSOycg7knAV4Y+nHMv9FseIStykfTN5ELKXGgJ3bzKIX2BUHJMocZ9ao
         bAnEG8DDlMfTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7EE00E21EFE;
        Wed, 19 Jul 2023 10:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: ipv4: Use kfree_sensitive instead of kfree
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168976142051.5988.8551185918272775357.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jul 2023 10:10:20 +0000
References: <20230717095932.18677-1-machel@vivo.com>
In-Reply-To: <20230717095932.18677-1-machel@vivo.com>
To:     =?utf-8?b?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqCA8bWFjaGVsQHZpdm8uY29tPg==?=@ci.codeaurora.org
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jul 2023 17:59:19 +0800 you wrote:
> key might contain private part of the key, so better use
> kfree_sensitive to free it.
> 
> Fixes: 38320c70d282 ("[IPSEC]: Use crypto_aead and authenc in ESP")
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  net/ipv4/esp4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net,v1] net: ipv4: Use kfree_sensitive instead of kfree
    https://git.kernel.org/netdev/net/c/daa751444fd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


