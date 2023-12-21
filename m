Return-Path: <linux-kernel+bounces-7953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E39CC81AFA0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD7E1F2817A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5233AC16;
	Thu, 21 Dec 2023 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HeBijgvr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C6239858;
	Thu, 21 Dec 2023 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL62uDC026618;
	Thu, 21 Dec 2023 07:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xM8x3CylIQFdiJ4PeOPo6wWJ3ARCdFJr+MWgDcH0lo0=; b=He
	BijgvrCSezFSZFryb1/RN59NCpOTXVnuodwomoBKFBIH9/OLlhKQ9UJeA5cr1blF
	d9EGap/7OzQpRRRQSZZzgc1N2KVAn6rWl05DoXJXB/fsjtrharAvb3ys3JoxgkD/
	9EXhbNwAnnZrK9sbcZ2NHyXHm8MOdU0/iT9nhGBWf5vcIEMzNj8l+cStNMTh8VgQ
	5OcT63fX3SPwW5tz+7xCdiGOzvFfyeuJRF7QMvrzmgLVXeJCVbce/udqRL+y/fWw
	FilcdxU1OtloPWr04oF5JJT5pUTxLOTDvmPmOHi6ua/FL7HIc73PlHNi5Ba3jojD
	mo7W3CbOleCTCkJCMgng==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4ea0grus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 07:37:38 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BL7bb1L013516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 07:37:37 GMT
Received: from [10.216.1.141] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 23:37:26 -0800
Message-ID: <351eb4d2-4d14-4a4d-ac14-a0189e6614cc@quicinc.com>
Date: Thu, 21 Dec 2023 13:07:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/3] net: stmmac: Add driver support for
 DWMAC5 common safety IRQ
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
CC: Vinod Koul <vkoul@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu
	<joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Prasad Sodagudi
	<psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>, Rob Herring
	<robh@kernel.org>,
        <kernel@quicinc.com>
References: <20231219104815.3443231-1-quic_jsuraj@quicinc.com>
 <20231219104815.3443231-4-quic_jsuraj@quicinc.com>
 <irmn42brbxjwz45gh7hoay4aeollnq7gnzkuyuzjxjyh3syrst@mvgm7vecrhna>
From: Suraj Jaiswal <quic_jsuraj@quicinc.com>
In-Reply-To: <irmn42brbxjwz45gh7hoay4aeollnq7gnzkuyuzjxjyh3syrst@mvgm7vecrhna>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lx4C50JPc6BOYOsGVW5TobU25mo2GVb8
X-Proofpoint-ORIG-GUID: lx4C50JPc6BOYOsGVW5TobU25mo2GVb8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210055

hi Serge,
taken care of comments please review.

Thanks
Suraj

