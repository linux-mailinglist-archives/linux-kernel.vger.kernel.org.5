Return-Path: <linux-kernel+bounces-66297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D082E8559E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FBB290E55
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0428F54;
	Thu, 15 Feb 2024 04:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I6L9U/aW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78B1C0F;
	Thu, 15 Feb 2024 04:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707972506; cv=none; b=JLMcdGqryIG5n0/cIMhBjFlFaSHMAJDqm7WPVXqJPCSYmWtfg5bPAq0FEHp4lLX95y5OfISY5ihQ2RD18eJJBK08/OSYvFCRTAcg2HBS1x7b7kNn1odkUg1Jmo3WEak6OsULAAi9diBZRVYzLVK4pnOycIQwQVVVJM38OKovm74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707972506; c=relaxed/simple;
	bh=5o/3QD9IVMwO2DGQRthGEJt8ZrCdo7xAiiwUB1JC6oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I4iTV0VVuHh8eyAAZ4QKHc3OZPWL7nMGtURWOmEdU3q2WxW73uZDuhrHnZWk7OVESSlfP7qHnih2CyFPCso6INznQJVnqRWvHnQq0OnEw+vhSezLvikTdxrYs5/m+hqszr+i84IutYvjdq+wLGfdTM4F8pRmNCyIPHoCyHhFY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I6L9U/aW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41F4MMq5010025;
	Thu, 15 Feb 2024 04:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=57EHGLJUekwB27YpA6QFEIQ+R7ja+si5OreIJSovoWE=; b=I6
	L9U/aWMxUFIONiViC/rPMptUXOIMM1RhOQJyZW2FDRKY6inCPze0mh3VDlNmPdVd
	6nwnhL6I3Rn0R76S8bkxwaHfe0owUcrwF25poFgD6o/InKuSy/TbEWOnLRV21icO
	sPdJs2+BmNNHLivcFR+nP2oKxCMCrzv8nmgNQUyArobj1eNo8Q0DWk7Vr/J/DJi6
	cq764ZBP4dRnVd9+fxW+mD6hvLXamQ9h+q3d+wSjDoTbsKTzTPxTVKVuFsAmA693
	WN3AnmKitgWwQ6Zj3IY4+Jf/XxqbsnCGuLlR7Q0SR2bUpWWUDvpMVzKiiKByhdof
	it/93PSOMC25fRxzmB1g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9bfs01h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 04:47:53 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41F4lqGO019041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 04:47:52 GMT
Received: from [10.216.17.27] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 14 Feb
 2024 20:47:44 -0800
Message-ID: <7a567b50-66f1-4737-ae6c-0dabd1d39bcf@quicinc.com>
Date: Thu, 15 Feb 2024 10:17:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: stmmac: dwmac-qcom-ethqos: Add support
 for 2.5G SGMII
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu
	<joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>
References: <20240208111714.11456-1-quic_snehshah@quicinc.com>
 <20240212173015.0341f0ee@kernel.org>
From: Sneh Shah <quic_snehshah@quicinc.com>
In-Reply-To: <20240212173015.0341f0ee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3RXFTHEoRYOKGGlv-yqGshlNz6ajAfjq
X-Proofpoint-GUID: 3RXFTHEoRYOKGGlv-yqGshlNz6ajAfjq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_04,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150033



On 2/13/2024 7:00 AM, Jakub Kicinski wrote:
> On Thu,  8 Feb 2024 16:47:14 +0530 Sneh Shah wrote:
>> Serdes phy needs to operate at 2500 mode for 2.5G speed and 1000
>> mode for 1G/100M/10M speed.
>> Added changes to configure serdes phy and mac based on link speed.
>> Changing serdes phy speed involves multiple register writes for
>> serdes block. To avoid redundant write operations only update serdes
>> phy when new speed is different.
> 
> Sounds like 2 separate changes in one patch, please split the
> optimization of not writing the registers multiple times and
> the 2.5G support.
> 

Optimization is part of 2.5G support change only. with introduction of
2.5G speed support we need to update reconfigure serdes phy. there are
2 different serdes configs.
1. config for 2.5G
2. common config 1G/100M/10M

The change here is not to reconfigure serdes phy among
1G/100M/10M speeds and only reconfigure if it switches to 2.5G.

>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>> index 31631e3f89d0..6bbdbb7bef44 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>> @@ -106,6 +106,7 @@ struct qcom_ethqos {
>>  	struct clk *link_clk;
>>  	struct phy *serdes_phy;
>>  	unsigned int speed;
>> +	int serdes_speed;
> 
> Why signed if speed itself is unsigned?

In stmmac speed can be assigned as SPEED_UNKNOWN which will be -1.
I will fix speed being unsigned int in a separate patch.

> 
>>  	/* Enable and restart the Auto-Negotiation */
>>  	if (ane)
>>  		value |= GMAC_AN_CTRL_ANE | GMAC_AN_CTRL_RAN;
>> +	else
>> +		value &= ~GMAC_AN_CTRL_ANE;
> 
> That looks unrelated. Either a separate patch or please explain in the
> commit msg why.

For 2.5G speed support MAC PCS autoneg needs to be disabled.
This adds the change to disable PCS autoneg. I will update commit
message to add more dtails

