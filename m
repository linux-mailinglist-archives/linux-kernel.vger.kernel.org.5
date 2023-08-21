Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0747828A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjHUML0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjHUMLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:11:24 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF49E3;
        Mon, 21 Aug 2023 05:11:12 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b703a0453fso56104141fa.3;
        Mon, 21 Aug 2023 05:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692619871; x=1693224671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpA+hrX20JQoPrR1fjncSFOrMNKcG0nPz8OtL2DrgHA=;
        b=cM/GQ+nvpMp9bIwmSoyyGXwSbTPbkUcKMO4uYUKfKynlni6O6GlxRiE7cTYpFI/IQL
         WimsIXKIsUtHOt9uM/sG9QQz6+jUoNXa7kq4fsYGQhssLmcuthf/PcrQ3F1Uzh+va5aK
         Ajd0NXUvtEVPq4G+6USBsDrDMGk86dXm+k24pt8fqcwe5JLJXkty9ynkbaElAX4vt4Rv
         ahOG9RsX59IITyoq+io62swgF4DZhavonD6mUZpVOIGcWEtwo3D0zYCFvIkOeH5nZEyH
         SIDQQ9E64awa5fEvjv3r69LmV8hYs8GB72VtZp7APuvfY+kWiPTuMJi5tYQ8z/B59nR+
         LPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692619871; x=1693224671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpA+hrX20JQoPrR1fjncSFOrMNKcG0nPz8OtL2DrgHA=;
        b=UO/4B9VafAb2zUG4qK5lRcgFClhBKal+7Yap//7U7j5xxplkUi8S0WVmLVeDdde1D3
         u8ScEY2JXHx9ODNilCvpj2lIC38qx6aY69e6gk/jmExfL8l7NnaW+e9WDEDwpsewXK4Z
         MlVv2baKstyEPK9vhu0jBa8i1Kdja28B+IIdDYeeN++YwTvTCviI4rL2rDd8PjAi1pXv
         eFHrh2RMNcyQc2jW5qAZcvigtF8zxSLkMum4/iE9iR6aMLMgOBrkRmlQEBgSOpcD3v8E
         sFRlAIpr+whWY2QVi2n+Q7ynyLNwMb2xnNzoZ7ZCjV9gGU6Sp9lI+qEnhzxJTn4oKO43
         5NUA==
X-Gm-Message-State: AOJu0Yz9vv6KWt1PNg7PcK+vnV5YJQMj7DY93UwO0HgC06qpSPRW1ldk
        yW9bqIt5zjMeHPV4JHAhcBE=
X-Google-Smtp-Source: AGHT+IGXLWrxzYVesCuPIPJnkvwQZyXbsUcN8wEOadyTGVdiLY4Ul7S+OS2VRaWDjUAUQMlu74+l4w==
X-Received: by 2002:a2e:9357:0:b0:2b7:33b9:8809 with SMTP id m23-20020a2e9357000000b002b733b98809mr4691640ljh.16.1692619870788;
        Mon, 21 Aug 2023 05:11:10 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id a22-20020a2e88d6000000b002b6dc99f858sm2200866ljk.66.2023.08.21.05.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 05:11:10 -0700 (PDT)
Date:   Mon, 21 Aug 2023 15:11:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Furong Xu <0x1207@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v2 1/1] net: stmmac: Check more MAC HW features
 for XGMAC Core 3.20
Message-ID: <k2emlehqp64sb3vqzfnsocppvngtyxpta32xw3uvve4s6lnzns@bnknws7wv47y>
References: <20230819105440.226892-1-0x1207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819105440.226892-1-0x1207@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Furong

Having changes enumerated in the patch log is an implicit sign
that the patch solves several problems at a time. Please split them up
into dedicated patches.

On Sat, Aug 19, 2023 at 06:54:40PM +0800, Furong Xu wrote:

> 1. XGMAC Core does not have hash_filter definition, it uses
> vlhash(VLAN Hash Filtering) instead, skip hash_filter when XGMAC.

