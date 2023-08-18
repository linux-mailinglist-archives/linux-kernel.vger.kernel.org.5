Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577EE780B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376771AbjHRMDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376767AbjHRMDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:03:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ECA30E6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60D89641E3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D420EC433C8;
        Fri, 18 Aug 2023 12:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692360194;
        bh=bu1MVi82BPmDSIibUNjdlS56ovX7Eg24gQiaTb8MNGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MYAy39Q6HEsRP02wSaJvQ7vZSs96nP09/6QVlf2+Njfv0ga6Ya9haZ+z7a3Slj5tv
         0e/MX5yuFQzZ52xapMwUFxqO9uc4JRut7+UXlfhmH2Ee6JVLP9jwuku/vFCJKlPxi7
         JKbT09UPf6c9CfQUnqDwoVipYuZIhLUbLIAVzwSGX7Y9CJTQ6b8VxwrhlH7i4IfllQ
         mcgOT7T0FF2pgEUClMMs8Q/JL+C7ICqzf2R3/hIfaA6Db52TkP7SnDl4FiGpXvKxeb
         9XDGF07RzKLZapkbQZS8MDrrq5OLL5j6sj4lB+yvCPsD0f+CzJY1/GtkgVKOXS5K7N
         K8ZDma6jqhAcA==
Date:   Fri, 18 Aug 2023 14:03:09 +0200
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
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: fix register
 definitions for MT7988
Message-ID: <ZN9d/RJ8qX4xbMml@vergenet.net>
References: <0c0547381d3dc2374e219c97645ab7e1fdfbc385.1692273294.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c0547381d3dc2374e219c97645ab7e1fdfbc385.1692273294.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:58:29PM +0100, Daniel Golle wrote:
> More register macros need to be adjusted for the 3rd GMAC on MT7988.
> Account for added bit in SYSCFG0_SGMII_MASK and adjust macros
> MTK_GDMA_MAC_ADRx to return correct registers for the 3rd GMAC.
> 
> Fixes: 445eb6448ed3 ("net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Simon Horman <horms@kernel.org>

