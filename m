Return-Path: <linux-kernel+bounces-61601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC8B85141B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FF5DB22A62
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC403A1C6;
	Mon, 12 Feb 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nOXXUsqJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BED03A27E;
	Mon, 12 Feb 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743275; cv=none; b=JQW1f3ebMxO6yjoBUwSahofH0Suj/6WRwOE5MANCoxV+EoJYbkU1VMjMG23vsPTAJlVYNx59+IeB7TpEPuDQfXM/g1q0LHMH1hUxdJ7Og5OtNnNJLT98V1qV67+Lwc1yW+Wt+VsnqMtQa8TQ2phpOWkDqwujXHWsqK/tdcvvPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743275; c=relaxed/simple;
	bh=qrgBY23QM4zj6ednu4Lq2gWZfraf6Q6XTHqkUa5h2FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m9nyzxrxzXYqKHnpO0TR414+pTPIi1yH45GWD7wpbGNRP8Kn127dk9k9UXUxrd/2godmN0aRBFggtUT1Xzr1kHgODPPW5dsunK+GhCBy/u5+h6zgKI1td08cFrqq4dgufMc/i2XetnW5z3JjLkZa9k6KTaahivh68WDpEJ6LgIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nOXXUsqJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CBcBqv015751;
	Mon, 12 Feb 2024 13:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1C0D0+yZHzwhmaYTig1IjP7ZQ4QWStZ4tDGurBk9Md8=; b=nO
	XXUsqJTIizCfirQjIhfMdY7ckDkKYG4hNNWgUI24gTkm2We0Za7un3Z7bqkSGLoi
	5gRmohJMyga9qCK6Paz5XfM8UsbsTmaIpkBSJPyNXyFKRpvdjClO5IbFEpN/7Rlv
	22eNvHOeu19cLTZXul+CWDxiLIZzlcgc0hCT6TDSkP8Cf9WSfIuSbTLiPFIUVKmd
	f3NGUGT6LI63QFO7XtBbTlM3gUYvPhCrNQXW0fxRWz2uie8ZujJQqlVx1zvM7M/N
	NcBGuxlCkNDXPjpuJs1lcjX4Ck0cv8p+7i65bzye3Yq2C5WwIJeTuNiE/+flYyD2
	IIpKspfb5nNcn7vwZ8eQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62n03f1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 13:07:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CD7nYa008570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 13:07:49 GMT
Received: from [10.216.29.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 05:07:44 -0800
Message-ID: <faadd3c9-e6e0-4042-812b-fa4287826f70@quicinc.com>
Date: Mon, 12 Feb 2024 18:37:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: clock: qcom: Add video clock bindings
 for SM8650
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Taniya Das
	<quic_tdas@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Ajit Pandey" <quic_ajipan@quicinc.com>
References: <20240206113145.31096-1-quic_jkona@quicinc.com>
 <20240206113145.31096-2-quic_jkona@quicinc.com>
 <cf0bc574-f120-4f0c-926d-1cd6c353289d@linaro.org>
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <cf0bc574-f120-4f0c-926d-1cd6c353289d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5aTDRkBqOgnmPiq1UlBy560bpy6PVAEm
X-Proofpoint-ORIG-GUID: 5aTDRkBqOgnmPiq1UlBy560bpy6PVAEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_09,2024-02-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 mlxlogscore=928 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120100



On 2/8/2024 1:49 PM, Krzysztof Kozlowski wrote:
> On 06/02/2024 12:31, Jagadeesh Kona wrote:
>> Extend device tree bindings of SM8450 videocc to add support for SM8650
>> videocc. While it at, fix the incorrect header include in sm8450 videocc
>> yaml documentation.
> 
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 

Thanks Krzysztof. Sure will take care of this in next series.

Thanks,
Jagadeesh

>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> ---
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

