Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865BE7B5A5A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbjJBSkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjJBSke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:40:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6CDB8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 11:40:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0136C433C7;
        Mon,  2 Oct 2023 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696272030;
        bh=UV9QeO2eUsWxPfUTEhIPFDbW+ZsPP9uBROySkLMm6WY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NmheTg+Pbz2sHwigFT80jEFLdtK/7lEz3/CeKzCeB+q7elJhLqYkyETjViMFc/Uaw
         kKCNpCaAFc4hnjTpev5zWa8zekc4zJZ0QJkJA+YMOv4gpROcYRngTgUYQ+6vaBgq4n
         iRpLJpIs/cfGXOuewBy7GoxKjLX77XQ9AMPV/MITd2P8vJKpC2j9fx6iUHL9kR1qpJ
         tgIprk9eX6F62MfbxePbkZ+k4rC+uBPdQpMl7zXdETZijcSIjf/RGQvqnEgn8BDAii
         azhsoFlrMWPq1F+K4njlEmSBxg6cZpBHsmBOm/JbdCRP8qc7+jmAab/jPH4Q/cVk+O
         JlPWMB/+nfORQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 928C6C395C5;
        Mon,  2 Oct 2023 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] mlxsw: Annotate structs with __counted_by
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169627203059.11990.1243800738958439683.git-patchwork-notify@kernel.org>
Date:   Mon, 02 Oct 2023 18:40:30 +0000
References: <20230929180611.work.870-kees@kernel.org>
In-Reply-To: <20230929180611.work.870-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     idosch@nvidia.com, petrm@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        gustavoars@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
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
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Sep 2023 11:07:39 -0700 you wrote:
> Hi,
> 
> This annotates several mlxsw structures with the coming __counted_by attribute
> for bounds checking of flexible arrays at run-time. For more details, see
> commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro").
> 
> Thanks!
> 
> [...]

Here is the summary with links:
  - [1/5] mlxsw: Annotate struct mlxsw_linecards with __counted_by
    https://git.kernel.org/netdev/net-next/c/0b7ed8183375
  - [2/5] mlxsw: core: Annotate struct mlxsw_env with __counted_by
    https://git.kernel.org/netdev/net-next/c/c63da7d62893
  - [3/5] mlxsw: spectrum: Annotate struct mlxsw_sp_counter_pool with __counted_by
    https://git.kernel.org/netdev/net-next/c/f7ebae83768f
  - [4/5] mlxsw: spectrum_router: Annotate struct mlxsw_sp_nexthop_group_info with __counted_by
    https://git.kernel.org/netdev/net-next/c/4d3a42ec5cff
  - [5/5] mlxsw: spectrum_span: Annotate struct mlxsw_sp_span with __counted_by
    https://git.kernel.org/netdev/net-next/c/18cee9da32cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


