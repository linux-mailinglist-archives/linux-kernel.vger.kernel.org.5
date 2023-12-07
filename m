Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D95808FA3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443644AbjLGSKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjLGSKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:10:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194E010F0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:10:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AF72C433C9;
        Thu,  7 Dec 2023 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701972642;
        bh=wn/rZxaQ6CPwgoghWVPT2OqAL9b44Y+FKEXiemEFjYQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BR2sLRZBFK/Oivcp9YQ3xIJYkQucj47JQmP2e3RZ/1Lld5zrh1W6LjKmfbA9WjX6+
         w/rfuAZE+Nb6YwV7qiuADkII9fWUVf95m/jR1a3Wk+sWKTctXhNvLSBUxX1wZ1en2a
         8p3tn4BUg7sutTI5c48bw0z//nDVw43F/FwOWqRLM242jSZdYs/FS9fsp425oY8j/Y
         drRGWy6Tr99X1XO9Vp34L84ODZgKsthegMRXT0L8LkcRDxAEN6GAtFCXHGfacGag22
         WSmJ1L2gx5/HATBGnB4vZcgmeaH7hejwdpBk/em88MvR//x1X0s6EoYpjDnBOZZ1xS
         +2kNvagFMbspg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7089DC43170;
        Thu,  7 Dec 2023 18:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: dsa: microchip: provide a list of valid protocols
 for xmit handler
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170197264245.15422.7349743280865094840.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Dec 2023 18:10:42 +0000
References: <20231206071655.1626479-1-sean@geanix.com>
In-Reply-To: <20231206071655.1626479-1-sean@geanix.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, arun.ramadoss@microchip.com, ceggers@arri.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

This patch was applied to bpf/bpf.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Dec 2023 08:16:54 +0100 you wrote:
> Provide a list of valid protocols for which the driver will provide
> it's deferred xmit handler.
> 
> When using DSA_TAG_PROTO_KSZ8795 protocol, it does not provide a
> "connect" method, therefor ksz_connect() is not allocating ksz_tagger_data.
> 
> This avoids the following null pointer dereference:
>  ksz_connect_tag_protocol from dsa_register_switch+0x9ac/0xee0
>  dsa_register_switch from ksz_switch_register+0x65c/0x828
>  ksz_switch_register from ksz_spi_probe+0x11c/0x168
>  ksz_spi_probe from spi_probe+0x84/0xa8
>  spi_probe from really_probe+0xc8/0x2d8
> 
> [...]

Here is the summary with links:
  - [v2,net] net: dsa: microchip: provide a list of valid protocols for xmit handler
    https://git.kernel.org/bpf/bpf/c/1499b89289bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


