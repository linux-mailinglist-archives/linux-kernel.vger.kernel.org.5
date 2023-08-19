Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27E478181B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 09:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344408AbjHSHsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 03:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344387AbjHSHsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 03:48:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC48E7B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 00:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FBCB6272F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA45C433C8;
        Sat, 19 Aug 2023 07:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692431285;
        bh=gIy6yc3rpRO+ZpOnV1d1ea8VdXNefO9kKXZEqnuE+k8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L6oNGQimc42TajW8Isq9Ep/y9xdS2g6YuCHn/SI6f026gOdDtCLgC7YaKo4BbhumZ
         Jvbk4aNQx99vneHTpAfLMYKOXuoBP7017K4jrRjtAqmskTt6aerWjbx/hzPWTaY8oJ
         4j2FHITbDbbEVxAkSisZBXEM01yTUe6N32zQhO6klazgDdcnC47uADc/Cy+TsYt+X3
         fQO6EkjOsfJMsFWW55v4U50Mm30HUwgiesuztj0NR16M+004peRkEPuIZE1AdMVzrp
         oafyNMZ53LCtPgtqto6NMWAolGZskHzZSRANUOKN7Xjxz80CkboKZkghmTXKL/TArb
         NY1r8a/NHwVTg==
Date:   Sat, 19 Aug 2023 09:48:01 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 3/4] net: ethernet: mtk_eth_soc: add support for
 in-SoC SRAM
Message-ID: <ZOBzsUIM1Thfw+yl@lore-desk>
References: <cover.1692400170.git.daniel@makrotopia.org>
 <f24cefa3f0f1ead90ab8552099d6ceeeb12ba997.1692400170.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U+qIIYHU7IgoXdym"
Content-Disposition: inline
In-Reply-To: <f24cefa3f0f1ead90ab8552099d6ceeeb12ba997.1692400170.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U+qIIYHU7IgoXdym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> MT7981, MT7986 and MT7988 come with in-SoC SRAM dedicated for Ethernet
> DMA rings. Support using the SRAM without breaking existing device tree
> bindings, ie. only new SoC starting from MT7988 will have the SRAM
> declared as additional resource in device tree. For MT7981 and MT7986
> an offset on top of the main I/O base is used.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 84 ++++++++++++++++-----
>  drivers/net/ethernet/mediatek/mtk_eth_soc.h | 12 ++-
>  2 files changed, 74 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/et=
hernet/mediatek/mtk_eth_soc.c
> index 2482f47313085..eea3a7e578831 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -1135,10 +1135,13 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
>  	dma_addr_t dma_addr;
>  	int i;
> =20
> -	eth->scratch_ring =3D dma_alloc_coherent(eth->dma_dev,
> -					       cnt * soc->txrx.txd_size,
> -					       &eth->phy_scratch_ring,
> -					       GFP_KERNEL);
> +	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM))
> +		eth->scratch_ring =3D eth->sram_base;

Hi Daniel,

scratch_ring is now an __iomem pointer while before was just a void one. We
need to fix it.

Regards,
Lorenzo

