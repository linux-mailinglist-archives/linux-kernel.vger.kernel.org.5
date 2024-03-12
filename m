Return-Path: <linux-kernel+bounces-100479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5279687986C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E661C20DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7C57E107;
	Tue, 12 Mar 2024 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EsqAGnyx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E656B92;
	Tue, 12 Mar 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259012; cv=none; b=d5kQMCnpk89CfIoM/suguiqS9NZwpM7sgZGWd+xmDrIoJqRmKvKmnC6fULSk/ttJCRv9mu8S9n4OKNb0HiFhar9nS/qNSbuJ4HAHcodhm2FM5rIJn6bQsgpJdJFKECmZPr89ZMBHdFuDMdddws1hf46UqcAxZjllTvqvscdDuy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259012; c=relaxed/simple;
	bh=25hitkHPC+cPp0r/xTw+/oIvTg6l/cE+n8jeN5uFNYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qu5tRZ0C0u4vTtdqFr5ifJo4NBTIOIInLCNyKdJaTne2QsTfXDiOOaKNYqgPsh0n0QQGLCfHiLrw+RQuBVfPzBRxbZLb6pLpkoCeoUPpuWEs+pVKqRu7U8fWSicsNFW2D514BBN21FpemkID7YY4QeOC5Te+BygV9ARyjG6HPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EsqAGnyx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42CDK4Wo023716;
	Tue, 12 Mar 2024 15:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1YlsY/ilBE8aLCLHhyjoBU/kKMHjrbkitE5f3BGFnbU=; b=Es
	qAGnyxV5DiUyPTdWkWwDNmnK6UH4CJndHhxmpOOLXp5OCl68aqqo9ISib1gWruEq
	3kHkqvZkAZDxUPSf+aPuqYDcJJfq+MUsxccP3NRMQxaWDxeCBZ+i3jmv3pgJrPJ9
	w/qxehzpuazqdLnc3oSd1E0NqHKK9r5UtwHZnfm0sZj4CbqRl+G2TcDtdofhcY/4
	AQ4GYbatjKRsK5Srh+ZP6EW94MtlmK5PdEZQ/FFr1zhWSQWKCFofv6314EfoBQg0
	8LzLO6VmWQCOYxPe7sCYiGekgXkkQ2u1Q4VJKJ23374xYQxyDOQCEuUSjMAZlnz0
	qf0K3Goz0excLqh0Ll8A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtgc3hbyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 15:56:31 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CFuUgd024103
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 15:56:30 GMT
Received: from [10.110.120.226] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 08:56:29 -0700
Message-ID: <793c269e-be90-d952-8fae-29fd0a84339a@quicinc.com>
Date: Tue, 12 Mar 2024 08:56:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC 0/3] Enable firmware-managed USB resources on Qcom targets
Content-Language: en-US
To: Sriram Dash <quic_sriramd@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <quic_wcheng@quicinc.com>, <Thinh.Nguyen@synopsys.com>,
        <p.zabel@pengutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_psodagud@quicinc.com>, <quic_nkela@quicinc.com>,
        <manivannan.sadhasivam@linaro.org>, <ulf.hansson@linaro.org>,
        <sudeep.holla@arm.com>, <quic_shazhuss@quicinc.com>
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RkHZJzLiAumKIH5dzEi__NUrUzrZFy6J
X-Proofpoint-GUID: RkHZJzLiAumKIH5dzEi__NUrUzrZFy6J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=881 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120120

On 3/5/2024 8:57 AM, Sriram Dash wrote:
> Some target systems allow multiple resources to be managed by firmware.
> On these targets, tasks related to clocks, regulators, resets, and
> interconnects can be delegated to the firmware, while the remaining
> responsibilities are handled by Linux.

What is some target? What does "target" means? 

-- 
---Trilok Soni


