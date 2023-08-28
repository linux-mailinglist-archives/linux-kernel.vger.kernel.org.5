Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC9178A8F8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjH1Jat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjH1Jad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:30:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE204BE;
        Mon, 28 Aug 2023 02:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A139635AC;
        Mon, 28 Aug 2023 09:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6703C43395;
        Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693215029;
        bh=DyjistNpfQlse3jCh5g2R74pkQlmRRv890yjBn+4RIE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gWHjivKdsW5ws9PyRgXnlHtcMIsheDzQAhTtcSTAafbMgHSTD54+Mg0g1vyOrJYEs
         OWjjBogoUPEhaMyJzJ9rr1w8rqlQZQlMMTKDbk7/fX+CHaqgXj5y1myozhXmufWa6R
         IhBg/n2+uSB69ne5N6hmSYiktRibPO9VF1s5l0nS5Yhf0NErsCxuhApLL2XHLWRVWr
         ezuB8d93yvMpyGZBifKsENBTxVxIc+96sNrO9kzUbTZF5rpI8lSIJ0Sh78BI2+EV44
         X01QKzjet8Guxme/Jf7a/h5LAC1wj8Az3z2o+q2LgqHZ72NyZNd/ajHUm8oyIE6/w2
         UaySH4g5OB9Ig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B329EC3274C;
        Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ethernet: tg3: remove unreachable code
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169321502973.13199.8379981419921280271.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Aug 2023 09:30:29 +0000
References: <20230825190443.48375-1-m.kobuk@ispras.ru>
In-Reply-To: <20230825190443.48375-1-m.kobuk@ispras.ru>
To:     Mikhail Kobuk <m.kobuk@ispras.ru>
Cc:     siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        jdelvare@suse.com, linux@roeck-us.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        lvc-project@linuxtesting.org, khoroshilov@ispras.ru
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
by David S. Miller <davem@davemloft.net>:

On Fri, 25 Aug 2023 22:04:41 +0300 you wrote:
> 'tp->irq_max' value is either 1 [L16336] or 5 [L16354], as indicated in
> tg3_get_invariants(). Therefore, 'i' can't exceed 4 in tg3_init_one()
> that makes (i <= 4) always true. Moreover, 'intmbx' value set at the
> last iteration is not used later in it's scope.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Here is the summary with links:
  - ethernet: tg3: remove unreachable code
    https://git.kernel.org/netdev/net/c/ec1b90886f3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


