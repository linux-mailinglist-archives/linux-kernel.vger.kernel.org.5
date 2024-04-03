Return-Path: <linux-kernel+bounces-129357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86524896968
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C8828622B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96A470CAD;
	Wed,  3 Apr 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hd8sqYaF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21A6CDBD;
	Wed,  3 Apr 2024 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133935; cv=none; b=nhioSGH2cn98gs8FgmF0xa1iF+gsAWtZqNsvEOGOz3FZM7PtZ7XXNCTNRDgQ3mhJwiZ5xxfy8KtEnmmIUhw9Ck8g6KxMSfeGharwMnevqWkv3uMQQLVfroNUN/UJ5yyMZTLUSi0hPXRKrma5f7lR/OX9ww1GCwu1RaCohsiMGEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133935; c=relaxed/simple;
	bh=HgxNMS/FN0Nk6FUWFDTk9f7rXSrv/Mx0j1/PjJ7OXSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PFbWr+/OhqVEE5FQrO28oFXmzybgvmRdf5WIJGq19xf+RI8gxMTLdZ+YWOK4TkfJNwMnZzH3iR5KonhOT28VmD0KTV/LsIxAl3po9wyAkDsUHq3aGHqV9jTAgdocYueXeoorPP22ZVex7FyS0Tr1DO4QHLpMvA6T5hmGNdwWtK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hd8sqYaF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43385mMS013800;
	Wed, 3 Apr 2024 08:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=U2835gZws67kNh8mPFrnxxRKQzJT+emLe1Ex3spc8EM=; b=Hd
	8sqYaFSJ89RDAavwHo35b/6Wzz3aBUViApZG2E0bAa/CUSPqN7lq8ExRM1IONGIP
	A0vq2KFOsv0rvCeMaFSRlsRQcH1f3f/eY5ihvYjnQxJ5s2nvm6gM7X2WLzgqF8G6
	ZdNzw6CTdTtMBMPgA6zfUqAgeMBFchhgYZ7iF2Z/cL8p310AqmUQXKd1CplYwQgK
	zWx7VeaLHnm5mezlzdCRhq6UrK/0YiMRbE/715SLq0cUaXaat8L2LH3zEB3XR9sT
	BLEUA2fXfq+5wLPkb3keG581StOIiKjXjMvH1dC28hwQq28eAIv0dko8NnTcTB2N
	IxqsVhiRIr0CGdbnvhAQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x93a5g34g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 08:45:29 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4338jTjA028371
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 08:45:29 GMT
Received: from [10.50.19.131] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 01:45:23 -0700
Message-ID: <91f59477-1799-4db6-bcc2-3f0c5225d1c8@quicinc.com>
Date: Wed, 3 Apr 2024 14:15:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] interconnect: qcom: icc-rpmh: Add QoS
 configuration support
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>
References: <20240325181628.9407-1-quic_okukatla@quicinc.com>
 <20240325181628.9407-2-quic_okukatla@quicinc.com>
 <d59896bb-a559-4013-a615-37bb43278b2e@linaro.org>
Content-Language: en-US
From: Odelu Kukatla <quic_okukatla@quicinc.com>
In-Reply-To: <d59896bb-a559-4013-a615-37bb43278b2e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Fm8W6r0cBbMxBDjwmb2VUgfbVnbKZ-N2
X-Proofpoint-ORIG-GUID: Fm8W6r0cBbMxBDjwmb2VUgfbVnbKZ-N2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_08,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=900
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030060



On 3/27/2024 2:26 AM, Konrad Dybcio wrote:
> On 25.03.2024 7:16 PM, Odelu Kukatla wrote:
>> It adds QoS support for QNOC device and includes support for
>> configuring priority, priority forward disable, urgency forwarding.
>> This helps in priortizing the traffic originating from different
>> interconnect masters at NoC(Network On Chip).
>>
>> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
>> ---
> 
> [...]
> 
>>  
>> +	if (desc->config) {
>> +		struct resource *res;
>> +		void __iomem *base;
>> +
>> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +		if (!res)
>> +			goto skip_qos_config;
>> +
>> +		base = devm_ioremap_resource(dev, res);
> 
> You were asked to substitute this call like 3 times already..
> 
> devm_platform_get_and_ioremap_resource
> 
> or even better, devm_platform_ioremap_resource
> 
> [...]
> 
>> @@ -70,6 +102,7 @@ struct qcom_icc_node {
>>  	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
>>  	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
>>  	size_t num_bcms;
>> +	const struct qcom_icc_qosbox *qosbox;
> 
> I believe I came up with a better approach for storing this.. see [1]
> 
> Konrad
> 
> [1] https://lore.kernel.org/linux-arm-msm/20240326-topic-rpm_icc_qos_cleanup-v1-4-357e736792be@linaro.org/
> 

I see in this series, QoS parameters are moved into struct qcom_icc_desc. 
Even though we program QoS at Provider/Bus level, it is property of the node/master connected to a Bus/NoC.
It will be easier later to know which master's QoS we are programming if we add in node data.
Readability point of view,  it might be good to keep QoS parameters in node data.  

Thanks,
Odelu




