Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65ED376D249
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjHBPk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjHBPk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B531EDA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 521DE61A14
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 15:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9535EC433C8;
        Wed,  2 Aug 2023 15:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690990821;
        bh=rhjbjV8sZ1peSZbXxFnvc17eLjF68P5s32OkLyh/sV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j35hkY5efxTYJI8k0ZpmxUBMnt7mxR6nPTCvfYI7+/094fGf5LfgGwIBvFs4B38GK
         RDT8sa0ja+ikQ0NisRFWq4wur0SENZ+oF3HQYGAWStF5TjZISF9qyhOK5nZzmxZac2
         n3rjUK1noMGltxU1VdjaJAGTnj/Br3t46tfAKDX4tS4x0hr6lHxyZLsRy9N1zf4UZa
         7kMX6fcc/UgS/S4VilqNEZv+9RikXtClqQnRkEakFKWCo5B9fBmQ5jXHlif/3OOApq
         aBqdlJ8TqE4Y9+vl6CtmCr5TNiqfEeYY/LNV9CxGKR6hZHcTjalOnqxmZ3bgOVfqB8
         shC6SoUuLN7sw==
Date:   Wed, 2 Aug 2023 17:40:16 +0200
From:   Simon Horman <horms@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
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
        Larysa Zaremba <larysa.zaremba@intel.com>
Subject: Re: [PATCH net-next v3] net: ethernet: mtk_eth_soc: support per-flow
 accounting on MT7988
Message-ID: <ZMp44GXm6QKG21+u@kernel.org>
References: <37a0928fa8c1253b197884c68ce1f54239421ac5.1690946442.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37a0928fa8c1253b197884c68ce1f54239421ac5.1690946442.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Larysa Zaremba

On Wed, Aug 02, 2023 at 04:31:09AM +0100, Daniel Golle wrote:
> NETSYS_V3 uses 64 bits for each counters while older SoCs are using
> 48/40 bits for each counter.
> Support reading per-flow byte and package counters on NETSYS_V3.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Hi Daniel,

I think you missed Larysa's Reviewed-by tag from v2.

In any case, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
> v3: correct calculation, local variables
> v2: fix typo bytes_cnt_* -> byte_cnt_*
> 
> drivers/net/ethernet/mediatek/mtk_eth_soc.c  |  1 +
>  drivers/net/ethernet/mediatek/mtk_ppe.c      | 21 +++++++++++++-------
>  drivers/net/ethernet/mediatek/mtk_ppe_regs.h |  2 ++
>  3 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 05be702f19c5..1b89f800f6df 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -5064,6 +5064,7 @@ static const struct mtk_soc_data mt7988_data = {
>  	.version = 3,
>  	.offload_version = 2,
>  	.hash_offset = 4,
> +	.has_accounting = true,
>  	.foe_entry_size = MTK_FOE_ENTRY_V3_SIZE,
>  	.txrx = {
>  		.txd_size = sizeof(struct mtk_tx_dma_v2),
> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
> index bf1ecb0c1c10..973370c3cb51 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe.c
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
> @@ -92,7 +92,6 @@ static int mtk_ppe_mib_wait_busy(struct mtk_ppe *ppe)
>  
>  static int mtk_mib_entry_read(struct mtk_ppe *ppe, u16 index, u64 *bytes, u64 *packets)
>  {
> -	u32 byte_cnt_low, byte_cnt_high, pkt_cnt_low, pkt_cnt_high;
>  	u32 val, cnt_r0, cnt_r1, cnt_r2;
>  	int ret;
>  
> @@ -107,12 +106,20 @@ static int mtk_mib_entry_read(struct mtk_ppe *ppe, u16 index, u64 *bytes, u64 *p
>  	cnt_r1 = readl(ppe->base + MTK_PPE_MIB_SER_R1);
>  	cnt_r2 = readl(ppe->base + MTK_PPE_MIB_SER_R2);
>  
> -	byte_cnt_low = FIELD_GET(MTK_PPE_MIB_SER_R0_BYTE_CNT_LOW, cnt_r0);
> -	byte_cnt_high = FIELD_GET(MTK_PPE_MIB_SER_R1_BYTE_CNT_HIGH, cnt_r1);
> -	pkt_cnt_low = FIELD_GET(MTK_PPE_MIB_SER_R1_PKT_CNT_LOW, cnt_r1);
> -	pkt_cnt_high = FIELD_GET(MTK_PPE_MIB_SER_R2_PKT_CNT_HIGH, cnt_r2);
> -	*bytes = ((u64)byte_cnt_high << 32) | byte_cnt_low;
> -	*packets = (pkt_cnt_high << 16) | pkt_cnt_low;
> +	if (mtk_is_netsys_v3_or_greater(ppe->eth)) {
> +		/* 64 bit for each counter */
> +		u32 cnt_r3 = readl(ppe->base + MTK_PPE_MIB_SER_R3);
> +		*bytes = ((u64)cnt_r1 << 32) | cnt_r0;
> +		*packets = ((u64)cnt_r3 << 32) | cnt_r2;
> +	} else {
> +		/* 48 bit byte counter, 40 bit packet counter */
> +		u32 byte_cnt_low = FIELD_GET(MTK_PPE_MIB_SER_R0_BYTE_CNT_LOW, cnt_r0);
> +		u32 byte_cnt_high = FIELD_GET(MTK_PPE_MIB_SER_R1_BYTE_CNT_HIGH, cnt_r1);
> +		u32 pkt_cnt_low = FIELD_GET(MTK_PPE_MIB_SER_R1_PKT_CNT_LOW, cnt_r1);
> +		u32 pkt_cnt_high = FIELD_GET(MTK_PPE_MIB_SER_R2_PKT_CNT_HIGH, cnt_r2);
> +		*bytes = ((u64)byte_cnt_high << 32) | byte_cnt_low;
> +		*packets = ((u64)pkt_cnt_high << 16) | pkt_cnt_low;
> +	}
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_regs.h b/drivers/net/ethernet/mediatek/mtk_ppe_regs.h
> index a2e61b3eb006..3ce088eef0ef 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe_regs.h
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe_regs.h
> @@ -163,6 +163,8 @@ enum {
>  #define MTK_PPE_MIB_SER_R2			0x348
>  #define MTK_PPE_MIB_SER_R2_PKT_CNT_HIGH		GENMASK(23, 0)
>  
> +#define MTK_PPE_MIB_SER_R3			0x34c
> +
>  #define MTK_PPE_MIB_CACHE_CTL			0x350
>  #define MTK_PPE_MIB_CACHE_CTL_EN		BIT(0)
>  #define MTK_PPE_MIB_CACHE_CTL_FLUSH		BIT(2)
> -- 
> 2.41.0
> 
> 
