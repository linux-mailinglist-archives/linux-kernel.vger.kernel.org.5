Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393647BF119
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441952AbjJJCug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441929AbjJJCu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:50:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55524A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:50:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE742C433CA;
        Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696906225;
        bh=Q5s1VZPYSu7cCJ2rJAuxMhAetdHKNdZm685p/HDoroc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=n/ijsvDhn+w7otl1J7HbIa+sLxP8OUx0bIN0E55RYLohfPhgjOagv/PWODvsYJdGH
         FlWCuFPQDjjWyYJno+NdcA4PghE30mfKmcxzhVQUD9itTSzhvCMt+YZ7ZTTxuSyaLA
         4LP8evtXoHO9LgLMq9/p3iC/hcntejZuLeBVFClREpbu0/k5da0QPXKFBghG754NRm
         OuL8uIb8sI3H3SWKQg9H4d4hkYu1ERFI8ljvOPWvyWxCFPDxc7rJskW2ByDovF//AS
         vLdnF9TwDBUjh7/bfdiHUji+T2sO61DZLI00un02sS7sQ6/A5+eSVX0moRYXzg3PWJ
         lT8AnIiXS7wqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FFE2E11F4C;
        Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cavium/liquidio: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169690622558.548.11736861209884778850.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Oct 2023 02:50:25 +0000
References: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-octeon_device-c-v1-1-9a207cef9438@google.com>
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-octeon_device-c-v1-1-9a207cef9438@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Oct 2023 22:52:34 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `app_name` to be NUL-terminated:
> 	dev_info(&oct->pci_dev->dev,
> 		 "Running %s (%llu Hz)\n",
> 		 app_name, CVM_CAST64(cs->corefreq));
> ... and it seems NUL-padding is not required, let's opt for strscpy().
> 
> [...]

Here is the summary with links:
  - cavium/liquidio: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/c04235395595

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


