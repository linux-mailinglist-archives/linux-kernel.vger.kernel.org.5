Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3A17B9923
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 02:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbjJEAKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 20:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244177AbjJEAKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 20:10:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF427DC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 17:10:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FC48C433C9;
        Thu,  5 Oct 2023 00:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696464626;
        bh=ZAyObxd3ELfiKp6Laq/5uFI4Zz0JhrXUcKzxBevzbw4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oPHtVwjyGDXalqOQVTKjg1HPa9A7C/5ETe91ML38o5p9jIh/bwMAA/YKXBbzxFE4J
         ZYzuofWqvfEn4Aq/CRMJVXDsmysO3aZ6HnISDNVV4+5siPejW44NSef8lSTDRUSAFh
         hdHfTI8UTWK1OyGFkYEvtxrQAUV4nYpSkOe+JDuM1LRD9xBRdxn+V4tfZhsxfxv4Il
         m6Y07qY3HGJZvhlA88FH+1rP3M3X2hSdOKFZYeqAOJSmwQkn295vjAH2Z0e/NDGtjE
         q0TNBVp37DmBeIwCKIkbdshRkxatAThLhiJpIwMaOCP855DsNnZgZYOBYdcrDwPahu
         2LsDb84VX0tsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E96CC595D0;
        Thu,  5 Oct 2023 00:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] r8152: modify rx_bottom
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169646462631.25730.11600010674078336884.git-patchwork-notify@kernel.org>
Date:   Thu, 05 Oct 2023 00:10:26 +0000
References: <20230926111714.9448-432-nic_swsd@realtek.com>
In-Reply-To: <20230926111714.9448-432-nic_swsd@realtek.com>
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, edumazet@google.com, bjorn@mork.no,
        pabeni@redhat.com
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
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Sep 2023 19:17:12 +0800 you wrote:
> v3:
> For patch #1, this patch is replaced. The new patch only break the loop,
> and keep that the driver would queue the rx packets.
> 
> For patch #2, modify the code depends on patch #1. For work_down < budget,
> napi_get_frags() and napi_gro_frags() would be used. For the others,
> nothing is changed.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] r8152: break the loop when the budget is exhausted
    https://git.kernel.org/netdev/net-next/c/2cf51f931797
  - [net-next,v3,2/2] r8152: use napi_gro_frags
    https://git.kernel.org/netdev/net-next/c/788d30daa8f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


