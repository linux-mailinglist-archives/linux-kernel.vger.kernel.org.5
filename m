Return-Path: <linux-kernel+bounces-72670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D86585B6F2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8D328501C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BFA651B9;
	Tue, 20 Feb 2024 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HOhhFJKx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBCA60DD6;
	Tue, 20 Feb 2024 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420316; cv=none; b=Ojbo8u6hNwmWjxBL3kIKrRFMyIoIu1eRiuxSpAMRIVpQGT0lMeSMgH0XYqYK9kr/mYxqQsRnEOnCHmFQXifOhn7PGSfIpJ5UWDy72ZikHVoGokzdMMMeVcqIar52o8Bo/wMurYUFDsfLhG3Wjmehdw92q8nmsXlntsg5vYpaYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420316; c=relaxed/simple;
	bh=6pNQxLl0GnHySyYMqnH4Xm6BRC1/LRaZTiGQX7HtdMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c3lmHz1tdyiWU+2agJa47QpiPrYVPUrDUyouHs/edIpJBCawEAmBNUU567hHR3bSryA6KTphN5YTiyqyV2vk/AoZ9KBr60EF5UUXxJTSAWcAGc+MqDPvLo3B0+ZDSgzFBE2e6n+Y2BnayHjbDJEsH4vAIoj9gNmXdpdEKKgnkqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HOhhFJKx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K4lv1X027238;
	Tue, 20 Feb 2024 09:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=N/CD0FCYkuZ9HzV6F9mo4RHIskjQxoogo9wDD04+oDc=; b=HO
	hhFJKxWEhxKpaWy5RYlRTyb9trEAPG+zHlhs203+JWHDL9M2WL8ec1sV5yYm0ZDN
	mDQQBJdsGfpGk/99uUPqlzdsaU5qhEXwDp+HclvLJDkSQSXVgdX3rymD43jYv9Pi
	j/VV4/8KSJl3hrf0xMoSyDjOpRAzsXmDMfGZWjmcuFS5Nbc3xfQ3P6XyisJfQ1DX
	HDoQln/TZNDvYunegYO9PEp8XZntaeuEwS0i050WeQ3zQCv+YeE2Ywfr35eo4Dvu
	SpuTfxeio+g1VW2EPXSU+4mr2WMtUPNVxaOOwNQ0C2iSgU+aT0TFfDtEFzpE2DO+
	jrWtKZSMc56BhaTTlnzw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wcnbd8f8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 09:11:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41K9Bojc018583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 09:11:50 GMT
Received: from [10.233.21.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 01:11:45 -0800
Message-ID: <37ba0703-6a15-48d5-bb07-71d0fa1c5b2c@quicinc.com>
Date: Tue, 20 Feb 2024 17:11:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] arm64: dts: qcom: add base AIM500 dtsi
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@quicinc.com>, Tingwei Zhang <quic_tingweiz@quicinc.com>
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
 <20240205115721.1195336-6-quic_jingyw@quicinc.com>
 <a429f2ab-8c6d-477c-8abc-51243523064c@linaro.org>
Content-Language: en-US
From: Jingyi Wang <quic_jingyw@quicinc.com>
In-Reply-To: <a429f2ab-8c6d-477c-8abc-51243523064c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WdMf6v_n29ENk3ZU_rbw6t4DimlbdeVl
X-Proofpoint-ORIG-GUID: WdMf6v_n29ENk3ZU_rbw6t4DimlbdeVl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=867 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402200065

Hi Krzysztof,

On 2/5/2024 8:35 PM, Krzysztof Kozlowski wrote:
> On 05/02/2024 12:57, Jingyi Wang wrote:
>> Introduce aim500 board dtsi.
>>
>> AIM500 Series is a highly optimized family of modules designed to
>> support AIoT and Generative AI applications based on sm8650p with
>> PMIC and bluetooth functions etc.
>>
>> Co-developed-by: Tingwei Zhang <quic_tingweiz@quicinc.com>
>> Signed-off-by: Tingwei Zhang <quic_tingweiz@quicinc.com>
>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi | 409 +++++++++++++++++++
>>  1 file changed, 409 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi b/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
>> new file mode 100644
>> index 000000000000..cb857da8653b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
>> @@ -0,0 +1,409 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +#include "sm8650p.dtsi"
>> +#include "pm8550.dtsi"
>> +#include "pm8550b.dtsi"
>> +#define PMK8550VE_SID 8
>> +#include "pm8550ve.dtsi"
>> +#include "pm8550vs.dtsi"
>> +#include "pmk8550.dtsi"
>> +
>> +/ {
>> +	aliases {
>> +		serial1 = &uart14;
>> +	};
>> +
>> +	vph_pwr: vph-pwr-regulator { };
> 
> What is this? Why is it needed?
> 
> 
> Best regards,
> Krzysztof
> 
vph_pwr is the power supply which differs from board design, it is defined in sm8650p-aim500-aiot.dts,
and it is used in the sm8650p-aim500.dts for regulator supply, so we leave the node here.

Thanks,
Jingyi

