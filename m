Return-Path: <linux-kernel+bounces-52012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883388492C5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153932836C4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC24947A;
	Mon,  5 Feb 2024 03:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QkMXeHFQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F3C9455;
	Mon,  5 Feb 2024 03:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707103483; cv=none; b=CUCMQ20AfhSSJr9mNC0Z8237r4boUGmHuYej+CaPFtJEVLCb4wR7H+x5HL8hq84vnRP8wiRCteQBPaHVOXqNiGAGxrUmn+9+YgFJhn2OfDVSmWElEQA747aiQ6pe88EDhFuxFtGN1B9IrDQkzesvWEgkV+qK5VAvE71w5d575FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707103483; c=relaxed/simple;
	bh=5gfeHckEgn7wafvr84TEMXZGl6K5uSSF8aAeLCt6SNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ps2WrKwLQnjPd+fHRtTWWJY8ShMeGFnO2ff3/kGLVhkMqvHebKA4W0leRC+VGKKjQmpopY58OU8Y6D2HbAfwsFdnvjsLOI/bGRBZoXclw8EHHfG8hjhNfzR8zKytWr1FaNsz6vWlJEBiDcxGwMC5eXSnBUF88oquuqB5/7YXjTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QkMXeHFQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4150duaJ002662;
	Mon, 5 Feb 2024 03:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bzk4sJkqKPDVjXVVLKXE3zEm3Jpnwgu3XaFCAYr5a2A=; b=Qk
	MXeHFQ9eeNytU/QNebhQJRBSxFqB1T/UyEBHPPVRY1nDOOQ+CO1XFfF5xfdhZIYc
	2CL02A7ceaVZWEsp3R4ji59uez6LIYv+8v8DLXoV19mhSqqZ2c+FrQ5gzvw+pCf6
	0iromW49yzmz+xPp97eCD2Sl2dQFRAGLH1QQiUImd3DE3MQBmMoU6NbnyfFh5h9R
	B8oHOj6b95VyYK2nfHCuhgpon+W+6GKPTH8Zn5iNSGPg5/cJFAcEHnPlyBr44d+k
	RxqfvjEe4nuMKnRAjc6XhHgVR8ynt4AhwbUrYtr9pZ68CQEkA+DMJ3J6lj1MTyH8
	noFB5jDBK6Gae1oS3vuA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w1f232g30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 03:24:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4153ONXp026005
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 03:24:23 GMT
Received: from [10.253.38.98] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 4 Feb
 2024 19:24:19 -0800
Message-ID: <05253a6d-7fa5-4c32-af6f-cda0f902cf77@quicinc.com>
Date: Mon, 5 Feb 2024 11:24:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v2 2/3] net: mdio: ipq4019: add support for
 clock-frequency property
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Christian Marangi <ansuelsmth@gmail.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Marko <robert.marko@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240130003546.1546-1-ansuelsmth@gmail.com>
 <20240130003546.1546-3-ansuelsmth@gmail.com>
 <7d86388d-15f5-4e72-b99f-aee3b47a5232@quicinc.com>
 <4cd01d93-7b6d-4766-8337-c4dc09aeedc2@lunn.ch>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <4cd01d93-7b6d-4766-8337-c4dc09aeedc2@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4eiG2ulv9_zSk7S7PwD1Oa1jz-ca5GBS
X-Proofpoint-GUID: 4eiG2ulv9_zSk7S7PwD1Oa1jz-ca5GBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-04_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050025



On 2/4/2024 11:22 PM, Andrew Lunn wrote:
> On Sun, Feb 04, 2024 at 05:59:10PM +0800, Jie Luo wrote:
>>
>>
>> On 1/30/2024 8:35 AM, Christian Marangi wrote:
>>> +
>>> +	/* If div is /256 assume nobody have set this value and
>>> +	 * try to find one MDC rate that is close the 802.3 spec of
>>> +	 * 2.5MHz
>>> +	 */
>>> +	for (div = 256; div >= 8; div /= 2) {
>>> +		/* Stop as soon as we found a divider that
>>> +		 * reached the closest value to 2.5MHz
>>> +		 */
>>> +		if (DIV_ROUND_UP(ahb_rate, div) > 2500000)
>>> +			break;
>>
>> Hi Christian,
>> Sorry for the delayed review.
>>
>> The MDIO hardware block supports higher frequency 6.25M and 12.5M,
>> Would you remove this 2.5MHZ limitation? On the IPQ platform, we
>> normally use 6.25MHZ.
> 
> 802.3 says the clock has a maximum of 2.5MHz. So this code is correct.
> 
> It is however O.K. to go faster, but since that breaks the standard,
> you need each board to indicate it knows all the devices on the bus do
> support higher speeds and its O.K. to break the standard. You indicate
> this by using the DT property in its .dts file. For an MDIO bus which
> is totally internal, you could however put the DT property in the SoC
> .dtsi file.
> 
>        Andrew

Understand it, Thanks Andrew.

