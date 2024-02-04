Return-Path: <linux-kernel+bounces-51448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37C4848B5E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2CD28599B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39298749C;
	Sun,  4 Feb 2024 06:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FEeRpyl0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39476FA8;
	Sun,  4 Feb 2024 06:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707026601; cv=none; b=rsTZzJ9AZijpHXl4/FWXwhLpGggAoQ/SQ6sBvHOqQ2Es8xY2r05PBS1bd9j7Jj+jBCXlrpOZw9ChOHo8nB9nNx4ll97ZoEwm3awOeKhvqjYN/1MSy6vqJLp0V+cDt90W8VMBufJpMeDffm7KDl8tnN1vX1iZ8CafPUJYyAX1LME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707026601; c=relaxed/simple;
	bh=DsSd6mK7iEDXY6OL8SEJLUhssTx3i/oRdOxh3YceDos=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MlEsKSiePNsL7EGpANVO+K3d9NwYa15/w/TaF5u44yd9GFgSXH1V5vhuDKo376mgTY1Qq+vF3rUzfnl/aY26cWs3S0/2lKC0uBmPS7KBeZf5mlhv629HLPerqV+2+CzS/z4FT44zelumIX6ppPlA5vT6BOCKIOkwfBU/SyazqQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FEeRpyl0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4145rSJO017362;
	Sun, 4 Feb 2024 06:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eka4mw5ED9BcfCWkk+CNjYr9R1rbWtj99uP9IFJDgtY=; b=FE
	eRpyl0NhgDDAK1PI7TNtLf95GJNJZcwm9oY8NkYdf93FqgM+etqnIl5NshQr4sM+
	XKZdBIHm8/pFxiVg8qI1KL+8vT7X3QxMvqwlxO/o+p+hBMwVlgaKMmP3ZM0DZ4fW
	32ZobDSsneGnN5lfJ4PZPVx2fH/hHCWlEwF+6osQ8PW0gOAvWI7dTgGHQJgdmJgi
	hZkD+2KuTukpgb4zBlhccY8MH8HFVQFBPRRzmVyJ85v5vGaoCMMc/cX5oqW0zRLd
	J04fD6QH5Ap13tMNOh+okepb+pz1Y/RF9aZNPHADiF03+G6QU+mhEdOyP1TboWYN
	NANBL8MbxSYO+EuoudqQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w1f22hc5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Feb 2024 06:03:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4146321x015047
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 4 Feb 2024 06:03:02 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 3 Feb
 2024 22:02:57 -0800
Message-ID: <be5b0a56-7e19-4cb1-b3e9-23a33f525bda@quicinc.com>
Date: Sun, 4 Feb 2024 14:02:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: arm: qcom: Document QCM8550, QCS8550
 SoC and board
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
 <20240119100621.11788-2-quic_tengfan@quicinc.com>
 <7e7bc8ba-f349-47f5-b6ba-6594edccaaa8@linaro.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <7e7bc8ba-f349-47f5-b6ba-6594edccaaa8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 75AyYclDClG8UYlN6jWeoEjGqWt_E1zS
X-Proofpoint-ORIG-GUID: 75AyYclDClG8UYlN6jWeoEjGqWt_E1zS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-04_03,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=894 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402040044



On 2/2/2024 10:34 PM, Krzysztof Kozlowski wrote:
> On 19/01/2024 11:06, Tengfei Fan wrote:
>> Document QCM8550, QCS8550 SoC and the AIM300 AIoT board bindings.
>> QCS8550 and QCM8550 processor combines powerful computing, extreme edge
>> AI processing, Wi-Fi 7, and robust video and graphics for a wide range
>> of use cases for the Internet of Things (IoT). QCS8550 is a QCS version
>> for QCM8550. Modem RF only in QCM8550 but not in QCS8550.
>> AIM300 Series is a highly optimized family of modules designed to
>> support AIoT applications. The module is mounted onto Qualcomm AIoT
>> carrier board to support verification, evaluation and development. It
>> integrates QCS8550 SoC, UFS and PMIC chip etc.
>> AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> I want to unreview it.
> 
> Please fix your commit msg to drop marketing and instead describe the
> SoC. I don't see for example any explanation why there is qcm8550 and
> sm8550. Aren't they the same?
> 
> 
> 
> Best regards,
> Krzysztof
> 

qcm8550 and sm8550 are different, they have different firmware release, 
qcm8550 related board dts will be pushed to upstream once it is ready later.

I will update commit message to introduce the different between qcm8550 
and sm8550.

qcm8550 introduce link: 
https://www.qualcomm.com/products/technology/processors/qcm8550

-- 
Thx and BRs,
Tengfei Fan

