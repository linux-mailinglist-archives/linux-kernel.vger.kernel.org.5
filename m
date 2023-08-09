Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C03776CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjHIXKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjHIXK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:10:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E074E75
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 16:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D4CB6417B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A382AC433C8;
        Wed,  9 Aug 2023 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691622627;
        bh=GBjuHFL646u1lkFK2JAMT4bXgcXxV4RlWdIPaFhWsoY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UBNPRxzIdXsxTCndxX/ZUJuzq+IuL1fEZFx0Oba0f77z1jZzjnbQNUBNnhgS5q1/T
         NFlIE2qDMh3NBa6bEfi+5FPDsdPIjLbJVzJRQ5C2F8rb/a4lYs9B/Lmidy/B1V5wHB
         3PXiMk404NZrRDx/48hiAi5tGZ+B78QWxLaOUnQheX9g4TjURdawJWzUNM4SCjkCGy
         W6ydK/MAFGQPe7iFmJn2xaEbvIZ2/HauMj/wyMjfeAs3EVFSp1KcyjBzpGHVEkt1vC
         JvRjc83drygXihs70F1RfI9lO+ZvFhrjERjfUTJjMBcT9XFf4zv6kGzNVbXrdwg+S0
         adg14QcfswWig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87E4BE3308F;
        Wed,  9 Aug 2023 23:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 00/11] Improve the taprio qdisc's relationship
 with its children
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169162262755.8257.7127331416998395436.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Aug 2023 23:10:27 +0000
References: <20230807193324.4128292-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230807193324.4128292-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us,
        vinicius.gomes@intel.com, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        muhammad.husaini.zulkifli@intel.com, yepeilin.cs@gmail.com,
        pctammela@mojatatu.com, richardcochran@gmail.com,
        shaozhengchao@huawei.com, glipus@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Aug 2023 22:33:13 +0300 you wrote:
> Changes in v4:
> - Clean up some leftovers in the ptp_mock driver.
> - Add CONFIG_PTP_1588_CLOCK_MOCK to tools/testing/selftests/tc-testing/config
> - Wait for taprio schedule to become operational in the selftests
> 
> Changes in v3:
> Fix ptp_mock compilation as module, fix small mistakes in selftests.
> 
> [...]

Here is the summary with links:
  - [v4,net-next,01/11] net/sched: taprio: don't access q->qdiscs[] in unoffloaded mode during attach()
    https://git.kernel.org/netdev/net-next/c/09e0c3bbde90
  - [v4,net-next,02/11] net/sched: taprio: keep child Qdisc refcount elevated at 2 in offload mode
    https://git.kernel.org/netdev/net-next/c/25b0d4e4e41f
  - [v4,net-next,03/11] net/sched: taprio: try again to report q->qdiscs[] to qdisc_leaf()
    https://git.kernel.org/netdev/net-next/c/98766add2d55
  - [v4,net-next,04/11] net/sched: taprio: delete misleading comment about preallocating child qdiscs
    https://git.kernel.org/netdev/net-next/c/6e0ec800c174
  - [v4,net-next,05/11] net/sched: taprio: dump class stats for the actual q->qdiscs[]
    https://git.kernel.org/netdev/net-next/c/665338b2a7a0
  - [v4,net-next,06/11] net: ptp: create a mock-up PTP Hardware Clock driver
    https://git.kernel.org/netdev/net-next/c/40b0425f8ba1
  - [v4,net-next,07/11] net: netdevsim: use mock PHC driver
    https://git.kernel.org/netdev/net-next/c/b63e78fca889
  - [v4,net-next,08/11] net: netdevsim: mimic tc-taprio offload
    https://git.kernel.org/netdev/net-next/c/35da47fe1c47
  - [v4,net-next,09/11] selftests/tc-testing: add ptp_mock Kconfig dependency
    https://git.kernel.org/netdev/net-next/c/355adce3010b
  - [v4,net-next,10/11] selftests/tc-testing: test that taprio can only be attached as root
    https://git.kernel.org/netdev/net-next/c/1890cf08bd99
  - [v4,net-next,11/11] selftests/tc-testing: verify that a qdisc can be grafted onto a taprio class
    https://git.kernel.org/netdev/net-next/c/29c298d2bc82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


