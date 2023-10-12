Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884CF7C61C0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 02:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376688AbjJLAag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 20:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376600AbjJLAa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 20:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418579D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 17:30:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF8EDC433B8;
        Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697070625;
        bh=JygYXv/iY2L4YfL3LQXXh3cOvpCmrEV6BuAM2IZkvXU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=V7eJ3qhNjVkM7W5nCe7ih12nbjrJysAUnTPoR5w4YneFbMZzrhySAvPkyZX3AVMys
         e122Nx+q6x62Pp4oUtkUZdUifT2npjT5Y9Fpa0E1PGCzhcBMxJk6DV0ZDNIpq2taJP
         paMVYkyF2itpgpRVXmeqqUnwtSoGUioS0Uy3gFOR1G+SK1CH2up+CPKYJYEU75TK8J
         MC8hfNd64OgOsUfK5lNnhVGJuVAj0gLuiC2aRPXG2JfQoiGgUtFn/nFIRHYjKVe4NJ
         LaQ9RbZAQ9ngZx/RRL/QFKsuQ+rqHuX3onTREU9ji13+513/nOtDCbPlaC/eVvNbha
         DohCAI57xzIMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8421E000BB;
        Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] octeontx2-af: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169707062568.15864.7454843502958715402.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 00:30:25 +0000
References: <20231010-strncpy-drivers-net-ethernet-marvell-octeontx2-af-cgx-c-v1-1-a443e18f9de8@google.com>
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-marvell-octeontx2-af-cgx-c-v1-1-a443e18f9de8@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Oct 2023 21:38:11 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We can see that linfo->lmac_type is expected to be NUL-terminated based
> on the `... - 1`'s present in the current code. Presumably making room
> for a NUL-byte at the end of the buffer.
> 
> [...]

Here is the summary with links:
  - octeontx2-af: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/473f8f2d1bfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


