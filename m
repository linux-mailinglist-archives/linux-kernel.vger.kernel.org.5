Return-Path: <linux-kernel+bounces-74367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2D485D31F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6248B1F21F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620653C6BA;
	Wed, 21 Feb 2024 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cXEZj7+0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E23A269;
	Wed, 21 Feb 2024 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506461; cv=none; b=sWmrqcEmHXtVv2eri0Vt/mA35IhtAw4/5x1vks9WCctVqyCc9I4+PRMHz8Wot1dXYEJ6JhPDKzxl40ES+wGyxEK+c+fRbQl6mRtzX3y0lLucsHnsmwAEX9DPQGKIZVvj2l0pyGf/HVhDhLGhGZtXNNLnfZjLDOM/NXr043Zl6c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506461; c=relaxed/simple;
	bh=mciGcG1/7XQyHXY9pTQf0Pnd9D3SNVyA+vi37R1v1PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ypotl8itmJ61GG/Z/g+6T4D+OT7YnpShJ8Uv1WClY4nCpOgeg3JpM2Ad510sUx6ENzU7K4OfG5OhRlgjyWUd8tsWnZitf5vOenJiU6sPJyPRf9RSsq/Dr7Wfuo+72jp0AqY6WYd96+C3INrPx6OiY4quOaGQAE0ytfLQV7qazs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cXEZj7+0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L7hgtc015736;
	Wed, 21 Feb 2024 09:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Rm9nfXyllOUZ4Ibd5UKs+r2t8KUwgkJ+x+imnhOfPek=; b=cX
	EZj7+0P12cPG+nxnzIP3cykoFWzA4w3PPmZhz1KjB+xwUWMqiaD+5LA7fU4ZFb/m
	psOD8bceG4X+LN2x1kneoD3stSbyDCI3fFOog6kbP34id3QlhxyB+zOF4/6e0D1B
	eRj8LW/2zf0xQ9BK4VMjwPEMnGI1v2NsGOZ9M2ZcV1O2S1UJ7rHq8zmGLVn4pykT
	l1KOvnzbzGPy0yHrzoqOJZ/rBs1L3z925sCNSwM7US0YlVKDKrLlWx6hvN49nMFi
	gGO5wmCG+wS1+Eq0C9WHp4PilBX6CmTBz1V0LRJNBbvD2fiW5l2WKI7O4/yi/qhL
	Gknzw1q9vgk2up3o/WJg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd22rhfpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 09:07:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41L97SEC020735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 09:07:28 GMT
Received: from [10.253.11.235] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 01:07:26 -0800
Message-ID: <5ac69cde-24d6-4d31-a1bb-10e91dd289ce@quicinc.com>
Date: Wed, 21 Feb 2024 17:07:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: core: Fix mcq mac configuration
To: Rohit Ner <rohitner@google.com>, Bean Huo <beanhuo@micron.com>,
        "Bart Van
 Assche" <bvanassche@acm.org>,
        "Martin K. Petersen"
	<martin.petersen@oracle.com>
CC: Avri Altman <avri.altman@wdc.com>,
        "Bao D. Nguyen"
	<quic_nguyenb@quicinc.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240220095637.2900067-1-rohitner@google.com>
Content-Language: en-US
From: Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20240220095637.2900067-1-rohitner@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hLHaYREpg8i8MLinWT63Eeuvb_fR_0wZ
X-Proofpoint-GUID: hLHaYREpg8i8MLinWT63Eeuvb_fR_0wZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210071



On 2/20/2024 5:56 PM, Rohit Ner wrote:
> As per JEDEC Standard No. 223E Section 5.9.2,
> the max # active commands value programmed by the host sw
> in MCQConfig.MAC should be one less than the actual value.
> 
> Signed-off-by: Rohit Ner <rohitner@google.com>
> ---
>   drivers/ufs/core/ufs-mcq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 0787456c2b89..c873fd823942 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -94,7 +94,7 @@ void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds)
>   
>   	val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
>   	val &= ~MCQ_CFG_MAC_MASK;
> -	val |= FIELD_PREP(MCQ_CFG_MAC_MASK, max_active_cmds);
> +	val |= FIELD_PREP(MCQ_CFG_MAC_MASK, max_active_cmds - 1);
>   	ufshcd_writel(hba, val, REG_UFS_MCQ_CFG);
>   }
>   EXPORT_SYMBOL_GPL(ufshcd_mcq_config_mac);

Reviewed-by: Can Guo <quic_cang@quicinc.com>

