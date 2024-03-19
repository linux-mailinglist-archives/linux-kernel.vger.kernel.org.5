Return-Path: <linux-kernel+bounces-106977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC79987F63B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D0E1F228C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2427C08F;
	Tue, 19 Mar 2024 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TK2SfL2h"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44FB7BAF5;
	Tue, 19 Mar 2024 03:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710820722; cv=none; b=ZMTVz0sKqHKZPTID/KCWil5oIo/M3TY6JrDL4WBJIGuo6IXD20QJhquksy7dByAjJ2dWSFiGrv2H8XyqCh+qKuhmFKsTn44TRUSw86Z9mM/8tmOlSrGFliwXqE/daf63mMKFiuxSPP9HtIm6aIgwCKRnDjA/nO/Tl+m7HciIPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710820722; c=relaxed/simple;
	bh=WprPGVkUxnwMHpWptObWu8i8DatoMRmFS/OAtPMxg/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=No28IJVe3kf2uMuJYiXg5N2wAyiOGYBvM1T0d+iEICoMNXClp/9NnFtMgy/cA9z8CDVy4AAaLWs6tLFjFm+PycS0Gvm2NCi7aR0xz5i5fzhTr1CVQtkouLCgwm6jfPc/v89r3TyCoJIQV88wPjwwEfx2c9DhNnrlYV8fM0sb1co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TK2SfL2h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J1jMDa020712;
	Tue, 19 Mar 2024 03:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OxTFjw4v7lk1ZxLMOoWzf8UcQQ1J32etgcnwEqlMBkM=; b=TK
	2SfL2hgnM1CFb0WL7n6QG3TAPOA5oauWxLkka6wmorIaHF7b5qqcayxs6gHlAO4E
	QxCoiv1W08tnMjZ1mphFD6P/vbM4tojdKy38Bc2MCAX3KoSJRejNTbSEDYfYrEkC
	0ncQYaUPxR/IUETOBYgVQCRRyl2oGT4HKANCMu/Bk97+khZSsp/hDqa+/+cVjNIj
	wdeahQ5UtUsH69a9nHHzcHH16RIITFpKje5pq8PxOOS6k8omYKFsKHv7BtStHEnc
	45o3din6f6314dJ+C9IvvDqPcUfxLo7UXXxBOcIYSCFIFbSCds1NtsaFDQw4p2/Z
	g/sFrlj/WKJjlZeKM1RA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wxt7d109b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 03:58:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42J3wZuo021764
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 03:58:35 GMT
Received: from [10.110.125.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Mar
 2024 20:58:34 -0700
Message-ID: <72a066f9-864d-deb4-7880-781558d59d6f@quicinc.com>
Date: Mon, 18 Mar 2024 20:57:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/5] dt-bindings: pinctrl: qcom,pmic-gpio: Add PMIH010x
 and PMD802x binding
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_jprakash@quicinc.com>
References: <20240314200419.4733-2-quic_amelende@quicinc.com>
 <20240314200419.4733-6-quic_amelende@quicinc.com>
 <5e317ad1-d473-423a-b85e-2f64a37f7d0d@linaro.org>
From: Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <5e317ad1-d473-423a-b85e-2f64a37f7d0d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E5twTZfHeozozWLMfwK_hV-cHzfPVPJ2
X-Proofpoint-GUID: E5twTZfHeozozWLMfwK_hV-cHzfPVPJ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190029



On 3/14/2024 2:20 PM, Krzysztof Kozlowski wrote:
> On 14/03/2024 21:04, Anjelique Melendez wrote:
>> Update the Qualcomm Technologies, Inc. PMIC GPIO binding documentation
>> to include compatible strings for PMIH010x and PMD802x PMICs.
>>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>  .../bindings/pinctrl/qcom,pmic-gpio.yaml      | 20 +++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
>> index 2b17d244f051..5cc04c016b25 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
>> @@ -57,10 +57,12 @@ properties:
>>            - qcom,pma8084-gpio
>>            - qcom,pmc8180-gpio
>>            - qcom,pmc8180c-gpio
>> +          - qcom,pmd802x-gpio
> 
> Is the "x" some sort of wildcard or actual PMIC model/version name?
> Wildcards are in general discouraged.
> 

"x" is being used as a wildcard here so can update with actual PMIC version
in next version.

Thanks,
Anjelique

