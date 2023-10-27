Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871917D948D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345593AbjJ0KAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjJ0KAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:00:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E1A10E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:00:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 253DFC433C8;
        Fri, 27 Oct 2023 10:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698400833;
        bh=acgkIgq+c+zzLDrNfvbjU1Kz+1KOS4/HgXyE8E8YI70=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Xx9Fmz9sIWoYJvyjoPvHTnW8ANqhIsaFVjkwntvnvaQBSA9eSg2fD74l0tAomnxI/
         XoAGAWZ6tzOGvMjUT7dmqh2yJro18BwkDIiOt6FIAKdOHEHSLjUsoRWTEPDlmdTt8u
         j5lC57fD0JgLgr8dFrmTEqdbMHiSb8nhhDPZCOplakoQGsiJ//6KbBjgtQRRfCSsq3
         3LOIVEN7nMy9rBAuxBs8cBYeqgDSa2t5gqGeop70RTIhkid5DPx1WL8VEH/QhkxqZY
         1Ny/HleMNd6XKUJssLRcaK/51kHYnDC6pq1IMq0Cdb8vOtq8cGutkw+ZRY2f2m8dmx
         oe/PEoaBMxATA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09308E11F56;
        Fri, 27 Oct 2023 10:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v16 net-next 01/23] net/tcp: Prepare tcp_md5sig_pool for
 TCP-AO
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169840083303.2931.6349303415176898109.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Oct 2023 10:00:33 +0000
References: <20231023192217.426455-2-dima@arista.com>
In-Reply-To: <20231023192217.426455-2-dima@arista.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com,
        kuba@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
        luto@amacapital.net, ardb@kernel.org, gilligan@arista.com,
        error27@gmail.com, David.Laight@aculab.com, 0x7f454c46@gmail.com,
        dcassidy@redhat.com, ebiggers@kernel.org, ebiederm@xmission.com,
        fruggeri05@gmail.com, dgaillar@ciena.com,
        herbert@gondor.apana.org.au, yoshfuji@linux-ipv6.org,
        colona@arista.com, cdleonard@gmail.com, mnassiri@ciena.com,
        noureddine@arista.com, horms@kernel.org, ftetreau@ciena.com,
        netdev@vger.kernel.org, Steen.Hegelund@microchip.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 23 Oct 2023 20:21:53 +0100 you wrote:
> TCP-AO, similarly to TCP-MD5, needs to allocate tfms on a slow-path,
> which is setsockopt() and use crypto ahash requests on fast paths,
> which are RX/TX softirqs. Also, it needs a temporary/scratch buffer
> for preparing the hash.
> 
> Rework tcp_md5sig_pool in order to support other hashing algorithms
> than MD5. It will make it possible to share pre-allocated crypto_ahash
> descriptors and scratch area between all TCP hash users.
> 
> [...]

Here is the summary with links:
  - [v16,net-next,01/23] net/tcp: Prepare tcp_md5sig_pool for TCP-AO
    https://git.kernel.org/netdev/net-next/c/8c73b26315aa
  - [v16,net-next,02/23] net/tcp: Add TCP-AO config and structures
    https://git.kernel.org/netdev/net-next/c/c845f5f3590e
  - [v16,net-next,03/23] net/tcp: Introduce TCP_AO setsockopt()s
    https://git.kernel.org/netdev/net-next/c/4954f17ddefc
  - [v16,net-next,04/23] net/tcp: Prevent TCP-MD5 with TCP-AO being set
    https://git.kernel.org/netdev/net-next/c/0aadc73995d0
  - [v16,net-next,05/23] net/tcp: Calculate TCP-AO traffic keys
    https://git.kernel.org/netdev/net-next/c/7c2ffaf21bd6
  - [v16,net-next,06/23] net/tcp: Add TCP-AO sign to outgoing packets
    https://git.kernel.org/netdev/net-next/c/1e03d32bea8e
  - [v16,net-next,07/23] net/tcp: Add tcp_parse_auth_options()
    https://git.kernel.org/netdev/net-next/c/f7dca36fc54a
  - [v16,net-next,08/23] net/tcp: Add AO sign to RST packets
    https://git.kernel.org/netdev/net-next/c/ba7783ad45c8
  - [v16,net-next,09/23] net/tcp: Add TCP-AO sign to twsk
    https://git.kernel.org/netdev/net-next/c/decde2586b34
  - [v16,net-next,10/23] net/tcp: Wire TCP-AO to request sockets
    https://git.kernel.org/netdev/net-next/c/06b22ef29591
  - [v16,net-next,11/23] net/tcp: Sign SYN-ACK segments with TCP-AO
    https://git.kernel.org/netdev/net-next/c/9427c6aa3ec9
  - [v16,net-next,12/23] net/tcp: Verify inbound TCP-AO signed segments
    https://git.kernel.org/netdev/net-next/c/0a3a809089eb
  - [v16,net-next,13/23] net/tcp: Add TCP-AO segments counters
    https://git.kernel.org/netdev/net-next/c/af09a341dcf6
  - [v16,net-next,14/23] net/tcp: Add TCP-AO SNE support
    https://git.kernel.org/netdev/net-next/c/64382c71a557
  - [v16,net-next,15/23] net/tcp: Add tcp_hash_fail() ratelimited logs
    https://git.kernel.org/netdev/net-next/c/2717b5adea9e
  - [v16,net-next,16/23] net/tcp: Ignore specific ICMPs for TCP-AO connections
    https://git.kernel.org/netdev/net-next/c/953af8e3acb6
  - [v16,net-next,17/23] net/tcp: Add option for TCP-AO to (not) hash header
    https://git.kernel.org/netdev/net-next/c/7753c2f0a857
  - [v16,net-next,18/23] net/tcp: Add TCP-AO getsockopt()s
    https://git.kernel.org/netdev/net-next/c/ef84703a911f
  - [v16,net-next,19/23] net/tcp: Allow asynchronous delete for TCP-AO keys (MKTs)
    https://git.kernel.org/netdev/net-next/c/d6732b95b6fb
  - [v16,net-next,20/23] net/tcp: Add static_key for TCP-AO
    https://git.kernel.org/netdev/net-next/c/67fa83f7c86a
  - [v16,net-next,21/23] net/tcp: Wire up l3index to TCP-AO
    https://git.kernel.org/netdev/net-next/c/248411b8cb89
  - [v16,net-next,22/23] net/tcp: Add TCP_AO_REPAIR
    https://git.kernel.org/netdev/net-next/c/faadfaba5e01
  - [v16,net-next,23/23] Documentation/tcp: Add TCP-AO documentation
    https://git.kernel.org/netdev/net-next/c/7fe0e38bb669

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


