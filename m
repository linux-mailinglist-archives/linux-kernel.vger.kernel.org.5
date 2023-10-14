Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D5D7C91D9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjJNAk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjJNAk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:40:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A139BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEEDDC433CA;
        Sat, 14 Oct 2023 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697244024;
        bh=LBRj7RPpH0t4uglFprw3OonulBFR3UbaQLNWIGKmsf0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uVavqv7NwI6oHhj42YaTFmb7lwoo3iGH4auhp9kxae0cGBRYb/9URRCMGnT+0Knew
         /Cv2vX0lxILkc5TP0lnmCfLkk0Z3eUPCnVNFgQm73S3R2+NKgxmORsuxj9EBGze0di
         5k01Md8t17sXBj9YkcoNiThJiXo4XmpX4a0gMLAzaiLqzfo2gXwg9ZNaf9+UwZPa4j
         KG72rIjbXzIJg5mSxwWAKYxGSDrK4axVfUxu5tNiA57rYz1MIpGg1YgMbcrNcBb3PG
         GAyzq6z1qmprLeOaggysqblSYVaDd8SUdJTShjQFAhJr5SRetW7vgJRk3ouZjYL0uC
         Po72e/5PBQGsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5C70E1F66B;
        Sat, 14 Oct 2023 00:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: ti: icssg-prueth: Fix tx_total_bytes count
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169724402474.30425.14506920247317022113.git-patchwork-notify@kernel.org>
Date:   Sat, 14 Oct 2023 00:40:24 +0000
References: <20231012064626.977466-1-danishanwar@ti.com>
In-Reply-To: <20231012064626.977466-1-danishanwar@ti.com>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, srk@ti.com, vigneshr@ti.com,
        r-gunasekaran@ti.com, rogerq@kernel.org, andrew@lunn.ch
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 12:16:26 +0530 you wrote:
> ICSSG HW stats on TX side considers 8 preamble bytes as data bytes. Due
> to this the tx_bytes of ICSSG interface doesn't match the rx_bytes of the
> link partner. There is no public errata available yet.
> 
> As a workaround to fix this, decrease tx_bytes by 8 bytes for every tx
> frame.
> 
> [...]

Here is the summary with links:
  - [v2] net: ti: icssg-prueth: Fix tx_total_bytes count
    https://git.kernel.org/netdev/net/c/2c0d808f36cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