> +	else
> +		eth->scratch_ring =3D dma_alloc_coherent(eth->dma_dev,
> +						       cnt * soc->txrx.txd_size,
> +						       &eth->phy_scratch_ring,
> +						       GFP_KERNEL);
>  	if (unlikely(!eth->scratch_ring))
>  		return -ENOMEM;
> =20
> @@ -2446,8 +2449,14 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
>  	if (!ring->buf)
>  		goto no_tx_mem;
> =20
> -	ring->dma =3D dma_alloc_coherent(eth->dma_dev, ring_size * sz,
> -				       &ring->phys, GFP_KERNEL);
> +	if (MTK_HAS_CAPS(soc->caps, MTK_SRAM)) {
> +		ring->dma =3D eth->sram_base + ring_size * sz;
> +		ring->phys =3D eth->phy_scratch_ring + ring_size * (dma_addr_t)sz;
> +	} else {
> +		ring->dma =3D dma_alloc_coherent(eth->dma_dev, ring_size * sz,
> +					       &ring->phys, GFP_KERNEL);
> +	}
> +
>  	if (!ring->dma)
>  		goto no_tx_mem;
> =20
> @@ -2546,8 +2555,7 @@ static void mtk_tx_clean(struct mtk_eth *eth)
>  		kfree(ring->buf);
>  		ring->buf =3D NULL;
>  	}
> -
> -	if (ring->dma) {
> +	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && ring->dma) {
>  		dma_free_coherent(eth->dma_dev,
>  				  ring->dma_size * soc->txrx.txd_size,
>  				  ring->dma, ring->phys);
> @@ -2566,9 +2574,14 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int r=
ing_no, int rx_flag)
>  {
>  	const struct mtk_reg_map *reg_map =3D eth->soc->reg_map;
>  	struct mtk_rx_ring *ring;
> -	int rx_data_len, rx_dma_size;
> +	int rx_data_len, rx_dma_size, tx_ring_size;
>  	int i;
> =20
> +	if (MTK_HAS_CAPS(eth->soc->caps, MTK_QDMA))
> +		tx_ring_size =3D MTK_QDMA_RING_SIZE;
> +	else
> +		tx_ring_size =3D MTK_DMA_SIZE;
> +
>  	if (rx_flag =3D=3D MTK_RX_FLAGS_QDMA) {
>  		if (ring_no)
>  			return -EINVAL;
> @@ -2603,9 +2616,20 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int r=
ing_no, int rx_flag)
>  		ring->page_pool =3D pp;
>  	}
> =20
> -	ring->dma =3D dma_alloc_coherent(eth->dma_dev,
> -				       rx_dma_size * eth->soc->txrx.rxd_size,
> -				       &ring->phys, GFP_KERNEL);
> +	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM) ||
> +	    rx_flag !=3D MTK_RX_FLAGS_NORMAL) {
> +		ring->dma =3D dma_alloc_coherent(eth->dma_dev,
> +					       rx_dma_size * eth->soc->txrx.rxd_size,
> +					       &ring->phys, GFP_KERNEL);
> +	} else {
> +		struct mtk_tx_ring *tx_ring =3D &eth->tx_ring;
> +
> +		ring->dma =3D tx_ring->dma + tx_ring_size *
> +			    eth->soc->txrx.txd_size * (ring_no + 1);
> +		ring->phys =3D tx_ring->phys + tx_ring_size *
> +			     eth->soc->txrx.txd_size * (ring_no + 1);
> +	}
> +
>  	if (!ring->dma)
>  		return -ENOMEM;
> =20
> @@ -2690,7 +2714,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ri=
ng_no, int rx_flag)
>  	return 0;
>  }
> =20
> -static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring)
> +static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring, =
bool in_sram)
>  {
>  	int i;
> =20
> @@ -2713,7 +2737,7 @@ static void mtk_rx_clean(struct mtk_eth *eth, struc=
t mtk_rx_ring *ring)
>  		ring->data =3D NULL;
>  	}
> =20
> -	if (ring->dma) {
> +	if (!in_sram && ring->dma) {
>  		dma_free_coherent(eth->dma_dev,
>  				  ring->dma_size * eth->soc->txrx.rxd_size,
>  				  ring->dma, ring->phys);
> @@ -3073,7 +3097,7 @@ static void mtk_dma_free(struct mtk_eth *eth)
>  	for (i =3D 0; i < MTK_MAX_DEVS; i++)
>  		if (eth->netdev[i])
>  			netdev_reset_queue(eth->netdev[i]);
> -	if (eth->scratch_ring) {
> +	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && eth->scratch_ring) {
>  		dma_free_coherent(eth->dma_dev,
>  				  MTK_QDMA_RING_SIZE * soc->txrx.txd_size,
>  				  eth->scratch_ring, eth->phy_scratch_ring);
> @@ -3081,13 +3105,13 @@ static void mtk_dma_free(struct mtk_eth *eth)
>  		eth->phy_scratch_ring =3D 0;
>  	}
>  	mtk_tx_clean(eth);
> -	mtk_rx_clean(eth, &eth->rx_ring[0]);
> -	mtk_rx_clean(eth, &eth->rx_ring_qdma);
> +	mtk_rx_clean(eth, &eth->rx_ring[0], MTK_HAS_CAPS(soc->caps, MTK_SRAM));
> +	mtk_rx_clean(eth, &eth->rx_ring_qdma, false);
> =20
>  	if (eth->hwlro) {
>  		mtk_hwlro_rx_uninit(eth);
>  		for (i =3D 1; i < MTK_MAX_RX_RING_NUM; i++)
> -			mtk_rx_clean(eth, &eth->rx_ring[i]);
> +			mtk_rx_clean(eth, &eth->rx_ring[i], false);
>  	}
> =20
>  	kfree(eth->scratch_head);
> @@ -4676,7 +4700,7 @@ static int mtk_sgmii_init(struct mtk_eth *eth)
> =20
>  static int mtk_probe(struct platform_device *pdev)
>  {
> -	struct resource *res =3D NULL;
> +	struct resource *res =3D NULL, *res_sram;
>  	struct device_node *mac_np;
>  	struct mtk_eth *eth;
>  	int err, i;
> @@ -4696,6 +4720,16 @@ static int mtk_probe(struct platform_device *pdev)
>  	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
>  		eth->ip_align =3D NET_IP_ALIGN;
> =20
> +	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM)) {
> +		if (mtk_is_netsys_v3_or_greater(eth)) {
> +			eth->sram_base =3D devm_platform_ioremap_resource(pdev, 1);
> +			if (IS_ERR(eth->sram_base))
> +				return PTR_ERR(eth->sram_base);
> +		} else {
> +			eth->sram_base =3D eth->base + MTK_ETH_SRAM_OFFSET;
> +		}
> +	}
> +
>  	spin_lock_init(&eth->page_lock);
>  	spin_lock_init(&eth->tx_irq_lock);
>  	spin_lock_init(&eth->rx_irq_lock);
> @@ -4759,6 +4793,18 @@ static int mtk_probe(struct platform_device *pdev)
>  			err =3D -EINVAL;
>  			goto err_destroy_sgmii;
>  		}
> +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM)) {
> +			if (mtk_is_netsys_v3_or_greater(eth)) {
> +				res_sram =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +				if (!res_sram) {
> +					err =3D -EINVAL;
> +					goto err_destroy_sgmii;
> +				}
> +				eth->phy_scratch_ring =3D res_sram->start;
> +			} else {
> +				eth->phy_scratch_ring =3D res->start + MTK_ETH_SRAM_OFFSET;
> +			}
> +		}
>  	}
> =20
>  	if (eth->soc->offload_version) {
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/et=
hernet/mediatek/mtk_eth_soc.h
> index cf9381a3d68b7..0e513f41ad477 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> @@ -139,6 +139,9 @@
>  #define MTK_GDMA_MAC_ADRH(x)	({ typeof(x) _x =3D (x); (_x =3D=3D MTK_GMA=
C3_ID) ?	\
>  				   0x54C : 0x50C + (_x * 0x1000); })
> =20
> +/* Internal SRAM offset */
> +#define MTK_ETH_SRAM_OFFSET	0x40000
> +
>  /* FE global misc reg*/
>  #define MTK_FE_GLO_MISC         0x124
> =20
> @@ -938,6 +941,7 @@ enum mkt_eth_capabilities {
>  	MTK_RSTCTRL_PPE1_BIT,
>  	MTK_RSTCTRL_PPE2_BIT,
>  	MTK_U3_COPHY_V2_BIT,
> +	MTK_SRAM_BIT,
> =20
>  	/* MUX BITS*/
>  	MTK_ETH_MUX_GDM1_TO_GMAC1_ESW_BIT,
> @@ -973,6 +977,7 @@ enum mkt_eth_capabilities {
>  #define MTK_RSTCTRL_PPE1	BIT_ULL(MTK_RSTCTRL_PPE1_BIT)
>  #define MTK_RSTCTRL_PPE2	BIT_ULL(MTK_RSTCTRL_PPE2_BIT)
>  #define MTK_U3_COPHY_V2		BIT_ULL(MTK_U3_COPHY_V2_BIT)
> +#define MTK_SRAM		BIT_ULL(MTK_SRAM_BIT)
> =20
>  #define MTK_ETH_MUX_GDM1_TO_GMAC1_ESW		\
>  	BIT_ULL(MTK_ETH_MUX_GDM1_TO_GMAC1_ESW_BIT)
> @@ -1048,14 +1053,14 @@ enum mkt_eth_capabilities {
>  #define MT7981_CAPS  (MTK_GMAC1_SGMII | MTK_GMAC2_SGMII | MTK_GMAC2_GEPH=
Y | \
>  		      MTK_MUX_GMAC12_TO_GEPHY_SGMII | MTK_QDMA | \
>  		      MTK_MUX_U3_GMAC2_TO_QPHY | MTK_U3_COPHY_V2 | \
> -		      MTK_RSTCTRL_PPE1)
> +		      MTK_RSTCTRL_PPE1 | MTK_SRAM)
> =20
>  #define MT7986_CAPS  (MTK_GMAC1_SGMII | MTK_GMAC2_SGMII | \
>  		      MTK_MUX_GMAC12_TO_GEPHY_SGMII | MTK_QDMA | \
> -		      MTK_RSTCTRL_PPE1)
> +		      MTK_RSTCTRL_PPE1 | MTK_SRAM)
> =20
>  #define MT7988_CAPS  (MTK_GDM1_ESW | MTK_QDMA | MTK_RSTCTRL_PPE1 | \
> -		      MTK_RSTCTRL_PPE2)
> +		      MTK_RSTCTRL_PPE2 | MTK_SRAM)
> =20
>  struct mtk_tx_dma_desc_info {
>  	dma_addr_t	addr;
> @@ -1215,6 +1220,7 @@ struct mtk_eth {
>  	struct device			*dev;
>  	struct device			*dma_dev;
>  	void __iomem			*base;
> +	void __iomem			*sram_base;
>  	spinlock_t			page_lock;
>  	spinlock_t			tx_irq_lock;
>  	spinlock_t			rx_irq_lock;
> --=20
> 2.41.0

--U+qIIYHU7IgoXdym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZOBzsQAKCRA6cBh0uS2t
rFdPAQDbZjLVS9cvk2P1LCkAzRD1HLVGWbHHJoXiJMrB3jUCZAEA6Ffj1/+lsScS
VPj+8WcsBcr0xSnntaRkGur8GDvuLQ0=
=1h0Y
-----END PGP SIGNATURE-----

--U+qIIYHU7IgoXdym--
