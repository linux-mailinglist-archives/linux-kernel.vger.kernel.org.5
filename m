Return-Path: <linux-kernel+bounces-141225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284598A1B17
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B775B1F22586
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B454D205E39;
	Thu, 11 Apr 2024 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hh1T/l8A"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C01205E26;
	Thu, 11 Apr 2024 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850308; cv=none; b=tzkzQDvhtHNLBAEScaV1MQsRmx93BK5EiTU73vy0dlg8l+XSjE0X4Q3DfyNFHQKv3Ol88M8whbLFKg/CvcZXjvhpOM5w7a8aWwHlqk2SChtjfT3UeJJPXAAqqLlnTYJ3vVQIGYF0ti4P0wTRPkfozsxy7nAgwswWcEZ12RtnRUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850308; c=relaxed/simple;
	bh=/IRr60aMZOeOyFiScIJ7Hqy89Fa77PW2HAAbz3xI4jQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efAXcmlEhSHdBfi0o1uUgguWkg82vehvhJt/QOQKRdFm2MrQy8Quy+SRmSpg3mIMYLAH2CYYeEvSW3w2H4slf9kCWHgkLtq+6+52R0Ot6ledVM9j/HXVsm/90rrAs5ZHifA5S4bGAbBke5M8h7VjRgawHxjHpDFD4bC0BXypfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hh1T/l8A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BDG7bV024388;
	Thu, 11 Apr 2024 15:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=haD8srUSA/7piIQcBMU+j
	z1u8jwrb7rUW232cvqEx3s=; b=Hh1T/l8AZXIPiuPJqEb+2xEhcwSozimpdVr7/
	ABvip+E1Wk/J/Zj8agqdbWyJOXCUiT7kxIstytMkXA+Kr/EioGE0k1drFabachGG
	e/twcqTZYzv9/ZuLmnPN3qe1clHinSdawWe/XA3nIErgRDeW4uRtXUcQGNH/g5LB
	rnwWMlOrXRIsrFHYwNEFgG5AxakO2YYA/gPwVGw0SJvV8jq4U85e4u4sjAhUfnBv
	psRlDjeOV5LSTGoaaOr+7fn2w0mbIocdr5edRg/SDi57nOvFQPmti6rJF1yvUb50
	dcbDTpIE+iyP7jKi+xqrz3TUbZFyfzUAR9PjsEMo8l8BCqSDQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xebqx9mg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 15:44:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BFijB4032349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 15:44:45 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 08:44:45 -0700
Date: Thu, 11 Apr 2024 08:44:44 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix
 Kernel Team <kernel@pengutronix.de>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sean Wang
	<sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <linux-gpio@vger.kernel.org>, <imx@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] pinctrl: qcom: sm7150: fix module autoloading
Message-ID: <ZhgFbKg8DPBsRrac@hu-bjorande-lv.qualcomm.com>
References: <20240411064614.7409-1-krzk@kernel.org>
 <20240411064614.7409-4-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240411064614.7409-4-krzk@kernel.org>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KU4mU--SOy6t8CFhdoXd3JVsuCKtrbVx
X-Proofpoint-ORIG-GUID: KU4mU--SOy6t8CFhdoXd3JVsuCKtrbVx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110115

On Thu, Apr 11, 2024 at 08:46:13AM +0200, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.  Pin controllers are
> considered core components, so usually they are built-in, however these
> can be built and used as modules on some generic kernel.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn

> ---
> 
> Changes in v2:
> 1. Add ack
> ---
>  drivers/pinctrl/qcom/pinctrl-sm7150.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm7150.c b/drivers/pinctrl/qcom/pinctrl-sm7150.c
> index c25357ca1963..c542f9bc6bcd 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sm7150.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sm7150.c
> @@ -1246,6 +1246,7 @@ static const struct of_device_id sm7150_tlmm_of_match[] = {
>  	{ .compatible = "qcom,sm7150-tlmm", },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, sm7150_tlmm_of_match);
>  
>  static struct platform_driver sm7150_tlmm_driver = {
>  	.driver = {
> -- 
> 2.34.1
> 

