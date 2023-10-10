Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CC27BF112
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441933AbjJJCu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441881AbjJJCu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:50:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6919E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:50:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1F38C433C7;
        Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696906225;
        bh=vQzSiuCATAwGdJtH0YWDno7u/yoU+dljPFxsH6KnWEg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZKQw4vyvQg/56URuiDdMtGNwa1kC6xvdq8mx95Z+2idwtWwWPhG+Qtd61evsbkzhc
         C+y0GI27nPRu5VwACcGlA0vQg+gt8jp5D40xxO37CmIMU8Y80GKhXKURY3xDoowJdj
         DHpu0uxR2JtBDmNWyTSA2Tzn8siGVLDX+IEQkPXVzCWDrCeXiJ1i5JgqSs7Y0AsL0N
         PTTWXORP2V2825kn43Hrt5mw2mq+lF+k5BlvIOP4M4zkktRHciXS5Zjg7Zz8LUkigy
         Z13zYvKT3vZSEFEtyCApFCUGYGSi3JciDKc46+HPNhTmhmRPLWwU1Stp0xQF/ictlU
         3NXdLxZUpdgrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86743E11F49;
        Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] liquidio: replace deprecated strncpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169690622554.548.4115453314058639791.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Oct 2023 02:50:25 +0000
References: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_vf_rep-c-v1-1-92123a747780@google.com>
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_vf_rep-c-v1-1-92123a747780@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Oct 2023 21:55:06 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not required as rep_cfg is memset to 0:
> |       memset(&rep_cfg, 0, sizeof(rep_cfg));
> 
> [...]

Here is the summary with links:
  - liquidio: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/a16724289af0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


