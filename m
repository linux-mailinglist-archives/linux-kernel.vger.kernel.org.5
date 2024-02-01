Return-Path: <linux-kernel+bounces-48742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A714F84608C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7B8289C09
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F9B8526C;
	Thu,  1 Feb 2024 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PtRqufRB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781684FBF;
	Thu,  1 Feb 2024 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814097; cv=none; b=gDfGdcgPSLKx7EUCTj07q9ZVDhmVjZHl/cDaTLbSVUmEmXGp1TnaBWNija8X6IhZ8T/iubaOj5i5JAIip4t/ms3flUaGaUCOnDJItf81HCjAXOwPz78uSLi1NZe9FQbbD9lspttbKUyVlfPzjs8Gd9IKEjFt7fQIU6GYtnEJark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814097; c=relaxed/simple;
	bh=Jfb2ag/RVb7aLbbTFIRRajXzhYFdXWB21U1ECTT7m+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S/iVpT40oKYqP1qIpPmb2uaAGHKuJxHfPzPpXTbHVm4k2pxe8ywlllyL8KPDWUV4hPf/ML1cO9fwrILOqsFNgBSYDtTyshKBufBDr/+KwpxmsE8PUX3/OdfdJ/Qp7EDFizwb+GyOKOkWbaLct9wEV7sKzKr3iFgY6t7dV8Nn88s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PtRqufRB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411GEMZa004256;
	Thu, 1 Feb 2024 19:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=CEPvhuqBAzR9JTprWZWY6mkiYQwJNcN/+j7I9096g80=; b=Pt
	RqufRBRL2/tQACYvHUmx8rVAPoE9dnhRRNoNy2BpxO3u/d0GaRd/AplxNJflzGmu
	f1qvIpWAQQ4zzrEwLu5SsUDqYSpTd6rdKOGk0D4JQr/HSnKrTD+6ECyXmCdC+Cs5
	b/qPW3RJ9aOIO+JmtUg4HDoSdLRzdpaekZ3fPiV5o9lgZwAvBBqtBu90p2ItS0bc
	naC/otOgipTlgz185sZj2IhBFYRAofIj8u5OBQ+N4VkRZR10Au/8402eZ/V3REzf
	n2Q8fE1JpOTl+rk6QWNNEZR1jqJWxo4JSAZxSuEentL/BkJJe8PwQVByKFMhPNi1
	846KKKu32Kk6TKIdqJWA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w06mnsu2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 19:00:57 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411J0t6H004090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 19:00:55 GMT
Received: from [10.110.99.223] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 11:00:52 -0800
Message-ID: <c2497eef-1041-4cd0-8220-42622c8902f4@quicinc.com>
Date: Thu, 1 Feb 2024 11:00:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: stmmac: TBS support for platform driver
Content-Language: en-US
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
 <5626e874-066c-4bf2-842d-a7f3387b6c1b@quicinc.com>
 <87a5okvbdt.fsf@geanix.com>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <87a5okvbdt.fsf@geanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 598Pt-pLYSSFWLEVg2mMTCAOFDnOomF_
X-Proofpoint-ORIG-GUID: 598Pt-pLYSSFWLEVg2mMTCAOFDnOomF_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010146



