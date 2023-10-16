Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF0B7CB71F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjJPXkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjJPXk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:40:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE5BAC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AE6AC433D9;
        Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697499625;
        bh=/FgU5kDauKM9IPPi0zHSJGKdB5YjioF3gz7ynJlnTT4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hcZihHWRQhtb73R16oYrbIzoBEccDCEXbdHSGFSK9lXjIF0WGUUDSZcDUmLrdka9F
         c5iacHL538krCp6Yw3dhB7KuLAgbq7AWKYd477LouE5H5hHalQPRSNzKqYJGAymKFI
         p5BhQensqb7D78UVnAdl2y6h+mVlzJPLNgW5PQGxGHKT3/zJGD2mlvyzY2HgXaKcRf
         VY0p+h/3aVCpGp8CtSTQw6HMu6mZ+Kpcot5z+PXJumRc7tpr18a56Z5f9YMXCf5vct
         FzcAlkXlAB8bMwt9YP5oq1Kn3p8h/AnIUnTOSW9UIA0D2Bx4Q/lJ3NMqjFVzn2ZX23
         nrM64+vX8vzlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D77DC04E27;
        Mon, 16 Oct 2023 23:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] lan78xx: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169749962517.28594.16918982789792723022.git-patchwork-notify@kernel.org>
Date:   Mon, 16 Oct 2023 23:40:25 +0000
References: <20231012-strncpy-drivers-net-usb-lan78xx-c-v1-1-99d513061dfc@google.com>
In-Reply-To: <20231012-strncpy-drivers-net-usb-lan78xx-c-v1-1-99d513061dfc@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Thu, 12 Oct 2023 22:30:54 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Other implementations of .*get_drvinfo use strscpy so this patch brings
> lan78xx_get_drvinfo() in line as well:
> 
> [...]

Here is the summary with links:
  - lan78xx: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/2242f22ae509

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


