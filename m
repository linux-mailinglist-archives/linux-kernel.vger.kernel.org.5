Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADAE7F2C95
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbjKUMK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjKUMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:10:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFC7121
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:10:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB0A4C433C8;
        Tue, 21 Nov 2023 12:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700568622;
        bh=95lFkvBi4thqbuTZpdKbkrRHuadtzCBOh65FH6sQF/Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MNZr0QRpNMavHONCW1o/zePPcl8ynlHPqel9gV/PhkVfdJ1C09zs1vvOnAQ4QajZn
         EIWuY1xGGYnmcecJwKhk4B8UII7pT0BulYJzyuNSx/VqqB0BfoPIGNlVSnumm9MrVn
         pN43zv9oKOZTfiDGIkD/1+wyJPbhHisSE7PStBbwglFaa6AO0xwXuYgKDHQSS3jSMl
         i7JJPe9SYj9onPkoDZ2w8CTXfVRKWH3vheM/8Ti9KAeYUa0GG4c0LAR8zD8zbDTHAQ
         9Oyw38/Sg8eCja00pvL5YO9BSSRjlLrkSoul9hAZIpUB5O/SIZCAXTbyF1uwJ8wrtf
         IhSiStCTG6BJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A056EEAA95F;
        Tue, 21 Nov 2023 12:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ipv4: Correct/silence an endian warning in
 __ip_do_redirect
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170056862265.12494.10990480171359832786.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Nov 2023 12:10:22 +0000
References: <20231119141759.420477-1-chentao@kylinos.cn>
In-Reply-To: <20231119141759.420477-1-chentao@kylinos.cn>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, kunwu.chan@hotmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com
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
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 19 Nov 2023 22:17:59 +0800 you wrote:
> net/ipv4/route.c:783:46: warning: incorrect type in argument 2 (different base types)
> net/ipv4/route.c:783:46:    expected unsigned int [usertype] key
> net/ipv4/route.c:783:46:    got restricted __be32 [usertype] new_gw
> 
> Fixes: 969447f226b4 ("ipv4: use new_gw for redirect neigh lookup")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [v2] ipv4: Correct/silence an endian warning in __ip_do_redirect
    https://git.kernel.org/netdev/net/c/c0e2926266af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


