Return-Path: <linux-kernel+bounces-11980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9138A81EE74
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCF82838E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF33B44381;
	Wed, 27 Dec 2023 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QO1owHxY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897644384;
	Wed, 27 Dec 2023 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BR8np4i022496;
	Wed, 27 Dec 2023 11:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Sx/RP1cmWSeRYwa4izPyv4Rup56F0QnSm3/JYAykqR8=; b=QO
	1owHxYRVIea3g2Z60at+8eLt5pHIJvm3MVllTprnzdbRQ+KO/nAEezR5m5VVYC2A
	vvXrA2k+o4avzsC8fp+j8ooreKFv7NYf+aI0+DKJ589pgeWqtTHMkw/Vf1VyyvfR
	rL7TIy7FPBf06YiUfIjjqfajIL5shGheT2ny3WIiDk6OqkkPRgh4IUAdSaXmaKbD
	KsVoq5xDoPbjEoaqBQcXtuPTmPYxWr4o3hUBrbp5CUXULA8bgkVgIf8lsmMR/iVb
	bS7GHWpHBSr0zovIUGWY2k3dvHEWTxxvrtxILFL99S71jiBEwK7/dslITYjwvzyN
	us1VsAbwHE2hhuwesPCg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v8atfrx3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 11:03:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BRB3lwn027868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 11:03:47 GMT
Received: from [10.217.90.28] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Dec
 2023 03:03:36 -0800
Message-ID: <bb77706b-0685-4992-b49e-49bef0d11800@quicinc.com>
Date: Wed, 27 Dec 2023 16:33:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 3/3] net: stmmac: Add driver support for
 DWMAC5 common safety IRQ
Content-Language: en-US
From: Suraj Jaiswal <quic_jsuraj@quicinc.com>
To: Serge Semin <fancer.lancer@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma
	<bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
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
References: <20231221073620.232619-1-quic_jsuraj@quicinc.com>
 <20231221073620.232619-4-quic_jsuraj@quicinc.com>
 <yromhtr73rwsr6hizr4tq37vfvyzfue7wzpmufqyscwspzffza@uhfcrn573acd>
 <aec2dc6a-ffa4-4753-a764-77dfe1af995a@quicinc.com>
 <xdcrwxh7e4t2zkgdcfwzjr2z4ouwgv3vr4drwvshadxmpwyqkd@j3kj3p2u7nd7>
 <2685432c-a086-4730-9dd6-8b8da1070697@quicinc.com>
In-Reply-To: <2685432c-a086-4730-9dd6-8b8da1070697@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0Gdyo3GlpIZodpdfDgMEKcrPcFKb30e_
X-Proofpoint-GUID: 0Gdyo3GlpIZodpdfDgMEKcrPcFKb30e_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312270081

Hi Seren,
please find the updated comment .

Thanks
Suraj

