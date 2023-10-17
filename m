Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7397CB988
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 06:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjJQEKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 00:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQEKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 00:10:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD22983
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 21:10:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63058C433C9;
        Tue, 17 Oct 2023 04:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697515835;
        bh=lQAc0M6wyDc260gsVnZP65MqVVRlE4I8/AoGwjKnMNY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uhBclQ0dI0ivJwnZ3PAiWJPwa9irt4jB3y4VhfKTrwrniIo5Jcwgff+TDzZvP7bv+
         +lztTmmLaf6dap7HLbT0KzMa4RMLVLP3tfoewfmCW2TJz54K5S6EE1OdMcjSDkKwF4
         VHA8F/kTx9bWuStif47Ab/POnqssGvaZ1mXUSiGsxDrHdVODJw+fVztWKKtUx8sfN0
         Q07+xEz5NvtNFJP+kpLOb/6e1SIzXiDDvSEUsibmtu7PtO1eBaFax19wh/9PXSZzVP
         BFXxY4N3auHeY3RbxaB6X0skPRmnFfx9TTAj0b4wwTQT5PWPJfK6m0L9H/22sLj4u1
         IjYv5p9EQejUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 264D3C4316B;
        Tue, 17 Oct 2023 04:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 0/6] introduce page_pool_alloc() related API
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169751583515.29825.863167765608905945.git-patchwork-notify@kernel.org>
Date:   Tue, 17 Oct 2023 04:10:35 +0000
References: <20231013064827.61135-1-linyunsheng@huawei.com>
In-Reply-To: <20231013064827.61135-1-linyunsheng@huawei.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

On Fri, 13 Oct 2023 14:48:20 +0800 you wrote:
> In [1] & [2] & [3], there are usecases for veth and virtio_net
> to use frag support in page pool to reduce memory usage, and it
> may request different frag size depending on the head/tail
> room space for xdp_frame/shinfo and mtu/packet size. When the
> requested frag size is large enough that a single page can not
> be split into more than one frag, using frag support only have
> performance penalty because of the extra frag count handling
> for frag support.
> 
> [...]

Here is the summary with links:
  - [net-next,v11,1/6] page_pool: fragment API support for 32-bit arch with 64-bit DMA
    https://git.kernel.org/netdev/net-next/c/90de47f020db
  - [net-next,v11,2/6] page_pool: unify frag_count handling in page_pool_is_last_frag()
    (no matching commit)
  - [net-next,v11,3/6] page_pool: remove PP_FLAG_PAGE_FRAG
    (no matching commit)
  - [net-next,v11,4/6] page_pool: introduce page_pool[_cache]_alloc() API
    (no matching commit)
  - [net-next,v11,5/6] page_pool: update document about fragment API
    (no matching commit)
  - [net-next,v11,6/6] net: veth: use newly added page pool API for veth with xdp
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


