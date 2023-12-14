Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09BB812561
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjLNCkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLNCkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:40:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB86BD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:40:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C30F5C433C7;
        Thu, 14 Dec 2023 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702521625;
        bh=RkWa2Vxp48FvhWUEDd4UAUVq0uHmwOqAASOVffoictA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EPdGwY0Ea+enh+Og3ixNEC6JafTwyIRlyh5MeZWpXddI8G+rXhH/A8j0nx1UAUGxQ
         aVQtVj+0naW/8J9yOrt9+fj03e1LhjGcoLlDIiMm/o+eWQnEme+KPk0jiwTsZBttB/
         WNSUNXy36Rg+MCrk0tCNdZUQ1RyE31NQhiLCo/TRcO3GVRmKo7U8CEs+fB4Sx7v7Uu
         dNV4UEB/xAeB7PCLyDwr5U1Tp8LJpoO3XqfcpE2uTkywvSKtiXW1Kr9W8Cl+WCWPf6
         mc+qFupyP8IJXKG5+h4B+jhBgxLWKJD8Yw5FPyqyG++ddSY1+Q7+DzcyQ5L4MgR8ty
         mI1SpzuTSnH/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5104DD4EFE;
        Thu, 14 Dec 2023 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] idpf: add get/set for Ethtool's header split
 ringparam
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170252162566.2494.10156204711336606229.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Dec 2023 02:40:25 +0000
References: <20231212142752.935000-1-aleksander.lobakin@intel.com>
In-Reply-To: <20231212142752.935000-1-aleksander.lobakin@intel.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, michal.kubiak@intel.com,
        przemyslaw.kitszel@intel.com, vladimir.oltean@nxp.com,
        andrew@lunn.ch, mkubecek@suse.cz, jiri@resnulli.us,
        paul.greenwalt@intel.com, anthony.l.nguyen@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Dec 2023 15:27:50 +0100 you wrote:
> Currently, the header split feature (putting headers in one smaller
> buffer and then the data in a separate bigger one) is always enabled
> in idpf when supported.
> One may want to not have fragmented frames per each packet, for example,
> to avoid XDP frags. To better optimize setups for particular workloads,
> add ability to switch the header split state on and off via Ethtool's
> ringparams, as well as to query the current status.
> There's currently only GET in the Ethtool Netlink interface for now,
> so add SET first. I suspect idpf is not the only one supporting this.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] ethtool: add SET for TCP_DATA_SPLIT ringparam
    https://git.kernel.org/netdev/net-next/c/50d73710715d
  - [net-next,2/2] idpf: add get/set for Ethtool's header split ringparam
    https://git.kernel.org/netdev/net-next/c/9b1aa3ef2328

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


