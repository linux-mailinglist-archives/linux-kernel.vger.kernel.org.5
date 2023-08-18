Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75651780B94
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376804AbjHRMNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376785AbjHRMMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:12:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D641435AD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6480862E8E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E724C433C7;
        Fri, 18 Aug 2023 12:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692360754;
        bh=NBGFt5eEWfHJ21aKAdl7v+uvCkOurbbahAK/Or24JXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=edr1+ub/Irb20ndnP3vetXj19FArIYcRWluZgt20aX5H/TdrS4m8JMj8n5T5PDSqB
         RAZhBhVLBT25GJE6C4vDq0Ml45ScJsjlm2wCmU4mcXw8SsYp0GJZqAyXouZ8vCU4iy
         YPGfCQC0ENVp4QsOrsUQ2ZjDhLRWF0L9CLxQ7HeMXewKAVJwRMTh7qZ5dfoJ9Niaok
         nETvJMSeJbiiVEy8l+J7Y1LEjme12lkHKVf7PBe5F6j9ltgA+46T7wRcPvaqqaXEvm
         AtM1UznmoYACuEE56uQMpmAlG+fsW7NzKO2NLo+9Je2f2cnnGnpRSeqhwiZTC96t0u
         uGIjLfYdh754g==
Date:   Fri, 18 Aug 2023 14:12:29 +0200
From:   Simon Horman <horms@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix NULL pointer on hw
 reset
Message-ID: <ZN9gLcMOsB220R5F@vergenet.net>
References: <6863f378a2a077701c60cea6ae654212e919d624.1692273610.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6863f378a2a077701c60cea6ae654212e919d624.1692273610.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 01:01:11PM +0100, Daniel Golle wrote:
> When a hardware reset is triggered on devices not initializing WED the
> calls to mtk_wed_fe_reset and mtk_wed_fe_reset_complete dereference a
> pointer on uninitialized stack memory.
> Initialize the hw_list will 0s and break out of both functions in case
> a hw_list entry is 0.
> 
> Fixes: 08a764a7c51b ("net: ethernet: mtk_wed: add reset/reset_complete callbacks")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Simon Horman <horms@kernel.org>

