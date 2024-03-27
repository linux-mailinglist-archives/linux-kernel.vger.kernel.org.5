Return-Path: <linux-kernel+bounces-120767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D699B88DCC2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C065B238B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986AE36138;
	Wed, 27 Mar 2024 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GNUi/WB5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033658131;
	Wed, 27 Mar 2024 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711539766; cv=none; b=MbLk2gnBiGoCy0nBSFyfhHeBMOch6qLkqCS73H/jV9Wu6qR5GH16BYtcceFS+a3oT7ro3FuWR99tXWm7n3AT5v6RIsIb8uo+Sw/8CCfyMVuK28jogCuQ2cAkRHj3rzvXku87bq1x8+gaH21bjvhH7gVxLrbFCfpLzvgzZYwDnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711539766; c=relaxed/simple;
	bh=jKerGuDBFpQHbzKd+ZNzzf/kDL+W5sx53L+ccsWbyuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XyVVEviq8LbqpHGVgDLBtsKAv+e/dvJTwZ8c/N6jn6Z9yx1Pk2NGwO/teW90ErIybew3wG/QaLgfeD9aQD2HMgdG9V21+GfqE8rbR7TzSiOLoWSb9AUUSjbvz7vvm58ILlx5MAZeIRZdskcrkW7N7T6Hu5FD6wBR2bWiLyqk45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GNUi/WB5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RARhUZ027583;
	Wed, 27 Mar 2024 11:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IRzo6j6PI/VAljRrgfvgQpUyrCe4gj1qQNWtNSI1tYU=; b=GN
	Ui/WB5ygXp2ctlzQrYTpAy8H1RRWqvFzIGyPHSAtDIuHBAcLvLLr2zyiBE6Z+a4P
	JLa1qm6aKFlE+fhnxfV/0pSHmaSe5G+fu8EFkLCJtULjGkAv67x1RzckQSSwVhcr
	frYf4DwgwQ6f/Gf+qed7ZBRsNkKlvD/1+VDrvq07LP9nIewGf1ZIBKt5osL0+HWk
	nBVs8vpD3e4JnyB7eUOcGtrSAk+fH3FsDqeKZKAuAdsT9rnDA5zs8s8Bwo1Du6fV
	gGa6NqzWi/QloK1Pp3sEQCd6fZEzo+IWAwu0CtjAVuvlQk4KS9nma3KwKhZAToGI
	p7XV6DKipgRr7yCjkwmw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x47839k5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 11:42:34 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42RBgXJE009973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 11:42:33 GMT
Received: from [10.50.35.38] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Mar
 2024 04:42:28 -0700
Message-ID: <1e1fcedb-d001-4883-9046-58f3933ff185@quicinc.com>
Date: Wed, 27 Mar 2024 17:12:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] interconnect: qcom: icc-rpmh: Add QoS
 configuration support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Georgi
 Djakov" <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>
References: <20240325181628.9407-1-quic_okukatla@quicinc.com>
 <20240325181628.9407-2-quic_okukatla@quicinc.com>
 <d59896bb-a559-4013-a615-37bb43278b2e@linaro.org>
 <73e5a697-2eb4-45d3-84eb-60401ea10cc1@linaro.org>
Content-Language: en-US
From: Odelu Kukatla <quic_okukatla@quicinc.com>
In-Reply-To: <73e5a697-2eb4-45d3-84eb-60401ea10cc1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2yAyAHPi8QB0wCAF0w1KJLEba2MA0PaQ
X-Proofpoint-ORIG-GUID: 2yAyAHPi8QB0wCAF0w1KJLEba2MA0PaQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270079



On 3/27/2024 2:14 PM, Krzysztof Kozlowski wrote:
> On 26/03/2024 21:56, Konrad Dybcio wrote:
>> On 25.03.2024 7:16 PM, Odelu Kukatla wrote:
>>> It adds QoS support for QNOC device and includes support for
>>> configuring priority, priority forward disable, urgency forwarding.
>>> This helps in priortizing the traffic originating from different
>>> interconnect masters at NoC(Network On Chip).
>>>
>>> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
>>> ---
>>
>> [...]
>>
>>>  
>>> +	if (desc->config) {
>>> +		struct resource *res;
>>> +		void __iomem *base;
>>> +
>>> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +		if (!res)
>>> +			goto skip_qos_config;
>>> +
>>> +		base = devm_ioremap_resource(dev, res);
>>
>> You were asked to substitute this call like 3 times already..
>>
>> devm_platform_get_and_ioremap_resource
>>
>> or even better, devm_platform_ioremap_resource
> 
> Yeah, I wonder what else from my feedback got ignored :(
> 

There was a misinterpretation of your comment from my side. Got it now, I will address this.

> 
> Best regards,
> Krzysztof
> 

Thanks,
Odelu

