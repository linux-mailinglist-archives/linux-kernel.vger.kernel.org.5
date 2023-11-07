Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765EA7E4BB6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343863AbjKGWad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjKGWa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:30:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE4F11C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:30:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5102DC433C9;
        Tue,  7 Nov 2023 22:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699396225;
        bh=Sv7q1sNgQia3vuFypk7za9VXVHxLOURPlsbpg/VVoT4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Fygoei7zNisCrNMvd48rC433GwgB/PJFVRECU5rg34Y1H7/EQ/acPEuwRJUZdSXhp
         uwDLHKuzcy0LDPgLomuKGHfGbtj1Ip9aYLeJa1YtB+Ow/NaVUws09sy1Gi6q9a2gp9
         krzQf31jbVrUE/4A/iJQOGb4eKlfvdWM4xr4SpWuwWoMFLTHVS7+Yn553ImmApItJj
         nxh/Pg051l+LhcbbU38mtn9cfxdOq5psHeAA16Ah5ZF8RwZ/dTFXtUlBwnvu0tr7UN
         aPoYUTib5JBKVxFgakHkRzLaPktm5xkB3QdZZSML1/6CG+gGlY+VtJpd4NAjCRorV5
         A27Ovot0cSwqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3550BE00087;
        Tue,  7 Nov 2023 22:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] vsock: fix server prevents clients from reconnecting
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169939622521.29953.960000418979346249.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Nov 2023 22:30:25 +0000
References: <20231103175551.41025-1-f.storniolo95@gmail.com>
In-Reply-To: <20231103175551.41025-1-f.storniolo95@gmail.com>
To:     None <f.storniolo95@gmail.com>
Cc:     luigi.leonardi@outlook.com, kvm@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, mst@redhat.com,
        imbrenda@linux.vnet.ibm.com, kuba@kernel.org, asias@redhat.com,
        stefanha@redhat.com, pabeni@redhat.com, sgarzare@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  3 Nov 2023 18:55:47 +0100 you wrote:
> From: Filippo Storniolo <f.storniolo95@gmail.com>
> 
> This patch series introduce fix and tests for the following vsock bug:
> If the same remote peer, using the same port, tries to connect
> to a server on a listening port more than once, the server will
> reject the connection, causing a "connection reset by peer"
> error on the remote peer. This is due to the presence of a
> dangling socket from a previous connection in both the connected
> and bound socket lists.
> The inconsistency of the above lists only occurs when the remote
> peer disconnects and the server remains active.
> This bug does not occur when the server socket is closed.
> 
> [...]

Here is the summary with links:
  - [net,1/4] vsock/virtio: remove socket from connected/bound list on shutdown
    https://git.kernel.org/netdev/net/c/3a5cc90a4d17
  - [net,2/4] test/vsock fix: add missing check on socket creation
    https://git.kernel.org/netdev/net/c/bfada5a7672f
  - [net,3/4] test/vsock: refactor vsock_accept
    https://git.kernel.org/netdev/net/c/84d5fb974131
  - [net,4/4] test/vsock: add dobule bind connect test
    https://git.kernel.org/netdev/net/c/d80f63f69025

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


