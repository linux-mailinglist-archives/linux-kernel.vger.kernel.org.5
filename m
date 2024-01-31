Return-Path: <linux-kernel+bounces-47220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CCE844AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53252B23496
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E3139FD3;
	Wed, 31 Jan 2024 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jX0hpcZN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B05739AC8;
	Wed, 31 Jan 2024 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738398; cv=none; b=QkqCLVcpse9d0/KrrdWhOrsLNUvN8LunyxdoFAj/oVQWO67IvvEGrjDU2/z4HBM7nh8nNO90m/TLWQTiXCvt/6e3F2u+azQpc+cSDVF1swPBXPZhz+sATf8omu4zPr0vgrjY6IacwiQsopUop42eGB91WF7x06bM0Sibkay5WQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738398; c=relaxed/simple;
	bh=QS9kYyTmF0+N4WirBEbQPjUnZA5Cj9CVicXQINR9Pnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JWlefwjT9xGuPwM+lUxNoLTQafI02v6+1+XCn2DCxYmTck9EHZCLpzY3M07cNfAqlUq3d4QmB9UhBFcgqcjOtfgVKiVSg83efF/kr3/PuYPDnNy/fbLTUXHJezgI0HnzLp6osEfFiWx32KtxMGnII2KpJIBJs/jGbfK335RGgIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jX0hpcZN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VKseC0031538;
	Wed, 31 Jan 2024 21:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6cceawbCFiLT/nNuxjw20HwwZkJ0peSJEK9m+ASYads=; b=jX
	0hpcZN831ZU0B3HHrEPsdDQ+KmBd1831TuEAvXjnVuOVTFZOzMC2n5w1E4HbRXF2
	RIXeiAhgQbVMgH/Jd/gohx9kXdiud+DHkBsTFkJSoNbAibxFMoAPgGpQcug7ljre
	iie+sM1L550U/rgiqg0XLn1iouCbDdv8+uuSUg/dnM1Pin1xdzRMonlF5vq4VIpz
	kjZwnVrjsaV5n6dHem2VR0Aq7Ppi7b08ALukMHw1Unc6fWU4+QtdE3jkR9IlUk0j
	uj+HjaomBQrt8Joc6gycVM/2iMlosftnLQAenSfFBTf/W4fp4oQQw1j7xA733uY9
	ujA3Sw9ofUD9kMPCnlsw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyve60auh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:59:23 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VLxMCO007973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 21:59:22 GMT
Received: from [10.110.127.163] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 13:59:20 -0800
Message-ID: <5626e874-066c-4bf2-842d-a7f3387b6c1b@quicinc.com>
Date: Wed, 31 Jan 2024 13:59:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: stmmac: TBS support for platform driver
To: Esben Haabendal <esben@geanix.com>
CC: Rohan G Thomas <rohan.g.thomas@intel.com>,
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
        Andrew Halaney <ahalaney@redhat.com>, <elder@linaro.org>,
        <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_bhaviks@quicinc.com>,
        <kernel.upstream@quicinc.com>
References: <20230927130919.25683-1-rohan.g.thomas@intel.com>
 <20230927130919.25683-3-rohan.g.thomas@intel.com>
 <92892988-bb77-4075-812e-19f6112f436e@quicinc.com>
 <87r0i44h8v.fsf@geanix.com>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <87r0i44h8v.fsf@geanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PB0QoEx8sXd23pNThVFyQYoPg1a0htHB
X-Proofpoint-ORIG-GUID: PB0QoEx8sXd23pNThVFyQYoPg1a0htHB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310170

Hi Esben,
	My responses are inline to the queries. I hope i have justified my problem statement.  

On 1/26/2024 12:43 AM, Esben Haabendal wrote:
> "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com> writes:
> 
>> Qualcomm had similar discussions with respect to enabling of TBS for a
>> particular queue. We had similar discussion on these terms yesterday
>> with Redhat. Adding Andrew from Redhat here
>>
>> What we discovered as part of the discussions is listed below.
>>
>> 1. Today upstream stmmac code is designed in such a way that TBS flag
>> is put as part of queue configurations(see below snippet) and as well
>> know that stmmac queue configuration comes from the dtsi file.
>>
>> //ndo_open => stmmac_open
>> int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;(comes from tx_queues_cfg)
>>
>> /* Setup per-TXQ tbs flag before TX descriptor alloc */
>> tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;
>>
>> 2. There is a no way to do this dynamically from user space because we don't have any 
>> API exposed which can do it from user space
> 
> Not now. But why not extend ethtool API to allow enabling TBS for
> supported controllers?
> 
ethtool API can be implemented but that still doesn't solve the problem of stopping the 
entire MAC block because of enhanced desc allocation. 
1. We can either allocate enhanced desc for all channels at bootup and then choose 
to switch to enable TBS mode at runtime  (Additional memory usage)
2. Live with the disruption of traffic for a brief duration of time. 
Which is not a good solution for priority and critical traffic. 
>> and also TBS rely on special descriptors aka enhanced desc this cannot
>> be done run time and stmmac has to be aware of it before we do
>> DMA/MAC/MTL start.
> 
> Isn't this somewhat similar to changing the RX/TX ring parameters, which
> I believe also is quite difficult to do at run time, and ethtool
> therefore requires the interface to be down in oroer to change them?
> 
>> To do this dynamically would only mean stopping DMA/MAC/MTL realloc
>> resources for enhanced desc and the starting MAC/DMA/MTL. This means
>> we are disrupting other traffic(By stopping MAC block).
> 
> Yes. But you would be disrupting traffic less than by requiring a
> complete reboot of the target which is needed if the devicetree must be
> changed.
> 
any DTS solution today anyway requires completely loading the boot image 
and rebooting the device, but once the device is functional,
End user can activate TBS, as he knows the exact usecase and requirements. 
I understand the solution is not scalable, but at this point we don't have a solution 
to activate TBS  at runtime. 
>> 3. I dont think there is a way we can enable this dynamically today. I
>> would like upstream community to share your thoughts as well.
> 
> Hereby done. Could we investigate the possibility of using ethtool to
> change TBS enable/disable "run-time"?
> 
We can either allocate enhanced desc for all channels at bootup
and then choose to switch to enable TBS mode at runtime
>> 4. I agree with Rohan's patch here and want upstream community to
>> accept it. This will allow use to configure the queues where TBS needs
>> to be enabled as hardcoding in the code unless upstream has better way
>> to this using userspace.
>>
>> Please let us know if you think otherwise. 
> 
> /Esben
Best Regards
ABC

