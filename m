Return-Path: <linux-kernel+bounces-8022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C3081B0BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D41C284850
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40022031F;
	Thu, 21 Dec 2023 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ht3Y1/n3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CAD1A715;
	Thu, 21 Dec 2023 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL63Ncl000354;
	Thu, 21 Dec 2023 08:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Ah///7Ew/pVHtSqFFyxdVQ5+uk4DukkXZr7lLzP9CTw=; b=Ht
	3Y1/n3MRlbCV8W/qIcHpxgoHom9WZ3mFHN/x0Gc+t+EkiWHlh4TxzFpocK2C2IBQ
	dsuqFhIS9R/By6fxfRXP5WpnMYKRNNkaUYdPpV2UYphCloydlzzkC7OmArero18q
	2+Cj6rZG5xi4ZSZlm5AfYiXGgCbSxRrWAqYJQ4SnAWrqWOXhjSKzwIC9rHtZs6oa
	9tw8POnfTKr/SifWgONj9MuqvUf1Z6BZ5btUwFulbW21JmWKFQQAUiaBudFphPfs
	NVoSnBPUvjhPsMXpKJM5H5IfB7KrzksBJThacMMIclnnaFlqLHpJRKJmEhYusdGc
	C49AF6PD+y8AizEh3BcQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4837hxdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 08:54:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BL8s80K005148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 08:54:08 GMT
Received: from [10.218.17.183] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 00:54:00 -0800
Message-ID: <8f94489d-5f0e-4166-a14e-4959098a5c80@quicinc.com>
Date: Thu, 21 Dec 2023 14:23:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: dwmac-qcom-ethqos: Add support for
 2.5G SGMII
Content-Language: en-US
To: Andrew Halaney <ahalaney@redhat.com>
CC: Vinod Koul <vkoul@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu
	<joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20231218071118.21879-1-quic_snehshah@quicinc.com>
 <4zbf5fmijxnajk7kygcjrcusf6tdnuzsqqboh23nr6f3rb3c4g@qkfofhq7jmv6>
 <8b80ab09-8444-4c3d-83b0-c7dbf5e58658@quicinc.com>
 <wvzhz4fmtheculsiag4t2pn2kaggyle2mzhvawbs4m5isvqjto@lmaonvq3c3e7>
From: Sneh Shah <quic_snehshah@quicinc.com>
In-Reply-To: <wvzhz4fmtheculsiag4t2pn2kaggyle2mzhvawbs4m5isvqjto@lmaonvq3c3e7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t5O3yU5HJCjlLeZ_rtOcJrwHtYJOLrkg
X-Proofpoint-ORIG-GUID: t5O3yU5HJCjlLeZ_rtOcJrwHtYJOLrkg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312210065



