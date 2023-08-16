Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EE077DAAC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242197AbjHPGue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242256AbjHPGuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BDA1BE7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 033BD63BD7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59A7CC433C9;
        Wed, 16 Aug 2023 06:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692168621;
        bh=FUbf49Z1DaFu1nEyYQOltWC9yOa/+ECxD8Bpe8XOnmw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pI5RpLZHu06vW3blTjo1t/UreW8Qtauu/bRS/v/gvoEXB5mdyiRTqWlItMvKZndi5
         YvUinX3Zo8AoXy5Y/tzBv/XCGC42r4AC25xNSfi4PlBdQ8zlMzoZn4tDuonOc8byJb
         6A+Ew5cRmaLaGZGhh3wliRPE4pxxvtRWPsv4PdfjdRDquToaML44DNm+7eYRqQeWxe
         p4bygPXME9as7XDDGsxFPY2/YchyBltoqvXSR6y3pxYD63XOCGC7sZzI1bTM35SOGO
         sA220q4Df76wk6oak4XHPRI8fQ+KurZUQ8VTJVJoZoavUEYtlU+EyvS9QshQMKUPPD
         qI5tnW/hKJsWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40C23C43168;
        Wed, 16 Aug 2023 06:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V6 net-next 0/2] net: fec: add XDP_TX feature support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169216862126.27729.5054786076620361678.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Aug 2023 06:50:21 +0000
References: <20230815051955.150298-1-wei.fang@nxp.com>
In-Reply-To: <20230815051955.150298-1-wei.fang@nxp.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, larysa.zaremba@intel.com,
        aleksander.lobakin@intel.com, jbrouer@redhat.com,
        netdev@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
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

On Tue, 15 Aug 2023 13:19:53 +0800 you wrote:
> This patch set is to support the XDP_TX feature of FEC driver, the first
> patch is add initial XDP_TX support, and the second patch improves the
> performance of XDP_TX by not using xdp_convert_buff_to_frame(). Please
> refer to the commit message of each patch for more details.
> 
> Wei Fang (2):
>   net: fec: add XDP_TX feature support
>   net: fec: improve XDP_TX performance
> 
> [...]

Here is the summary with links:
  - [V6,net-next,1/2] net: fec: add XDP_TX feature support
    https://git.kernel.org/netdev/net-next/c/f601899e4321
  - [V6,net-next,2/2] net: fec: improve XDP_TX performance
    https://git.kernel.org/netdev/net-next/c/af6f4791380c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


