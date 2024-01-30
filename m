Return-Path: <linux-kernel+bounces-44288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C4B841FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE35294FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1836087E;
	Tue, 30 Jan 2024 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IQPSBsEp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC85B5CE;
	Tue, 30 Jan 2024 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607875; cv=none; b=AntWh9pOKbIhFJ56rOCtA36Tjo4AqHeuJWXz2qG15t5a55U5RFFjU+UJgYuQJCATvucp7NyO+lArPm08Pv7Y/hVQnwbtrCW+lEopIfFI2f29CGO+3SxwvFXbAYV+YXEXioHJJ1fn5fiLKgonh27kJn//x3Me8wlTRliSh1pNeqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607875; c=relaxed/simple;
	bh=ouY7hgTD8wiqxL73yDTOMq7/ztje8llaH3bU7gcMP/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OkcuUIUpsnUvr6dgDJ7htcRcJwZhvnA4m0RayAZAxZBTqUYjJDNU1x2kjhqGD7xnA06SqRMKUCTj8jPScbJXjFgYU8Fkz/Tbi3UuYTsZat+VZUMUObh3pjHLZAULdYeCn+8mC2vUHXAtuAWGW6GaCIIKOuufmJHqp6sq5gEWQZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IQPSBsEp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U9UBBw017740;
	Tue, 30 Jan 2024 09:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=PV/qkhxMhSm6FkOTpTPSi435N2PjaZa4J3VVt4zIeqM=; b=IQ
	PSBsEpM3umWWUdcMALD8+ARSsy5sGpCEwV4K7NKtgxngtQgMTYam/l0XonfOMlmd
	UOyFrxjtGhWQStDMh9kJCUUyV+U++6KuP6Mt+4z3yu2Kzn9a8jLWpSaQ6gEWvPlP
	1O9TQ1cEqjQvpQ17dEJ5hyrUE3119tB2wk6is7fPphBiOgr33aDQaSZ7ECmPjPys
	06BkVyrZfoISN0MQsWJfqgq/dPdNmab/v+V1YXDwQ5MXjO3nUL9R+QnDqcS71rYD
	g3xKo7y16raWkH398NtV8z6ZfKvgkNggZxokvPBjx2aYSBSVFI2uvQGXYolIESD2
	QiQnYoZCF1pcNWN0J8xQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxvve07y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 09:44:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U9iFY7014745
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 09:44:15 GMT
Received: from [10.50.3.106] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 01:44:05 -0800
Message-ID: <d5377d84-7c75-4f4a-9e93-a825a6ea859c@quicinc.com>
Date: Tue, 30 Jan 2024 15:14:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: dwmac-qcom-ethqos: Add support for
 pm ops
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
References: <20240127130327.22443-1-quic_snehshah@quicinc.com>
 <jnwylhbparw4uwci3epbd7th4izt3rnd3uzrnm5mdunm55kdoh@yyp4dprfh3sl>
From: Sneh Shah <quic_snehshah@quicinc.com>
In-Reply-To: <jnwylhbparw4uwci3epbd7th4izt3rnd3uzrnm5mdunm55kdoh@yyp4dprfh3sl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DOvChhsk8qofe4Y8xVaT37HyWdBglQsm
X-Proofpoint-ORIG-GUID: DOvChhsk8qofe4Y8xVaT37HyWdBglQsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_04,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300070