On 12/20/2023 9:29 PM, Andrew Halaney wrote:
> On Wed, Dec 20, 2023 at 01:02:45PM +0530, Sneh Shah wrote:
>>
>>
>> On 12/18/2023 9:50 PM, Andrew Halaney wrote:
>>> On Mon, Dec 18, 2023 at 12:41:18PM +0530, Sneh Shah wrote:
>>>> Serdes phy needs to operate at 2500 mode for 2.5G speed and 1000
>>>> mode for 1G/100M/10M speed.
>>>> Added changes to configure serdes phy and mac based on link speed.
>>>>
>>>> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
>>>> ---
>>>>  .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 31 +++++++++++++++++--
>>>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>>>> index d3bf42d0fceb..b3a28dc19161 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>>>> @@ -21,6 +21,7 @@
>>>>  #define RGMII_IO_MACRO_CONFIG2		0x1C
>>>>  #define RGMII_IO_MACRO_DEBUG1		0x20
>>>>  #define EMAC_SYSTEM_LOW_POWER_DEBUG	0x28
>>>> +#define ETHQOS_MAC_AN_CTRL		0xE0
>>>>  
>>>>  /* RGMII_IO_MACRO_CONFIG fields */
>>>>  #define RGMII_CONFIG_FUNC_CLK_EN		BIT(30)
>>>> @@ -78,6 +79,10 @@
>>>>  #define ETHQOS_MAC_CTRL_SPEED_MODE		BIT(14)
>>>>  #define ETHQOS_MAC_CTRL_PORT_SEL		BIT(15)
>>>>  
>>>> +/*ETHQOS_MAC_AN_CTRL bits */
>>>> +#define ETHQOS_MAC_AN_CTRL_RAN			BIT(9)
>>>> +#define ETHQOS_MAC_AN_CTRL_ANE			BIT(12)
>>>> +
>>>
>>> nit: space please add a space before ETHQOS_MAC_AN_CTRL
>>>
>> will take care of this in next patch
>>
>>>>  struct ethqos_emac_por {
>>>>  	unsigned int offset;
>>>>  	unsigned int value;
>>>> @@ -109,6 +114,7 @@ struct qcom_ethqos {
>>>>  	unsigned int num_por;
>>>>  	bool rgmii_config_loopback_en;
>>>>  	bool has_emac_ge_3;
>>>> +	unsigned int serdes_speed;
> 
> Another nit as I look closer: I think this should be grouped by phy_mode
> etc just for readability.
Didn't get this. can you please elaborate more?
> 
>>>>  };
>>>>  
>>>>  static int rgmii_readl(struct qcom_ethqos *ethqos, unsigned int offset)
>>>> @@ -600,27 +606,47 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos)
>>>>  
>>>>  static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
>>>>  {
>>>> -	int val;
>>>> -
>>>> +	int val, mac_an_value;
>>>>  	val = readl(ethqos->mac_base + MAC_CTRL_REG);
>>>> +	mac_an_value = readl(ethqos->mac_base + ETHQOS_MAC_AN_CTRL);
>>>>  
>>>>  	switch (ethqos->speed) {
>>>> +	case SPEED_2500:
>>>> +		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
>>>> +		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
>>>> +			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
>>>> +			      RGMII_IO_MACRO_CONFIG2);
>>>> +		if (ethqos->serdes_speed != SPEED_2500)
>>>> +			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
>>>> +		mac_an_value &= ~ETHQOS_MAC_AN_CTRL_ANE;
>>>> +		break;
>>>>  	case SPEED_1000:
>>>>  		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
>>>>  		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
>>>>  			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
>>>>  			      RGMII_IO_MACRO_CONFIG2);
>>>> +		if (ethqos->serdes_speed != SPEED_1000)
>>>> +			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
>>>> +		mac_an_value |= ETHQOS_MAC_AN_CTRL_RAN | ETHQOS_MAC_AN_CTRL_ANE;
>>>>  		break;
>>>>  	case SPEED_100:
>>>>  		val |= ETHQOS_MAC_CTRL_PORT_SEL | ETHQOS_MAC_CTRL_SPEED_MODE;
>>>> +		if (ethqos->serdes_speed != SPEED_1000)
>>>> +			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
>>>> +		mac_an_value |= ETHQOS_MAC_AN_CTRL_RAN | ETHQOS_MAC_AN_CTRL_ANE;
>>>>  		break;
>>>>  	case SPEED_10:
>>>>  		val |= ETHQOS_MAC_CTRL_PORT_SEL;
>>>>  		val &= ~ETHQOS_MAC_CTRL_SPEED_MODE;
>>>> +		if (ethqos->serdes_speed != SPEED_1000)
>>>> +			phy_set_speed(ethqos->serdes_phy, ethqos->speed);
>>>> +		mac_an_value |= ETHQOS_MAC_AN_CTRL_RAN | ETHQOS_MAC_AN_CTRL_ANE;
>>>>  		break;
>>>>  	}
>>>>  
>>>>  	writel(val, ethqos->mac_base + MAC_CTRL_REG);
>>>> +	writel(mac_an_value, ethqos->mac_base + ETHQOS_MAC_AN_CTRL);
>>>> +	ethqos->serdes_speed = ethqos->speed;
>>>
>>> I see these bits are generic and there's some functions in stmmac_pcs.h
>>> that muck with these...
>>>
>>> Could you help me understand if this really should be Qualcomm specific,
>>> or if this is something that should be considered for the more core bits
>>> of the driver? I feel in either case we should take advantage of the
>>> common definitions in that file if possible.
>>>
>> we do have function dwmac_ctrl_ane in core driver which updates same registers. However, it does not have the option to reset ANE bit, it can only set bits. For SPEED_2500 we need to reset ANE bit. Hence I am adding it here. Not sure if we can extend dwmac_ctrl_ane function to reset bits as well.
> 
> I'd evaluate if you can update that function to clear the ANE bit when
> the ane boolean is false. From the usage I see I feel that makes sense,
> but correct me if you think I'm wrong.
> At the very least let's use the defines from there, and possibly add a
> new function if clearing is not acceptable in dwmac_ctrl_ane().
> 
> Stepping back, I was asking in general is the need to muck with ANE here
> is a Qualcomm specific problem, or is that a generic thing that should be
> handled in the core (and the phy_set_speed() bit stay here)? i.e. would
> any dwmac5 based IP need to do something like this for SPEED_2500?
I think disabling ANE for SPEED_2500 is generic not specific to qualcomm. Even in dwxgmac2 versions also we need to disable ANE for SPEED_2500. Autoneg clause 37 stadard doesn't support 2500 speed. So we need to disable autoneg for speed 2500

> 
>>>>  
>>>>  	return val;
>>>>  }
>>>> @@ -789,6 +815,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>>>>  				     "Failed to get serdes phy\n");
>>>>  
>>>>  	ethqos->speed = SPEED_1000;
>>>> +	ethqos->serdes_speed = SPEED_1000;
>>>>  	ethqos_update_link_clk(ethqos, SPEED_1000);
>>>>  	ethqos_set_func_clk_en(ethqos);
>>>>  
>>>> -- 
>>>> 2.17.1
>>>>
>>>
>>
> 

