Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24077534F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjGNIUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbjGNIUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3B2B7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D658161C63
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 339BFC433C9;
        Fri, 14 Jul 2023 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689322820;
        bh=T7/zTjGjpHMgiWXm1BGbK/me/hBFsG2ye/GyNLBpbCE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=B2mqiBQzBFy/EEn/WiR61n2LK0RZiQ2B4hSdpBXV/OBDOKFADLuwOCPNLPEV3alhb
         utAatg/AT6lQU9FP47C9EkGsBOp0yLCoWA5k06Vx8svqmL/k5q8wrq3KVgkM2T+qn2
         gaLVPtOr1lmb+WGDtyEbHFq+vsol0s4rAAVzObipSVo1x7+dFO8yalXHAIdYp7fSG1
         61RcWAhPrKQIj89yejOXFRu1C+w4fPv5jAN20I2hT6F5X8Ioa+aNdSjA5nDtz1k1ij
         drZAPBaYNGVMF6hG1ztYJAf2/mPc6yETcMF3MwRxmUtbdpqAHwTFoR5EuViZUKCfSh
         LvJouLoNYTePQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B42EE4508D;
        Fri, 14 Jul 2023 08:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: ethernet: Remove repeating expression
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168932282010.1632.8857195926955967765.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Jul 2023 08:20:20 +0000
References: <20230713121633.8190-1-machel@vivo.com>
In-Reply-To: <20230713121633.8190-1-machel@vivo.com>
To:     =?utf-8?b?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqCA8bWFjaGVsQHZpdm8uY29tPg==?=@ci.codeaurora.org
Cc:     jiawenwu@trustnetic.com, mengyuanlou@net-swift.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
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
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 20:16:03 +0800 you wrote:
> Identify issues that arise by using the tests/doublebitand.cocci
> semantic patch. Need to remove duplicate expression in if statement.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net,v1] net: ethernet: Remove repeating expression
    https://git.kernel.org/netdev/net/c/a822551c51f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


