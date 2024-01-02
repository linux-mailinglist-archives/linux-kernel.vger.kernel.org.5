Return-Path: <linux-kernel+bounces-14248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 991E58219E6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E25E1F220EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53C6D2FA;
	Tue,  2 Jan 2024 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SYn1pykk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072BEACE;
	Tue,  2 Jan 2024 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 402AXGpr062512;
	Tue, 2 Jan 2024 04:33:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704191596;
	bh=BxYuu9G3Hpb/Bs5A+un9uQi+qqPTeusWxKQoqmwv1vk=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=SYn1pykkwzhGWSGWpw6AbAOWRWX0h1Rs6+HwHanHThwzKhu2VZ32qDq0Tj0r5RcRm
	 Nw8HYVth98SnG7xEQ1tb4CmbLTeeLcZ2h0fQjuRQ7mT0gMLAKRD0Fh4jMswRjN/nNs
	 R4l9fIG8ZR366xUEFNGCkgva0CXihIt/LOAO8lz0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 402AXGjM106382
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jan 2024 04:33:16 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jan 2024 04:33:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jan 2024 04:33:15 -0600
Received: from [10.249.131.186] ([10.249.131.186])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 402AXCks027081;
	Tue, 2 Jan 2024 04:33:13 -0600
Message-ID: <162e12c7-c7c1-3bf9-48ec-05ee3c30e784@ti.com>
Date: Tue, 2 Jan 2024 16:03:11 +0530
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
Subject: Re: [PATCH 3/3] net: ethernet: ti: am65-cpsw: Add device tree
 property to set max MTU
Content-Language: en-US
To: =?UTF-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?=
	<Jorge.SanjuanGarcia@duagon.com>
References: <20240102081825.14635-1-jorge.sanjuangarcia@duagon.com>
 <c025f2f9-ca2c-4fdb-adb1-803745fded0c.a613f387-0b3b-49fd-9401-3a0ed0c1f80e.20d242d9-3999-48e2-8a9e-cd0f9ba3351c@emailsignatures365.codetwo.com>
 <20240102081825.14635-4-jorge.sanjuangarcia@duagon.com>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20240102081825.14635-4-jorge.sanjuangarcia@duagon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello,

On 02-01-2024 13:49, Sanjuán García, Jorge wrote:
> The switch supports ethernet frame sizes between 64 and 2024 bytes
> (including VLAN) as stated in the technical reference manual.

Could you please share the source for the "2024 bytes" mentioned above?
In J7200 SoC's TRM, I see support for up to 9604 bytes (including VLAN)
in the "CPSW_PN_RX_MAXLEN_REG_k" register description for CPSW5G
instance of CPSW.

> 
> This patch adds a new devicetree property so the switch ports can
> be configured with an MTU higher than the standar 1500 bytes, making

nitpick: standar/standard.

> the max frame length configured on the registers and the max_mtu
> advertised on the network device consistent.
> 
> Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
> ---

For patches which add new features, please use the subject prefix
[PATCH net-next].

>   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 18 ++++++++++++++----
>   drivers/net/ethernet/ti/am65-cpsw-nuss.h |  1 +
>   2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c 
> b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index a920146d7a60..6a5c8b6e03f4 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -56,7 +56,7 @@
>   #define AM65_CPSW_MAX_PORTS     8
> 
>   #define AM65_CPSW_MIN_PACKET_SIZE       VLAN_ETH_ZLEN
> -#define AM65_CPSW_MAX_PACKET_SIZE      (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)
> +#define AM65_CPSW_MAX_PACKET_SIZE      2024
> 
>   #define AM65_CPSW_REG_CTL               0x004
>   #define AM65_CPSW_REG_STAT_PORT_EN      0x014
> @@ -2198,8 +2198,7 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common 
> *common, u32 port_idx)
>           eth_hw_addr_set(port->ndev, port->slave.mac_addr);
> 
>           port->ndev->min_mtu = AM65_CPSW_MIN_PACKET_SIZE;
> -       port->ndev->max_mtu = common->rx_packet_max -
> -                             (VLAN_ETH_HLEN + ETH_FCS_LEN);
> +       port->ndev->max_mtu = common->max_mtu;

This seems to be modifying what was added in just the previous patch.
Isn't it better to merge these changes into a single patch?

>           port->ndev->hw_features = NETIF_F_SG |
>                                     NETIF_F_RXCSUM |
>                                     NETIF_F_HW_CSUM |
> @@ -2927,8 +2926,19 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
>           if (common->port_num < 1 || common->port_num > AM65_CPSW_MAX_PORTS)
>                   return -ENOENT;
> 
> +       common->max_mtu = VLAN_ETH_DATA_LEN;
> +       of_property_read_u32(dev->of_node, "max-frame-size", &common->max_mtu);

The device-tree property "max-frame-size" is a port-specific property.
Therefore, it is wrong to expect the property to be present at the CPSW
node level instead of being present within each port in the
"ethernet-ports" node. This section should be moved into the function:
am65_cpsw_nuss_init_slave_ports()
which parses the device-tree nodes for each port. The "max-frame-size"
property can be stored there on a per-port basis within a newly added
member in "struct am65_cpsw_port" as mentioned in my previous mail for
patch 2/3.

> +
> +       common->rx_packet_max = common->max_mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;
> +       if (common->rx_packet_max > AM65_CPSW_MAX_PACKET_SIZE) {
> +               common->rx_packet_max = AM65_CPSW_MAX_PACKET_SIZE;
> +               common->max_mtu = AM65_CPSW_MAX_PACKET_SIZE -
> +                                 (VLAN_ETH_HLEN + ETH_FCS_LEN);
> +       }
> +
> +       dev_info(common->dev, "Max RX packet size set to %d\n", 
> common->rx_packet_max);
> +
>           common->rx_flow_id_base = -1;
> -       common->rx_packet_max = AM65_CPSW_MAX_PACKET_SIZE;
>           init_completion(&common->tdown_complete);
>           common->tx_ch_num = AM65_CPSW_DEFAULT_TX_CHNS;
>           common->pf_p0_rx_ptype_rrobin = false;
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h 
> b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
> index 141160223d73..3bb0ff94a46a 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
> @@ -130,6 +130,7 @@ struct am65_cpsw_common {
>           u32                     tx_ch_rate_msk;
>           u32                     rx_flow_id_base;
> 
> +       int                     max_mtu;
>           int                     rx_packet_max;
> 
>           struct am65_cpsw_tx_chn tx_chns[AM65_CPSW_MAX_TX_QUEUES];

...

-- 
Regards,
Siddharth.

