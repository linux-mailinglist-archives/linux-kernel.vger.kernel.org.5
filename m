Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6EC766806
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjG1JAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjG1JAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:00:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320DFE7E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:00:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9F6C62081
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15F80C433BC;
        Fri, 28 Jul 2023 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690534828;
        bh=OZLB1TlYuhOUluQEOXMdJljYbREOPCoaejaLskUJsro=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KP31QNIhYbIcx4YnOIeBngeqJ/TqKNaQlTPAkwUcsyvMASu+cpPZhgtiFJU+vtHSG
         zCu/91fHASrD/iZSKBVWdQmg6n4GcOG5oHeYkdEYOmbtywJRgmON+lvhPc7tYkWitd
         W8FvanvoUfpVGBbN5uNCm/VT9NqeuCAaUoJiKIiTHwyiuIPuT/d+Zpk8XaGE2/OEEL
         jP3Rotg4WtxzPVDAJPLqd58HlXi8DEE0K3o+gIuZPCV5gyg/GvuH37ZFWoJdVFup75
         AVRDnhgel8UI5FpvSsN/ngRSutZ3bzMrWqLzM40XtPB2KOoR0fqy3pS3ltGcGwT6Gl
         UiHpQEjQ3cfug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED0B2C39562;
        Fri, 28 Jul 2023 09:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v2 0/2] rxfh with custom RSS fixes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169053482796.22021.4158483891713381939.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Jul 2023 09:00:27 +0000
References: <20230725205655.310165-1-jdamato@fastly.com>
In-Reply-To: <20230725205655.310165-1-jdamato@fastly.com>
To:     Joe Damato <jdamato@fastly.com>
Cc:     netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
        ecree@solarflare.com, andrew@lunn.ch, kuba@kernel.org,
        davem@davemloft.net, leon@kernel.org, pabeni@redhat.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 25 Jul 2023 20:56:53 +0000 you wrote:
> Greetings:
> 
> Welcome to v2, now via net-next. No functional changes; only style
> changes (see the summary below).
> 
> While attempting to get the RX flow hash key for a custom RSS context on
> my mlx5 NIC, I got an error:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: ethtool: Unify ETHTOOL_{G,S}RXFH rxnfc copy
    https://git.kernel.org/netdev/net-next/c/801b27e88046
  - [net-next,v2,2/2] net/mlx5: Fix flowhash key set/get for custom RSS
    https://git.kernel.org/netdev/net-next/c/0212e5d915a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