On 1/30/2024 1:12 AM, Andrew Halaney wrote:
> On Sat, Jan 27, 2024 at 06:33:27PM +0530, Sneh Shah wrote:
>> Add qcom ethqos specific runtime and system sleep pm ops.
>> As part of system sleep qcom ethqos needs to disable all clocks.
>> This ops will be extended further with qcom specific features.
> 
> This last sentence sounds like this series is incomplete, I'd avoid such
> wording if its untrue. Upstream typically won't accept things that are
> building infrastructure for patches that will "eventually be posted".
> 
> You state in your commit what the code does (really it replaces the
> stmmac_pltfrm_ops with its own), but only gloss over the why. I'd lead
> with the "why". i.e. I'd say something like
> "net: stmmac: dwmac-qcom-ethqos: Turn clocks off/on during suspend/resume"
> 
> Since there's already a handler installed for PM ops, I'd explain why
> you need to change to new ones as well.
> 
>>
>> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
>> ---
>>  .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 51 ++++++++++++++++++-
>>  1 file changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>> index 31631e3f89d0..cba601ee9e01 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
>> @@ -720,6 +720,55 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
>>  	netdev_dbg(priv->dev, "PTP rate %d\n", plat_dat->clk_ptp_rate);
>>  }
>>  
>> +static int qcom_ethqos_runtime_suspend(struct device *dev)
>> +{
>> +	struct net_device *ndev = dev_get_drvdata(dev);
>> +	struct stmmac_priv *priv = netdev_priv(ndev);
>> +
>> +	return stmmac_bus_clks_config(priv, false);
>> +}
>> +
> 
> This perfectly matches the stmmac_runtime_suspend() function installed
> originally. I don't see why you couldn't at a minimum reuse
> that function instead of writing your own.
> 
>> +static int qcom_ethqos_runtime_resume(struct device *dev)
>> +{
>> +	struct net_device *ndev = dev_get_drvdata(dev);
>> +	struct stmmac_priv *priv = netdev_priv(ndev);
>> +
>> +	return stmmac_bus_clks_config(priv, true);
>> +}
> 
> Same idea as the stmmac_runtime_suspend() comment above!
> 
>> +
>> +static int qcom_ethqos_suspend(struct device *dev)
>> +{
>> +	struct net_device *ndev = dev_get_drvdata(dev);
>> +	struct stmmac_priv *priv = netdev_priv(ndev);
>> +	int ret;
>> +
>> +	if (!ndev || !netif_running(ndev))
>> +		return -EINVAL;
>> +
>> +	ret = stmmac_suspend(dev);
> 
> ret here is ignored.
> 
>> +
>> +	return stmmac_bus_clks_config(priv, false);
>> +}
>> +
>> +static int qcom_ethqos_resume(struct device *dev)
>> +{
>> +	struct net_device *ndev = dev_get_drvdata(dev);
>> +	struct stmmac_priv *priv = netdev_priv(ndev);
>> +	int ret;
> 
> unused ret.
> 
>> +
>> +	if (!ndev || !netif_running(ndev))
>> +		return -EINVAL;
>> +
>> +	stmmac_bus_clks_config(priv, true);
> 
> Probably should check this.
> 
>> +
>> +	return stmmac_resume(dev);
>> +}
> 
> Both the new system sleep ops installed here basically match the
> stmmac_pltfrm_suspend/resume() functions that were already installed.
> The only difference I'm noting is that you want to call
> stmmac_bus_clks_config() in your implementation, whereas the originals call
> the exit()/init() callbacks if they exist in the platform driver.
> 
> I would say "let's just make a exit()/init() callback for Qualcomm", but
> looking further... (see below)
> 
>> +
>> +const struct dev_pm_ops qcom_ethqos_pm_ops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(qcom_ethqos_suspend, qcom_ethqos_resume)
>> +	SET_RUNTIME_PM_OPS(qcom_ethqos_runtime_suspend, qcom_ethqos_runtime_resume, NULL)
>> +};
>> +
>>  static int qcom_ethqos_probe(struct platform_device *pdev)
>>  {
>>  	struct device_node *np = pdev->dev.of_node;
>> @@ -838,7 +887,7 @@ static struct platform_driver qcom_ethqos_driver = {
>>  	.probe  = qcom_ethqos_probe,
>>  	.driver = {
>>  		.name           = "qcom-ethqos",
>> -		.pm		= &stmmac_pltfr_pm_ops,
>> +		.pm		= &qcom_ethqos_pm_ops,
> 
> You effectively remove the stmmac_pltfr_noirq_suspend()/resume()
> callbacks here, which do the stmmac_bus_clks_config() via
> pm_runtime_force_suspend() etc during late suspend/early resume.
> 
> I do see this if statement, but I believe !device_may_wakeup() is true here,
> so the clocks should get killed.
> 
> 	static int __maybe_unused stmmac_pltfr_noirq_suspend(struct device *dev)
> 	{
> 		struct net_device *ndev = dev_get_drvdata(dev);
> 		struct stmmac_priv *priv = netdev_priv(ndev);
> 		int ret;
> 
> 		if (!netif_running(ndev))
> 			return 0;
> 
> 		if (!device_may_wakeup(priv->device) || !priv->plat->pmt) {
> 			/* Disable clock in case of PWM is off */
> 			clk_disable_unprepare(priv->plat->clk_ptp_ref);
> 
> 			ret = pm_runtime_force_suspend(dev);
> 			if (ret)
> 				return ret;
> 		}
> 
> 		return 0;
> 	}
> 
> Right now I'm of the opinion that this patch shouldn't really change
> much based on that digging. Please let me know if I'm missing something
> but it appears to me this should already be working.

I agree with all the points above. The reason we were still pushing qcom
specific changes is we wanted a PM wrapper function to add qcom specific
changes for features such as deep sleep. 

Looks like I had overlooked exit()/init()  platform callbacks you have
correctly pointed out. I can use this callbacks to do all the ethqos specific 
operations. Considering this point, the current patch is unnecessary.

Thanks for pointing this out!
> 
>>  		.of_match_table = qcom_ethqos_match,
>>  	},
>>  };
>> -- 
>> 2.17.1
>>
> 

