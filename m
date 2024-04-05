Return-Path: <linux-kernel+bounces-133329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED8E89A24F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AEDA1F215DD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1024171092;
	Fri,  5 Apr 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c5sxVIW5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5851146593;
	Fri,  5 Apr 2024 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333969; cv=none; b=hu0Igm1zWIkSB9LRghV0rAfTHlmOkRYk3XMb7bderWajJaR48xq9sqojqrsn2rkWY9A5bR927rNpn05nFm4LOU2jZB7SINb+7dGg/HVa8nRoEFmtzA3oJVrE71pFwNXgNd8n2xrC0y95m0k7w9Lc08Ia7zyLCJl8lSXsFll/J1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333969; c=relaxed/simple;
	bh=TL72WFePHlEPGBmKx6y2Vwftq03HD1g8Xm9Z08m3Tow=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N8U+GIntDZXwaoHp3A7YtHRYIkATS3RcpoEhLC62ZMUbBM9V5M3ypuC+tvDdi/neac6k/FXX01aYZg/Cfqsa757B+SltnVXQvcYWekTtmrwa6OOmxaM9BnYW2GFzySdQTTlNH6Cba4Z0Ra/cfaHPKYQxXu6FvKgiuA5qn8Ryp8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c5sxVIW5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435CCNTw015228;
	Fri, 5 Apr 2024 16:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9ykimK+h1oJPJJ2Us+V+2GFSTbKBZtDOXlF3J8WiOk4=; b=c5
	sxVIW5dyhE8lyU0fcJzi31msrYAkZAHfSQ11qV9LNhBjpe5nsw3fOfpxBcLbe2XQ
	irHDmKHQc+cYhxsLeT8SKZ4Awbz6D9Y1Paod9U28LmY6jDmIikuoir0762GpmrYa
	iEKU6IBANn9gBsOI3oV/NQEhvBy14TvygDx0wG4zorVvuJAF4XESU+0zDq6fHhgn
	wD2WMQIeNikxw0ltNgQnQarlmzp7BIoYnrHX6dwhcEbo7OifLlHNOsyDCADibMS+
	+HP4OTq2IS9u6x7pTWJf+DRpgiGL8G19vdnOJrrIPVdY7Yf/766Kb7QEKMGLxvEZ
	uXm1MGIt20pf2z3Wdqdw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xaaj19fjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 16:19:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435GJDDc017750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 16:19:13 GMT
Received: from [10.216.11.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 09:19:10 -0700
Message-ID: <b6785706-625d-0ecf-3ada-152fe06474ac@quicinc.com>
Date: Fri, 5 Apr 2024 21:49:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: venus: fix use after free in vdec_close
Content-Language: en-US
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia
	<quic_vgarodia@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1712332319-11767-1-git-send-email-quic_dikshita@quicinc.com>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <1712332319-11767-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: x03A3mWb9iP_8FfQk04LeJ69ht-T1qVU
X-Proofpoint-GUID: x03A3mWb9iP_8FfQk04LeJ69ht-T1qVU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_17,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050116

Hello All,

Please ignore this patch, sent by mistake.
Sorry for spamming.

On 4/5/2024 9:21 PM, Dikshita Agarwal wrote:
> There appears to be a possible use after free with vdec_close().
> The firmware will add buffer release work to the work queue through
> HFI callbacks as a normal part of decoding. Randomly closing the
> decoder device from userspace during normal decoding can incur
> a read after free for inst.
> 
> Fix it by cancelling the delayed work in vdec_close.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 29130a9..8dda46a 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -1747,6 +1747,7 @@ static int vdec_close(struct file *file)
>  
>  	vdec_pm_get(inst);
>  
> +	cancel_delayed_work_sync(&inst->delayed_process_work);
>  	v4l2_m2m_ctx_release(inst->m2m_ctx);
>  	v4l2_m2m_release(inst->m2m_dev);
>  	vdec_ctrl_deinit(inst);

