Return-Path: <linux-kernel+bounces-15564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D4D822E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630C62852B5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700CD199B7;
	Wed,  3 Jan 2024 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ej7piJoa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374B3199A1;
	Wed,  3 Jan 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403COgmQ006945;
	Wed, 3 Jan 2024 13:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+wuhooESwpOIr8NtlZRl5NSI5e4hdmeSWyeoXiRorss=; b=ej
	7piJoaysjM3N0A4Su2igvXrSog4W+yLwvd9iSPvXasb/iGBk6pXa5pj4CK03UeRL
	IFkrWn1yvjiTHgGBit6anmsnxqBhCPpt4bpkane9s6pzK70WPjrOGdHEHR61MO6F
	ol2k6zHnefWoLYS9jjWYPaAmAoijd6q2Yj1Z0CGxiG14ar998Nrn932ATh+eZKA+
	RDVAK4EFK5SeVFtePQqL2E6dmTj+4NVYJJcLFW36mBY1uEI1t09aSzQlmeT3R6M7
	usFKGWoKi9hbMd3U8cvG5MzX9EA6GpDbEGrUu8UQEIOXYqEQ/6Y4GjaDTcvBdn4j
	9rST6IRoexBD1WJ5q/zA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vcgubb9k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 13:25:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 403DPRnC024254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 13:25:27 GMT
Received: from [10.253.72.77] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 3 Jan
 2024 05:25:24 -0800
Message-ID: <ec002e99-a9c1-4e61-ac1f-f87d0bbd7a38@quicinc.com>
Date: Wed, 3 Jan 2024 21:25:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy support
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Vladimir Oltean
	<olteanv@gmail.com>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, <andrew@lunn.ch>,
        <hkallweit1@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231109101618.009efb45@fedora>
 <0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
 <46d61a29-96bf-868b-22b9-a31e48576803@quicinc.com>
 <20231110103328.0bc3d28f@fedora>
 <3dd470a9-257e-e2c7-c71a-0c216cf7db88@quicinc.com>
 <20231111225441.vpcosrowzcudb5jg@skbuf>
 <39a8341f-04df-4eba-9cc2-433e9e6a798e@quicinc.com>
 <20231112235852.k36lpxw66nt7wh2e@skbuf>
 <ZVInvOqh6QAvNJtw@shell.armlinux.org.uk>
 <20231113195120.44k6hhth7y53df53@skbuf>
 <ZZQfm98HrjRdXJEq@shell.armlinux.org.uk>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZZQfm98HrjRdXJEq@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pBLBVmvzvcKDAUwFCGkArn8KNNNAWo_R
X-Proofpoint-GUID: pBLBVmvzvcKDAUwFCGkArn8KNNNAWo_R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030110



On 1/2/2024 10:37 PM, Russell King (Oracle) wrote:
> On Mon, Nov 13, 2023 at 09:51:20PM +0200, Vladimir Oltean wrote:
>> On Mon, Nov 13, 2023 at 01:42:20PM +0000, Russell King (Oracle) wrote:
>>> On Mon, Nov 13, 2023 at 01:58:52AM +0200, Vladimir Oltean wrote:
>>>>  From 17fd68123d78f39a971f800de6da66522f71dc71 Mon Sep 17 00:00:00 2001
>>>> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>>>> Date: Tue, 3 Oct 2023 22:16:25 +0300
>>>> Subject: [PATCH 1/2] net: phylink: move phylink_pcs_neg_mode() to phylink.c
>>>>
>>>> Russell points out that there is no user of phylink_pcs_neg_mode()
>>>> outside of phylink.c, nor is there planned to be any, so we can just
>>>> move it there.
>>>
>>> Looks familiar...
>>>
>>> http://git.armlinux.org.uk/cgit/linux-arm.git/commit/?h=net-queue&id=c2aa9d3846c218d28a8a3457b0447998b0d84c5d
>>
>> Well, yeah, I did mention that the patch was written at your suggestion,
>> and there aren't that many options in which that patch can be written.
>> I didn't look at your trees, and I made that change as part of a much
>> larger effort which involves phylink, which I will email you separately
>> about.
>>
>> I will gladly drop my ownership on the first patch and ask Luo Jie to
>> pick your version instead, if this is what you're implying from the 2
>> word reply.
> 
> The reason that I hadn't submitted it was because I didn't want to move
> the function out of the header file until the next LTS was released.
> 
> It seems 6.6 was announced as a LTS on the 17th November, so I'm happier
> to now proceed with moving this into phylink.c.
> 
> as phylink_pcs_neg_mode() was merged in 6.5-rc1, it will have had three
> kernel cycles - including one each side of the LTS release which I think
> is reasonable.
> 
> I will send my patch hopefully sometime this week so it's in 6.8
> depending on pressures.
> 

Thanks for updating the information.