On 2/1/2024 12:26 AM, Esben Haabendal wrote:
> "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com> writes:
>> On 1/26/2024 12:43 AM, Esben Haabendal wrote:
>>> "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com> writes:
>>>
>>>> Qualcomm had similar discussions with respect to enabling of TBS for a
>>>> particular queue. We had similar discussion on these terms yesterday
>>>> with Redhat. Adding Andrew from Redhat here
>>>>
>>>> What we discovered as part of the discussions is listed below.
>>>>
>>>> 1. Today upstream stmmac code is designed in such a way that TBS flag
>>>> is put as part of queue configurations(see below snippet) and as well
>>>> know that stmmac queue configuration comes from the dtsi file.
>>>>
>>>> //ndo_open => stmmac_open
>>>> int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;(comes from tx_queues_cfg)
>>>>
>>>> /* Setup per-TXQ tbs flag before TX descriptor alloc */
>>>> tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;
>>>>
>>>> 2. There is a no way to do this dynamically from user space because
>>>> we don't have any API exposed which can do it from user space
>>>
>>> Not now. But why not extend ethtool API to allow enabling TBS for
>>> supported controllers?
>>
>> ethtool API can be implemented but that still doesn't solve the
>> problem of stopping the entire MAC block because of enhanced desc
>> allocation.
> 
> I am not sure what you exact point is here.
> 
> If you look at the implementation of ethtool API for changing ring
> parameters, you have stmmac_set_ringparam() which calls
> stmmac_reinit_ringparam(), which again calls stmmac_release() if the
> interface is up (stopping the entire MAC), and then stmmac_open() which
> reinitializes everything.
> 
> The same pattern could be applied to changes to enable enhanced
> descriptor allocation.
> 
> I don't see why that will not be acceptable. Why would anyone have to do
> that while critical traffic is flowing? In your system you should be
> able to know which queues needs enhanced descriptors before starting
> communication.
> 
>> 1. We can either allocate enhanced desc for all channels at bootup and
>> then choose to switch to enable TBS mode at runtime (Additional memory
>> usage)
> 
> A good default would IMHO be to enable enhanced descriptors for all but
> TX queue 0. This will allow use of TBS without needing to change
> anything. If the rather minimal extra memory usage is disturbing anyone,
> then they can tune it at boot time before bringing the interface up.
> 
>> 2. Live with the disruption of traffic for a brief duration of time.
>> Which is not a good solution for priority and critical traffic.
> 
> As mentioned above, I don't see why anyone would need to modify the
> descriptor allocation while critical traffic is flowing.
> 
> If you are able put this information in your device tree, you definitely
> will be able to put it in an boot script in some form.
> 
>>>> and also TBS rely on special descriptors aka enhanced desc this
>>>> cannot be done run time and stmmac has to be aware of it before we
>>>> do DMA/MAC/MTL start.
>>>
>>> Isn't this somewhat similar to changing the RX/TX ring parameters,
>>> which I believe also is quite difficult to do at run time, and
>>> ethtool therefore requires the interface to be down in oroer to
>>> change them?
>>>
>>>> To do this dynamically would only mean stopping DMA/MAC/MTL realloc
>>>> resources for enhanced desc and the starting MAC/DMA/MTL. This means
>>>> we are disrupting other traffic(By stopping MAC block).
>>>
>>> Yes. But you would be disrupting traffic less than by requiring a
>>> complete reboot of the target which is needed if the devicetree must be
>>> changed.
>>>
>> any DTS solution today anyway requires completely loading the boot
>> image and rebooting the device, but once the device is functional, End
>> user can activate TBS, as he knows the exact usecase and requirements.
>> I understand the solution is not scalable, but at this point we don't
>> have a solution to activate TBS at runtime.
> 
> Exactly. We are discussing a solution to activate enhanced descriptors
> at "runtime". But I propose to do it in a similar way as changing ring
> parameters, so it is in runtime seen from a CPU perspective, but the
> interface will be shortly brought down when changing it.
> 
>>>> 3. I dont think there is a way we can enable this dynamically today. I
>>>> would like upstream community to share your thoughts as well.
>>>
>>> Hereby done. Could we investigate the possibility of using ethtool to
>>> change TBS enable/disable "run-time"?
>>>
>> We can either allocate enhanced desc for all channels at bootup
>> and then choose to switch to enable TBS mode at runtime.
> 
> I think we should do something like this:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=3b12ec8f618e
> 
> for all glue drivers, so a sane default is established that allows using
> TBS from boot up.
> 
> But in addition to that, I think it would make sense to create an
> ethtool API to change it from that default. And it will bring down the
> interface while applying the change.
> 

Agreed. Okay, We can go with this approach. I will evaluate the changes from ethtool perspective.
ethtool approach will be favorable to everyone as most of the users rely on ethtool to configure 
the NIC parameters. 

For now glue drivers can exclude queue0 for tbs and have all other queues to have tbs enabled.  

> /Esben

