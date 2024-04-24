Return-Path: <linux-kernel+bounces-157356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7CB8B1051
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77155281C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC20216D30D;
	Wed, 24 Apr 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YRCQ4xh3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B816C6B0;
	Wed, 24 Apr 2024 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977704; cv=none; b=mXDq2x+LrHBnjKptNEyH9wDvJlE9reKjpqUzRoIdXUsk4SjZhMjAj5iAb1fQW4ODEpK63rp5rZMDEzlv90Roi30io6oxIukYQLv+XU6A8i7lblijx73pavpu/oX/y4GuKxorz4XiRd0F4qX09hvstLdT63208YwOqqhTUs1tMYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977704; c=relaxed/simple;
	bh=03FTo8TX02vLrcI2shufivf/kM3LQHeukH8JFNjZ4CI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8ruOhQjWGIqkRjLJPfeWQeV5lp+2kLa5jqnctz5w0FDZGUd2TkLnIFoBEgN5NwQXxvyAAZQHUv50zuRSZCfIx9KW1Jvb7hZNuqewFhwFCEZVBZv7QiHbC5R0V0n8LHf6q4SO+r/gtCM/2+tUx5SuA80u5FTNFfDxSWBHZbo04M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YRCQ4xh3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OGrT5T008304;
	Wed, 24 Apr 2024 16:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=jzXmqBTlpriB7yNyYZ29U
	7ZdBSUKzzqy/fFz/tFukzk=; b=YRCQ4xh3htXTzv//VAidA8XM0A76rHZCWXh7C
	wikrqZrOPsqrLVfO+6EXk+yf8jE4D6FRNu5QbssWCrMLRuZkzvmqMRuf29sfpXMC
	bdmVCAI022ysmD5vsydLdvi0JX7G3I/Gj2SkrDHKZ6K1DQScMG3go3PVAjfMmzHV
	E6Z5sk4ZknKHi2J5RZIdGlgyXa/YPFkf98XnvlQj6x/lPAZz/xqiw1l6gqWbpfr5
	NKyTDIeOmEzk3pj3s+LcjD0UZ1ZLoxCwFUcLwCV44Tmj3BUSs/4g6lnJZYZGjHAI
	Ewjb0vYco2OsyRZFq81ElZ8Un8SG+XxnW0gekm5gwRYoR1B3Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9gsgfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 16:54:53 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OGspiA009227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 16:54:51 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 09:54:51 -0700
Date: Wed, 24 Apr 2024 09:54:50 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Luca Weiss <luca@z3ntu.xyz>
CC: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/7] rpmsg: qcom_smd: Don't print error during probe
 deferral
Message-ID: <Zik5WuYgJap2RVC5@hu-bjorande-lv.qualcomm.com>
References: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
 <20240424-apcs-mboxes-v1-1-6556c47cb501@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240424-apcs-mboxes-v1-1-6556c47cb501@z3ntu.xyz>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oU_Ag-3xolf0hvdHt6iLrwWj_OVuWzJT
X-Proofpoint-ORIG-GUID: oU_Ag-3xolf0hvdHt6iLrwWj_OVuWzJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_13,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240070

On Wed, Apr 24, 2024 at 06:23:54PM +0200, Luca Weiss wrote:
> When the mailbox driver has not probed yet, skip printing the error
> message since it's just going to confuse users.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  drivers/rpmsg/qcom_smd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
> index 43f601c84b4f..6fc299657adf 100644
> --- a/drivers/rpmsg/qcom_smd.c
> +++ b/drivers/rpmsg/qcom_smd.c
> @@ -1502,7 +1502,8 @@ struct qcom_smd_edge *qcom_smd_register_edge(struct device *parent,
>  
>  	ret = qcom_smd_parse_edge(&edge->dev, node, edge);
>  	if (ret) {
> -		dev_err(&edge->dev, "failed to parse smd edge\n");
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&edge->dev, "failed to parse smd edge\n");

In the described case, this error message would not be entirely
accurate, and the cause is not accurately captured in devices_deferred.

Unless I'm mistaken, it seems like qcom_smd_parse_edge() will also print
a more useful error in every other case, except after the mbox_chan !=
-ENODEV check..

How about making that:

	if (PTR_ERR(edge->mbox_chan) != -ENODEV) {
		ret = dev_err_probe(dev, PTR_ERR(edge->mbox_chan),
				    "failed to acquire IPC mailbox\n");
		goto put_node;
	}

And then drop the error print here in qcom_smd_register_edge().

It would bring us the devices_deferred tracking, and it would avoid the
double print in all other cases.

Regards,
Bjorn

>  		goto unregister_dev;
>  	}
>  
> 
> -- 
> 2.44.0
> 

