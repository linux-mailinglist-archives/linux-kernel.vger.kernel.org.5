Return-Path: <linux-kernel+bounces-58229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E603884E32A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783A529219E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF5C78B75;
	Thu,  8 Feb 2024 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hGdscU2q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA02EB14;
	Thu,  8 Feb 2024 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402589; cv=none; b=bCrK7KS6qBfsGgdG6SdsrV5IbStYNXGvPp8Uw7AFYVF4zf12ZZxIcZGwYznsMDhRMk0snkf/FLVuq3HkhFptTsqJqwUCCf/53ixf81/wMffVCNK5+QToXEAHbNQVudPq9gxFqLvfvYWOFHEWPLdobxoxtxCoCyTkJix99bzfi7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402589; c=relaxed/simple;
	bh=BjhD4pm+ohrOgBwpHnJBgVialPzyURLLtifb2JZRcvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=npotn9jDbR/d0NKX9u0O4rwBu4lVFC2lwENvTkOzCzNCE5c14/t5lslbunDGeEE0VyGWmxvUhDe6T1ggeDjx6bAOk988eLKd7YpYU828pvO/IdXQGv9Dfftkl6IHP/O1mB5vNhN8q8yZsSiWWE1gdS7BawQVWc0x8A4yHGvVfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hGdscU2q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4185Do4c025038;
	Thu, 8 Feb 2024 14:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pqOQ0pk1w4ZIPMpcW3wgFsiH/QfkfRueUw7WRbNFp/8=; b=hG
	dscU2qq7Ic0Y0NtjNeSa5QCTQrb6PSzTkJHnr++4IRXVWAGLEwcktx0Bth5QEkG0
	XlywtN8eNwDRmcn6V9mv93s2hvmy7JRxdTlsV2hgdtfsZ/nIeT7pHOccUwFjToZ2
	AMHMtViXlNVCdQ6BgJB8HPINcmQtNeqJo3FjdR6PvIObwoj6WsiVRqDToxv69jE8
	522tK+6nBeMFNAtZjMmrM8KEygaMZksuyIOel49kcdLBceSAvy5fsCrANKelj47r
	MQjMviUCYMDTYKoHGlmB4+8yzk4EX0dg0t7EoYnLWC+PbfjKuDPuLp7vr/fc49QN
	FLKDH7BN9CFNobwpbQSg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4h0uj6h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 14:29:37 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418ETbXG005314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 14:29:37 GMT
Received: from [10.216.60.50] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 06:29:34 -0800
Message-ID: <b1991baf-e642-f811-14b0-ccd7c0cd56ec@quicinc.com>
Date: Thu, 8 Feb 2024 19:59:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] soc: qcom: mdt_loader: Add Upperbounds check for
 program header access
Content-Language: en-US
To: Auditya Bhattaram <quic_audityab@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20240208123527.19725-1-quic_audityab@quicinc.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240208123527.19725-1-quic_audityab@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KxJzfQkUXXq8Ut2NX3OHB5BcGof4Gp04
X-Proofpoint-GUID: KxJzfQkUXXq8Ut2NX3OHB5BcGof4Gp04
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_05,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080077



On 2/8/2024 6:05 PM, Auditya Bhattaram wrote:
> hash_index is evaluated by looping phdrs till QCOM_MDT_TYPE_HASH
> is found. Add an upperbound check to phdrs to access within elf size.
> 
> Fixes: 64fb5eb87d58 ("soc: qcom: mdt_loader: Allow hash to reside in any segment")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Auditya Bhattaram <quic_audityab@quicinc.com>
> ---
> Changes in v3:
>   - Corrected wrong patch versioning in the Subject.
>   - Added error prints for Invalid access.
> Link to v2 https://lore.kernel.org/linux-arm-msm/9773d189-c896-d5c5-804c-e086c24987b4@quicinc.com/T/#t
> Link to v1 https://lore.kernel.org/linux-arm-msm/5d7a3b97-d840-4863-91a0-32c1d8e7532f@linaro.org/T/#t
> ---
>   drivers/soc/qcom/mdt_loader.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 6f177e46fa0f..61e2377cc5c3 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -145,6 +145,11 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
>   	if (phdrs[0].p_type == PT_LOAD)
>   		return ERR_PTR(-EINVAL);
> 
> +	if (((size_t)(phdrs + ehdr->e_phnum)) > ((size_t)ehdr + fw->size)) {

This change is valid only if somehow, ehdr->e_phnum gets corrupted or 
changed via some engineering means and results in out-of-bounds access.

Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

> +		dev_err(dev, "Invalid phdrs access: %s\n", fw_name);

Should it print ehdr->e_phnum as well to be more valid?

-Mukesh

> +		return ERR_PTR(-EINVAL);
> +	}
> +
>   	for (i = 1; i < ehdr->e_phnum; i++) {
>   		if ((phdrs[i].p_flags & QCOM_MDT_TYPE_MASK) == QCOM_MDT_TYPE_HASH) {
>   			hash_segment = i;
> --
> 2.17.1
> 
> 

