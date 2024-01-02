Return-Path: <linux-kernel+bounces-14227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892A2821976
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B61D1C21A5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474F9D287;
	Tue,  2 Jan 2024 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WJCX10Cy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C7D268;
	Tue,  2 Jan 2024 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 402AAxYq057964;
	Tue, 2 Jan 2024 04:10:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704190259;
	bh=wjNblscvzjBJWi7IEaB+NGGPDDjrbOs7ytEZtICb098=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=WJCX10Cygb9zsVzPIPCfW9C287lID3P858kTqxeOgNLjM1kJwkbhsQAtCTv0fwNS6
	 Nwo056D6KzYy6+kLX2KH2Ew2jH9C4nrxKM3S1bGOQie91tZo48OUQ/Gb1H/PKpGw9S
	 623Fv7LU2sXvuLXzgNHvR8702BDTJOqvluY7YHtU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 402AAxSW071229
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jan 2024 04:10:59 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jan 2024 04:10:59 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jan 2024 04:10:59 -0600
Received: from [10.249.131.186] ([10.249.131.186])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 402AAuxr002273;
	Tue, 2 Jan 2024 04:10:56 -0600
Message-ID: <e0337cfa-9744-7451-1fef-7f43f3b6cbe0@ti.com>
Date: Tue, 2 Jan 2024 15:40:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH 2/3] net: ethernet: ti: am65-cpsw: Introduce rx_packet_max
 member
Content-Language: en-US
To: =?UTF-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?=
	<Jorge.SanjuanGarcia@duagon.com>
References: <20240102081825.14635-1-jorge.sanjuangarcia@duagon.com>
 <c025f2f9-ca2c-4fdb-adb1-803745fded0c.a613f387-0b3b-49fd-9401-3a0ed0c1f80e.92d487ae-01e3-421b-a953-2e66fd9b9d60@emailsignatures365.codetwo.com>
 <20240102081825.14635-3-jorge.sanjuangarcia@duagon.com>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20240102081825.14635-3-jorge.sanjuangarcia@duagon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello,

On 02-01-2024 13:49, Sanjuán García, Jorge wrote:
> The value written to the register AM65_CPSW_PORT_REG_RX_MAXLEN
> is currently fixed to what AM65_CPSW_MAX_PACKET_SIZE defines. This
> patch prepares the driver so that the maximum received frame length
> can be configured in future updates.
> 
> Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
> ---

For patches which add new features, please use the subject prefix
[PATCH net-next].

>   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 13 ++++++++-----
>   drivers/net/ethernet/ti/am65-cpsw-nuss.h |  2 ++
>   2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c 
> b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 378d69b8cb14..a920146d7a60 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -151,9 +151,11 @@ static void am65_cpsw_port_set_sl_mac(struct am65_cpsw_port 
> *slave,
> 
>   static void am65_cpsw_sl_ctl_reset(struct am65_cpsw_port *port)
>   {
> +       struct am65_cpsw_common *common = port->common;
> +
>           cpsw_sl_reset(port->slave.mac_sl, 100);
>           /* Max length register has to be restored after MAC SL reset */
> -       writel(AM65_CPSW_MAX_PACKET_SIZE,
> +       writel(common->rx_packet_max,
>                  port->port_base + AM65_CPSW_PORT_REG_RX_MAXLEN);

Prior to this patch, since the RX Packet size was hard-coded, it was
being set to the same value across all ports. However, please note that
there are per-port registers:
port->port_base + AM65_CPSW_PORT_REG_RX_MAXLEN
So, wouldn't it be better to define the "rx_packet_max" member within
"struct am65_cpsw_port", rather than "struct am65_cpsw_common"?
The same question applies to the following sections as well.

I went through patch 3/3 of this series and the device-tree property:
max-frame-size
is being used to fetch the value for "rx_packet_max". But, isn't
max-frame-size a port specific parameter? Shouldn't it then be stored as
a member of "struct am65_cpsw_port".

>   }
> 
> @@ -455,7 +457,7 @@ static int am65_cpsw_nuss_common_open(struct 
> am65_cpsw_common *common)
>                  AM65_CPSW_CTL_VLAN_AWARE | AM65_CPSW_CTL_P0_RX_PAD,
>                  common->cpsw_base + AM65_CPSW_REG_CTL);
>           /* Max length register */
> -       writel(AM65_CPSW_MAX_PACKET_SIZE,
> +       writel(common->rx_packet_max,
>                  host_p->port_base + AM65_CPSW_PORT_REG_RX_MAXLEN);
>           /* set base flow_id */
>           writel(common->rx_flow_id_base,
> @@ -507,7 +509,7 @@ static int am65_cpsw_nuss_common_open(struct 
> am65_cpsw_common *common)
> 
>           for (i = 0; i < common->rx_chns.descs_num; i++) {
>                   skb = __netdev_alloc_skb_ip_align(NULL,
> -                                                 AM65_CPSW_MAX_PACKET_SIZE,
> +                                                 common->rx_packet_max,
>                                                     GFP_KERNEL);
>                   if (!skb) {
>                           ret = -ENOMEM;
> @@ -848,7 +850,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common 
> *common,
> 
>           k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
> 
> -       new_skb = netdev_alloc_skb_ip_align(ndev, AM65_CPSW_MAX_PACKET_SIZE);
> +       new_skb = netdev_alloc_skb_ip_align(ndev, common->rx_packet_max);
>           if (new_skb) {
>                   ndev_priv = netdev_priv(ndev);
>                   am65_cpsw_nuss_set_offload_fwd_mark(skb, 
> ndev_priv->offload_fwd_mark);
> @@ -2196,7 +2198,7 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common 
> *common, u32 port_idx)
>           eth_hw_addr_set(port->ndev, port->slave.mac_addr);
> 
>           port->ndev->min_mtu = AM65_CPSW_MIN_PACKET_SIZE;
> -       port->ndev->max_mtu = AM65_CPSW_MAX_PACKET_SIZE -
> +       port->ndev->max_mtu = common->rx_packet_max -
>                                 (VLAN_ETH_HLEN + ETH_FCS_LEN);
>           port->ndev->hw_features = NETIF_F_SG |
>                                     NETIF_F_RXCSUM |
> @@ -2926,6 +2928,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
>                   return -ENOENT;
> 
>           common->rx_flow_id_base = -1;
> +       common->rx_packet_max = AM65_CPSW_MAX_PACKET_SIZE;
>           init_completion(&common->tdown_complete);
>           common->tx_ch_num = AM65_CPSW_DEFAULT_TX_CHNS;
>           common->pf_p0_rx_ptype_rrobin = false;
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h 
> b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
> index f3dad2ab9828..141160223d73 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
> @@ -130,6 +130,8 @@ struct am65_cpsw_common {
>           u32                     tx_ch_rate_msk;
>           u32                     rx_flow_id_base;
> 
> +       int                     rx_packet_max;
> +
>           struct am65_cpsw_tx_chn tx_chns[AM65_CPSW_MAX_TX_QUEUES];
>           struct completion       tdown_complete;
>           atomic_t                tdown_cnt;

...

-- 
Regards,
Siddharth.

