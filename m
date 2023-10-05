Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5458C7BA31F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbjJEPwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjJEPu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:50:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3412B8691;
        Thu,  5 Oct 2023 07:07:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C72EC4AF69;
        Thu,  5 Oct 2023 13:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696512635;
        bh=TS8iQF3pZ+MrI0LCqI3NgyUR8ILWgVcCfwy5pAkXYFc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Qp9BOUDm024I9JujoEUevDiJH/CXU0J0vxvE2wS9M0GEqKaiZ+ydjKAb6hHE0uhbh
         rCvtx43h9w2F9T/FEVuYuT/IA2QvKwURb045pIiBqx6L5AryNNtPz8OZko0POSwQYx
         c2XVyIdZdlFV1y/t+nNA+GBUotZXgfhEGcQw/iAxTj8kdxH3J6pQgKC8iwgwfIvVmt
         4tv0tj3iuYLbyvsntTWtvYzYHCHWNOXdNetUrUjUHRhRzDPnWUF0cAL86XJWTs/2k0
         v4KtWUtuokBD7U/16cleqwjA8l+A0MPsyhZGKeld640juxikEJDF8Tmk077rvjQJph
         IzGKXysbdH+jA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 464BBE11F51;
        Thu,  5 Oct 2023 13:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] net: ethernet: mediatek: disable irq before schedule napi
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169651263528.29610.10578709494865123351.git-patchwork-notify@kernel.org>
Date:   Thu, 05 Oct 2023 13:30:35 +0000
References: <20231002140805.568-1-ansuelsmth@gmail.com>
In-Reply-To: <20231002140805.568-1-ansuelsmth@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
        Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        igvtee@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org
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
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  2 Oct 2023 16:08:05 +0200 you wrote:
> While searching for possible refactor of napi_schedule_prep and
> __napi_schedule it was notice that the mtk eth driver disable the
> interrupt for rx and tx AFTER napi is scheduled.
> 
> While this is a very hard to repro case it might happen to have
> situation where the interrupt is disabled and never enabled again as the
> napi completes and the interrupt is enabled before.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mediatek: disable irq before schedule napi
    https://git.kernel.org/netdev/net/c/fcdfc462881d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


