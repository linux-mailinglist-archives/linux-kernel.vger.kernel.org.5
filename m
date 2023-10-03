Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEF17B65E4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239824AbjJCJuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239793AbjJCJu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:50:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE8B9E;
        Tue,  3 Oct 2023 02:50:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 299D3C433C9;
        Tue,  3 Oct 2023 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696326624;
        bh=y7mQxJnkRB98psYX745aFCncUuqe078K1Ap5IaeIaaE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qULOOE7mwt9ghVrmiiYqZGaZvfZE/LpSgDfVCjWQnudkxqERiNrydhJmJpWDuU8UL
         hfwLgNF5hK56g54worL8RvXWEOOolcWEWZQjb8KgtqSuHmSJkY2q718pPcUKOeKjE3
         jEhTKG7khr6/Fx26axEPzlTIVbGYqTyvKWx7cSkkGdN9xUmyEmtHmCk+ATtMEqUFes
         zwQIBtvJSdt7SuDyHUAbqpImQbOxOa9MYc6U9EPeNHRiReCnrPSPxxwyvRl6H8miza
         LU+Dl+NS3qKTJzvXRnO+FQPYCS10/TnJsSM9QcSf8yEaVOVrglEPqS/0o00IY/kGxn
         zK1dO0OiEyZhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B8ACE632D1;
        Tue,  3 Oct 2023 09:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] udp_tunnel: Use flex array to simplify code
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169632662404.31348.9179995662374808172.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Oct 2023 09:50:24 +0000
References: <4a096ba9cf981a588aa87235bb91e933ee162b3d.1695542544.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <4a096ba9cf981a588aa87235bb91e933ee162b3d.1695542544.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
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
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 24 Sep 2023 10:03:07 +0200 you wrote:
> 'n_tables' is small, UDP_TUNNEL_NIC_MAX_TABLES	= 4 as a maximum. So there
> is no real point to allocate the 'entries' pointers array with a dedicate
> memory allocation.
> 
> Using a flexible array for struct udp_tunnel_nic->entries avoids the
> overhead of an additional memory allocation.
> 
> [...]

Here is the summary with links:
  - [net-next] udp_tunnel: Use flex array to simplify code
    https://git.kernel.org/netdev/net-next/c/ef35bed6fad6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


