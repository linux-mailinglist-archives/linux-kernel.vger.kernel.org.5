Return-Path: <linux-kernel+bounces-3281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFED0816A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F24282B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C59E12B93;
	Mon, 18 Dec 2023 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jUgonzWq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140F712B61;
	Mon, 18 Dec 2023 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI7weGU029514;
	Mon, 18 Dec 2023 09:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6lHtX4h5VX2oEtzX8FS/QeNc9WcK0n6EiGg67AQjDb8=; b=jU
	gonzWqz13NbA5oU+/3c/9GI3gq86GmQUEmV8tlw5zhyYBVMsIATpC0mt4egP4PWz
	BrXtnuBN2ebtu1+0xJAMFi/Or9SLJC+0cxfMsu535mJJRx2WtK1KkwkNTboyMntp
	3yeudVixcg+AJX3vYRxT7Ay3lZ3gNriSdkf7FksASMgBsrEFpsEASd48sGPrRisJ
	MA+xbV9pQHOYl6SzLYRVcCJsBoFAzKbVcvBM62A0aDrm/Uq9FlqxPw3JfI76KIBt
	AdbPnKZaXnk6xf9QjEG8OVIo1zr4GImwA4NOOz9kGqVkSJiidkQAvjp4c7xw8Van
	XIJODhhZ8LzyUt8nARsw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2gw0rd9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 09:58:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI9w6Ik026436
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 09:58:06 GMT
Received: from [10.217.90.28] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 01:57:57 -0800
Message-ID: <8ed8450f-a9c7-4e9d-97b8-3d26668c7eb4@quicinc.com>
Date: Mon, 18 Dec 2023 15:27:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/3] net: stmmac: Add driver support for
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
References: <20231212115841.3800241-1-quic_jsuraj@quicinc.com>
 <20231212115841.3800241-4-quic_jsuraj@quicinc.com>
 <bcppwdnscrebqtsap2fyfd6ltpi4al3ojm5dqytzp37h7y7rdy@zqy6bncdhzl2>
From: Suraj Jaiswal <quic_jsuraj@quicinc.com>
In-Reply-To: <bcppwdnscrebqtsap2fyfd6ltpi4al3ojm5dqytzp37h7y7rdy@zqy6bncdhzl2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8G2h9_YAlPDb10pnGjp-qGq3GfJQ3gbk
X-Proofpoint-ORIG-GUID: 8G2h9_YAlPDb10pnGjp-qGq3GfJQ3gbk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180071


Hi Serge,
Please find commnet inline & let me know if any further action needed

Thanks
Suraj

