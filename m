Return-Path: <linux-kernel+bounces-860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F43981472D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5EAFB22206
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA235288DF;
	Fri, 15 Dec 2023 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iRtasdpa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D425250EF;
	Fri, 15 Dec 2023 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFAru8l016976;
	Fri, 15 Dec 2023 11:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BK0epugF+6eSyIzgP1H3ccnYVHXcpoCVFb88Ej8e3hw=; b=iR
	tasdpamAlU90sNhPusOrf0+tSbdufuEgvJ+wZOdDplsc0Sn2OTh8e9kJ8xkvGUqV
	a3mzo8B5VMMkiAgOX8+4hqBEjV9u1HHJUqAKQGeaxisqzKFzunulqo+r9E2QK3yS
	FbF8ynpGahEmQtG3Ec4x2bPz0rUP163oF8MMnCUqHLO4x5oa65Q0G/zeqXh1bKSf
	auiV+2/7SlDaDhXcBFH9+5TZ72mCEbuzZnwj1bC0OHYnSp0koPR6Tf39FnbnAJ+Q
	wlsDKPfHYCEC+q4PjcWcioYxXJcAd38VTp25aa3B9BfwTFlmhzR4ADYBJx8WOWoX
	e3Ylh32SPBZHXtS2p6yw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0hqcgucw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 11:42:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFBgpxq012370
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 11:42:51 GMT
Received: from [10.253.13.71] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 03:42:46 -0800
Message-ID: <1bed5f99-c265-4539-971e-e3ecddd0fbce@quicinc.com>
Date: Fri, 15 Dec 2023 19:42:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>, <linux-arm-msm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20231212115151.20016-1-quic_luoj@quicinc.com>
 <20231212115151.20016-6-quic_luoj@quicinc.com>
 <20231212-caution-improvise-ed3cc6a1d305@spud>
 <11ffc985-3f2b-46b9-ae0b-911f7abe98d1@quicinc.com>
 <20231214-outshine-shush-8a11c68607cd@spud>
 <c5123ce7-6fdc-43c7-ac07-251c39196e66@quicinc.com>
 <a1e5ffec-a20d-4389-83f9-ee09bd9d733d@linaro.org>
 <a84a36af-69f8-46af-967e-b06d028597a3@quicinc.com>
 <26c8b0b1-5ea9-45cc-adf3-0d0b03a1284d@linaro.org>
 <4b9c56b8-3b29-4861-a3d5-2da26fbc14b4@quicinc.com>
 <20231215-junkyard-primate-64d32bbde12c@spud>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20231215-junkyard-primate-64d32bbde12c@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d3U11bG3bsANsPnF2QrAi0L3DveHiqqX
X-Proofpoint-GUID: d3U11bG3bsANsPnF2QrAi0L3DveHiqqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=678 clxscore=1015 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150077



On 12/15/2023 6:42 PM, Conor Dooley wrote:
>>>> This is indeed not a generic property, which is the Ethernet
>>>> function configs same as clock-frequency.
>>>
>>>
>>> Then it should not be made as a generic property...
>>
>> sure, i saw your another comments, will prefix qcom_ on this property.
> 
> iff the property stays, that would be a prefix of "qcom," not "qcom_".
> 
> Cheers,
> Conor.

Ok, thanks.

