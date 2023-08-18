Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0B278157B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 00:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241690AbjHRWkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 18:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241647AbjHRWkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 18:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A731BD4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1279610A6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 22:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02602C433C9;
        Fri, 18 Aug 2023 22:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692398422;
        bh=pphJOl9LcFEZfc59hQjrvgqeXPyUvIX5+2mgM8hIiEI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gUWo3mUNIMdzj8iXHIj565OjfnBqZ+HHuk3n6o29sXre0/8M3IMuSy05Bw5RU2e7i
         cINMR7VYgJinU9sFDw/xY2MJHeL/mZwAPj7ijGj4XkVxg8U3K2p2POxTlMpd8uwyWs
         DDbtDmUIxjktYn4K/Pcw3AD72PW7Q7q4I/adQxa71M6hTD16+0wdym0XppgDnyKr1R
         YrepK3lCl0o9GzyMG3Up0PQD9iQmcfMt3GL4/fXJlWuPF9uwYEZripbYPMeQS4Fnse
         okXqR74Q+BzixfjwFhC2dgoRMWxaBa+v0cRnH1dhR2j8u/e3CwHxOe90SyfiIBk4EA
         MKalbsKrrA2qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D449AC395DC;
        Fri, 18 Aug 2023 22:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net Patch] octeontx2-af: SDP: fix receive link config
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169239842186.2718.13546826553275633730.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Aug 2023 22:40:21 +0000
References: <20230817063006.10366-1-hkelam@marvell.com>
In-Reply-To: <20230817063006.10366-1-hkelam@marvell.com>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, sgoutham@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, lcherian@marvell.com,
        sbhatta@marvell.com, naveenm@marvell.com, edumazet@google.com,
        pabeni@redhat.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Aug 2023 12:00:06 +0530 you wrote:
> On SDP interfaces, frame oversize and undersize errors are
> observed as driver is not considering packet sizes of all
> subscribers of the link before updating the link config.
> 
> This patch fixes the same.
> 
> Fixes: 9b7dd87ac071 ("octeontx2-af: Support to modify min/max allowed packet lengths")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: SDP: fix receive link config
    https://git.kernel.org/netdev/net/c/05f3d5bc2352

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


