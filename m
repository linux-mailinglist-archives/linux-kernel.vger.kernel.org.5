Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B302377B145
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjHNGMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbjHNGLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:11:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A4130E1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:10:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D2EC62F3A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D181BC433C9;
        Mon, 14 Aug 2023 06:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691993423;
        bh=NHnjRKtw8AgBc1nGIFhnjo9Ir+/TB9yG1+otJ39s1mM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dK6N5B9T7MU3nZsq0jm7eM98Y2swR8l0mgR2gpc3z55kNI4pSh0UuvQdhWKr/Cmj2
         pDk9ymc8c9qxOlH/7n8dtF/lCag28JQDpAlZ1Dnamx4+dZrTfRvHDBdAUBn8pkmjTb
         zs/2sAdQNLBvzqbb6tHxqLt6JIgmS9gP3+UuQ8L8YHLEu9WoC1T4cf1iTwJi/QQgcY
         lR6vFBl7Ykx1FrmtaLUIrWG4Y2KiSL1D+C7hcEaHYDWIF0JiBL0bezE5KhB6xqiR1+
         r6UtMnGLahFxoVlU40OYgZMZZxUmfWjuBoTDRRLz0ZaWE3gZHybuB3ddlRdIr0j8E1
         xiQxyvJ8CGxBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B51E9E93B34;
        Mon, 14 Aug 2023 06:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/14] mptcp: get rid of msk->subflow
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169199342373.13316.7611325761631728090.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Aug 2023 06:10:23 +0000
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     mptcp@lists.linux.dev, martineau@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuniyu@amazon.com
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 17:57:13 +0200 you wrote:
> The MPTCP protocol maintains an additional struct socket per connection,
> mainly to be able to easily use tcp-level struct socket operations.
> 
> This leads to several side effects, beyond the quite unfortunate /
> confusing 'subflow' field name:
> 
> - active and passive sockets behaviour is inconsistent: only active ones
>   have a not NULL msk->subflow, leading to different error handling and
>   different error code returned to the user-space in several places.
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] mptcp: avoid unneeded mptcp_token_destroy() calls
    https://git.kernel.org/netdev/net-next/c/131a627751e3
  - [net-next,02/14] mptcp: avoid additional __inet_stream_connect() call
    https://git.kernel.org/netdev/net-next/c/ccae357c1c6a
  - [net-next,03/14] mptcp: avoid subflow socket usage in mptcp_get_port()
    https://git.kernel.org/netdev/net-next/c/cfb63e50d319
  - [net-next,04/14] net: factor out inet{,6}_bind_sk helpers
    https://git.kernel.org/netdev/net-next/c/e6d360ff87f0
  - [net-next,05/14] mptcp: mptcp: avoid additional indirection in mptcp_bind()
    https://git.kernel.org/netdev/net-next/c/8cf2ebdc0078
  - [net-next,06/14] net: factor out __inet_listen_sk() helper
    https://git.kernel.org/netdev/net-next/c/71a9a874cd6b
  - [net-next,07/14] mptcp: avoid additional indirection in mptcp_listen()
    https://git.kernel.org/netdev/net-next/c/40f56d0c7043
  - [net-next,08/14] mptcp: avoid additional indirection in mptcp_poll()
    https://git.kernel.org/netdev/net-next/c/5426a4ef6455
  - [net-next,09/14] mptcp: avoid unneeded indirection in mptcp_stream_accept()
    https://git.kernel.org/netdev/net-next/c/1f6610b92ac3
  - [net-next,10/14] mptcp: avoid additional indirection in sockopt
    https://git.kernel.org/netdev/net-next/c/f0bc514bd5c1
  - [net-next,11/14] mptcp: avoid ssock usage in mptcp_pm_nl_create_listen_socket()
    https://git.kernel.org/netdev/net-next/c/3aa362494170
  - [net-next,12/14] mptcp: change the mpc check helper to return a sk
    https://git.kernel.org/netdev/net-next/c/3f326a821b99
  - [net-next,13/14] mptcp: get rid of msk->subflow
    https://git.kernel.org/netdev/net-next/c/39880bd808ad
  - [net-next,14/14] mptcp: Remove unnecessary test for __mptcp_init_sock()
    https://git.kernel.org/netdev/net-next/c/e263691773cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


