Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9767CB71E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjJPXke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjJPXk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:40:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8935AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E746C43395;
        Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697499625;
        bh=e7qgiujjUVa5yHpuG+b1NZk2F8mymAlM6GQvCqMJAV0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m5Ef6oGLnfHHPgFWyY4S1XxZP5p6jM5aLF44CzW4HJlmcNFwN+pVqG2sSAOYPJwGN
         CW8/GYBaNh1y4/Z4VG2bMye2peKektfi8a0o+I95imifDTHvxBbztu4qR2HnHc3+WY
         A2XsBXc9Qp2/sQHUvUoYuSyhJj4dol3BfVkNy5wd9xzM+CbxSRChr269Z00lilIxmZ
         LpuZmTTCU6H1V3S7krWAv9yxuj78EtreRxxEU4yFEtZLA9g/m22EZLjfW8FCyQ/RCg
         jNdEYZgHSuL0jH/OMvB+IrFf1jaQYDrRnkUL7eMpvEMaTVRnUDbbFIkZcbIpaiekAA
         evaaTQHvXEyew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3561AC04E32;
        Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169749962521.28594.9573819095136256613.git-patchwork-notify@kernel.org>
Date:   Mon, 16 Oct 2023 23:40:25 +0000
References: <20231012-strncpy-drivers-net-usb-sr9800-c-v1-1-5540832c8ec2@google.com>
In-Reply-To: <20231012-strncpy-drivers-net-usb-sr9800-c-v1-1-5540832c8ec2@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Thu, 12 Oct 2023 22:33:34 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Other implementations of .*get_drvinfo use strscpy so this patch brings
> sr_get_drvinfo() in line as well:
> 
> [...]

Here is the summary with links:
  - net: usb: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/1cfce8261d9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


