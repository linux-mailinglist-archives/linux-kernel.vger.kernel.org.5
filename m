Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AF17D457C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjJXCab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjJXCa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:30:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D95E5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:30:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7511DC433C9;
        Tue, 24 Oct 2023 02:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698114626;
        bh=uTJdGU6PVW1afxCvV2580N6vBNBEyv5C/dwm7N1xx30=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tIjr5rhWhTWmiR8DtTfZ0kX00SWnR2RhmiuhhWkePpU7Iq+bvG2C8aMpbb1Wv+05h
         RLQANx3NlAvgz73qrXAqPj5uJbtzZ103L7qwlBfWswuMqlf9FQ9VaFwHPLyr0BE5Wj
         X0D17clSpw9Tr4WKNV1f388OxCpkYojpW3giJ8ooIqDlo07tV+vBI3bPOOZHD0bi3J
         6hzsrrwtCltCDIATfeeUtdqWzCOrC09cvGEdS98zkIO8JnRFA69+r+ejoMdAgvcTBB
         JkvQCLSYytS0LJIR85wziYD28S/b8IsIF5oH99q+DmOUHL64mHYvynrz13sz4fJ+YW
         a0b6RAvW7BapA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A647E4CC1D;
        Tue, 24 Oct 2023 02:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 0/5] introduce page_pool_alloc() related API
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169811462636.8734.17177752915706845046.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Oct 2023 02:30:26 +0000
References: <20231020095952.11055-1-linyunsheng@huawei.com>
In-Reply-To: <20231020095952.11055-1-linyunsheng@huawei.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Oct 2023 17:59:47 +0800 you wrote:
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
  - [net-next,v12,1/5] page_pool: unify frag_count handling in page_pool_is_last_frag()
    https://git.kernel.org/netdev/net-next/c/58d53d8f7da6
  - [net-next,v12,2/5] page_pool: remove PP_FLAG_PAGE_FRAG
    https://git.kernel.org/netdev/net-next/c/09d96ee5674a
  - [net-next,v12,3/5] page_pool: introduce page_pool_alloc() API
    https://git.kernel.org/netdev/net-next/c/de97502e16fc
  - [net-next,v12,4/5] page_pool: update document about fragment API
    https://git.kernel.org/netdev/net-next/c/8ab32fa1c794
  - [net-next,v12,5/5] net: veth: use newly added page pool API for veth with xdp
    https://git.kernel.org/netdev/net-next/c/2d0de67da51a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


