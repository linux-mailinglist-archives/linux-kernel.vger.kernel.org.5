Return-Path: <linux-kernel+bounces-122861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F11588FE88
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DEB1C211C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD177EF16;
	Thu, 28 Mar 2024 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gxC+Npgr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7D7F7D5;
	Thu, 28 Mar 2024 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627286; cv=none; b=XAUgOSLve6lOZ00NpOKUEPU7Se0kHo1MCYtK0tmFFObq6UT/LIOuMnJ6MlgYcX4kdEMzy+fcniJ6CsnKbYM2lLpoJsHpf7U6J+wb2iDynIYq6wSRg3LByRx0/nKEa/6fXoxMAUUfZ5iZlm+15cQglTPq7398QJe1QNp8O1N9iXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627286; c=relaxed/simple;
	bh=qQGL3KEVALIYTB3iaYhCLAJRzfoPdhBLQhivo5AcuHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=kmtIcoGqzm7+jtCy2RgOJgGBE85V6P+cam8MRNGj6/0ABMVpqjQqJ2eK8F3OTC/UHysnBWd5qwRlOOQ6vHLuyqc+Mx+SI9wFBViZV6enVGawiW4bDdNGw5KyH9AV74KK2XycNC01j8uREJxkeuHWT26rypFt5IWCxMo4izBuwSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gxC+Npgr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SAVtgk030829;
	Thu, 28 Mar 2024 12:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:cc:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zJ4nt5TmQ8B8l4dzJcYb0Pb3LyYOiQTCoq/dt1LSxRU=; b=gx
	C+NpgruJtTLYOyZu5+jHAxl0uRsJIqXHlZK4/0WbkZx0cUQ6+K4lZ39ApazVT5yw
	nRb3JpnBp2SJseOAX7VNwyW4EZLrG1ptpq8MV7uxy9cV06tSuOc8kJjBNb/hpEPr
	UCvebmVcV6mxw029kTAbrurYxayRzu56CMwWbQfeskzIvtOvdSQhCMm8djhNmYvh
	5oDqOeSEsR1PMcGDikcJpV1C7jtjWj+6PUG7uw7Fn1+N0nX5jnfYW8H0qje4vUYa
	rau4JmZRjStd3WeE91BhVYlHDZKWx9Ppuw9qUmFFnfvgCHlpJUJJHVXdd62JZ3pU
	umyaPREy6Ow34DxLnYxQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u2037qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 12:01:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SC1Axq030884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 12:01:10 GMT
Received: from [10.216.61.17] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 05:01:07 -0700
Message-ID: <19bb6ff0-04ff-4e88-8c8a-499c054bdea4@quicinc.com>
Date: Thu, 28 Mar 2024 17:31:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
References: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
CC: Caleb Connolly <caleb.connolly@linaro.org>, <Volodymyr_Babchuk@epam.com>,
        "andersson@kernel.org >> Bjorn Andersson" <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm
	<linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From: "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vSol2qy5wNRC1Autn8p6AtWI4KUfl8yT
X-Proofpoint-ORIG-GUID: vSol2qy5wNRC1Autn8p6AtWI4KUfl8yT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_11,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280081



On 3/28/2024 1:39 AM, Volodymyr Babchuk wrote:
> It appears that hardware does not like cacheable accesses to this
> region. Trying to access this shared memory region as Normal Memory
> leads to secure interrupt which causes an endless loop somewhere in
> Trust Zone.

Linux does not write into cmd-db region. This region is write protected 
by XPU. Making this region uncached magically solves the XPU write fault
issue.

Can you please include above details?

> 
> The only reason it is working right now is because Qualcomm Hypervisor
> maps the same region as Non-Cacheable memory in Stage 2 translation
> tables. The issue manifests if we want to use another hypervisor (like
> Xen or KVM), which does not know anything about those specific
> mappings. This patch fixes the issue by mapping the shared memory as
> Write-Through. This removes dependency on correct mappings in Stage 2
> tables.

Using MEMREMAP_WC also resolves for qcm6490, see below comment.

> 
> I tested this on SA8155P with Xen.
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>   drivers/soc/qcom/cmd-db.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index a5fd68411bed5..dd5ababdb476c 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -324,7 +324,7 @@ static int cmd_db_dev_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> -	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WB);
> +	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WT);

In downstream, we have below which resolved similar issue on qcm6490.

cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WC);

Downstream SA8155P also have MEMREMAP_WC. Can you please give it a try 
on your device?

Thanks,
Maulik

