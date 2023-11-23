Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102F77F64A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjKWRBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbjKWRAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:00:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17683D54
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:00:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2783C433B7;
        Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700758826;
        bh=c1xQdKu33/2/hzLvS6W0JiVMAuAHBG5kYzsJtKNVht4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UthFXOJBPFmYIunQY/p6IYFXB+AxH9hSI+ir01MRWXSYWHCudEPvLRsyb46Nv9asc
         ZAVXcSu2bhPlzvuXL2qu7/7aYF+uhJG78HazYUp1sce2xE1pd/31SKZeCIfhaRjorG
         pFt0uecXIdvg28tlTMIQqyX2ogu2JVtFeDjT+0hZOoZCRLGx31cE8yG0Puzp2sARpu
         WqZ9TQTygSsbIVXZRqIywzzB4hkP6kVHot1lsFNvl6Cfv0tbOtQoGKiZ0MI9SUiNHr
         r0Bkl+AIaRGQq4IDqFTQjCf/Yf2nRF5ukubFXz+2WRYr4jzjiSNKdGO+3lNKRBNJCe
         CAsRgS+zLA2Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 911F5E19E3A;
        Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tls: fix NULL deref on tls_sw_splice_eof() with empty
 record
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170075882659.541.15438374448743865458.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Nov 2023 17:00:26 +0000
References: <20231122214447.675768-1-jannh@google.com>
In-Reply-To: <20231122214447.675768-1-jannh@google.com>
To:     Jann Horn <jannh@google.com>
Cc:     borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
        davem@davemloft.net, dhowells@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Nov 2023 22:44:47 +0100 you wrote:
> syzkaller discovered that if tls_sw_splice_eof() is executed as part of
> sendfile() when the plaintext/ciphertext sk_msg are empty, the send path
> gets confused because the empty ciphertext buffer does not have enough
> space for the encryption overhead. This causes tls_push_record() to go on
> the `split = true` path (which is only supposed to be used when interacting
> with an attached BPF program), and then get further confused and hit the
> tls_merge_open_record() path, which then assumes that there must be at
> least one populated buffer element, leading to a NULL deref.
> 
> [...]

Here is the summary with links:
  - [net] tls: fix NULL deref on tls_sw_splice_eof() with empty record
    https://git.kernel.org/netdev/net/c/53f2cb491b50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


