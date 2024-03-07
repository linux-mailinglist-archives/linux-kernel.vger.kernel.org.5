Return-Path: <linux-kernel+bounces-95123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3BA874974
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92023281C78
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA876340A;
	Thu,  7 Mar 2024 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aK9oK45t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38334633F5;
	Thu,  7 Mar 2024 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799665; cv=none; b=aBAHBf99uQq+wAcIF9d+SMSPqWHFLtMJZDqc4gBsCeYJxAreNUhViZe2Io42icggyA4wcrG8KHyk9iM+JJ6IG3GsYI3AtvaFvtR/Ibcj2Dbqg9GJHIfqQrbXt1TXhIV5PaGex3yxWGt2nkNAVu1cU55BnhLwxWDWVD93Rfdxkcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799665; c=relaxed/simple;
	bh=NDZ1E5gQ7TCSxucTvQcLUX4vB5AJPIVxD1vCXwDw9QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gK+cIUP4ftS8FtY98//Bpn1w12nnxCMgTvAktpdAAWj0hnAl3sPfNPhvldhMG7kK3qlQzcCO2qUYcZEto7Iq/3FONK0EUMVbVUxc2StxCk4x0VRM4L6RprUieJp/lcQeQd6+saA7ooPWRZx3bHW+ClcSI9QD8Wt5C+ck4/GTW8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aK9oK45t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4277mu5a003580;
	Thu, 7 Mar 2024 08:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=q7GoIHg6TGs1bP6qT2WFb6DV1jjf+4voLbe4S+7/Djg=; b=aK
	9oK45tRtCgFsN2SOeA+8MB2cS9Nmar6HArVn9Es8LBS65u4XV2o3+2FqBNMQLGXa
	3gSrOvoKYoHWrvkSgtgBbbai/fdq2leZTt/5ycs/IN08JaPTWgTpI8Qz968Tsbjx
	a4T0VWz7CCPipSPFBrb1gedSij0D6dMQhZBSiUlwXcQI3cm4+Y7lK0GscuMj74Tj
	IpFV83XKrcucaC27AswORQNhU6eAkfOk+xxio23ZBW0OuLQlTrF/egnpb9p2XxAn
	OZpI174ICYAJNNttCPKIPLKlvXvicXAqTFFU2w93BeTesPbezxxBHjN4NgwihWDB
	5fgtelbD5oDCUQ5EZeXw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wq9h8g1t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 08:20:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4278Kgel021266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 08:20:42 GMT
Received: from [10.204.67.124] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Mar
 2024 00:20:35 -0800
Message-ID: <5271ebb4-68e7-468f-b1e0-b35a77f53902@quicinc.com>
Date: Thu, 7 Mar 2024 13:50:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] add display and panel on qcm6490 idp
Content-Language: en-US
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
        <arnd@arndb.de>, <neil.armstrong@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_abhinavk@quicinc.com>, <quic_rajeevny@quicinc.com>,
        <quic_vproddut@quicinc.com>
References: <20240215103929.19357-1-quic_riteshk@quicinc.com>
From: Ritesh Kumar <quic_riteshk@quicinc.com>
In-Reply-To: <20240215103929.19357-1-quic_riteshk@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iuZyJztrG5hMGBEQJb40NpGtMBEQPKFb
X-Proofpoint-ORIG-GUID: iuZyJztrG5hMGBEQJb40NpGtMBEQPKFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_04,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1011 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403070059


On 2/15/2024 4:09 PM, Ritesh Kumar wrote:
> Build the Novatek NT36672E DSI Panel driver as module and enable
> display subsystem on Qualcomm qcm6490 idp board.
>
> Ritesh Kumar (2):
>    arm64: defconfig: enable Novatek NT36672E DSI Panel driver
>    arm64: dts: qcom: qcm6490-idp: add display and panel

Can you please review and apply these two patches.

Thanks,
Ritesh

