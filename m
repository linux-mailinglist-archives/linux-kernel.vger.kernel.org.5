Return-Path: <linux-kernel+bounces-3286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 168B2816A65
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE3CAB22C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F4912B9F;
	Mon, 18 Dec 2023 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aIxOzsgT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573512B9D;
	Mon, 18 Dec 2023 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI8otZX001804;
	Mon, 18 Dec 2023 09:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=C8jKSD0wlQGupBE4Dhy2cxrVBb7opOfFw9Tu/10EJUo=; b=aI
	xOzsgTHEGns63pqQ2RQRLg14J4LXSD3kSc/VB6Ve16Kx3HHZZnZbmB7sXD1v76/M
	psDaTKSpvaBxChiKopKMGNyIDJzcbMKnpMpOUh5UM2ftM6A4frmrkHNVyUfyl4Mb
	yiRxlGvQcspo9CRxY/jTBV4rNoXRr/FQkZ0NnBnh1p6A8l3VxqPGv1+LTErTyK3/
	GdjuUTmN8wIUQlybPFTnckR+LxDu7xhPaQHWnjwnCWR5NrP+c6fsmNgERf5cfHbI
	CC+3i4565J2VbhTOYbM+R6Eo8+J9SG+ymMd0tT53VrmDH+vdXZQQYZ5in5YmZW+v
	tj7YfDe/V6FZvsEz/ybw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2jx0g507-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 09:59:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI9xqjN009464
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 09:59:55 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 01:59:49 -0800
Message-ID: <e00b2c5a-cd79-40ed-b78b-0aa8c5b33fa0@quicinc.com>
Date: Mon, 18 Dec 2023 17:59:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] arm64: dts: qcom: sm8550: remove
 address/size-cells from mdss_dsi1
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231207092801.7506-1-quic_tengfan@quicinc.com>
 <20231207092801.7506-4-quic_tengfan@quicinc.com>
 <9cf61b7b-199a-4535-a701-10851959b940@linaro.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <9cf61b7b-199a-4535-a701-10851959b940@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7yruj2pYRWqv1NpP_ybZG9fClLusQeXR
X-Proofpoint-GUID: 7yruj2pYRWqv1NpP_ybZG9fClLusQeXR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=725 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180071



在 12/11/2023 6:25 PM, Krzysztof Kozlowski 写道:
> On 07/12/2023 10:27, Tengfei Fan wrote:
>> Address/size-cells will cause dtbs check warning, because mdss_dsi1 node
>> have not ranges and child also have not reg, so remove address/size-cells.
> 
> Paste the excerpt of warning.
Sure, I will paste the excerpt of warning.
> 
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
> 
> I am not sure if this is correct. The address/size cells are there for
> panels. We have multiple of such warnings, so I would like to have here
> consensus for all of them.
Currently these address/size cells lead to dtc W=1 warning, so these 
should be dropped. These can be re-added if needed at a later date.
> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Tengfei Fan

