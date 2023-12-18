Return-Path: <linux-kernel+bounces-3490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB04816D00
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A480C281283
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AD849F6F;
	Mon, 18 Dec 2023 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GGUnoiL/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A148CF9;
	Mon, 18 Dec 2023 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIBVlKo008711;
	Mon, 18 Dec 2023 11:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6rQzpbXWgglrouGjflZgoxRgWts4Avoi6kZbZQLIY7w=; b=GG
	UnoiL/5vC4rYdgFvYefMJm3J54o5l9xpU2atPF8V8UQNPK+AN3YGckSoJIwF/Vyc
	ROQQRVap7gfjZ77MnIEOrblxtSDHG9N8Tc0Xfg3Eui0ghZMeauvYQYlKtqXTH19H
	7hYgc7dGROAkzuI2lQWoMq6UAZQhAoZh09qI6SbL+7hdjwIaxU+xosSxEno4Gsic
	/4Zmn3wF3AxczEqZD7wMt/Jc0HA3WXt9tUvMZUsJpOt7GuEw+MMq43a3JEJdySEW
	WIkjvfpy6jRE+ZdF54FyzdLzS7dBZ9kn5/iKt8I9ySTX6ZqJKX/yvFACWn4DrSHu
	73ihFi338ZWiUwj2NQoA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14xy44nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:44 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BIBeh43028609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:43 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 03:40:36 -0800
Message-ID: <281a46c1-ce2a-4986-8562-878c7267efd0@quicinc.com>
Date: Mon, 18 Dec 2023 17:10:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <jsnitsel@redhat.com>,
        <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <qipl.kernel.upstream@quicinc.com>
References: <20231215101827.30549-1-quic_bibekkum@quicinc.com>
 <20231215101827.30549-4-quic_bibekkum@quicinc.com>
 <e4329952-34ac-4458-a63c-1f64e288614c@linaro.org>
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <e4329952-34ac-4458-a63c-1f64e288614c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1iff2ovQNWMWW5Fz0XqWBOc6eAAVSLGm
X-Proofpoint-ORIG-GUID: 1iff2ovQNWMWW5Fz0XqWBOc6eAAVSLGm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=998 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312180084



On 12/16/2023 5:05 AM, Konrad Dybcio wrote:
> On 15.12.2023 11:18, Bibek Kumar Patro wrote:
>> Add ACTLR data table for SM8550 along with support for
>> same including SM8550 specific implementation operations.
>>
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
> [...]
> 
>> +static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
>> +	.impl = &qcom_smmu_500_impl,
>> +	.adreno_impl = &qcom_adreno_smmu_500_impl,
>> +	.cfg = &qcom_smmu_impl0_cfg,
>> +	.actlrcfg = sm8550_apps_actlr_cfg,
>> +	.actlrcfg_gfx = sm8550_gfx_actlr_cfg,
> There are platforms that feature more than just APPS and Adreno SMMUs,
> this implementation seems to assume there's only these two :/
> 

Yes, some platforms can feature additional SMMUs as well including APPS 
and Adreno. In that case there would be a corresponding compatible 
string and an additional field in qcom_smmu_match_data might be needed.

Thanks,
Bibek

> I suppose the only way to solve this would be to introduce new compatibles
> for each one of them.. Krzysztof, do you think that's reasonable? E.g.
> MSM8996 has at least 5 instances, 8998 has at least 4 etc.
> 
> Konrad

