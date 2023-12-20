Return-Path: <linux-kernel+bounces-6539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A76C819A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E43C1F23760
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DA21C695;
	Wed, 20 Dec 2023 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JtYPMk6h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC81B26F;
	Wed, 20 Dec 2023 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK6fKkU010398;
	Wed, 20 Dec 2023 08:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+6NBB2Pd6DfZEk1paBxij/oUAhxNpI8p5+8suGrbVLA=; b=Jt
	YPMk6hPEgv6amvEngPC13CMUtrSw8FbiRbQziv7E8zFEa52LlLiLKtPiKr9qDxAH
	wCjsaxu07/kmdyui7DZbZJSNi3gTRFadTNrTMAkLEhGj2WHmNNDkaVC8ECuR3AdD
	W7xAFgsgc6+ircm6TA8jsdz5Ux2hmgl+dnNr5IWJ5dcLgoiQm09aMYf4FmVJQKQ1
	I+yDUp65BjzDM3bFYhtaZ0E+WMc4iaQT3VaiLUBp9xj28tg8kTeCSLoTVf1HYsQz
	sXbUZ8Vwan9fNtpKmZGxfDhVy7c2H4SW1NfY/Ujjr36DNVRt/iii8rODzeRPLnkC
	TM4Um6zdzRMM0aQIHDUA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3rppggmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:08:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK88dCH027670
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:08:39 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 00:08:33 -0800
Message-ID: <ccd67437-39cb-4fea-98aa-4dfae5f4c1d0@quicinc.com>
Date: Wed, 20 Dec 2023 13:38:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] iommu/arm-smmu: re-enable context caching in smmu
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
References: <20231219135947.1623-1-quic_bibekkum@quicinc.com>
 <20231219135947.1623-2-quic_bibekkum@quicinc.com>
 <810ee42b-49c9-4184-b5aa-a95261faf77a@linaro.org>
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <810ee42b-49c9-4184-b5aa-a95261faf77a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sydQix4L66O3NvKJ7H3PIi-q5GBgoixu
X-Proofpoint-GUID: sydQix4L66O3NvKJ7H3PIi-q5GBgoixu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=871 impostorscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200055



On 12/19/2023 11:29 PM, Konrad Dybcio wrote:
> On 19.12.2023 14:59, Bibek Kumar Patro wrote:
>> Default MMU-500 reset operation disables context caching in
>> prefetch buffer. It is however expected for context banks using
>> the ACTLR register to retain their prefetch value during reset
>> and runtime suspend.
>>
>> Replace default MMU-500 reset operation with Qualcomm specific reset
>> operation which envelope the default reset operation and re-enables
>> context caching in prefetch buffer for Qualcomm SoCs.
>>
>> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Suggested-by implies I came up with this being a solution to
> an issue.. definitely not the case!
> 

Noted, will send v6 by removing the Suggested by tag
and will address the return check as well.

Thanks,
Bibek

> Konrad

