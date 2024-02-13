Return-Path: <linux-kernel+bounces-62956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07849852865
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8D81F24B51
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD3112B80;
	Tue, 13 Feb 2024 05:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FgAQ9zs9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE60A134CB;
	Tue, 13 Feb 2024 05:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803683; cv=none; b=MBRu7M2bqlZKoC/xmToT+sGVLz8Y73VGObGIU4Co7Ts4bKeoZLZyA5rH68t2BGZiqryZilxETGp3sSZ0IVro7aXcH8nbLtAu2k1iaBwLKe5DFXkSNHSGi0bx68ZK8GmHiT96kEbjjb8/c5fEmi5VLMqM2NCSGRdhGlCsp4iCT40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803683; c=relaxed/simple;
	bh=JcJOQfOGs3Nd12dE0t8lktdd+IGLHzqX6FYs7yU4MB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SRrv32yXC/ags4HqwQ2YdsqYkRNr4h7LHvyhUJ2Kjf2QZDBhm0sR20tln/mS41bMiPvw1b9KSXm2XSg8C1zeqXb+Gja7/G7SrajcOTGrV+QH0v71wRNf0uvmFE+V6rPHQHWm5xBWY8m1Xt25EhdB/dMT+adBI1aozRuG1BSI35w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FgAQ9zs9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D5455N027331;
	Tue, 13 Feb 2024 05:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=NDJEgqD0UrZ14pM1kBz9TXy8QgN9x+UJgD+MBzF8irw=; b=Fg
	AQ9zs9mSCyYd3dzWIj9zmPTNV+eionR9iWAhi5UeElf2yZAZKIo9Aqf7Y2PGGUrz
	K2HXWPkmMfi7vnXYzpV1rRVFbgrSeQGB9dzfHaGiO+5Y0jeEb1p1OK4XiYixWcDC
	wkWoZJf2fO/ioV3FMkpz6GHQxD2t9jEX83jw9VuGPD2C1MLd+Y8rSrrPaQELJDhY
	5KSbduvvPnERkItSeNeGLjklaRydXseiYaucvm6dWZgiM5em01fiMFL110tbVe+j
	oBwaJXjNTTeiFzT8a9DO9S0GXQgNgps9Fvc2Sl8cS6bco9t3SP7m2zB32jzLdIpt
	5cJqW6843+OzLYRatY7A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7wfy8ewa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 05:54:37 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D5saM2005379
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 05:54:36 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 21:54:33 -0800
Message-ID: <9ad7967f-0a6a-96ed-1433-832f76752059@quicinc.com>
Date: Tue, 13 Feb 2024 11:24:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] soc: qcom: rpmh-rsc: Enhance check for VRM in-flight
 request
Content-Language: en-US
To: Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        <quic_mkshah@quicinc.com>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_collinsd@quicinc.com>, <quic_eberman@quicinc.com>,
        <quic_lsrao@quicinc.com>, <stable@vger.kernel.org>
References: <20240212-rpmh-rsc-fixes-v3-1-1be0d705dbb5@quicinc.com>
 <20240213035203.2492516-1-quic_subbaram@quicinc.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240213035203.2492516-1-quic_subbaram@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aKWrJLp_GdD2C3_ZRx5pHSvmB5INVu_b
X-Proofpoint-ORIG-GUID: aKWrJLp_GdD2C3_ZRx5pHSvmB5INVu_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=427
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130043



On 2/13/2024 9:22 AM, Subbaraman Narayanamurthy wrote:
> Hi Maulik,
> 
>> +bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
>> +{
> 
> <snip>
> 
>> +	if (SLAVE_ID(addr1) == CMD_DB_HW_VRM
>> +	    && VRM_ADDR(addr1) == VRM_ADDR(addr2))
>> +		return true;
>> +	else if (addr1 == addr2)
>> +		return true;
>> +	else
>> +		return false;
> 
> Minor..it would be better if you modify it as following.
> 
> +	if (addr1 == addr2)
> +		return true;
> +	else if (SLAVE_ID(addr1) == CMD_DB_HW_VRM
> +	    && VRM_ADDR(addr1) == VRM_ADDR(addr2))
> +		return true;
> +
> +	return false;

Even better if it becomes one statement for true rest with
false..
> 
> -Subbaraman
> 
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.

Probably, you don't want to include this in your reply.

-Mukesh

> 

