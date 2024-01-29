Return-Path: <linux-kernel+bounces-42565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7037884032E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1108A1F2352D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CD957861;
	Mon, 29 Jan 2024 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D45sQB0K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F4F56B70;
	Mon, 29 Jan 2024 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525334; cv=none; b=tu+WAJmeXZwUs6xSqK9Ztd+67eDFCG6I8TShkqOOwzfdD5LBH+Nei+XPX73IAL541lB5/D7daJb5FRJ8VQyh4U/6PwLXEANW6JGq7ctUu7L/qlwM94G1bZx5y0IRE7SMZtvEY2cLOw23g7vHZKZhlmaS4gC5Tjwi88avFhC2iZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525334; c=relaxed/simple;
	bh=Cwwb1IrnhAqflNwwr5xSZUeDUm1bhUtrWeRJtuIBwI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=syJt3Tqae2O5H5za9zsv/4DqdLBtEwa/qi7cwTREtHn/BgBPncsfkYL+7Ej8bGD0aPavEfofm8ZCw9blT7CmuaiJ2mYsvndQVfiiQjLCLUPiI5Da1+1q75TxeRADhfgISlRMAEW/mdx3Kf5fXtbMUCglaLojPzxz5Q7i4seLWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D45sQB0K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T7jqMX032528;
	Mon, 29 Jan 2024 10:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZugSSSRjJH8eOzWRrav1dwHxGdpfMlgQG3DI1tTj0AA=; b=D4
	5sQB0Kw7xD3lwRWOS6sew+n5Kzq8u07fxKWSdBBZK8F+LBGR2rOBctnssd6JAXQb
	pHfwTrFn/NPwUHwqkZR4kMESANNhkVxRvAts0f0ZnFDpJkkFeyudiflRvcXWA8SE
	HKrg3m7jYhJOUazEqPRligwenMRwG36zoB0kTbviwWiwWbYTjb+5aX3aIkA8pMXp
	C9FVkF9QlMXvGkojXRQHqwQfbEjWJ7ait1NhG4D+QdbGig+wEDHy7h9SvtXiSSKh
	anMXPDm1leRtwCEAs6A9zuptGiX1BIWGLOjAkl1bHxdY7XRnHYf9CiHk2M56QnUb
	a5mutE+13vhQLPD+0mpQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx23k8wsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:48:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40TAmgcl008905
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:48:42 GMT
Received: from [10.218.35.133] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 02:48:39 -0800
Message-ID: <151f5738-791e-42cb-b8fe-e0cfbf9f7dca@quicinc.com>
Date: Mon, 29 Jan 2024 16:18:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] rpmsg: glink: Add bounds check on tx path
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>, <afaerber@suse.com>,
        <ivan.ivanov@suse.com>
References: <20240113002505.15503-1-mkoutny@suse.com>
Content-Language: en-US
From: Deepak Kumar Singh <quic_deesin@quicinc.com>
In-Reply-To: <20240113002505.15503-1-mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UiTqmIwQw3BpaeOMGQ7Ee7xTrNm9Ik5I
X-Proofpoint-GUID: UiTqmIwQw3BpaeOMGQ7Ee7xTrNm9Ik5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=793
 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290077



On 1/13/2024 5:55 AM, Michal Koutný wrote:
> Add bounds check on values read from shared memory in the tx path. In
> cases where the VM is misbehaving, the transport should exit and print a
> warning when bogus values may cause out of bounds to be read.
> 
> Link: https://git.codelinaro.org/clo/la/kernel/msm-5.10/-/commit/32d9c3a2f2b6a4d1fc48d6871194f3faf3184e8b
> Suggested-by: Chris Lew <quic_clew@quicinc.com>
> Suggested-by: Sarannya S <quic_sarannya@quicinc.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   drivers/rpmsg/qcom_glink_smem.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> Why RFC? The patch is adopted from the link above. It would be good to
> asses whether such conditions can also happen with rpmsg glink.
> (And if so, whether the zeroed values are the best correction.)
> 
Hi Michal,

There is already a patch posted for similar problem -
https://lore.kernel.org/all/20231201110631.669085-1-quic_deesin@quicinc.com/

> diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
> index 7a982c60a8dd..3e786e590c03 100644
> --- a/drivers/rpmsg/qcom_glink_smem.c
> +++ b/drivers/rpmsg/qcom_glink_smem.c
> @@ -146,6 +146,11 @@ static size_t glink_smem_tx_avail(struct qcom_glink_pipe *np)
>   	else
>   		avail -= FIFO_FULL_RESERVE + TX_BLOCKED_CMD_RESERVE;
>   
> +	if (avail > pipe->native.length) {
> +		pr_warn_once("%s: avail clamped\n", __func__);
> +		avail = 0;
> +	}
> +
>   	return avail;
>   }
>   
> @@ -177,6 +182,10 @@ static void glink_smem_tx_write(struct qcom_glink_pipe *glink_pipe,
>   	unsigned int head;
>   
>   	head = le32_to_cpu(*pipe->head);
> +	if (head > pipe->native.length) {
> +		pr_warn_once("%s: head overflow\n", __func__);
> +		return;
> +	}
>   
>   	head = glink_smem_tx_write_one(pipe, head, hdr, hlen);
>   	head = glink_smem_tx_write_one(pipe, head, data, dlen);

