Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A033F7CB6F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjJPXU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjJPXUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:20:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCC795
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:20:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7281C433CA;
        Mon, 16 Oct 2023 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697498422;
        bh=SFVf1dut2cr8mYKcCmXD6aj+47GLfeCnx0HqaDEXnu0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SVPML+mHlskrz/hcDe6t9755ktQU+hgAG2RiODOuou49uaHEw/7FeotV5ofrFEuoM
         GmEuYREFSeg+YexJ1YC5kpD/V8Ynm4LBxkRhaA83ViNxq5RE6p7qjJHz0yjeSWomKH
         b6yX8BDRHhT2bf0iGElPdNQRvYALnoy5rXK3+P+OF5Nw2HzHtXYC8rlETzjoOT6rV+
         L/qQIt+ZJVgQ1S1Cem6Du7i7R0hsTDkXve1VrF1Ih0uRsGj+QnZqUVEOpjYhHKPKXk
         6NkkzOlie8dToXSWmZMVTBoOtUTCwX9omTdq42Nr6bltDTNZpvZWQ6HxGhXSLdwLYC
         rb8oxSsRLihng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBA1FC43170;
        Mon, 16 Oct 2023 23:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: netcp: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169749842182.17995.788376629952172297.git-patchwork-notify@kernel.org>
Date:   Mon, 16 Oct 2023 23:20:21 +0000
References: <20231012-strncpy-drivers-net-ethernet-ti-netcp_ethss-c-v1-1-93142e620864@google.com>
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-ti-netcp_ethss-c-v1-1-93142e620864@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
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

On Thu, 12 Oct 2023 21:05:40 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> [...]

Here is the summary with links:
  - net: netcp: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/eb7fa2eb9689

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


