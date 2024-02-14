Return-Path: <linux-kernel+bounces-64674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4684D854156
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAFB1C267C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F899474;
	Wed, 14 Feb 2024 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hCTuTGmZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E2C8F40;
	Wed, 14 Feb 2024 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707875028; cv=none; b=G55QQZi7rYG+NLdO3J9MkOtECgwKZXTuubrEu6SMhT+QS/CqU5MwMztqGXF1n7nwKapVGX6UF/qXSoSXkLBDyP+4RndWyWEmnQ27r130ilLivq2PDjX8MFtKc2hr60nGjvxcdv1wqTHxQZ3LLvL7d1t5cHSLGaOhftda3RnLW4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707875028; c=relaxed/simple;
	bh=I5ZfUF1YSblSmzuscamdi26822vsk7E/SinkXoVdgaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XecuxnJuM4D59uSHMGlqVtRPrU4IDEHFlXSPPSSQbIAzgry6z5Av9CU/Q2+rnv4Yah8rsoku2iObVgzDou/d3LB4fy4Lttx3PBwItyCQmrhuMXU5s7M/BiePlDfLZyPRkNrjdZQr0aIgWBFd38FIJLfQVKNJLewmYDAp5/AkHnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hCTuTGmZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41E0kEdO016909;
	Wed, 14 Feb 2024 01:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BEnjXFrY8jtJX8MYamsZGbWdMnQoTXuJ9G4KYZH+VhE=; b=hC
	TuTGmZpZBxYreXBu7VPXdRKnhN0qWCVjxUWCILmd6sD9KQ7K+9lszoHGKZ00i7j2
	KXiV+k2apjUFa7H4j0Ed7gIOdMTmV77aBdpglI+RVfa4R2n/ahBtxZsPC1FQlhpW
	42Lx0NC1FukpycgswKM0NsKKebMhis0+kzi/MCPsIHRUXZxXBhS/II/hvLnsuTvu
	MBR3NLD+k4Ow1nzVXLf8IPMvcRFAB7888jkEaL29j7Mevzz6r+M/4jw9Z31L8Lbx
	fKaD7PzPqyZ5JQkdUYjVzMpZ2KnPRuIR6Ai6ZOgIADR/3bPp248CyiNJcfM1tl3p
	HtJJYS+AE/WO4sKJC31A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7wfyaq69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 01:43:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41E1hXjh004907
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 01:43:33 GMT
Received: from [10.253.37.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 17:43:29 -0800
Message-ID: <a062ce8d-638a-4a33-8afa-45ad47efcd72@quicinc.com>
Date: Wed, 14 Feb 2024 09:43:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: qcom,coresight-tpdm: Rename
 qcom,dsb-element-size
To: Rob Herring <robh@kernel.org>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Tao Zhang <quic_taozha@quicinc.com>,
        "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240213160521.15925-1-quic_jinlmao@quicinc.com>
 <20240213160521.15925-2-quic_jinlmao@quicinc.com>
 <20240213222957.GA2502642-robh@kernel.org>
Content-Language: en-US
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <20240213222957.GA2502642-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JWqlbZDNFU-HbvuqF1yX0KIYXy_l84lL
X-Proofpoint-ORIG-GUID: JWqlbZDNFU-HbvuqF1yX0KIYXy_l84lL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=847
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402140012


On 2/14/2024 6:29 AM, Rob Herring wrote:
> On Tue, Feb 13, 2024 at 08:05:17AM -0800, Mao Jinlong wrote:
>> Change qcom,dsb-element-size to qcom,dsb-element-bits as the unit is
>> bit.
> That may be, but this is an ABI and you are stuck with it. Unless, you
> can justify why that doesn't matter. (IIRC, this is new, so maybe no
> users yet?)

Hi Rob,

Because for CMB type, it uses qcom,cmb-element-bits. So I change the 
format to be the same as
CMB.

Thanks
Jinlong Mao


