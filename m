Return-Path: <linux-kernel+bounces-103095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262F187BAEF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA55F283439
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBBC6E5E9;
	Thu, 14 Mar 2024 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CoIYsKde"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11F74316C;
	Thu, 14 Mar 2024 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410760; cv=none; b=rmSnFE1Y4UYUbk6qdQ/9zCNiLNFGX5cjMg2G7Pw4cjhaV+Zd8yTV3M2+vBQnuhQWtEXF/T8JwsCFIjLExpOJ53W8m+6IpmfMHsAv1q/KEu47afk1UQ/sWCTeG8MFc0cWT3/JNtrDuNbb36hl4cF7C2My+ziPUfDDgSDLVaHWCsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410760; c=relaxed/simple;
	bh=7mB2JnIdpmcSJsN5iVWqHsXaAySy9mcR8ZFwsrjpQNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lUrMJuogHYtqzxEWVCTx6EGh6egXm56V2IhK7Tigdvo7u5A3pKBiskkeiQOe8CxXWrxN3bioZqfo34H17B0XCk+h0xDKN9YS7fBZbwz87fnZiDKKCDBCBs2TdXb8GfZ2kc5QGFM9h6LvDaj/oEoFxXIf/+Tj6vVvoopBWI3d2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CoIYsKde; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E8smqd008062;
	Thu, 14 Mar 2024 10:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YyRQiJXUC2Ui/xsufHD0TLY/D6sdIuy37IAVbcOczLc=; b=Co
	IYsKdeZJaX8e/A24XBGgD87V+GnFQYhYqNADLzdUzOkEQFhdTn/6mHLduLKibjQy
	GrFxuepJ262gudxy65NjnsP881c/RH3t+rK53rC36jNpPRC+2UqNgH25KoCYXAf9
	Z6F8821oHkvPrUtepKHGy62qqiK2G7dzpCGBn5jYzt/CPzoR+XK2OoQpcvSGsn4I
	cIRupbRVyP6KNpd8CHyAH1j4bpHzBL9HRvX98WiiSCYcI7QfbAFxfSkXq+9KPP4+
	MRlGkVhzrevbpEch7joKXuM6koOFI28Sem9KT7iV5X3GhBlsyAMXvXLEo9bYgY+u
	uajWJs2n3iXqbxrifO7Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wux4u04ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 10:05:53 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EA5qqc000914
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 10:05:52 GMT
Received: from [10.239.29.49] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 03:05:46 -0700
Message-ID: <88c32ccb-fadd-49e8-a8fc-76f93353d204@quicinc.com>
Date: Thu, 14 Mar 2024 18:05:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: Add three missing
 fastrpc-compute-cb nodes
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <quic_ekangupt@quicinc.com>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240314063334.31942-1-quic_lxu5@quicinc.com>
 <c7ac2b10-eee3-4269-85e4-a68d24c2337a@linaro.org>
Content-Language: en-US
From: Ling Xu <quic_lxu5@quicinc.com>
In-Reply-To: <c7ac2b10-eee3-4269-85e4-a68d24c2337a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -nSgWU4yaUF8myQvixTBJamdT616lfuu
X-Proofpoint-ORIG-GUID: -nSgWU4yaUF8myQvixTBJamdT616lfuu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_08,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=990 phishscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1011 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140070

在 2024/3/14 14:55, Krzysztof Kozlowski 写道:
> On 14/03/2024 07:33, Ling Xu wrote:
>> Add three missing cDSP fastrpc compute-cb nodes for the SM8650 SoC.
>>
>> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 29 ++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> index ba72d8f38420..c238ad1be0d4 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>> @@ -5084,6 +5084,35 @@
>>  							 <&apps_smmu 0x19c8 0x0>;
>>  						dma-coherent;
>>  					};
>> +
>> +					/* note: secure cb9 in downstream */
>> +
>> +					compute-cb@10 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <12>;
>> +						iommus = <&apps_smmu 0x196C 0x0000>,
>> +							 <&apps_smmu 0x0C0C 0x0020>,
>> +							 <&apps_smmu 0x19CC 0x0000>;
> 
> Lowercase hex. Please look at the code above, don't copy downstream
> code. This applies to all your work: don't send us downstream code, but
> clean it up from all of its problems.
> 
> Best regards,
> Krzysztof
> 

Hi, sorry, do you mean that I should delete this line: /* note: secure cb9 in downstream */?
All I sent are upstream codes, I didn't copy cb9 here and I also see this commented line in sm8550.dtsi.

-- 
Thx and BRs,
Ling Xu