Because these a completely different flags.

"hash_filter" indicates an availability of the HASH-based MAC-address
filters in DW (G)MAC IP-cores by means of the HASHSEL flag available
in "Register 22 HW Feature Register".

"vlhash" indicates the HASH-based VLAN ID filters in DW QoS Eth and DW
XGMAC IP-cores by means of the VLHASH flag available in
the MAC_HW_Feature0 register.

DW xGMAC and DW QoS Eth use hash_tb_sz field as the HASH-based
MAC-address filter indicator. It's zero if there is no HASH-based
filter available in the controller. So your fix is a half measure
only.

> 2. Show exact size of Hash Table instead of raw register value.
> 3. Show full description of safety features defined by Synopsys Databook.

> 4. When safety feature is configured with no parity, or ECC only,
> keep FSM Parity Checking disabled.

This change looks as a significant alteration of the DW XGMAC v3.x
Safety Feature configuration procedure. It must be in a separate
patch in order to be independently revertable in case of regressions.

The description in the patch log doesn't include all the changes
provided by the patch itself. Once again please split the changes up.

> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> Changes in v2:
>   - Rebase patch on net-next. Thanks Simon :)
> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h  | 36 ++++++++++
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    | 21 ++++++
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  6 +-
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 23 ++++++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 71 +++++++++++++++++--
>  5 files changed, 149 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index 1f5293c8cc04..403cb397d4d3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -410,6 +410,18 @@ struct dma_features {
>  	unsigned int number_tx_queues;
>  	/* PPS output */
>  	unsigned int pps_out_num;
> +	/* Number of Traffic Classes */
> +	unsigned int numtc;
> +	/* DCB Feature Enable */
> +	unsigned int dcben;
> +	/* IEEE 1588 High Word Register Enable */
> +	unsigned int advthword;
> +	/* PTP Offload Enable */
> +	unsigned int ptoen;
> +	/* One-Step Timestamping Enable */
> +	unsigned int osten;
> +	/* Priority-Based Flow Control Enable */
> +	unsigned int pfcen;
>  	/* Alternate (enhanced) DESC mode */
>  	unsigned int enh_desc;
>  	/* TX and RX FIFO sizes */
> @@ -430,16 +442,40 @@ struct dma_features {
>  	unsigned int dvlan;
>  	unsigned int l3l4fnum;
>  	unsigned int arpoffsel;
> +	/* One Step for PTP over UDP/IP Feature Enable */
> +	unsigned int pou_ost_en;
> +	/* Tx Timestamp FIFO Depth */
> +	unsigned int ttsfd;
> +	/* Queue/Channel-Based VLAN tag insertion on Tx */
> +	unsigned int cbtisel;
> +	/* Supported Parallel Instruction Processor Engines */
> +	unsigned int frppipe_num;
> +	/* Number of Extended VLAN Tag Filters */
> +	unsigned int nrvf_num;
>  	/* TSN Features */
>  	unsigned int estwid;
>  	unsigned int estdep;
>  	unsigned int estsel;
>  	unsigned int fpesel;
>  	unsigned int tbssel;
> +	/* Number of DMA channels enabled for TBS */
> +	unsigned int tbs_ch_num;
> +	/* Per-Stream Filtering Enable */
> +	unsigned int sgfsel;
>  	/* Numbers of Auxiliary Snapshot Inputs */
>  	unsigned int aux_snapshot_n;
>  	/* Timestamp System Time Source */
>  	unsigned int tssrc;
> +	/* Enhanced DMA Enable */
> +	unsigned int edma;
> +	/* Different Descriptor Cache Enable */
> +	unsigned int ediffc;
> +	/* VxLAN/NVGRE Enable */
> +	unsigned int vxn;
> +	/* Debug Memory Interface Enable */
> +	unsigned int dbgmem;
> +	/* Number of Policing Counters */
> +	unsigned int pcsel;

All of these have little value since unused by the driver in anyway
but only printed by the DbgFS features node.

>  };
>  
>  /* RX Buffer size must be multiple of 4/8/16 bytes */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 7f68bef456b7..7a8f47e7b728 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -122,6 +122,9 @@
>  #define XGMAC_TLPIEN			BIT(0)
>  #define XGMAC_LPI_TIMER_CTRL		0x000000d4
>  #define XGMAC_HW_FEATURE0		0x0000011c
> +#define XGMAC_HWFEAT_EDMA		BIT(31)
> +#define XGMAC_HWFEAT_EDIFFC		BIT(30)
> +#define XGMAC_HWFEAT_VXN		BIT(29)
>  #define XGMAC_HWFEAT_SAVLANINS		BIT(27)
>  #define XGMAC_HWFEAT_TSSTSSEL		GENMASK(26, 25)
>  #define XGMAC_HWFEAT_ADDMACADRSEL	GENMASK(22, 18)
> @@ -142,29 +145,47 @@
>  #define XGMAC_HW_FEATURE1		0x00000120
>  #define XGMAC_HWFEAT_L3L4FNUM		GENMASK(30, 27)
>  #define XGMAC_HWFEAT_HASHTBLSZ		GENMASK(25, 24)
> +#define XGMAC_HWFEAT_NUMTC		GENMASK(23, 21)
>  #define XGMAC_HWFEAT_RSSEN		BIT(20)
> +#define XGMAC_HWFEAT_DBGMEMA		BIT(19)
>  #define XGMAC_HWFEAT_TSOEN		BIT(18)
>  #define XGMAC_HWFEAT_SPHEN		BIT(17)
> +#define XGMAC_HWFEAT_DCBEN		BIT(16)
>  #define XGMAC_HWFEAT_ADDR64		GENMASK(15, 14)
> +#define XGMAC_HWFEAT_ADVTHWORD		BIT(13)
> +#define XGMAC_HWFEAT_PTOEN		BIT(12)
> +#define XGMAC_HWFEAT_OSTEN		BIT(11)
>  #define XGMAC_HWFEAT_TXFIFOSIZE		GENMASK(10, 6)
> +#define XGMAC_HWFEAT_PFCEN		BIT(5)
>  #define XGMAC_HWFEAT_RXFIFOSIZE		GENMASK(4, 0)
>  #define XGMAC_HW_FEATURE2		0x00000124
> +#define XGMAC_HWFEAT_AUXSNAPNUM		GENMASK(30, 28)
>  #define XGMAC_HWFEAT_PPSOUTNUM		GENMASK(26, 24)
>  #define XGMAC_HWFEAT_TXCHCNT		GENMASK(21, 18)
>  #define XGMAC_HWFEAT_RXCHCNT		GENMASK(15, 12)
>  #define XGMAC_HWFEAT_TXQCNT		GENMASK(9, 6)
>  #define XGMAC_HWFEAT_RXQCNT		GENMASK(3, 0)
>  #define XGMAC_HW_FEATURE3		0x00000128
> +#define XGMAC_HWFEAT_TBSCH		GENMASK(31, 28)
>  #define XGMAC_HWFEAT_TBSSEL		BIT(27)
>  #define XGMAC_HWFEAT_FPESEL		BIT(26)
> +#define XGMAC_HWFEAT_SGFSEL		BIT(25)
>  #define XGMAC_HWFEAT_ESTWID		GENMASK(24, 23)
>  #define XGMAC_HWFEAT_ESTDEP		GENMASK(22, 20)
>  #define XGMAC_HWFEAT_ESTSEL		BIT(19)
> +#define XGMAC_HWFEAT_TTSFD		GENMASK(18, 16)
>  #define XGMAC_HWFEAT_ASP		GENMASK(15, 14)
>  #define XGMAC_HWFEAT_DVLAN		BIT(13)
>  #define XGMAC_HWFEAT_FRPES		GENMASK(12, 11)
>  #define XGMAC_HWFEAT_FRPPB		GENMASK(10, 9)
> +#define XGMAC_HWFEAT_POUOST		BIT(8)
> +#define XGMAC_HWFEAT_FRPPIPE		GENMASK(7, 5)
> +#define XGMAC_HWFEAT_CBTISEL		BIT(4)
>  #define XGMAC_HWFEAT_FRPSEL		BIT(3)
> +#define XGMAC_HWFEAT_NRVF		GENMASK(2, 0)
> +#define XGMAC_HW_FEATURE4		0x0000012c
> +#define XGMAC_HWFEAT_EASP		BIT(4)
> +#define XGMAC_HWFEAT_PCSEL		GENMASK(1, 0)
>  #define XGMAC_MAC_DPP_FSM_INT_STATUS	0x00000150
>  #define XGMAC_MAC_FSM_CONTROL		0x00000158
>  #define XGMAC_PRTYEN			BIT(1)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 38782662ff98..34e1b0c3f346 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -861,8 +861,10 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
>  	value |= XGMAC_TCEIE; /* TSO Memory Correctable Error */
>  	writel(value, ioaddr + XGMAC_DMA_ECC_INT_ENABLE);
>  

> -	/* Only ECC Protection for External Memory feature is selected */
> -	if (asp <= 0x1)
> +	/* 0x2: Without ECC or Parity Ports on External Application Interface
> +	 * 0x4: Only ECC Protection for External Memory feature is selected
> +	 */
> +	if (asp == 0x2 || asp == 0x4)
>  		return 0;

This changes the dwxgmac3_safety_feat_config() method semantic. Please
detach in a separate patch and thoroughly explain.

>  
>  	/* 4. Enable Parity and Timeout for FSM */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index 3aacf791efeb..fa69d64a8694 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -393,6 +393,9 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
>  
>  	/* MAC HW feature 0 */
>  	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE0);
> +	dma_cap->edma = (hw_cap & XGMAC_HWFEAT_EDMA) >> 31;
> +	dma_cap->ediffc = (hw_cap & XGMAC_HWFEAT_EDIFFC) >> 30;
> +	dma_cap->vxn = (hw_cap & XGMAC_HWFEAT_VXN) >> 29;
>  	dma_cap->vlins = (hw_cap & XGMAC_HWFEAT_SAVLANINS) >> 27;
>  	dma_cap->tssrc = (hw_cap & XGMAC_HWFEAT_TSSTSSEL) >> 25;
>  	dma_cap->multi_addr = (hw_cap & XGMAC_HWFEAT_ADDMACADRSEL) >> 18;
> @@ -425,9 +428,12 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
>  		dma_cap->l3l4fnum = 32;
>  
>  	dma_cap->hash_tb_sz = (hw_cap & XGMAC_HWFEAT_HASHTBLSZ) >> 24;
> +	dma_cap->numtc = ((hw_cap & XGMAC_HWFEAT_NUMTC) >> 21) + 1;
>  	dma_cap->rssen = (hw_cap & XGMAC_HWFEAT_RSSEN) >> 20;
> +	dma_cap->dbgmem = (hw_cap & XGMAC_HWFEAT_DBGMEMA) >> 19;
>  	dma_cap->tsoen = (hw_cap & XGMAC_HWFEAT_TSOEN) >> 18;
>  	dma_cap->sphen = (hw_cap & XGMAC_HWFEAT_SPHEN) >> 17;
> +	dma_cap->dcben = (hw_cap & XGMAC_HWFEAT_DCBEN) >> 16;
>  
>  	dma_cap->addr64 = (hw_cap & XGMAC_HWFEAT_ADDR64) >> 14;
>  	switch (dma_cap->addr64) {
> @@ -445,13 +451,18 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
>  		break;
>  	}
>  
> +	dma_cap->advthword = (hw_cap & XGMAC_HWFEAT_ADVTHWORD) >> 13;
> +	dma_cap->ptoen = (hw_cap & XGMAC_HWFEAT_PTOEN) >> 12;
> +	dma_cap->osten = (hw_cap & XGMAC_HWFEAT_OSTEN) >> 11;
>  	dma_cap->tx_fifo_size =
>  		128 << ((hw_cap & XGMAC_HWFEAT_TXFIFOSIZE) >> 6);
> +	dma_cap->pfcen = (hw_cap & XGMAC_HWFEAT_PFCEN) >> 5;
>  	dma_cap->rx_fifo_size =
>  		128 << ((hw_cap & XGMAC_HWFEAT_RXFIFOSIZE) >> 0);
>  
>  	/* MAC HW feature 2 */
>  	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE2);
> +	dma_cap->aux_snapshot_n = (hw_cap & XGMAC_HWFEAT_AUXSNAPNUM) >> 28;
>  	dma_cap->pps_out_num = (hw_cap & XGMAC_HWFEAT_PPSOUTNUM) >> 24;
>  	dma_cap->number_tx_channel =
>  		((hw_cap & XGMAC_HWFEAT_TXCHCNT) >> 18) + 1;
> @@ -464,16 +475,28 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
>  
>  	/* MAC HW feature 3 */
>  	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE3);
> +	dma_cap->tbs_ch_num = ((hw_cap & XGMAC_HWFEAT_TBSCH) >> 28) + 1;
>  	dma_cap->tbssel = (hw_cap & XGMAC_HWFEAT_TBSSEL) >> 27;
>  	dma_cap->fpesel = (hw_cap & XGMAC_HWFEAT_FPESEL) >> 26;
> +	dma_cap->sgfsel = (hw_cap & XGMAC_HWFEAT_SGFSEL) >> 25;
>  	dma_cap->estwid = (hw_cap & XGMAC_HWFEAT_ESTWID) >> 23;
>  	dma_cap->estdep = (hw_cap & XGMAC_HWFEAT_ESTDEP) >> 20;
>  	dma_cap->estsel = (hw_cap & XGMAC_HWFEAT_ESTSEL) >> 19;
> +	dma_cap->ttsfd = (hw_cap & XGMAC_HWFEAT_TTSFD) >> 16;
>  	dma_cap->asp = (hw_cap & XGMAC_HWFEAT_ASP) >> 14;
>  	dma_cap->dvlan = (hw_cap & XGMAC_HWFEAT_DVLAN) >> 13;
>  	dma_cap->frpes = (hw_cap & XGMAC_HWFEAT_FRPES) >> 11;
>  	dma_cap->frpbs = (hw_cap & XGMAC_HWFEAT_FRPPB) >> 9;
> +	dma_cap->pou_ost_en = (hw_cap & XGMAC_HWFEAT_POUOST) >> 8;
> +	dma_cap->frppipe_num = ((hw_cap & XGMAC_HWFEAT_FRPPIPE) >> 5) + 1;
> +	dma_cap->cbtisel = (hw_cap & XGMAC_HWFEAT_CBTISEL) >> 4;
>  	dma_cap->frpsel = (hw_cap & XGMAC_HWFEAT_FRPSEL) >> 3;
> +	dma_cap->nrvf_num = (hw_cap & XGMAC_HWFEAT_NRVF) >> 0;
> +
> +	/* MAC HW feature 4 */
> +	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE4);

