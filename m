Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0838B806CA8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377802AbjLFKuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377800AbjLFKuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:50:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD749C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:50:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63784C433C7;
        Wed,  6 Dec 2023 10:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701859824;
        bh=K2zT6kkUnhgLv0QLn9Ttq5VH+zsoNyXUhXhB1JpYuoo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GL9Vj2z/o3o42r+Ywefuu/07JnPXtEUZFGBCFUyEmuLasnP8og2hpfsRf6vnZqpzk
         ZDcaXad8NrMlT6J6jHF/JdRQZcTIF75NXjoOsq0FCcW/qNVmkkXbfqX+IVUZYNcKHe
         lJnvBT1eDgMfnjNkmCrHuiX++SDF+Zgycw1xWS4NBX3s1wTsD5TGNSCY3pNN9wzksY
         wGYgKp4U+nXDlT0WPYe/VgOkVAFsrHABckRI4PYBkSE895cgkZK1tuhNf2uvC9iQRT
         6Jel6vQASniOqMdIpqEpQSlPtgjOW+YtlsRgYt8mar/xLwU1B7LinxtNXpsG1dqMNe
         yW5anwbw2kVRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D9C6C395DC;
        Wed,  6 Dec 2023 10:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: atlantic: Fix NULL dereference of skb pointer in
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170185982424.14845.6146405240665086065.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Dec 2023 10:50:24 +0000
References: <20231204085810.1681386-1-daniil31415it@gmail.com>
In-Reply-To: <20231204085810.1681386-1-daniil31415it@gmail.com>
To:     =?utf-8?b?0JTQsNC90LjQuNC7INCc0LDQutGB0LjQvNC+0LIgPGRhbmlpbDMxNDE1aXRAZ21h?=@ci.codeaurora.org,
        =?utf-8?b?aWwuY29tPg==?=@ci.codeaurora.org
Cc:     epomozov@marvell.com, irusskikh@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, ap420073@gmail.com,
        khoroshilov@ispras.ru, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        lvc-project@linuxtesting.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  4 Dec 2023 11:58:10 +0300 you wrote:
> If is_ptp_ring == true in the loop of __aq_ring_xdp_clean function,
> then a timestamp is stored from a packet in a field of skb object,
> which is not allocated at the moment of the call (skb == NULL).
> 
> Generalize aq_ptp_extract_ts and other affected functions so they don't
> work with struct sk_buff*, but with struct skb_shared_hwtstamps*.
> 
> [...]

Here is the summary with links:
  - net: atlantic: Fix NULL dereference of skb pointer in
    https://git.kernel.org/netdev/net/c/cbe860be3609

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


