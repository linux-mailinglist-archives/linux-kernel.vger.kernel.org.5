Return-Path: <linux-kernel+bounces-57305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD09384D6CE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5341C22B31
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D20535CF;
	Wed,  7 Feb 2024 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YOWaCVfl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD36220335;
	Wed,  7 Feb 2024 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707350116; cv=none; b=BfJB3Y9zajfFMcv43tdiSq1bm2MtcZ9andgB+hjd2q450pQBBcl4xRqSyayoKF8UaA4xxWMvMVDTS3LnZu7uo1n0og2V1DrHG4zKOw1vJui27yeBi9HHvWLHxZPsk5nWirgRAxhLGWgv1DgMl5FXQBAyCDTAZzpj4FRE4gvxdOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707350116; c=relaxed/simple;
	bh=VDfAjHW8McZv39SIa3owamfR7WXBRmrXLZFuoUTHIio=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iwtR1SIg4dAPFufPwPaBK/XdSrbk+cLIuzUbpMMH4RE/iDaSO8uAKkvUBAvKNqXO+EkJHMu2zzyOKtU8btripm/+reQFK2hqhdK/VzbUHIljNLa8nR9hgrvPNQvTLCHrtUSlfcgJ2Ea4F2QUkY2qFjBtOFzB5jiJXpnnr2zKzDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YOWaCVfl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417Ms4e4021166;
	Wed, 7 Feb 2024 23:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jASkXHgSccq7FXFfSwb1V8nIGVqTlFnM5UN8uHvrymw=; b=YO
	WaCVflOxTvqjvWq14NV9UNrgD4PBnIlZyc6fmsYMHDVS/U6ILkMefRgcRoCvfRIB
	u7v6+uUk18xgm5saMtotBIxzD6OpHkfDPzbALzQqSyKcxibYCxl0AoTh5dkn+shO
	eXgKFYS/FSpFl7K8fcLcpsSdCFXyqAUndCJhcH5SOu0BM/KKQ0HqwQQG+2qvNLJU
	9mrrwAK48MWUJBlDqg2DKY5rANFv7ZOdH9dG/3dVOUzwuuB7Xb7SvWdNqz3fz91h
	xCbTc8AsiEEfeEDFLIZNP8vZQUXOdmnzZYoU/SYS7u3XUqx8bQkm0R45UmBxd9Ci
	1R9mWbAtjmkktggju4dg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3x41tru5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 23:54:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 417NsuJJ007717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 23:54:56 GMT
Received: from [10.110.62.200] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 15:54:52 -0800
Message-ID: <182afe94-e6db-4329-8653-93f6315dea54@quicinc.com>
Date: Wed, 7 Feb 2024 15:54:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: stmmac: dwmac-qcom-ethqos: Enable TBS on
 all queues but 0
Content-Language: en-US
To: Abhishek Chauhan <quic_abchauha@quicinc.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>
CC: <kernel@quicinc.com>
References: <20240207224001.2109224-1-quic_abchauha@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240207224001.2109224-1-quic_abchauha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ygOZdbS30vKfvIBTNfdCtE1xVWs4KkyC
X-Proofpoint-GUID: ygOZdbS30vKfvIBTNfdCtE1xVWs4KkyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_09,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=976 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402070174

On 2/7/2024 2:40 PM, Abhishek Chauhan wrote:
> TSO and TBS cannot co-exist. TBS requires special descriptor to be
> allocated at bootup. Initialising Tx queues at probe to support
> TSO and TBS can help in allocating those resources at bootup.
> 
> TX queues with TBS can support etf qdisc hw offload.
> 
> This is similar to the patch raised by NXP
> commit 3b12ec8f618e ("net: stmmac: dwmac-imx: set TSO/TBS TX queues default 
> settings")
> 
> Changes since v2:
> - Fixed the styling of comment in the dwmac-qcom-ethqos.c
> - Followed the upstream format to give other glue
>   driver references to solve the same problem
> - Appended  the subject with net-next
> - Discussion of why this patch is required is discussed in
> https://lore.kernel.org/netdev/c2497eef-1041-4cd0-8220-42622c8902f4@quicinc.com/
> 
> Changes since v1:
> - Subject is changed as per upstream guidelines
> - Added a reference of a similar change done by NXP in
>   body of the commit message

Note that your patch change history should not be part of your commit
text, but instead should be below the "---" line.
> 
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---

in other words put it here. the change history will not be part of the
git history

I strongly suggest looking at b4 since it will manage your patch history:
https://b4.docs.kernel.org/en/latest/index.html#for-developers

>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 31631e3f89d0..2691a250a5a7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -728,7 +728,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  	struct stmmac_resources stmmac_res;
>  	struct device *dev = &pdev->dev;
>  	struct qcom_ethqos *ethqos;
> -	int ret;
> +	int ret, i;
>  
>  	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
>  	if (ret)
> @@ -822,6 +822,10 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  		plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
>  	}
>  
> +	/* Enable TSO on queue0 and enable TBS on rest of the queues */
> +	for (i = 1; i < plat_dat->tx_queues_to_use; i++)
> +		plat_dat->tx_queues_cfg[i].tbs_en = 1;
> +
>  	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
>  }
>  


