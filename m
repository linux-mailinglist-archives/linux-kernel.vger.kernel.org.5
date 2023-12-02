Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08447801A96
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 05:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjLBEUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 23:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBEUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 23:20:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE863D40
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 20:20:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55B81C433C9;
        Sat,  2 Dec 2023 04:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701490824;
        bh=wY26yQIEBbe4Nr9NvsYTLwnEbE6uZhSZJ1xkeUJI2dM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OE9/YrLfJEZhgX63nlNw2azgOcPe/dNf2/yBrovdJdVvFBKdkXS2qTw9Nja5kK/wz
         LxzeLR02oAuI1PDjhz3qEVYpVTKPvtVySOKGvU1viYdrxmWzR3dCNr4sGJ8Jbz0KgN
         Ch7FFM6mC5OnqaAXxAWsr+FS4ylJXKBczJYE3I9XN5JvSAeglmV64A6IGn0aySxwQ9
         bMqQuutpptLKgbKSquJbeahve7MAE+krVxlXfR4jkurvBsqpKodTRDYHUQPcgUACKI
         vJbbHj8+K8BNgtcX84iv/mtR5L41IIbn12rLINgLI5CdznK+xSeEBxA7+A3ircVWUR
         IHraTD/zgEKEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F68AC64459;
        Sat,  2 Dec 2023 04:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] hv_netvsc: rndis_filter needs to select NLS
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170149082425.6898.11188583894805240877.git-patchwork-notify@kernel.org>
Date:   Sat, 02 Dec 2023 04:20:24 +0000
References: <20231130055853.19069-1-rdunlap@infradead.org>
In-Reply-To: <20231130055853.19069-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, haiyangz@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, horms@kernel.org, mikelley@microsoft.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Nov 2023 21:58:53 -0800 you wrote:
> rndis_filter uses utf8s_to_utf16s() which is provided by setting
> NLS, so select NLS to fix the build error:
> 
> ERROR: modpost: "utf8s_to_utf16s" [drivers/net/hyperv/hv_netvsc.ko] undefined!
> 
> Fixes: 1ce09e899d28 ("hyperv: Add support for setting MAC from within guests")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Simon Horman <horms@kernel.org> # build-tested
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 
> [...]

Here is the summary with links:
  - [v2] hv_netvsc: rndis_filter needs to select NLS
    https://git.kernel.org/netdev/net/c/6c89f4996437

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


