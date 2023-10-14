Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ECA7C91CE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjJNAai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjJNAa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:30:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30A4CC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1986EC43397;
        Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697243427;
        bh=7xfhkf9yKZYMHOIzM0/KeKtAWNEDZuqpW4TLaNUbC3I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BaZ0vWOzlGSp31B8JlmVTwapr2a0Mo97l7+hK0tri0ir1J6gqyIzgH85Js5opU+Gl
         KM3dleWDeen1ajefQA7T6vXRXeTQ5jaJ+ooEk/l484tZ77XdjJSx8+F230RIQUxnpq
         n4xMXLE7K94GMnizujnT+/XA804xi8WyiP+uBic7VkHSSURf6n0p9z49mwkgLCMYPN
         F6F7TQMdmwgpSfz8uEPLzcOLNBIFftH72/7zik3E2fxFvAxzRNjmwMmW+Xnp/f7ZNK
         EF39PwqOf3cuVYbEMN5vyNjvT7vTHGF4VUh1JV53afrkz9iixr93nvGXGLCKKetM9A
         n7NVOoMcftugQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EAE60E1F666;
        Sat, 14 Oct 2023 00:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ionic: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169724342695.24435.11221830253130686654.git-patchwork-notify@kernel.org>
Date:   Sat, 14 Oct 2023 00:30:26 +0000
References: <20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_main-c-v1-1-23c62a16ff58@google.com>
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_main-c-v1-1-23c62a16ff58@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     shannon.nelson@amd.com, brett.creeley@amd.com, drivers@pensando.io,
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

On Wed, 11 Oct 2023 21:53:44 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not needed due to `ident` being memset'd to 0 just before
> the copy.
> 
> [...]

Here is the summary with links:
  - ionic: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/ad0ebd8b4457

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