On 12/26/2023 4:40 PM, Suraj Jaiswal wrote:
> Hi seren
> let me check below on test setup once & get back
> 
> Thanks
> Suraj
> 
> On 12/22/2023 8:05 PM, Serge Semin wrote:
>> On Fri, Dec 22, 2023 at 02:13:49PM +0530, Suraj Jaiswal wrote:
>>> HI Serge,
>>> please find commnet inline.
>>>
>>> Thanks
>>> Suraj
>>>
>>> On 12/21/2023 6:19 PM, Serge Semin wrote:
>>>> Hi Suraj
>>>>
>>>> On Thu, Dec 21, 2023 at 01:06:20PM +0530, Suraj Jaiswal wrote:
>>>>> Add support to listen HW safety IRQ like ECC(error
>>>>> correction code), DPP(data path parity), FSM(finite state
>>>>> machine) fault in common IRQ line.
>>>>>
>>>>> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
>>>>
>>>> Thanks for taking my notes into account. One more comment is further
>>>> below.
>>>>
>>>>> ---
>>>>>  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>>>>>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 ++
>>>>>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37 +++++++++++++++++++
>>>>>  .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 ++++
>>>>>  4 files changed, 49 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
>>>>> index 721c1f8e892f..b9233b09b80f 100644
>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
>>>>> @@ -344,6 +344,7 @@ enum request_irq_err {
>>>>>  	REQ_IRQ_ERR_ALL,
>>>>>  	REQ_IRQ_ERR_TX,
>>>>>  	REQ_IRQ_ERR_RX,
>>>>> +	REQ_IRQ_ERR_SFTY,
>>>>>  	REQ_IRQ_ERR_SFTY_UE,
>>>>>  	REQ_IRQ_ERR_SFTY_CE,
>>>>>  	REQ_IRQ_ERR_LPI,
>>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>>>>> index 9f89acf31050..ca3d93851bed 100644
>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>>>>> @@ -31,6 +31,7 @@ struct stmmac_resources {
>>>>>  	int wol_irq;
>>>>>  	int lpi_irq;
>>>>>  	int irq;
>>>>> +	int sfty_irq;
>>>>>  	int sfty_ce_irq;
>>>>>  	int sfty_ue_irq;
>>>>>  	int rx_irq[MTL_MAX_RX_QUEUES];
>>>>> @@ -297,6 +298,7 @@ struct stmmac_priv {
>>>>>  	void __iomem *ptpaddr;
>>>>>  	void __iomem *estaddr;
>>>>>  	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
>>>>> +	int sfty_irq;
>>>>>  	int sfty_ce_irq;
>>>>>  	int sfty_ue_irq;
>>>>>  	int rx_irq[MTL_MAX_RX_QUEUES];
>>>>> @@ -305,6 +307,7 @@ struct stmmac_priv {
>>>>>  	char int_name_mac[IFNAMSIZ + 9];
>>>>>  	char int_name_wol[IFNAMSIZ + 9];
>>>>>  	char int_name_lpi[IFNAMSIZ + 9];
>>>>> +	char int_name_sfty[IFNAMSIZ + 10];
>>>>>  	char int_name_sfty_ce[IFNAMSIZ + 10];
>>>>>  	char int_name_sfty_ue[IFNAMSIZ + 10];
>>>>>  	char int_name_rx_irq[MTL_MAX_TX_QUEUES][IFNAMSIZ + 14];
>>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>>> index 47de466e432c..7d4e827dfeab 100644
>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>>> @@ -3592,6 +3592,10 @@ static void stmmac_free_irq(struct net_device *dev,
>>>>>  		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
>>>>>  			free_irq(priv->wol_irq, dev);
>>>>>  		fallthrough;
>>>>> +	case REQ_IRQ_ERR_SFTY:
>>>>> +		if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq)
>>>>> +			free_irq(priv->sfty_irq, dev);
>>>>> +		fallthrough;
>>>>>  	case REQ_IRQ_ERR_WOL:
>>>>>  		free_irq(dev->irq, dev);
>>>>>  		fallthrough;
>>>>> @@ -3661,6 +3665,23 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>>>>>  		}
>>>>>  	}
>>>>>  
>>>>> +	/* Request the common Safety Feature Correctible/Uncorrectible
>>>>> +	 * Error line in case of another line is used
>>>>> +	 */
>>>>> +	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
>>>>> +		int_name = priv->int_name_sfty;
>>>>> +		sprintf(int_name, "%s:%s", dev->name, "safety");
>>>>> +		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
>>>>> +				  0, int_name, dev);
>>>>> +		if (unlikely(ret < 0)) {
>>>>> +			netdev_err(priv->dev,
>>>>> +				   "%s: alloc sfty MSI %d (error: %d)\n",
>>>>> +				   __func__, priv->sfty_irq, ret);
>>>>> +			irq_err = REQ_IRQ_ERR_SFTY;
>>>>> +			goto irq_error;
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>>  	/* Request the Safety Feature Correctible Error line in
>>>>>  	 * case of another line is used
>>>>>  	 */
>>>>> @@ -3798,6 +3819,21 @@ static int stmmac_request_irq_single(struct net_device *dev)
>>>>>  		}
>>>>>  	}
>>>>>  
>>>>> +	/* Request the common Safety Feature Correctible/Uncorrectible
>>>>> +	 * Error line in case of another line is used
>>>>> +	 */
>>>>> +	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
>>>>
>>>>> +		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
>>>>> +				  IRQF_SHARED, dev->name, dev);
>>>>
>>>> Just noticed yesterday that stmmac_safety_interrupt() is also called
>>>> from the stmmac_interrupt() handler which is supposed to be registered
>>>> on the generic "mac" IRQ. Won't it cause races around the CSRs
>>>> (doubtfully but still worth to note) and the errors handling
>>>> (stmmac_global_err()) in case if both IRQs are raised simultaneously?
>>>> At the very least it looks suspicious and worth double-checking.
>>>>
>>>> I also found out that nobody seemed to care that the same handler is
>>>> registered on MAC, WoL and LPI IRQ lines. Hmm, no race-related
>>>> problems have been reported so far for the platforms with separate
>>>> WoL/LPI IRQs. It's either a lucky coincident or the IRQs are always
>>>> assigned to the same CPU or the IRQs handle is indeed free of races.
>>>> In anyway it looks suspicious too. At the very least AFAICS the DMA
>>>> IRQ-handler is indeed racy on the status CSR access. It isn't
>>>> cleared-on-read, but write-one-to-clear. So the statistics might be
>>>> calculated more than once for the same CSR state. There might be some
>>>> other problems I failed to spot on the first glance.
>>>>
>>>> David, Eric, Jacub, Paolo, your opinion about the note above?
>>>>
>>>> -Serge(y)
>>>>
>>
>>> <Suraj> We are adding common IRQ similar to already present code for correcteable/uncorrecable https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c#L3592.
>>
>> From that perspective your change in stmmac_request_irq_multi_msi() is
>> correct, but stmmac_request_irq_single() is another story. The first
>> one method implies assigning the individual IRQ handlers to all
>> available lines. The later method assigns the _common_ handler to all
>> the lines. The common handler already calls the Safety IRQ handler -
>> stmmac_safety_feat_interrupt(). So should the safety IRQ line is
>> separately available it's possible to have the Safety IRQ handlers
>> executed concurrently - in framework of the common IRQ events handling
>> (if safety IRQ is raised during the common IRQ being handled) and
>> individual Safety IRQ. It's prune to the race condition I pointed out
>> to in my message above. Did you consider that problem?
>>
>>> Also, we need the sfty IRQ handling as soon as the fault occured & that can only be handled if we have handler attached with sfty IRQ.
>>> stmmac_interrupt() will only be triggerd when interrupt triggered for rx/tx packet .
>>> while registerting with sfty IRQ will get triggered as soon as emac HW detect the fault. 
>>
>> Please read my comment more carefully. The safety IRQ can be raised
>> during the common IRQ handling, thus the
>> stmmac_safety_feat_interrupt() method might get to be concurrently
>> executed.
>>
>> -Serge(y)
>>
<Suraj> Have testing this on device . We have added print in the both the places stmmac_interrupt() as well as sfty interrupt handler.
We can see that sfty interrupt handler is getting triggred first & stmmac_safety_feat_interrupt () code added in stmmac_intterupt() is not getting triggred because looks like interrupt status bit register is already getting cleared as part of sfty interrupt handler. So it looks good . Please let us know if any further comment. 

