Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA2778C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjHKLAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjHKLA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:00:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0226CE60;
        Fri, 11 Aug 2023 04:00:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CDE2645BC;
        Fri, 11 Aug 2023 11:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBA3DC433C9;
        Fri, 11 Aug 2023 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691751627;
        bh=a15wPchtiTRtpNjsVMEMPyxizYnehhV/FQ6oI5+CqNc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DJeS98tjK+wTU5OhXLYtHQRflE8coQ3uU9J5D8os2jZWFm5M/2lY8cTc+l0oCkVMq
         /qL2S5mTmg0DT9PUqUZKVAhOeMvW/6rGmMsnw+SzVnO1mjSodvlW3kSSD8wd1T2flB
         amCLgC6NN6rV8vHAnZgBjzWG6P9wEQaxCTKngPctqQ9DBcwJHsvTSr/ueqVKE0Bc3k
         RUKYnRHX49+TO/SnPo5jOO9lku54NJGnn0j41nX6xciDI89Ym3J/159aHt8xenE8t/
         4pIAs6/NnqmKOm5aulwT282hBQWtR4/wc9IHSlPhF6cI4oabjdP1kSu+PgwZ1S8HDo
         71wNq6d5vvbtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C07BEE21ECE;
        Fri, 11 Aug 2023 11:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/3] net: dsa: rzn1-a5psw: add support for vlan
 and .port_bridge_flags
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169175162778.30809.2651056116058056426.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Aug 2023 11:00:27 +0000
References: <20230810093651.102509-1-alexis.lothore@bootlin.com>
In-Reply-To: <20230810093651.102509-1-alexis.lothore@bootlin.com>
To:     =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@ci.codeaurora.org
Cc:     clement@clement-leger.fr, andrew@lunn.ch, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        milan.stevanovic@se.com, jimmy.lalande@se.com,
        pascal.eberhard@se.com, thomas.petazzoni@bootlin.com
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 10 Aug 2023 11:36:48 +0200 you wrote:
> From: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> Hello,
> this series enables vlan support in Renesas RZN1 internal ethernet switch,
> and is a follow up to the work initiated by Clement Leger a few months ago,
> who handed me over the topic.
> This new revision aims to iron the last few points raised by Vladimir to
> ensure that the driver is in line with switch drivers expectations, and is
> based on the lengthy discussion in [1] (thanks Vladimir for the valuable
> explanations)
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] net: dsa: rzn1-a5psw: use a5psw_reg_rmw() to modify flooding resolution
    https://git.kernel.org/netdev/net-next/c/6cf30fdd7b06
  - [net-next,v5,2/3] net: dsa: rzn1-a5psw: add support for .port_bridge_flags
    https://git.kernel.org/netdev/net-next/c/0d37f839836b
  - [net-next,v5,3/3] net: dsa: rzn1-a5psw: add vlan support
    https://git.kernel.org/netdev/net-next/c/7b3f77c428ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


