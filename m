Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA447E0172
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347019AbjKCJUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346996AbjKCJU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:20:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232D0D42
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 02:20:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD109C433CB;
        Fri,  3 Nov 2023 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699003223;
        bh=89TbsSiluHz4CNriX3OAzekwzCM5uTxxSUvf2oTXa34=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sqB2O09bxp2xTGfqpa2Q9qJPPULBI/7K6WKuSLhdxJKrPxI31or3SZlsGvKoJo/gj
         5xxu5L76j/JxVLRDC2phsoGH5WQeNGwAYjkA3KHOvEWB5ie4mRAdl1PiPSXNWuReGr
         Pp4uZzL8vDEKgRJbbjhKyG2phH2YCeR+Lw1587PYYnsT8e0/+5SEMjabOuoE0jEwLn
         n1n4iufPu78h20j1ZCLQ9U/s7q8YxgK6khG7P+jyXlMyEMJwtdkAytRyCi9gFa47RP
         B9aCBFs9OuaVFRNlDz2FfrbUddqh3x23kgPKNlE16sKufO0FTYi/D685q3khINa0v1
         ZZaH7/HlwjBtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89DC0E00088;
        Fri,  3 Nov 2023 09:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: xgmac: Enable support for multiple
 Flexible PPS outputs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169900322356.11636.3563922436510557327.git-patchwork-notify@kernel.org>
Date:   Fri, 03 Nov 2023 09:20:23 +0000
References: <20231031022729.2347871-1-0x1207@gmail.com>
In-Reply-To: <20231031022729.2347871-1-0x1207@gmail.com>
To:     Furong Xu <0x1207@gmail.com>
Cc:     davem@davemloft.net, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com, jpinto@synopsys.com,
        horms@kernel.org, fancer.lancer@gmail.com,
        jacob.e.keller@intel.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by David S. Miller <davem@davemloft.net>:

On Tue, 31 Oct 2023 10:27:29 +0800 you wrote:
> From XGMAC Core 3.20 and later, each Flexible PPS has individual PPSEN bit
> to select Fixed mode or Flexible mode. The PPSEN must be set, or it stays
> in Fixed PPS mode by default.
> XGMAC Core prior 3.20, only PPSEN0(bit 4) is writable. PPSEN{1,2,3} are
> read-only reserved, and they are already in Flexible mode by default, our
> new code always set PPSEN{1,2,3} do not make things worse ;-)
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: xgmac: Enable support for multiple Flexible PPS outputs
    https://git.kernel.org/netdev/net/c/db456d90a4c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


