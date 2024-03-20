Return-Path: <linux-kernel+bounces-109254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B59D8816D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF3D1B240D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2AF6A8A8;
	Wed, 20 Mar 2024 17:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PK6+CDNg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32156A328;
	Wed, 20 Mar 2024 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957106; cv=none; b=gVeQgwuXdJVRoO9/AciB/BM8D8P4jD7LPm/CNVZIoJ1JoCpyHVWWSe0VpNdJ/p399DUQkNCanJIeWjEWflBgim339FexqyBkI5doWZ/UkvNT0J7T7hm+zHkvQq6mAi8E0/mXHPs8QLqUtfsJk87+fTj3bKAFK9tbIHhNAqTSjao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957106; c=relaxed/simple;
	bh=7P9/QmCE6aFpaJaS1PUe07j2hYnFfS9cQcuIjDTZTdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b/Rc12mKeUMosvJmmGB7TJEq7l52U48jYv4LsCzjFXXmrS0w9yg8TheTFEzxZ+XaAeuIOTXIT9GLRWkYzFTNxLZclK9/Gx9UZQ7W907966j8nn6EevGO0KEakxqxtWpBdH4OQiBc3xqfz2pCjwFSvwPJdG5jcH7Qhsuk3Aqlnfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PK6+CDNg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KEjTnn002692;
	Wed, 20 Mar 2024 17:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dnF/28aEJAK6SVvxp6/SCXZUMZnyDVgEXCoYQhgJ6Jw=; b=PK
	6+CDNg+Sggj3+GwbvJlLvD/BRM80kx2LUPWAcFjxg7goG/Dj8QzBKfv6v1MxxBzp
	/i1BC/bVyMKC1cSHCySGYcf3iOHhQdX1qZVVZ4eLDnFns3tgDo+sEDNe6al6MEjs
	W2wqJGxhRRRS8K0VH9koUVtQ6rK5fG6LMYVrvvw6QaDr0HsW3Z84dvcL9ffKVSm0
	fJISW0a7G7WP15jfjhoFyHTEq6Jj/Kad2qV45Sj2GBFTWkM4RpofpBKAjdSuP6z5
	tDXN0AFLzfpySzmQf5fC2ff/Uf3x3VmYFrFy68AxE+1aXbVc8AGnSVp5uJRfRLK/
	UilN/FzyY8M7URn5lnTA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x01br8jfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:51:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KHpbff005008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:51:37 GMT
Received: from [10.50.49.240] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 10:51:32 -0700
Message-ID: <e9b6be31-567d-47c2-9cfa-282c8cbcdcf7@quicinc.com>
Date: Wed, 20 Mar 2024 23:21:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] interconnect: qcom: icc-rpmh: Add QoS
 configuration support
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
References: <20240306073016.2163-1-quic_okukatla@quicinc.com>
 <20240306073016.2163-2-quic_okukatla@quicinc.com>
 <e7105dd7-68ff-4af6-b91e-56b6e50ff949@linaro.org>
From: Odelu Kukatla <quic_okukatla@quicinc.com>
In-Reply-To: <e7105dd7-68ff-4af6-b91e-56b6e50ff949@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7uw4oJ0Hl5MHsnHWtxf62MH-P5WfCojg
X-Proofpoint-ORIG-GUID: 7uw4oJ0Hl5MHsnHWtxf62MH-P5WfCojg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=910 lowpriorityscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200142



On 3/6/2024 2:01 PM, Krzysztof Kozlowski wrote:
> On 06/03/2024 08:30, Odelu Kukatla wrote:
>> It adds QoS support for QNOC device and includes support for
>> configuring priority, priority forward disable, urgency forwarding.
>> This helps in priortizing the traffic originating from different
>> interconnect masters at NoC(Network On Chip).
>>
>> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
>> ---
>>  drivers/interconnect/qcom/icc-rpmh.c | 105 +++++++++++++++++++++++++++
>>  drivers/interconnect/qcom/icc-rpmh.h |  32 ++++++++
>>  2 files changed, 137 insertions(+)
> 
>>  
>> +	if (desc->config) {
>> +		struct resource *res;
>> +		void __iomem *base;
>> +
>> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +		if (!res) {
>> +			dev_warn(dev, "Skipping QoS, failed to get resource\n");
> 
> Why is this a warning? If the MMIO is not required, your driver should
> not spawn warnings.
> 

Right, it should not be a warning, will clean it up.

> 
>> +			goto skip_qos_config;
>> +		}
>> +
>> +		base = devm_ioremap(dev, res->start, resource_size(res));
> 
> Combine these two (there's a helper for that).
> 

I will address this in v4.

>> +		if (IS_ERR(base)) {
>> +			dev_warn(dev, "Skipping QoS, ioremap failed: %ld\n", PTR_ERR(base));
>> +			goto skip_qos_config;
>> +		};
>> +
>> +		qp->regmap = devm_regmap_init_mmio(dev, base, desc->config);
>> +
> 
> Drop blank line.
> 
>> +		if (IS_ERR(qp->regmap)) {
>> +			dev_warn(dev, "Skipping QoS, regmap failed; %ld\n", PTR_ERR(qp->regmap));
>> +			goto skip_qos_config;
>> +		}
>> +
>> +		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
>> +		if (qp->num_clks < 0) {
>> +			dev_warn(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);
> 
> dev_info(), because current binding sais clocks are not required and you
> are not allowed to affect ABI. While ABI here does not look broken,
> spawning new warnings to proper users is not welcomed.
> 

I will convert it to dev_info() in next version. But qp->num_clks = 0 if clock property is not added, so it does not spawn warning.
will move all other dev_warn() to dev_info().

> Best regards,
> Krzysztof
> 

Thanks,
Odelu

