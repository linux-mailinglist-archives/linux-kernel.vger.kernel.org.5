Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7F27B4C46
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjJBHK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbjJBHK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:10:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082AB8E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:10:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 974CCC433C9;
        Mon,  2 Oct 2023 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696230623;
        bh=Qz9f+JOAES8NGqHKt/UEN6UssKaT0glPTgdb17pk8gE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AWMT0ars2iTB1rAPVv8pHFs/T250GSL6vckhVX7jk2NMN2v7D9YCRkElb29UFGGR0
         UeOBVC5r8neDccR4/+Aa1oej1VUzblgwiqMIqK9Pb84ZO6sqeLgD4lBy7ThOcLuMuY
         znxVcybXZ4PkgFUMp9zBUifQFx+dDLDnYuKO+TMJ251rUGW45+CYpi/Zjn1gxPRVyG
         8nlJK6DhQ3EZI+MAdGPiR7uC8dkYWBYSD6SSxiAfHrNHSuBJZlb8Iam9386k2lkfJC
         6IAQNISEM3s+g7kjJMlnns7ahGEKol3pjkPJFIVuwtPj5fXmz69ZeQE6L6DMiUN0po
         Oy42eMNRF6+ig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77D36C395C5;
        Mon,  2 Oct 2023 07:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] sky2: Make sure there is at least one frag_addr available
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169623062348.24181.10859418276789667320.git-patchwork-notify@kernel.org>
Date:   Mon, 02 Oct 2023 07:10:23 +0000
References: <20230922165036.gonna.464-kees@kernel.org>
In-Reply-To: <20230922165036.gonna.464-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     mlindner@marvell.com, stephen@networkplumber.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, lkp@intel.com,
        aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Sep 2023 09:50:39 -0700 you wrote:
> In the pathological case of building sky2 with 16k PAGE_SIZE, the
> frag_addr[] array would never be used, so the original code was correct
> that size should be 0. But the compiler now gets upset with 0 size arrays
> in places where it hasn't eliminated the code that might access such an
> array (it can't figure out that in this case an rx skb with fragments
> would never be created). To keep the compiler happy, make sure there is
> at least 1 frag_addr in struct rx_ring_info:
> 
> [...]

Here is the summary with links:
  - [v2] sky2: Make sure there is at least one frag_addr available
    https://git.kernel.org/netdev/net/c/6a70e5cbedaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


