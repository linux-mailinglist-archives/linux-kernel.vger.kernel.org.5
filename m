Return-Path: <linux-kernel+bounces-22726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC2D82A22C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799F81F20FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168394F894;
	Wed, 10 Jan 2024 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kUEFH0Y1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C7F4F885;
	Wed, 10 Jan 2024 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AK8qBa015886;
	Wed, 10 Jan 2024 20:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=NgCE54sEzeUce6C/KiC9M0zAoiO6fbBzNGjrx8pUiLE=; b=kU
	EFH0Y134OQMi7pJYBTNbEfdPmPPZm6O4eDm1+ykwDemfQtUjJhSnXu1HuQ0ZABTs
	YlicfOOsaJIvhGs47dMrSbQZAXTvzs8CltbbPKcWILtqs/mj00Gv2i7Jkstg2/vr
	xqZNQ5+5prVw+VlaswHXT7APWdnbDvbgzzD3xMailYwlbbSkw7H2+VgievYgR5uD
	sOXK4WgLXbdiD82daOBH18rYbuF4gXbKtvEa8OvyLY/QRGsPEiKm6s/okOzpiwAE
	g4IUQIsFICGbCp6KmPRzVd0Dejdin36EMBVWvLuPYrwasUFTTdfrVPmc4LzPe0Zs
	EQR4EnO4FTUKPIs5qvKA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhsb2hf1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 20:19:56 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40AKJtXW026511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 20:19:55 GMT
Received: from [10.110.5.89] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 12:19:53 -0800
Message-ID: <92892988-bb77-4075-812e-19f6112f436e@quicinc.com>
Date: Wed, 10 Jan 2024 12:19:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: stmmac: TBS support for platform driver
Content-Language: en-US
To: Rohan G Thomas <rohan.g.thomas@intel.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "Jose
 Abreu" <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        "Serge
 Semin" <fancer.lancer@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>, <elder@linaro.org>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_bhaviks@quicinc.com>,
        <kernel.upstream@quicinc.com>
References: <20230927130919.25683-1-rohan.g.thomas@intel.com>
 <20230927130919.25683-3-rohan.g.thomas@intel.com>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <20230927130919.25683-3-rohan.g.thomas@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -pA_WXnVrm5JzPP1OM40hLBadBDWBoIa
X-Proofpoint-GUID: -pA_WXnVrm5JzPP1OM40hLBadBDWBoIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100161

Qualcomm had similar discussions with respect to enabling of TBS for a particular queue. 
We had similar discussion on these terms yesterday with Redhat. Adding Andrew from Redhat here 

What we discovered as part of the discussions is listed below. 

1. Today upstream stmmac code is designed in such a way that TBS flag is put as
part of queue configurations(see below snippet) and as well know that stmmac queue 
configuration comes from the dtsi file. 

//ndo_open => stmmac_open
int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;(comes from tx_queues_cfg)

/* Setup per-TXQ tbs flag before TX descriptor alloc */
tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;

2. There is a no way to do this dynamically from user space because we don't have any 
API exposed which can do it from user space and also TBS rely on special descriptors 
aka enhanced desc this cannot be done run time and stmmac has to be aware of it before 
we do DMA/MAC/MTL start. To do this dynamically would only mean stopping DMA/MAC/MTL 
realloc resources for enhanced desc and the starting MAC/DMA/MTL. This means we are 
disrupting other traffic(By stopping MAC block).

3. I dont think there is a way we can enable this dynamically today. I would like upstream 
community to share your thoughts as well.

4. I agree with Rohan's patch here and want upstream community to accept it. This will allow
use to configure the queues where TBS needs to be enabled as hardcoding in the code unless upstream
has better way to this using userspace.

Please let us know if you think otherwise. 


On 9/27/2023 6:09 AM, Rohan G Thomas wrote:
> Enable Time Based Scheduling(TBS) support for Tx queues through the
> stmmac platform driver. For this a new per-queue tx-config property,
> tbs-enabled is added to the devicetree.
> 
> Commit 7eadf57290ec ("net: stmmac: pci: Enable TBS on GMAC5 IPK PCI
> entry") enables similar support for the stmmac pci driver.
> 
> Also add check whether TBS support is available for a Tx DMA channel
> before enabling TBS support for that Tx DMA channel.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 25 +++++++++++++++----
>  .../ethernet/stmicro/stmmac/stmmac_platform.c |  4 +++
>  2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 81b6f3ecdf92..7333f0640b3d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3773,12 +3773,18 @@ stmmac_setup_dma_desc(struct stmmac_priv *priv, unsigned int mtu)
>  		dma_conf->dma_rx_size = DMA_DEFAULT_RX_SIZE;
>  
>  	/* Earlier check for TBS */
> -	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++) {
> -		struct stmmac_tx_queue *tx_q = &dma_conf->tx_queue[chan];
> -		int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;
> +	if (priv->dma_cap.tbssel) {
> +		/* TBS is available only for tbs_ch_num of Tx DMA channels,
> +		 * starting from the highest Tx DMA channel.
> +		 */
> +		chan = priv->dma_cap.number_tx_channel - priv->dma_cap.tbs_ch_num;
> +		for (; chan < priv->plat->tx_queues_to_use; chan++) {
> +			struct stmmac_tx_queue *tx_q = &dma_conf->tx_queue[chan];
> +			int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;
>  
> -		/* Setup per-TXQ tbs flag before TX descriptor alloc */
> -		tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;
> +			/* Setup per-TXQ tbs flag before TX descriptor alloc */
> +			tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;
> +		}
>  	}
>  
>  	ret = alloc_dma_desc_resources(priv, dma_conf);
> @@ -7505,6 +7511,15 @@ int stmmac_dvr_probe(struct device *device,
>  		}
>  	}
>  
> +	/* If TBS feature is supported(i.e. tbssel is true), then at least 1 Tx
> +	 * DMA channel supports TBS. So if tbs_ch_num is 0 and tbssel is true,
> +	 * assume all Tx DMA channels support TBS. TBS_CH field, which gives
> +	 * number of Tx DMA channels with TBS support is only available only for
> +	 * DW xGMAC IP. For other DWMAC IPs all Tx DMA channels can support TBS.
> +	 */
> +	if (priv->dma_cap.tbssel && !priv->dma_cap.tbs_ch_num)
> +		priv->dma_cap.tbs_ch_num = priv->dma_cap.number_tx_channel;
> +
>  	ndev->features |= ndev->hw_features | NETIF_F_HIGHDMA;
>  	ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
>  #ifdef STMMAC_VLAN_TAG_USED
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 843bd8804bfa..6c0191c84071 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -279,6 +279,10 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
>  		plat->tx_queues_cfg[queue].coe_unsupported =
>  			of_property_read_bool(q_node, "snps,coe-unsupported");
>  
> +		/* Select TBS for supported queues */
> +		plat->tx_queues_cfg[queue].tbs_en =
> +			of_property_read_bool(q_node, "snps,tbs-enabled");
> +
>  		queue++;
>  	}
>  	if (queue != plat->tx_queues_to_use) {

