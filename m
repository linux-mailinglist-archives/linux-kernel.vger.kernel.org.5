Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF937C61C1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 02:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376666AbjJLAad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 20:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376583AbjJLAa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 20:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69557B7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 17:30:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E91E5C433BC;
        Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697070626;
        bh=ic4p5FL8H/WP6cBu+eSyU2CbFtqrAwAUjqHHScIInSI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eHbBrB+HGSkIEqg/nHyZD2Y/EQEc9ernguzbYLykDMDTDNwrlQNRDk1/EkoEb63gc
         f0QeGFZvov/tEQ+8wZGJqO8kbKCrNyPTSTMaYfn3bbg81r+Jmtbru3M9EU8+DXpsVy
         pjXdNV9uCxUuDBUnJZ1qYxk7SnFrdye9ijgXdz24fz5AK+L1zA09oJTYHMHxYdOmWk
         J3MIGDvseXy9tfmGE0ZIokUKyM91yVDTvpirudVz6jclG/ey9Hu3OplJ3KFQOS01xj
         AIkvQXpsmjAVfzzI9JrIHxnUOj1h9I5x6TNVna6+wWu+s7KvHgwjdZqBgstqJALAf1
         1wQbIx3/fdHGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D64C9C595C5;
        Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: lantiq_gswip: replace deprecated strncpy with
 ethtool_sprintf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169707062587.15864.15415155248488674538.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 00:30:25 +0000
References: <20231009-strncpy-drivers-net-dsa-lantiq_gswip-c-v1-1-d55a986a14cc@google.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-lantiq_gswip-c-v1-1-d55a986a14cc@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     hauke@hauke-m.de, andrew@lunn.ch, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Oct 2023 18:24:20 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> [...]

Here is the summary with links:
  - net: dsa: lantiq_gswip: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/ed9417206de7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


