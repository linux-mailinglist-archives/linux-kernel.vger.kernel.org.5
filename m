Return-Path: <linux-kernel+bounces-50506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9979D847A04
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBA71C248AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB178062B;
	Fri,  2 Feb 2024 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XxnmToxK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D487915E5A3;
	Fri,  2 Feb 2024 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903838; cv=none; b=DI7/9tIrAtlZd0oxiow71YYum/OUfxt7Zd9lY4ctx90n9bmO0HrrxaWoE1W/W4ZmD9fX6akz+EPHaXhK97BEYZlVJAZyDIvtAhu4Wk63zlUZ4z0vsESOjkaYIoRmyqZAjZpO7XTVSZ5lrMH/bEZW1DyFe2iuAS67xIdXSottcIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903838; c=relaxed/simple;
	bh=ukbTX8yqMyjTunHbi98P1uDkWKc+yV5d2lJmNH0+6L8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATNK1VQHizfPmUyovixIU7A+C81c9Vk8/m6R3XBeeSjP1mGQpwFvruuSbe+al3dgJL+5FpZ5BzKD5P9uTZB1DEpQqjePitdppWvAx2pIJ8e1vW9nFPCgmiVip/Em+40RDTDcqSMubKAzuRuIgGoeQOa63ghsFK/IIU+3qByqnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XxnmToxK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412JehZj028333;
	Fri, 2 Feb 2024 19:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=0jsbiUGZoVRm+Jqip9Jzj
	NucpXpxG9ms6OPSdQr3b5c=; b=XxnmToxKtrZqoUD7DzDJ4UfR/jZ7vPiitpXa+
	nPN6AAvsoY1DyuDIUO1fYVxhqk72WrU0Fu7PB4IhVNLDmSOgAHBo1lhneStGz/87
	t3dUk2Coi34Sj1i8ix7qdKSxUmRGMWYA7E7EZQ4ak6DJqgEhRK/kINNwpogyqz+g
	s8269XFXC+kQ35u05k5jkzO7n/mbxL8JyGpZvDO2Lr1dfDHtmQBUzmsWuWCCzAv0
	kmkEm0eMOmf2KUwsLf3mRzmV4jIz+WGYSHNMniRK3bd7kyZxpL7oINc/7lV+HRQK
	SuG1yjwf07Ok1hEz/BQVmgtHv9+vomvQ3jCeUXxfDx2BTEK0A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptvj9me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 19:57:13 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412JuvVH011778
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 19:56:57 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 11:56:53 -0800
Date: Fri, 2 Feb 2024 11:56:53 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] soc: qcom: llcc: Check return value on Broadcast_OR reg
 read
Message-ID: <5ba42ywqwi2ix2hyo4ysdgo2onyrhm6rtvpow626r7kctoixz6@xrens4w3k7ar>
Mail-Followup-To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@quicinc.com, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240202-fix_llcc_update_act_ctrl-v1-1-d36df95c8bd5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240202-fix_llcc_update_act_ctrl-v1-1-d36df95c8bd5@quicinc.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oxwqDb5h7420ezCW4ZTIs3hYBJnnezbG
X-Proofpoint-ORIG-GUID: oxwqDb5h7420ezCW4ZTIs3hYBJnnezbG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_13,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=802 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020146

On Fri, Feb 02, 2024 at 11:47:43AM -0800, Unnathi Chalicheemala wrote:
> Commit a3134fb09e0b ("drivers: soc: Add LLCC driver") didn't
> check return value after Broadcast_OR register read in
> llcc_update_act_ctrl(), add it.
> 

Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

You'll probably want to add:

Fixes: a3134fb09e0b ("drivers: soc: Add LLCC driver")

> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
> ---
>  drivers/soc/qcom/llcc-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 4ca88eaebf06..cbef0dea1d5d 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -859,6 +859,8 @@ static int llcc_update_act_ctrl(u32 sid,
>  	ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
>  				      slice_status, !(slice_status & status),
>  				      0, LLCC_STATUS_READ_DELAY);
> +	if (ret)
> +		return ret;
>  
>  	if (drv_data->version >= LLCC_VERSION_4_1_0_0)
>  		ret = regmap_write(drv_data->bcast_regmap, act_clear_reg,
> 
> ---
> base-commit: 021533194476035883300d60fbb3136426ac8ea5
> change-id: 20240202-fix_llcc_update_act_ctrl-64908aed9450
> 
> Best regards,
> -- 
> Unnathi Chalicheemala <quic_uchalich@quicinc.com>
> 

