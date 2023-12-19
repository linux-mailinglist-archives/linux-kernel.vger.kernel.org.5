Return-Path: <linux-kernel+bounces-5232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD774818844
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6B71F2287B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5237218ED2;
	Tue, 19 Dec 2023 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fsVEC5wr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6650D18EA0;
	Tue, 19 Dec 2023 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJAgmYt023604;
	Tue, 19 Dec 2023 13:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=QivfX9dR/w5DQ1pMwXDcAJ5dv1UM9wtRLMwtkpY0jus=; b=fs
	VEC5wrDFBWxJ8h91HJn8GZKw4MyyMd45BGc2ErQfKqstJCU//wgHtQgZ5erxUddH
	od8KlqkmROtRrwn8JHGCC8qdfYQR8Sd/O4HeyKgwiH+mNnZgzNlCdlgwgXMScdTl
	W0wh+9ZPDaq7zXXMkHZsSo0EqwH6O7F638O9BaCXHselCWUHqM/6aZxMz9T1ZaeW
	TP8lotqhDG0gNDiWD+oiMFBKVN1xrVRO2BDnyPjy+y/skX8UX9g88qO1qtYLDlob
	NO4iERHsPubjN0Tdogb1Y8WS/SQpgxO/CAchv7pRRLA2bFzx8+vlmVZQeiIu0fBL
	a8mVCz3aGx7/8h0n3d6g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v39n8rbry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 13:06:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJD6eqM003237
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 13:06:40 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 05:06:34 -0800
Message-ID: <d5291beb-7384-4ee9-a7a4-8aad931d7bc8@quicinc.com>
Date: Tue, 19 Dec 2023 18:36:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <jsnitsel@redhat.com>,
        <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <qipl.kernel.upstream@quicinc.com>
References: <20231215101827.30549-1-quic_bibekkum@quicinc.com>
 <20231215101827.30549-6-quic_bibekkum@quicinc.com>
 <3c7b8c2c-7174-4ced-8954-5a249f792c1e@linaro.org>
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <3c7b8c2c-7174-4ced-8954-5a249f792c1e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O6cKu9jgX6SHlCA8_-p4qhVgRs9Y6LeR
X-Proofpoint-GUID: O6cKu9jgX6SHlCA8_-p4qhVgRs9Y6LeR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxlogscore=697 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312190097



On 12/16/2023 5:24 AM, Konrad Dybcio wrote:
[...]
>> +
>> +	arm_mmu500_reset(smmu);
> We should check the return value here, in case the function is modified
> some day in a way that makes it return something else than 0
> 

Thanks for pointing this actually. I crosschecked on the
arm_mmu500_reset function behavior, looks like there's no return value
other than 0 and so the functionality won't change. I think we can
keep it as it is in this case.

Thanks,
Bibek

> LGTM otherwise!
> 
> Konrad

