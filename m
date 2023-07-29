Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178647680BE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 19:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjG2RUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 13:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG2RUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 13:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF071716
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 10:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D25D360C83
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 17:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3345EC433C8;
        Sat, 29 Jul 2023 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690651221;
        bh=HGCU0Wu3IHcjCDcOzH1VNDX6WUxYD5nlAGAUD7BACrw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ehkkYi0qyRBq7NpJBHNtWFeyuBPiX1vlWr2UgT/Wp7oh26OrN0CSnrewauBbyCZv9
         a4+BELWf3/qSegXOdUoDSkk45w6LS9S4AGBfkiIRbjjmti/TU4mDzr+SB3EXdlCh8r
         kGRiIVVCBthzx7/RcZljQYV+IaU4FkPvx0gPDD8ThDUsBNDc7l44lQnFN52eZ9Ui+i
         n1IDHW5Rko05+jks3V3UMWmpLLaVkBSTbb9C60REDJMvwbn67kBM90hMzkcBh5dklb
         yIltoymF9tMOBnSk1yT2Y+lTnZJqm4sjhjyyKGAt5WCU2TfiVBLLFxhE+v2wDcMgHX
         JfgxOtOxfnZfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18976C43169;
        Sat, 29 Jul 2023 17:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/1] net: gro: fix misuse of CB in udp socket lookup
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169065122109.20073.13115022881374676943.git-patchwork-notify@kernel.org>
Date:   Sat, 29 Jul 2023 17:20:21 +0000
References: <20230727152503.GA32010@debian>
In-Reply-To: <20230727152503.GA32010@debian>
To:     Richard Gobert <richardbgobert@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        dsahern@kernel.org, tom@herbertland.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gal@nvidia.com
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 27 Jul 2023 17:25:11 +0200 you wrote:
> GRO stack uses `udp_lib_lookup_skb` which relies on IP/IPv6 CB's info, and
> at the GRO stage, CB holds `napi_gro_cb` info. Specifically,
> `udp_lib_lookup_skb` tries to fetch `iff` and `flags` information from the
> CB, to find the relevant udp tunnel socket (GENEVE/VXLAN/..). Up until a
> patch I submitted recently [0], it worked merely by luck, due
> to the layouts of `napi_gro_cb` and IP6CB.
> 
> [...]

Here is the summary with links:
  - [v3,1/1] net: gro: fix misuse of CB in udp socket lookup
    https://git.kernel.org/netdev/net/c/7938cd154368

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


