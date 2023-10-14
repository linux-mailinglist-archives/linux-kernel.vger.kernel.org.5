Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E797C91CD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjJNAac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJNAa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B9C0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1387C433CD;
        Sat, 14 Oct 2023 00:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697243427;
        bh=QLh7oSokX/rC9zSWUn+z4oaePbGDrDJFlc+FBj6TeBo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ldC8qNB0BNr4Gjt2IQwyMx42j7bHFZM9nUZVNIyMKQxWpykqFzQj9pn0WxeShJNKw
         TGYGdyawne0rLosZBNystcJZZY8XW5koWRO8vPM+E+HBpMfFVAFNEFzHpX9TuC3Stu
         2JG/ibjl+WuvD1HNDbQyyVTQY40iIOCpO4gJIOnTu5wUzq16k99B++a/lk0Op0Hz2e
         oVxn/L+/3v1CFuk5gHkOxpHInasNgv0jLf3JCALfiWz4/8tSrsIGK1+pwSmP0S41Q7
         mA17OZGun3yp6gU5G4upNCI4tmbdL3ULH8+z9E8aIsF1gviDwVNRUX2WgCNPMuWlzZ
         jNgiVduL1kKug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9B52C691EF;
        Sat, 14 Oct 2023 00:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sparx5: replace deprecated strncpy with ethtool_sprintf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169724342688.24435.6284977405562328203.git-patchwork-notify@kernel.org>
Date:   Sat, 14 Oct 2023 00:30:26 +0000
References: <20231011-strncpy-drivers-net-ethernet-microchip-sparx5-sparx5_ethtool-c-v1-1-410953d07f42@google.com>
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-microchip-sparx5-sparx5_ethtool-c-v1-1-410953d07f42@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Wed, 11 Oct 2023 21:37:18 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy() in favor of this more robust and easier to
> understand interface.
> 
> [...]

Here is the summary with links:
  - net: sparx5: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/e343023e03d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


