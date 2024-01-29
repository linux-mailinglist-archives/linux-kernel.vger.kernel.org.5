Return-Path: <linux-kernel+bounces-42853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6F98407BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735621C24648
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEFD657CB;
	Mon, 29 Jan 2024 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TRI05WaM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE68965BA0;
	Mon, 29 Jan 2024 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536774; cv=none; b=QMslcgx+1B4RyqBdJd4Ry6MvDR3ZOmLkXndbcHoltiahy8Ug+IXAUFJpd0imF59GKUqAxWryDpxsgfTTm5PEp4nAgpvhJm5r/81xuj9esGBUco1PIjA61TOiptD6oVf3w6ydmwNxUJm0owglhc2n76uyOp9GM1YB6WxqDvxFb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536774; c=relaxed/simple;
	bh=xJn1F7MAesV6tS4qm1/fKFLcvA/61etupSyvqTcNAfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TQc1X5qdIPpDCHKa2g0yuC85WD/KmEosrLYN6lyXFfCyTTTHGMlmqqmWecQ+L4dnVL5SS8cjuAdkHd4q9oYASJGAGHW3zwNLZgwav67bMpjQnTxFTyZVXv2RoRoggcoMpD5SKqDbhF8YbykPZsFDnnG1/aeUW/s/zbjhQUM6Bjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TRI05WaM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5rKia013136;
	Mon, 29 Jan 2024 13:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YxVrAb5WKHv+F5epFgMr04iEH3uFT5hSdeiYGl8vc4E=; b=TR
	I05WaMQ7bRubP3QMc8e8EKYvYG9urDJRwc/MXcC8bnFdT31XbXUi9b/bG2iMZ9C2
	iP0UcHNeLLDga8cbHEiCDgVl9Ee1I2E3ms9PtZe0QxVDLIazd1ro3zDi+8hd6l4k
	rIwKH3Zsm4v8q/sk6+5pqdyR5qGJ+ur2U071bpRbsUGVouIOdYNFQDWwNEA+211X
	VY3QoWhlN2TSjwDfppH3fTaw9dJkypciy0zTc3mtsd4wmraPkIjpluae3OfizpNp
	aD4bBB8ErH1HzN5JGBb0bHUdpSuuRIyOxGiPu4tO/5tWL17OVNySlynbmO5CX5va
	DI9mW70ytYpFjh1G72Sg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx3t9sbas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 13:59:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40TDxBlp022523
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 13:59:11 GMT
Received: from [10.253.38.251] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 05:59:06 -0800
Message-ID: <cdd0e481-2738-465b-9ef8-b7ab79981fbe@quicinc.com>
Date: Mon, 29 Jan 2024 21:59:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 0/3] net: mdio-ipq4019: fix wrong default MDC
 rate
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: Andrew Lunn <andrew@lunn.ch>, Andy Gross <agross@kernel.org>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Marko <robert.marko@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>
References: <20240124213640.7582-1-ansuelsmth@gmail.com>
 <53445feb-a02c-4859-a993-ccf957208115@quicinc.com>
 <f8a9e328-5284-4f24-be5d-7e9804869ecd@lunn.ch>
 <5d778fc0-864c-4e91-9722-1e39551ffc45@quicinc.com>
 <CAA8EJppUGH1pMg579nJmG2iTHGsOJdgDL93kfOvKofANTGGdHw@mail.gmail.com>
 <65b3ecd7.050a0220.9e26c.0d9e@mx.google.com>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <65b3ecd7.050a0220.9e26c.0d9e@mx.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yZM3yuQnxIPAraWf1Mq0QMxrwzmEYYz2
X-Proofpoint-ORIG-GUID: yZM3yuQnxIPAraWf1Mq0QMxrwzmEYYz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_07,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=778 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401290102



On 1/27/2024 1:33 AM, Christian Marangi wrote:
> On Fri, Jan 26, 2024 at 07:20:03PM +0200, Dmitry Baryshkov wrote:
>> On Fri, 26 Jan 2024 at 18:03, Jie Luo <quic_luoj@quicinc.com> wrote:
>>>
>>>
>>>
>>> On 1/26/2024 1:18 AM, Andrew Lunn wrote:
>>>>> Hi Christian,
>>>>> Just a gentle reminder.
>>>>>
>>>>> The MDIO frequency config is already added by the following patch series.
>>>>> https://lore.kernel.org/netdev/28c8b31c-8dcb-4a19-9084-22c77a74b9a1@linaro.org/T/#m840cb8d269dca133c3ad3da3d112c63382ec2058
>>>>
>>>> I admit this version was posted first. However, its embedded in a
>>>> patch series which is not making much progress, and i doubt will make
>>>> progress any time soon.
>>>>
>>>> If you really want your version to be used, please split it out into a
>>>> standalone patch series adding just MDIO clock-frequency support, with
>>>> its binding, and nothing else.
>>>>
>>>>       Andrew
>>>
>>> Hi Andrew,
>>> We will rework the patch series to include only MDIO frequency related
>>> function and frequency dt binding, and post the updated patch series
>>> on th/Tuesdae Mondayy of next week. We will work with Christian to
>>> ensure he can re-use this patch as well.
>>
>> Can you do the other way around: rebase your patches on top of Chritian's work?

Hi Dmitry,
Sure, we can take this approach if fine by Andrew as well.

>>
> 
> Would be ideal, also I have to send v2 that handle the 802.3 suggested
> MDC rate (ready I just need to send after this has been handled).
> 
> Also I can see some problem with Lui patch where thse divior
> value is not reapplied after MDIO reset effectively reverting to the
> default value.

Hi Christian,
In my version, the divisor is programmed in every MDIO operation and 
hence I did not add the code to revert to configured value in reset 
function. But sure. we can program it once during the probe/reset and 
avoid doing it during read/write ops.

In addition, the MDIO divisor 1, 2 and 4 are not supported by the MDIO
hardware block, maybe we can remove these macros to avoid confusion, or 
add a comment mentioning that these are not supported.

> 
> If it's a credits problem I can totally change the from or add
> Co-devloped, I just need the feature since the thing is broken from a
> looong time on ipq40xx and ipq807x.
> 

