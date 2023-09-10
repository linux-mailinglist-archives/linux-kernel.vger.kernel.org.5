Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7E5799EB5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 16:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346698AbjIJOrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 10:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjIJOrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 10:47:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322631A5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 07:47:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCBAC433C7;
        Sun, 10 Sep 2023 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694357254;
        bh=NErVm+qMXZ/pqK2rnbYhPDdyFVVpqvEVZyCXf/EFVGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ubxVCTCKav+V51WDKuTtO0EDuxSfsqy9sKFT5Af++H1Fh3Z9uIHtsZLcAFgogb2DW
         kLN62joKoSscCalyAHAP1XhN7GoOyat3h480sycZQEab/1X+UtB3OMRPlouXDt99ZN
         7MYBaeQpinURBCB7NUKIK7Wb3DjSxBSK+Sl0SxDkZUQeRxSJV3X9b17qZkqFP+xdn4
         0KQrhvL8fzq6mcEPAGZCkT+dwy+F/FxAA2a3/FqpTQ1SU0P0JGO8gB7iXPKcJS0L6b
         GYiMhnyyct6+GQ+oHPRMrxdM6YZ2kNDAtY4w6cPoFKpA2voqNJP7VcCSiBe8+Q0ISf
         Fy3sv/BaB1Bug==
Date:   Sun, 10 Sep 2023 16:47:28 +0200
From:   Simon Horman <horms@kernel.org>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     justin.chen@broadcom.com, florian.fainelli@broadcom.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mw@semihalf.com, linux@armlinux.org.uk,
        nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
        Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        maxime.chevallier@bootlin.com, nelson.chang@mediatek.com,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 3/3] net: ethernet: mtk_eth_soc: fix possible NULL
 pointer dereference in mtk_hwlro_get_fdir_all()
Message-ID: <20230910144728.GF775887@kernel.org>
References: <20230908061950.20287-1-hbh25y@gmail.com>
 <20230908061950.20287-4-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908061950.20287-4-hbh25y@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 02:19:50PM +0800, Hangyu Hua wrote:
> rule_locs is allocated in ethtool_get_rxnfc and the size is determined by
> rule_cnt from user space. So rule_cnt needs to be check before using
> rule_locs to avoid NULL pointer dereference.
> 
> Fixes: 7aab747e5563 ("net: ethernet: mediatek: add ethtool functions to configure RX flows of HW LRO")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

