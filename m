Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968F47BF71C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjJJJU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJJJUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:20:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC4193
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 02:20:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76611C433C9;
        Tue, 10 Oct 2023 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696929623;
        bh=NerkXt+rZPAlIupXJbcBKtsX2t6qQ5YjxKM52f99KNo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ryUbXkqMfY8RPPCD9gbx7vuqOtYjaTjR3sUkUgC00poq+dgxfJ+FMgUUZhYaqcffU
         h3XQ2eiSDGxC3T/ewHsb4Sw5bjGAklxQho6BdCh80FsN1Ik42KLgJg+wxC+ezyy0BV
         25fVHynjmGm+hwkcrxYq1pcioa7dUNQPxi3ra7NirkdGrGwk05eOtVQPIhQK0lqb72
         QE+7Jeskx8SWefUSDyEUGMuqMVKiNBa1OTfyp2j85q0c9mhBQ9SVjnVxF0VCWwJAP9
         MwiqKqu5lwo+Rz4DCPOJrgDbT6GHejW0soTw1Ilo0MgU8tXi8musx/Ne5iKkfTyVdI
         3dnz4wRBEeSbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54698C595C5;
        Tue, 10 Oct 2023 09:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: dsa: microchip: Fix uninitialized var in
 ksz9477_acl_move_entries()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169692962334.26090.2044433680478545315.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Oct 2023 09:20:23 +0000
References: <20231006115822.144152-1-o.rempel@pengutronix.de>
In-Reply-To: <20231006115822.144152-1-o.rempel@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
        f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com,
        olteanv@gmail.com, woojung.huh@microchip.com,
        arun.ramadoss@microchip.com, linux@armlinux.org.uk,
        dan.carpenter@linaro.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com, petrm@nvidia.com, lukma@denx.de
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Oct 2023 13:58:22 +0200 you wrote:
> Address an issue in ksz9477_acl_move_entries() where, in the scenario
> (src_idx == dst_idx), ksz9477_validate_and_get_src_count() returns 0,
> leading to usage of uninitialized src_count and dst_count variables,
> which causes undesired behavior as it attempts to move ACL entries
> around.
> 
> Fixes: 002841be134e ("net: dsa: microchip: Add partial ACL support for ksz9477 switches")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/1] net: dsa: microchip: Fix uninitialized var in ksz9477_acl_move_entries()
    https://git.kernel.org/netdev/net-next/c/59fe651753fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


