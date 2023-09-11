Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1479B23C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346799AbjIKVYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbjIKJZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:25:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E494CD3;
        Mon, 11 Sep 2023 02:25:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14996C433C9;
        Mon, 11 Sep 2023 09:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694424342;
        bh=WpA2HSmOVnDSDp9vUx/6sCnejIWAz21QU/ikOzyuZyI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=J1bK6F0j/wB+fJQr4Kt2LbjQu31XTnJldrWV6fRSwa+M1taFaNRtmK7Retp2iW85v
         QGnjIcPDSaM1GBi7GploYD2QGH9LX/gKrnIfTZtrZOlw/5MNF8Ayf+yNas4tQGcbG0
         LWPnw6BjjSOEQe+b7Eo3A/zRUghv0FV9bR6fdcBCbFHLiworBLw4tpVW0x0+/O9XqR
         oKQcs0VGmGGKl0yr8HEX4wx/FiEB8GX61ExY77SncAOG+ZsbGSKkACDS+y5wBiCdHl
         +zGc7DeZR7ssi4fVNxh6JxMDun1HstF8CZvwLYHLePZKa/iwokQD3dnWDni7I3myN4
         qV7PsihENvfaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03E26E1C280;
        Mon, 11 Sep 2023 09:25:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] r8152: check budget for r8152_poll()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169442434201.22330.8875438731088949212.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Sep 2023 09:25:42 +0000
References: <20230908070152.26484-422-nic_swsd@realtek.com>
In-Reply-To: <20230908070152.26484-422-nic_swsd@realtek.com>
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
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
by David S. Miller <davem@davemloft.net>:

On Fri, 8 Sep 2023 15:01:52 +0800 you wrote:
> According to the document of napi, there is no rx process when the
> budget is 0. Therefore, r8152_poll() has to return 0 directly when the
> budget is equal to 0.
> 
> Fixes: d2187f8e4454 ("r8152: divide the tx and rx bottom functions")
> Signed-off-by: Hayes Wang <hayeswang@realtek.com>
> 
> [...]

Here is the summary with links:
  - [net] r8152: check budget for r8152_poll()
    https://git.kernel.org/netdev/net/c/a7b8d60b3723

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


