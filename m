Return-Path: <linux-kernel+bounces-52276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D72849628
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB39A1F234CA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7F1125D8;
	Mon,  5 Feb 2024 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mb9wg81F"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10C912B61;
	Mon,  5 Feb 2024 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124551; cv=none; b=u4p45cYQwYCsszOlptIzr4/j1Jkcf09PMfatBGkS36SKJfTFkifnrbxsJ33qKpm5OFD3+SXtQBQ3LeIpL7AyIr1MmyTJu5g7SQxSTyJcgm10MM+Xfi6vz9D68IL4DmVM2neEDhd7Z4kGqmOsvTZKRmg0yJkzGKi+s+6X91akpPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124551; c=relaxed/simple;
	bh=TQFovvxDwF/q+H5X9EDqxuH2V4Iz/9IqPKJbhU1v3A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kfldenUTm8nRQd6o/Pb67Id00rnbkJtJ6lku1sBES3Il51LauSfkFNF6SyTjDOqkhdVF1U6ofSAcND3sorrpX13pPZty0yxJPXD/EYYV9fa+1XsHIvNVa0ARpoGg3WOt5dAgOs0HhkA28gNYHqlo7IUVlgUPbL1amUhe16bjxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mb9wg81F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4158a5Pe023612;
	Mon, 5 Feb 2024 09:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yngiMajARrIPzVmPcAVgzjYlEwIV23piF1sjvZnmHsI=; b=Mb
	9wg81F4K40k548EozbwnbXGjvZuZzpSt9OmYqWC5zbV5zKHELsz68XVYdyhP454y
	8gzcO0lAEXJKsymVJv5jZm/B5uDhDPDf/08Irtg1XGGDFqrxMuFuLz8WK/5WZy77
	mxHrvaEcudwTnsXAn7FIpaOqDL5uDAzIIfJ8msbUNNw50DXbwuF4zWUQK39FcKNN
	FOaVo3DC7GgZCwEyoxtBdyN0uBuIaZYtager1V9N+ocKo5SjMYVAjDnrOtCxLVk+
	BxyLkjyoipYm1EwpEFPXnbKkFoRLRFlRiNj+c8PlsgSzXQZKr9NGWZNkwK3ZYT03
	z6SnCjBPg3Wi/5hQhkeQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2v7282yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 09:15:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4159FW71029043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 09:15:32 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 01:15:27 -0800
Message-ID: <3ba45513-8112-4527-8314-88a8db29d201@quicinc.com>
Date: Mon, 5 Feb 2024 17:15:24 +0800
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
 <4179cecd-66dc-49c3-9564-0321bf614d99@linaro.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <4179cecd-66dc-49c3-9564-0321bf614d99@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: I_FBDNWj8Wo3DvL1XdNueXPWg4lsdx5v
X-Proofpoint-ORIG-GUID: I_FBDNWj8Wo3DvL1XdNueXPWg4lsdx5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 mlxlogscore=438
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050069



On 2/5/2024 4:03 PM, Krzysztof Kozlowski wrote:
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
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> 
> To be clear, because you keep ignoring my comments:
> 
> NAK
> 
> Best regards,
> Krzysztof
> 

Yes, I will drop your "Reviewed-by" tag, I had some misunderstand for 
your related comments in V3 patch series.


-- 
Thx and BRs,
Tengfei Fan