> +	dma_cap->asp |= (hw_cap & XGMAC_HWFEAT_EASP) >> 2;

So you intermix ASP and EASP flags in the dma_features->asp field.
This makes the field value being deviated from what DW Eth QoS/XGMAC
defines. It doesn't look correct. Am I missing something?

> +	dma_cap->pcsel = (hw_cap & XGMAC_HWFEAT_PCSEL) >> 0;
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 733b5e900817..7a9bbcf03ea5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6243,6 +6243,16 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
>  		"External",
>  		"Both",
>  	};

> +	static const char * const dwxgmac_safety_feature_desc[] = {
> +		"No",
> +		"All Safety Features with ECC and Parity",
> +		"All Safety Features without ECC or Parity",
> +		"All Safety Features with Parity Only",
> +		"ECC Only",

Hm, Looking at the DW Eth QoS v5.10a HW manual the description is the
opposite:
 0x0 (NONE): No Safety features selected
 0x1 (ECC_ONLY): Only "ECC protection for external
memory" feature is selected
 0x2 (AS_NPPE): All the Automotive Safety features are
selected without the "Parity Port Enable for external inter-
face" feature
 0x3 (AS_PPE): All the Automotive Safety features are
selected with the "Parity Port Enable for external interface"
feature

Something isn't right. I doubt DW XGMAC v3.x has a different Safety
feature implementation. Please double check the description text.

-Serge(y)

> +		"UNDEFINED",
> +		"UNDEFINED",
> +		"UNDEFINED",
> +	};
>  	struct net_device *dev = seq->private;
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  
> @@ -6261,15 +6271,16 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
>  		   (priv->dma_cap.mbps_1000) ? "Y" : "N");
>  	seq_printf(seq, "\tHalf duplex: %s\n",
>  		   (priv->dma_cap.half_duplex) ? "Y" : "N");
> -	seq_printf(seq, "\tHash Filter: %s\n",
> -		   (priv->dma_cap.hash_filter) ? "Y" : "N");
> -	if (priv->plat->has_xgmac)
> +	if (priv->plat->has_xgmac) {
>  		seq_printf(seq,
>  			   "\tNumber of Additional MAC address registers: %d\n",
>  			   priv->dma_cap.multi_addr);
> -	else
> +	} else {
> +		seq_printf(seq, "\tHash Filter: %s\n",
> +			   (priv->dma_cap.hash_filter) ? "Y" : "N");
>  		seq_printf(seq, "\tMultiple MAC address registers: %s\n",
>  			   (priv->dma_cap.multi_addr) ? "Y" : "N");
> +	}
>  	seq_printf(seq, "\tPCS (TBI/SGMII/RTBI PHY interfaces): %s\n",
>  		   (priv->dma_cap.pcs) ? "Y" : "N");
>  	seq_printf(seq, "\tSMA (MDIO) Interface: %s\n",
> @@ -6316,12 +6327,13 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
>  		   (priv->dma_cap.enh_desc) ? "Y" : "N");
>  	seq_printf(seq, "\tTX Fifo Size: %d\n", priv->dma_cap.tx_fifo_size);
>  	seq_printf(seq, "\tRX Fifo Size: %d\n", priv->dma_cap.rx_fifo_size);
> -	seq_printf(seq, "\tHash Table Size: %d\n", priv->dma_cap.hash_tb_sz);
> +	seq_printf(seq, "\tHash Table Size: %lu\n", priv->dma_cap.hash_tb_sz ?
> +		   (BIT(priv->dma_cap.hash_tb_sz) << 5) : 0);
>  	seq_printf(seq, "\tTSO: %s\n", priv->dma_cap.tsoen ? "Y" : "N");
>  	seq_printf(seq, "\tNumber of PPS Outputs: %d\n",
>  		   priv->dma_cap.pps_out_num);
>  	seq_printf(seq, "\tSafety Features: %s\n",
> -		   priv->dma_cap.asp ? "Y" : "N");
> +		   dwxgmac_safety_feature_desc[priv->dma_cap.asp]);
>  	seq_printf(seq, "\tFlexible RX Parser: %s\n",
>  		   priv->dma_cap.frpsel ? "Y" : "N");
>  	seq_printf(seq, "\tEnhanced Addressing: %d\n",
> @@ -6346,6 +6358,53 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
>  		   priv->dma_cap.fpesel ? "Y" : "N");
>  	seq_printf(seq, "\tTime-Based Scheduling (TBS): %s\n",
>  		   priv->dma_cap.tbssel ? "Y" : "N");
> +	seq_printf(seq, "\tNumber of DMA Channels Enabled for TBS: %d\n",
> +		   priv->dma_cap.tbs_ch_num);
> +	seq_printf(seq, "\tPer-Stream Filtering: %s\n",
> +		   priv->dma_cap.sgfsel ? "Y" : "N");
> +	seq_printf(seq, "\tTX Timestamp FIFO Depth: %lu\n",
> +		   BIT(priv->dma_cap.ttsfd) >> 1);
> +	seq_printf(seq, "\tNumber of Traffic Classes: %d\n",
> +		   priv->dma_cap.numtc);
> +	seq_printf(seq, "\tDCB Feature: %s\n",
> +		   priv->dma_cap.dcben ? "Y" : "N");
> +	seq_printf(seq, "\tIEEE 1588 High Word Register: %s\n",
> +		   priv->dma_cap.advthword ? "Y" : "N");
> +	seq_printf(seq, "\tPTP Offload: %s\n",
> +		   priv->dma_cap.ptoen ? "Y" : "N");
> +	seq_printf(seq, "\tOne-Step Timestamping: %s\n",
> +		   priv->dma_cap.osten ? "Y" : "N");
> +	seq_printf(seq, "\tPriority-Based Flow Control: %s\n",
> +		   priv->dma_cap.pfcen ? "Y" : "N");
> +	seq_printf(seq, "\tNumber of Flexible RX Parser Instructions: %lu\n",
> +		   BIT(priv->dma_cap.frpes) << 6);
> +	seq_printf(seq, "\tNumber of Flexible RX Parser Parsable Bytes: %lu\n",
> +		   BIT(priv->dma_cap.frpbs) << 6);
> +	seq_printf(seq, "\tParallel Instruction Processor Engines: %d\n",
> +		   priv->dma_cap.frppipe_num);
> +	seq_printf(seq, "\tNumber of Extended VLAN Tag Filters: %lu\n",
> +		   priv->dma_cap.nrvf_num ?
> +		   (BIT(priv->dma_cap.nrvf_num) << 1) : 0);
> +	seq_printf(seq, "\tWidth of the Time Interval Field in GCL: %d\n",
> +		   priv->dma_cap.estwid ? 4 * priv->dma_cap.estwid + 12 : 0);
> +	seq_printf(seq, "\tDepth of GCL: %lu\n",
> +		   priv->dma_cap.estdep ? (BIT(priv->dma_cap.estdep) << 5) : 0);
> +	seq_printf(seq, "\tQueue/Channel-Based VLAN Tag Insertion on TX: %s\n",
> +		   priv->dma_cap.cbtisel ? "Y" : "N");
> +	seq_printf(seq, "\tNumber of Auxiliary Snapshot Inputs: %d\n",
> +		   priv->dma_cap.aux_snapshot_n);
> +	seq_printf(seq, "\tOne-Step Timestamping for PTP over UDP/IP: %s\n",
> +		   priv->dma_cap.pou_ost_en ? "Y" : "N");
> +	seq_printf(seq, "\tEnhanced DMA: %s\n",
> +		   priv->dma_cap.edma ? "Y" : "N");
> +	seq_printf(seq, "\tDifferent Descriptor Cache: %s\n",
> +		   priv->dma_cap.ediffc ? "Y" : "N");
> +	seq_printf(seq, "\tVxLAN/NVGRE: %s\n",
> +		   priv->dma_cap.vxn ? "Y" : "N");
> +	seq_printf(seq, "\tDebug Memory Interface: %s\n",
> +		   priv->dma_cap.dbgmem ? "Y" : "N");
> +	seq_printf(seq, "\tNumber of Policing Counters: %lu\n",
> +		   priv->dma_cap.pcsel ? BIT(priv->dma_cap.pcsel + 3) : 0);
>  	return 0;
>  }
>  DEFINE_SHOW_ATTRIBUTE(stmmac_dma_cap);
> -- 
> 2.34.1
> 
> 
