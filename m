Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238147FECD2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjK3KU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbjK3KUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:20:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A8A1721
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:20:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0F38C433CB;
        Thu, 30 Nov 2023 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701339626;
        bh=jlMAthDr8tpF9CYaRufXkToH4ZNXgCZlcijzkEV466Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gnBvxW/okGUirICH5ZtbW2bwoWyRE49JUOVl0wOGhYcUBSGEKW//NtPpboTShE09m
         ipBgdTp2eQPkG7AdssuXfcxSQ5bjmwdoRJ1fsSWCWbMcJE34N4kPgIBkGhRuSkIdii
         IOUJ02pyTETpSFe1L2N/FVhJK2tWBMBqmDNNLYY2w2VtOC9hhKk0LmaztNAJfy8BjJ
         UyAgo56LSTTcTDMHuCzjlvFAqmuBwp1Wj9J0MO78vtJMAY9Lxv0x66rzE4EbSGUT1E
         /zkRUm/+dtWuloyY2cVOr0Hq/K18QElJVikgqZPzShlixjzlH+Au8WnlXtgYamdsRI
         QHHv50endLmIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8267DDFAA86;
        Thu, 30 Nov 2023 10:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/6] net: ravb: Fixes for the ravb driver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170133962652.30027.7032016375127706992.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Nov 2023 10:20:26 +0000
References: <20231128080439.852467-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231128080439.852467-1-claudiu.beznea.uj@bp.renesas.com>
To:     claudiu beznea <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        renesas@sang-engineering.com, robh@kernel.org,
        biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
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

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 28 Nov 2023 10:04:33 +0200 you wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> This series adds some fixes for ravb driver. Patches in this series
> were initilly part of series at [1].
> 
> [...]

Here is the summary with links:
  - [v2,1/6] net: ravb: Check return value of reset_control_deassert()
    https://git.kernel.org/netdev/net/c/d8eb6ea4b302
  - [v2,2/6] net: ravb: Use pm_runtime_resume_and_get()
    https://git.kernel.org/netdev/net/c/88b74831faae
  - [v2,3/6] net: ravb: Make write access to CXR35 first before accessing other EMAC registers
    https://git.kernel.org/netdev/net/c/d78c0ced60d5
  - [v2,4/6] net: ravb: Start TX queues after HW initialization succeeded
    https://git.kernel.org/netdev/net/c/6f32c0866020
  - [v2,5/6] net: ravb: Stop DMA in case of failures on ravb_open()
    https://git.kernel.org/netdev/net/c/eac16a733427
  - [v2,6/6] net: ravb: Keep reverse order of operations in ravb_remove()
    https://git.kernel.org/netdev/net/c/edf9bc396e05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


