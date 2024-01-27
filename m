Return-Path: <linux-kernel+bounces-40933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B2F83E869
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744CD1C20AE4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9129C646;
	Sat, 27 Jan 2024 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n4srbI9Y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D6E19A;
	Sat, 27 Jan 2024 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706315032; cv=none; b=VDrm0223RlFC2C46+QKWN+g8qh4FbtFhN/28uHPU2XzWigKlwwJ6MqZe1e2efMojitD7t9sG7GalkLJUbVXQIdhlHa0IIb+1mNMxNg5cH+p94r/xsD/mFnCLzBj/6qfaPhYwfEWqiequ2Wb8rLOgKJsaZOMn1Sn5b5rT77m5H9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706315032; c=relaxed/simple;
	bh=7LnmKXAMJFU1obVIBSv+V0d5UNbewL3dVnUcxEli3Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WLeBmES2WGOmknigAS7OWCnLhU7fX17yK0cBkaw4xvm3GBFXWTawM6S5lPKKWCJABnyL+gHYNaeJ6NipwdtAAWWEjyMowKlTb5RFza349DWp+viTBqZd/fQNCq12PegBXj0arQT904GZP3Mwt9Ioonsod+6fqQP6HdwV3cT2uoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n4srbI9Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QNdOQs005928;
	Sat, 27 Jan 2024 00:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Z+fT7nX6OH5oPLL8NPSq+oI9rB13qgCcJghaZper11g=; b=n4
	srbI9YhH5VOPx+E8pd60BRpu70CDNvlP6TWIIfixX2gECAZAzPIhFHtlWROLubB6
	VIUW3/xxa8/Dv2LQou30pry4SnpnwYf7kKYcM7ZU9v26mYlLCoWTfcFi4/JqA/Zy
	9VtFB+eb7jt12Jb4qHTQ53w+3wrxkNcOXq3fg4NwTW936vXU4vxw2EWhS3bdHX5V
	IY/KsYhq5RWQQ10UixJ+9hnktyytamGwcfIBGAVioemzfhc8+jAhMyNWJO0ju6Q3
	t3cLOJLRMWHjEi1D5OAY3o69QJUJ5tyLdh9RL4S6bzoTsf8yJIKDqA3MUwP25M3c
	JWICW7ma7oj9goaeNvIA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvjbg8hm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:23:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R0Nlse009696
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:23:47 GMT
Received: from [10.110.53.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 16:23:44 -0800
Message-ID: <065cbefc-031e-7595-9d48-f869585dfcd3@quicinc.com>
Date: Fri, 26 Jan 2024 16:23:43 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] qcom: smem: remove hwspinlock from item get routine
Content-Language: en-US
To: Tao Zhang <quic_taozhan@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240102022512.999635-1-quic_taozhan@quicinc.com>
From: Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20240102022512.999635-1-quic_taozhan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: r15WZgRvOezgLEJuW8c6LBQVddXzlR5v
X-Proofpoint-ORIG-GUID: r15WZgRvOezgLEJuW8c6LBQVddXzlR5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxlogscore=885 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270001



On 1/1/2024 6:25 PM, Tao Zhang wrote:
> During an SSR(Sub-System Restart) process, the remoteproc driver will
> try to read the crash reason from SMEM. The qcom_smem_get() backing such
> operations does however take the hwspinlock (tcsr mutex), which might be
> held by the dying remoteproc.
> 
> The associated timeout on the hwspin_lock_timeout_irqsave() would take
> care of the system not hanging forever, but the get operation will fail,
> unnecessarily delaying the process for the 'HWSPINLOCK_TIMEOUT' duration
> (currently is '1s'), and finally resulting in failure to get crash
> information from SMEM.
> 
> This timeout can be avoided by removing the hwspinlock in the
> qcom_smem_get routine. SMEM ensures that the allocated item will only be
> visible after the new item is safe to use by following a specific order
> of updates.
> 
> In the private partition case, qcom_smem_get_private() will use
> 'offset_free_uncached' as a loop boundary when looking for existing
> allocated items. The corresponding allocation will only update
> offset_free_uncached once the item is fully initialized.
> 
>      hdr->canary = SMEM_PRIVATE_CANARY;
>      hdr->item = cpu_to_le16(item);
>      hdr->size = cpu_to_le32(ALIGN(size, 8));
>      hdr->padding_data = cpu_to_le16(le32_to_cpu(hdr->size) - size);
>      hdr->padding_hdr = 0;
> 
>      wmb();
>      le32_add_cpu(&phdr->offset_free_uncached, alloc_size);
> 
> The global partition is similar but uses the "entry->allocated" variable
> to ensure the item is not visible to qcom_smem_get_global().
> 
> Signed-off-by: Tao Zhang <quic_taozhan@quicinc.com>
> ---

Reviewed-by: Chris Lew <quic_clew@quicinc.com>

