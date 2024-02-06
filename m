Return-Path: <linux-kernel+bounces-55402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E7A84BC46
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B9D1C244D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D050DF5C;
	Tue,  6 Feb 2024 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K3E7EjXo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DEFC15B;
	Tue,  6 Feb 2024 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241069; cv=none; b=TPm0uCtdQTtF+x2QOFPKYvL6M5qZKtbYc3spWJDo4rfyZjT9niABStU1HE2pSbH8NTHpBnmnPFV9zJLAuRNe7h6G0mb9LXnXQezvVMmRHqOIR/GUgEnzwWYc/4L3PJqWtPPsVXuniPVNHV2HhR/T106Dk6MmhLcXmfVrKpLgn7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241069; c=relaxed/simple;
	bh=QhKjdUyYc9x3l14yyjgNcyAXH+3ItvWxs5m15qoyz/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xh+O7QybHX0jFSUh/M1sxA4vin9nnRB+dyrB90sU8f/tUBY++TWULBFbSHKGohdw6GVu/pC+g04xyrVgZVblnYbOkwHy8AnkShWU3BZHjbvlewPVnmoi9/hMYKa14AifX28s7aWAsi/Wh2QY2hl7w8DfKE7QlRRgMYXrYqLZG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K3E7EjXo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 416CqE9h003991;
	Tue, 6 Feb 2024 17:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YSZbU39de2Pw9PYzWE9cTPaZgT4sfubdamZgAk/WS5o=; b=K3
	E7EjXoo85Qa1CM+5EJK9RbXaF1WUTu1E7kj0x3RzzjIfj+ZeZEQdExqxCz1eTdLN
	cA2WZGDPxmlQX2u1URgwU9QNHUaIzuqlkZizOvqSob/t9pD9VVbVKiLAqcnRTeQA
	ZSwNiu6Zi/egkUvlKup94GCYn299A+mfr5I6Mz9JQP+j9uT02Q7aN24MKx8+PJhq
	GIz1XRzMBeCzsQAd6zBXqJJqB1T9vkNpp1pi9zddz//G8qXv7o9W/bPpyDzt3Wup
	cGyOoV/T9wZEYQpGhATC6ycW85o/AymZ3QMdKEj0snmXWWBSERhYvFBaxtBOizKU
	M68tFA4PEW5GuN8vL1Ug==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w31wnu71f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 17:37:13 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416HbCxk012164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 17:37:12 GMT
Received: from [10.71.111.207] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 09:37:11 -0800
Message-ID: <6436b9c7-de53-4248-9c06-48c39c54e014@quicinc.com>
Date: Tue, 6 Feb 2024 09:37:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/panel: simple: push blanking limit on RK32FN48H
Content-Language: en-US
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
References: <20240205-ltdc_mp13-v1-0-116d43ebba75@foss.st.com>
 <20240205-ltdc_mp13-v1-5-116d43ebba75@foss.st.com>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240205-ltdc_mp13-v1-5-116d43ebba75@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7qIUBFQcaiZMpdVSbLBGTgixzgx6ubmK
X-Proofpoint-GUID: 7qIUBFQcaiZMpdVSbLBGTgixzgx6ubmK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060123



On 2/5/2024 1:26 AM, Raphael Gallais-Pou wrote:
> Push horizontal front porch and vertical back porch blanking limit.
> This allows to get a 60 fps sharp.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

Hi Raphael,

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> ---
>   drivers/gpu/drm/panel/panel-simple.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 7b286382ffb4..10b361d603be 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -3516,10 +3516,10 @@ static const struct display_timing rocktech_rk043fn48h_timing = {
>   	.pixelclock = { 6000000, 9000000, 12000000 },
>   	.hactive = { 480, 480, 480 },
>   	.hback_porch = { 8, 43, 43 },
> -	.hfront_porch = { 2, 8, 8 },
> +	.hfront_porch = { 2, 8, 10 },
>   	.hsync_len = { 1, 1, 1 },
>   	.vactive = { 272, 272, 272 },
> -	.vback_porch = { 2, 12, 12 },
> +	.vback_porch = { 2, 12, 26 },
>   	.vfront_porch = { 1, 4, 4 },
>   	.vsync_len = { 1, 10, 10 },
>   	.flags = DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_HSYNC_LOW |
> 
> -- 
> 2.25.1
> 

