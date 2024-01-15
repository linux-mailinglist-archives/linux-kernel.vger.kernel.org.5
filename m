Return-Path: <linux-kernel+bounces-25644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B1382D401
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40EA11C21078
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661B5257A;
	Mon, 15 Jan 2024 05:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hAv42R/u"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64305522B;
	Mon, 15 Jan 2024 05:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40F5lP0t007070;
	Mon, 15 Jan 2024 05:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uyeVkaizlVzKddAtNODyS0H7XtdU67ViDGrXRlk+WyI=; b=hA
	v42R/u/rAPv69pP9jmoBYyZg2bqgNaaiycodFYLnlU+pbF90zSPvEj6s+wUIa3mZ
	uxPbj7kmb5azr9eFfWS5ITdYATsLLlpvDB59PYTIPVolHnKUSK3p9sz0MA2L+nmo
	wJq9JUtCsGdJumb0QosJ1xFCOSkdjTaGbKZm1v36kgZM2TWltk+wlcpfdsDBzN6R
	W9Ewmly7vZRaMc5GtYOtoAc3hYJC3aACJxAe9GBUA/4LjTcy6zmBIhWRLE4voqh9
	1QpvexiHT/oOV/JFo711UNeomgxfhk5eAJoKfClP40O/2tk4Mn75qhlkuVzX5bIm
	XtejccEEMYRuDH2Njdfw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vkmjujpxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 05:54:14 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40F5sDbw015621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 05:54:13 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 14 Jan
 2024 21:54:10 -0800
Message-ID: <b89dd2bb-2c8e-4528-85f3-0f510889c34d@quicinc.com>
Date: Mon, 15 Jan 2024 13:54:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: dts: qcom: qcs6490-idp: Add definition for
 three LEDs.
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross
	<agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240112-lpg-v4-1-c4004026686b@quicinc.com>
 <1f14bff5-4f3e-426b-b81d-006da061af1e@linaro.org>
From: hui liu <quic_huliu@quicinc.com>
In-Reply-To: <1f14bff5-4f3e-426b-b81d-006da061af1e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T6G1asB1vliVUoccl5DI6Yw_C_vH-ZgL
X-Proofpoint-GUID: T6G1asB1vliVUoccl5DI6Yw_C_vH-ZgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 bulkscore=0 impostorscore=0
 mlxlogscore=222 clxscore=1015 malwarescore=0 priorityscore=1501
 adultscore=0 mlxscore=1 spamscore=1 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401150042



On 1/12/2024 3:44 PM, Krzysztof Kozlowski wrote:
> On 12/01/2024 04:05, Hui Liu via B4 Relay wrote:
>> From: Hui Liu <quic_huliu@quicinc.com>
>>
>> Add definition for three LEDs to make sure they can
>> be enabled base on QCOM LPG LED driver.
>>
>> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
>> ---
>> Changes in v4:
>> - Removed "label" definition and added "function" definition.
> 
> You did not test your patch before sending.
> 
> Subject is still wrong. Also, it still has unnecessary full stop. Drop it.
I will update it to qcm6490-idp, I understood wrong previously.
> 
> Best regards,
> Krzysztof
> 

