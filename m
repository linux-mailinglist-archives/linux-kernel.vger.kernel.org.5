Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1089A7CD7BC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjJRJUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjJRJU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:20:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688DC102
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:20:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDA89C433C9;
        Wed, 18 Oct 2023 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697620824;
        bh=5dhYRc+zirG3v+xL8lCr9litt6Xv19Db8q0bpo0dXb0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g24BS5KAk3/YL1O4j/vK+DqmVW/CodwOUGAuppMJNNg+dbjgGQTZnQiECvGScTyH7
         GkurggucP532q9lynpjcrl3/YsBr8+t7GayCgLftRHzWWlHOr2ZK094qE3F0S8xmnD
         lYjHtyfPff0+0n7d6mGtaFB5LfhGIucIhMqZekIkIPiCBjH2TJC/nOnHnsyblhugFV
         Z4/SaWyw8N48ddnu/seBBFE9sc94op0oqxHFAkA98sOMBKop4ljE3h0g3Dx+yXmVYD
         5M0AQidGeGI4ajmYfOtsKtxmgFo7HRGHujMm9/WMcWOS9qAQW8zYOZSWFRna5aovjj
         g+ar6eoj2wGfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE1B0C04DD9;
        Wed, 18 Oct 2023 09:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pktgen: Fix interface flags printing
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169762082384.4908.15716073327666227322.git-patchwork-notify@kernel.org>
Date:   Wed, 18 Oct 2023 09:20:23 +0000
References: <20231016140631.1245318-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20231016140631.1245318-1-Ilia.Gavrilov@infotecs.ru>
To:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        Jason@zx2c4.com, keescook@chromium.org, linyunsheng@huawei.com,
        0x7f454c46@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
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

On Mon, 16 Oct 2023 14:08:59 +0000 you wrote:
> Device flags are displayed incorrectly:
> 1) The comparison (i == F_FLOW_SEQ) is always false, because F_FLOW_SEQ
> is equal to (1 << FLOW_SEQ_SHIFT) == 2048, and the maximum value
> of the 'i' variable is (NR_PKT_FLAG - 1) == 17. It should be compared
> with FLOW_SEQ_SHIFT.
> 
> 2) Similarly to the F_IPSEC flag.
> 
> [...]

Here is the summary with links:
  - [net] net: pktgen: Fix interface flags printing
    https://git.kernel.org/netdev/net/c/1d30162f35c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