Please find the log below .


/ # [ 1505.602173] sj: stmmac_safety_interrupt from sfty IRQ handler
[ 1505.607274] qcom-ethqos 23040000.ethernet eth1: Found correctable error in MTL: 'RXCES: MTL RX Memory Error'
[ 1505.617395] sj: stmmac_safety_interrupt from sfty IRQ handler
[ 1505.622494] qcom-ethqos 23040000.ethernet eth1: Found correctable error in MTL: 'TXCES: MTL TX Memory Error'
[ 1505.888913] sj: stmmac_safety_interrupt from sfty IRQ handler
[ 1505.894010] qcom-ethqos 23040000.ethernet eth1: Found correctable error in MTL: 'RXCES: MTL RX Memory Error'
[ 1506.605821] sj: stmmac_safety_interrupt from sfty IRQ handler
[ 1506.610919] qcom-ethqos 23040000.ethernet eth1: Found correctable error in MTL: 'RXCES: MTL RX Memory Error'
[ 1506.621034] sj: stmmac_safety_interrupt from sfty IRQ handler
[ 1506.626131] qcom-ethqos 23040000.ethernet eth1: Found correctable error in MTL: 'TXCES: MTL TX Memory Error'
[ 1507.613036] sj: stmmac_safety_interrupt from sfty IRQ handler
[ 1507.618133] qcom-ethqos 23040000.ethernet eth1: Found correctable error in MTL: 'RXCES: MTL RX Memory Error'
[ 1507.628249] sj: stmmac_safety_interrupt from sfty IRQ handler
[ 1507.633346] qcom-ethqos 23040000.ethernet eth1: Found correctable error in MTL: 'TXCES: MTL TX Memory Error'
[ 1508.619034] sj: stmmac_safety_interrupt from sfty IRQ handler
[ 1508.624132] qcom-ethqos 23040000.ethernet eth1: Found correctable error in MTL: 'RXCES: MTL RX Memory Error'
[ 1508.634245] sj: stmmac_safety_interrupt from sfty IRQ handler
[ 1508.639343] qcom-ethqos 23040000.ethernet eth1: Found correctable error in MTL: 'TXCES: MTL TX Memory Error'
[ 1509.631151] sj: stmmac_safety_interrupt from sfty IRQ handler
[ 1509.636249] qcom-ethqos 23040000.ethernet eth1: Found correctable error in MTL: 'RXCES: MTL RX Memory Error'

