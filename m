Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEE97C91E6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjJNAu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJNAu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:50:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC2BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:50:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F488C433C8;
        Sat, 14 Oct 2023 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697244624;
        bh=R7XjRM7iJWEuyNXlp5L3QYzrLdxLerO7l23H1nDRFC8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PUiiKtYGKMRp+LCBOZmajgPm9Y7UjR1rGuGnq1OvquuURpLKsrDX2/xcyc3moclk1
         oaHd03hYvcd2kAC7I7bXXsW3d+M6+VqLICAUf5LPG33i/UGHfhrV8q7tSFKEkN7IxY
         lnT3AUrsdOx26Yz0a/0WDda+iDICvCI5FYvQfGzdRH2Rdv/HhMcT+tDZPX6IRWMx9v
         3voW+XpZ4lhYe+WWBblEtXEpsCnmFvEvAJxUErv8oieWErU3wPCWkgnLoQl53HsagP
         gDKsvznEO7Aw/6V9XvBHlZ3Z6NW3iEMljatCDpmgEjHh3eTR9aLMFhEPytOxOkdaD1
         vMw41wZQs8GDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F06FAC691EF;
        Sat, 14 Oct 2023 00:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] qed: replace uses of strncpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169724462397.2191.2269567778777339120.git-patchwork-notify@kernel.org>
Date:   Sat, 14 Oct 2023 00:50:23 +0000
References: <20231012-strncpy-drivers-net-ethernet-qlogic-qed-qed_debug-c-v2-1-16d2c0162b80@google.com>
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-qlogic-qed-qed_debug-c-v2-1-16d2c0162b80@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     aelior@marvell.com, manishc@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org
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

On Thu, 12 Oct 2023 18:35:41 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This patch eliminates three uses of strncpy():
> 
> Firstly, `dest` is expected to be NUL-terminated which is evident by the
> manual setting of a NUL-byte at size - 1. For this use specifically,
> strscpy() is a viable replacement due to the fact that it guarantees
> NUL-termination on the destination buffer.
> 
> [...]

Here is the summary with links:
  - [v2] qed: replace uses of strncpy
    https://git.kernel.org/netdev/net-next/c/a02527363abb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


