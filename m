Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF117C81D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjJMJUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjJMJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:20:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E28195
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:20:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C80DC433CB;
        Fri, 13 Oct 2023 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697188827;
        bh=y9jDUO5xD/h+ai60uaWtxxXBe+UBTx8FQS8ef0NQ1CQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Gd8Tb2MXQKv6DGxUg8FsrdZKl2dCaM7voXeaoiMPw1XT/l8feYLlF8hObsMl+giqX
         FIgDIuUeKTHLowxNfOK+JeCPucUl57d49MRWT91CmksF2l96zO4xzGSWhr5/G5xeLR
         ImpqY7K5mNHUPjxq3HsBSq19Ob3pYIXPBowbKPJRDNGkBRvfcvzWPP6jZG02E5Cftl
         ram5MyckjFF8NiT+EPo8EuWD3QG75eUxCR4TvCddcOYTJ88alDgvlkKySzQDCq75Wa
         mU3Q14WiEEqD8VV05rxDVPyDr2vhjdsQUAbjrJ2QK3GmytuWFlQuQDYSxBu2j98P9y
         lrCPDkaVweQwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 821DAC691EF;
        Fri, 13 Oct 2023 09:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: fec: replace deprecated strncpy with ethtool_sprintf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169718882752.6212.16802837129949088436.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Oct 2023 09:20:27 +0000
References: <20231009-strncpy-drivers-net-ethernet-freescale-fec_main-c-v1-1-4166833f1431@google.com>
In-Reply-To: <20231009-strncpy-drivers-net-ethernet-freescale-fec_main-c-v1-1-4166833f1431@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
        linux-imx@nxp.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Mon, 09 Oct 2023 23:05:41 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> [...]

Here is the summary with links:
  - net: fec: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/659ce55fddd2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


