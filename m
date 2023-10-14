Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FE47C91A0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjJNAAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjJNAA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:00:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67361AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:00:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10424C433B9;
        Sat, 14 Oct 2023 00:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697241626;
        bh=2Cwm6LisU+P9GUP96QYZ7Q9NvdOC7Vh28XyKKYvVGZc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rLbE/XrlMcyajcNIas0Ah3tA53LrR9kXnNeUanCVaIKdMxwgBQ1NnqKpUaCQ2HrvP
         wbUrO0cP/19kUrYoHn+unf1E2eVU6eDJ22LsiIb3VDzTsZc8tQg60H6MSZXYx2gg6R
         oGCx6G0c0CADcjOA+gV2uxxyJeZdTI2sQa20M25/E9Ca0O4rS/3qeVDzCMdtxAAd1V
         1mtruKPEQvBFHv8tp2CG1yewrCqd4/aq/DOuxzQu+nb7yaBKvr/I/expxW9bfEWegr
         /JCXz3Pow1yzhLQwc9qPbt1e8HVd0zhZ+2Ca3zJHFQKGUl5HUACAtNeLkewu4bsnZY
         lR+QP3eiIPjMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2A81C73FEA;
        Sat, 14 Oct 2023 00:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: dsa: vsc73xx: replace deprecated strncpy with
 ethtool_sprintf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169724162599.10042.9303043491352873770.git-patchwork-notify@kernel.org>
Date:   Sat, 14 Oct 2023 00:00:25 +0000
References: <20231010-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v2-1-ba4416a9ff23@google.com>
In-Reply-To: <20231010-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v2-1-ba4416a9ff23@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
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

On Tue, 10 Oct 2023 22:32:35 +0000 you wrote:
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
  - [v2] net: dsa: vsc73xx: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/e3bbab4754de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