On 12/14/2023 8:42 PM, Serge Semin wrote:
> Hi Suraj
> 
> On Tue, Dec 12, 2023 at 05:28:41PM +0530, Suraj Jaiswal wrote:
>> Add support to listen HW safety IRQ like ECC(error
>> correction code), DPP(data path parity), FSM(finite state
>> machine) fault in common IRQ line.
>>
>> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
>> ---
>>  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 +++
>>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 21 +++++++++++++++++++
>>  .../ethernet/stmicro/stmmac/stmmac_platform.c |  9 ++++++++
>>  4 files changed, 34 insertions(+)
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
>> index 9f89acf31050..ca3d93851bed 100644
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
>> @@ -305,6 +307,7 @@ struct stmmac_priv {
>>  	char int_name_mac[IFNAMSIZ + 9];
>>  	char int_name_wol[IFNAMSIZ + 9];
>>  	char int_name_lpi[IFNAMSIZ + 9];
>> +	char int_name_sfty[IFNAMSIZ + 10];
>>  	char int_name_sfty_ce[IFNAMSIZ + 10];
>>  	char int_name_sfty_ue[IFNAMSIZ + 10];
>>  	char int_name_rx_irq[MTL_MAX_TX_QUEUES][IFNAMSIZ + 14];
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 47de466e432c..6cf289f192a7 100644
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
>> @@ -3759,6 +3763,7 @@ static int stmmac_request_irq_single(struct net_device *dev)
>>  	struct stmmac_priv *priv = netdev_priv(dev);
>>  	enum request_irq_err irq_err;
>>  	int ret;
> 
>> +	char *int_name;
> 
> See my comment below.
> 
>>  
>>  	ret = request_irq(dev->irq, stmmac_interrupt,
>>  			  IRQF_SHARED, dev->name, dev);
>> @@ -3798,6 +3803,20 @@ static int stmmac_request_irq_single(struct net_device *dev)
>>  		}
>>  	}
>>  
> 
>> +	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
>> +		int_name = priv->int_name_sfty;
>> +		sprintf(int_name, "%s:%s", dev->name, "safety");
>> +		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
>> +				  0, int_name, dev);
>> +		if (unlikely(ret < 0)) {
>> +			netdev_err(priv->dev,
>> +				   "%s: alloc safety failed %d (error: %d)\n",
>> +				   __func__, priv->sfty_irq, ret);
>> +			irq_err = REQ_IRQ_ERR_SFTY;
>> +			goto irq_error;
>> +		}
>> +	}
>> +
> 
> Omg, I thought this change belonged to stmmac_request_irq_multi_msi().
> My bad, sorry. Please move the code above to
> stmmac_request_irq_multi_msi() and get back the part in
> stmmac_request_irq_single() as it was in v5, but instead of specifying
> "safety" IRQ name use "dev->name" as the rest of similar code snippets
> in here have:
> 
> +	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
> +		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
> +				  0, dev->name, dev);
> +		if (unlikely(ret < 0)) {
> +			netdev_err(priv->dev,
> +				   "%s: alloc safety failed %d (error: %d)\n",
> +				   __func__, priv->sfty_irq, ret);
> +			irq_err = REQ_IRQ_ERR_SFTY;
> +			goto irq_error;
> +		}
> +	}

<Suraj> We can not use "dev->name" as this is name already used by "stmmac_interrupt" @ https://elixir.bootlin.com/linux/v6.1.68/source/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c#L3655.
<
ret = request_irq(dev->irq, stmmac_interrupt,
			  IRQF_SHARED, dev->name, dev);
>
if we are using same "dev->name" while requesting safety IRQ as well then  "/proc/interrupt" will show same name eth0/eth1 for  both "stmmac_interrupt" & "safety interrupt" and by looking at "/proc/interrupt" output we can not say which IRQ is for safety and which is for stmmac_interrupt.
> 
> I guess at some point afterwards we'll need to refactor the IRQs
> request part of this driver: replace stmmac_request_irq_single() body
> with the upper part of the stmmac_request_irq_multi_msi() method and
> then just make the former method being called from the later one...
> 
>>  	return 0;
>>  
>>  irq_error:
>> @@ -7462,8 +7481,10 @@ int stmmac_dvr_probe(struct device *device,
>>  	priv->dev->irq = res->irq;
>>  	priv->wol_irq = res->wol_irq;
>>  	priv->lpi_irq = res->lpi_irq;
>> +	priv->sfty_irq = res->sfty_irq;
>>  	priv->sfty_ce_irq = res->sfty_ce_irq;
>>  	priv->sfty_ue_irq = res->sfty_ue_irq;
> 
>> +
> 
> Please drop this change. The code below is attached to the code above
> because it basically does the same but in the loop. 
<Suraj> below loop code "for (i = 0; i < MTL_MAX_RX_QUEUES; i++) priv->rx_irq[i] = res->rx_irq[i];" is not for rx_irq array and will not help for safety irq.
Let me know if I got your commnet properly .
> 
>>  	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
>>  		priv->rx_irq[i] = res->rx_irq[i];
>>  	for (i = 0; i < MTL_MAX_TX_QUEUES; i++)
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> index 1ffde555da47..3808a3225a7d 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> @@ -726,6 +726,15 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>>  		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
>>  	}
>>  
>> +	stmmac_res->sfty_irq =
>> +		platform_get_irq_byname_optional(pdev, "sfty");
> 
>> +
> 
> Please drop this change too. It's normal to have a method call
> attached to the error check statement especially seeing the rest of
> the similar code snippets are designed that way in this function.
<Suraj> Do you means to remove all below code where we are printing the dev_info() message ?
We added this code similar to LPM code.
> 
> -Serge(y)
> 
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