On 12/20/2023 8:20 PM, Serge Semin wrote:
> Hi Suraj
> 
> On Tue, Dec 19, 2023 at 04:18:15PM +0530, Suraj Jaiswal wrote:
>> Add support to listen HW safety IRQ like ECC(error
>> correction code), DPP(data path parity), FSM(finite state
>> machine) fault in common IRQ line.
>>
>> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
>> ---
>>  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
>>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 35 +++++++++++++++++++
>>  .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 +++++
>>  4 files changed, 46 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
>> index 721c1f8e892f..b9233b09b80f 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
>> @@ -344,6 +344,7 @@ enum request_irq_err {
>>  	REQ_IRQ_ERR_ALL,
>>  	REQ_IRQ_ERR_TX,
>>  	REQ_IRQ_ERR_RX,
>> +	REQ_IRQ_ERR_SFTY,
>>  	REQ_IRQ_ERR_SFTY_UE,
>>  	REQ_IRQ_ERR_SFTY_CE,
>>  	REQ_IRQ_ERR_LPI,
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>> index 9f89acf31050..9aeaca01cace 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>> @@ -31,6 +31,7 @@ struct stmmac_resources {
>>  	int wol_irq;
>>  	int lpi_irq;
>>  	int irq;
>> +	int sfty_irq;
>>  	int sfty_ce_irq;
>>  	int sfty_ue_irq;
>>  	int rx_irq[MTL_MAX_RX_QUEUES];
>> @@ -297,6 +298,7 @@ struct stmmac_priv {
>>  	void __iomem *ptpaddr;
>>  	void __iomem *estaddr;
>>  	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
>> +	int sfty_irq;
>>  	int sfty_ce_irq;
>>  	int sfty_ue_irq;
>>  	int rx_irq[MTL_MAX_RX_QUEUES];
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 47de466e432c..f6639ffb017e 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -3592,6 +3592,10 @@ static void stmmac_free_irq(struct net_device *dev,
>>  		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
>>  			free_irq(priv->wol_irq, dev);
>>  		fallthrough;
>> +	case REQ_IRQ_ERR_SFTY:
>> +		if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq)
>> +			free_irq(priv->sfty_irq, dev);
>> +		fallthrough;
>>  	case REQ_IRQ_ERR_WOL:
>>  		free_irq(dev->irq, dev);
>>  		fallthrough;
>> @@ -3661,6 +3665,21 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>>  		}
>>  	}
>>  
>> +	/* Request the common Safety Feature Correctible/Uncorrectible
>> +	 * Error line in case of another line is used
>> +	 */
> 
>> +	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
>> +		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
>> +				  0, dev->name, dev);
> 
> Not entirely what I asked. What I asked was to make the code unified in
> the respective IRQ-request methods. You just copy-and-pasted the same
> code snippet in both functions. To see what I meant please find the
> diff attached to this message. It's applicable on top of this patch.
> 
>> +		if (unlikely(ret < 0)) {
>> +			netdev_err(priv->dev,
> 
>> +				   "%s: alloc safety failed %d (error: %d)\n",
>> +				   __func__, priv->sfty_irq, ret);
> 
> This looks different than the rest of the error messages in this
> method (see the attached diff).
> 
>> +			irq_err = REQ_IRQ_ERR_SFTY;
>> +			goto irq_error;
>> +		}
>> +	}
>> +
>>  	/* Request the Safety Feature Correctible Error line in
>>  	 * case of another line is used
>>  	 */
>> @@ -3798,6 +3817,21 @@ static int stmmac_request_irq_single(struct net_device *dev)
>>  		}
>>  	}
>>  
>> +	/* Request the common Safety Feature Correctible/Uncorrectible
>> +	 * Error line in case of another line is used
>> +	 */
>> +	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
> 
>> +		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
>> +				  0, dev->name, dev);
> 
> IRQF_SHARED?
> 
>> +		if (unlikely(ret < 0)) {
> 
>> +			netdev_err(priv->dev,
>> +				   "%s: alloc safety failed %d (error: %d)\n",
>> +				   __func__, priv->sfty_irq, ret);
> 
> This also looks different than the rest of the error messages in this 
> method (see the attached diff).
> 
> Some other comments I'll send to v8 after all the above finally fixed.
> 
> -Serge(y)
> 
>> +			irq_err = REQ_IRQ_ERR_SFTY;
>> +			goto irq_error;
>> +		}
>> +	}
>> +
>>  	return 0;
>>  
>>  irq_error:
>> @@ -7462,6 +7496,7 @@ int stmmac_dvr_probe(struct device *device,
>>  	priv->dev->irq = res->irq;
>>  	priv->wol_irq = res->wol_irq;
>>  	priv->lpi_irq = res->lpi_irq;
>> +	priv->sfty_irq = res->sfty_irq;
>>  	priv->sfty_ce_irq = res->sfty_ce_irq;
>>  	priv->sfty_ue_irq = res->sfty_ue_irq;
>>  	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> index 70eadc83ca68..ab250161fd79 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> @@ -743,6 +743,14 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>>  		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
>>  	}
>>  
>> +	stmmac_res->sfty_irq =
>> +		platform_get_irq_byname_optional(pdev, "sfty");
>> +	if (stmmac_res->sfty_irq < 0) {
>> +		if (stmmac_res->sfty_irq == -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;
>> +		dev_info(&pdev->dev, "IRQ safety IRQ not found\n");
>> +	}
>> +
>>  	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
>>  
>>  	return PTR_ERR_OR_ZERO(stmmac_res->addr);
>> -- 
>> 2.25.1
>>
>>

