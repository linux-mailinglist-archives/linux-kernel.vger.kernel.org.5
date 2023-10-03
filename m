Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC67B6302
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjJCIAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJCIAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:00:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8111A3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:00:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73092C433CC;
        Tue,  3 Oct 2023 08:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696320024;
        bh=E0jQM8BhH2LaM0xbaK0cMDCk7fz6afRN3SBgIT/MWb8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QSMr3GRSqmxe5UmQtAuouUyB593eq81NTZj+WGBXmflBZVC4p7Sywvj3EyBxju9Pv
         Fe/Y6jHOQ0jqWFPOfl7XrYZLUcNqRcV1Etxayh4ut9vSIzTG2Z981jjuIY8zps/P/U
         L/3q4q1DiqPcnHa3iR0a55b0SAAH/aO0T48t7KN+I+ElKj+eMqlSUJvb7EQAGaM2no
         AF6DKXnuID3hV1A81TXYi5A/zjD95pLMl/HRYhyzHwZb1h/d8PhVckJ9B8ODIltg36
         dJkUs/3qg4PUzaTKBASIy4i0m+Jxv6oPBFw01NPw6l2vAzW36vVpjB4DumBSh+bKWM
         yS0blIP9xr5jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5869EE632D8;
        Tue,  3 Oct 2023 08:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: tcp: add a missing nf_reset_ct() in 3WHS handling
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169632002435.14594.164514284857184031.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Oct 2023 08:00:24 +0000
References: <20230922210530.2045146-1-i.maximets@ovn.org>
In-Reply-To: <20230922210530.2045146-1-i.maximets@ovn.org>
To:     Ilya Maximets <i.maximets@ovn.org>
Cc:     netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, dsahern@kernel.org, fw@strlen.de,
        madhu.koriginja@nxp.com, frode.nordahl@canonical.com,
        steffen.klassert@secunet.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 22 Sep 2023 23:04:58 +0200 you wrote:
> Commit b0e214d21203 ("netfilter: keep conntrack reference until
> IPsecv6 policy checks are done") is a direct copy of the old
> commit b59c270104f0 ("[NETFILTER]: Keep conntrack reference until
> IPsec policy checks are done") but for IPv6.  However, it also
> copies a bug that this old commit had.  That is: when the third
> packet of 3WHS connection establishment contains payload, it is
> added into socket receive queue without the XFRM check and the
> drop of connection tracking context.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: tcp: add a missing nf_reset_ct() in 3WHS handling
    https://git.kernel.org/netdev/net/c/9593c7cb6cf6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