>>>    
>>>>> +		if (unlikely(ret < 0)) {
>>>>> +			netdev_err(priv->dev,
>>>>> +				   "%s: ERROR: allocating the sfty IRQ %d (%d)\n",
>>>>> +				   __func__, priv->sfty_irq, ret);
>>>>> +			irq_err = REQ_IRQ_ERR_SFTY;
>>>>> +			goto irq_error;
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>>  	return 0;
>>>>>  
>>>>>  irq_error:
>>>>> @@ -7462,6 +7498,7 @@ int stmmac_dvr_probe(struct device *device,
>>>>>  	priv->dev->irq = res->irq;
>>>>>  	priv->wol_irq = res->wol_irq;
>>>>>  	priv->lpi_irq = res->lpi_irq;
>>>>> +	priv->sfty_irq = res->sfty_irq;
>>>>>  	priv->sfty_ce_irq = res->sfty_ce_irq;
>>>>>  	priv->sfty_ue_irq = res->sfty_ue_irq;
>>>>>  	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
>>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>>>>> index 70eadc83ca68..ab250161fd79 100644
>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>>>>> @@ -743,6 +743,14 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>>>>>  		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
>>>>>  	}
>>>>>  
>>>>> +	stmmac_res->sfty_irq =
>>>>> +		platform_get_irq_byname_optional(pdev, "sfty");
>>>>> +	if (stmmac_res->sfty_irq < 0) {
>>>>> +		if (stmmac_res->sfty_irq == -EPROBE_DEFER)
>>>>> +			return -EPROBE_DEFER;
>>>>> +		dev_info(&pdev->dev, "IRQ safety IRQ not found\n");
>>>>> +	}
>>>>> +
>>>>>  	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
>>>>>  
>>>>>  	return PTR_ERR_OR_ZERO(stmmac_res->addr);
>>>>> -- 
>>>>> 2.25.1
>>>>>
>>>>>
> 

