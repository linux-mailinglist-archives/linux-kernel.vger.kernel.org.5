Return-Path: <linux-kernel+bounces-168147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48148BB449
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DA91C21C87
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6A2158A39;
	Fri,  3 May 2024 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GmtIxKKw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A8FD51A;
	Fri,  3 May 2024 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765374; cv=none; b=L5YMR448ADJkqycfscmwCjuoU+hu1dZuo1y1749cMCLmokZI7Kh3FIPjkrViSLTBLkZ0IOo+y2txhhsfxYudlC2Ip0zZAmbZXAnVzHJRwOSRTpGOTbhw7Xfu0Ek6ft82Xee0zcTv64NglfHL9jmpJki0kF/OBtfjIGW55P7VtNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765374; c=relaxed/simple;
	bh=IQN5QjIn1RZWTwXEakOXK5gedy/uHSNwa88sq9b6KVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QRq/N/nluZYxgJQuFRVvnGujPSL245WgzLc1luTwVSpQmM+omyTL9rwKt4X4amKvELgywjyy0qBmhIFHP+IRM9xZDRRP4sG8TKVJw6Sgb80qimfVbLCad9tx0ZyIb4bHeBEkzlAp4i3D6+a5JpfgxqEFoK0gyenW3Co5W3xEn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GmtIxKKw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 443Jeo2Z014580;
	Fri, 3 May 2024 19:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Rgm4jiBiBwxRzKcwO+Se0j2hgZlRD3hn15OaPV3cY8A=; b=Gm
	tIxKKwsXCk3RYVFfgKI/qKa/36laJsGV+Pfdx18zKNlIuDEQYKaTQ5n8HopRxfMP
	xIr4r7kq7nxVOIZiuf7D9llaTej8edvKXHYb8Z/p8WlTBIrZRdxLDNm64S2jmgZV
	i9E1AkkdINb0T2/xN2Bg0QYHM0SAze33EiG9gNNoo9k6UulD8uoeXVr6npSgr6x5
	/EFeQbvJUbrzEMAyWd174OZeJvnc5ht7FCgxdix/Z/AvFK9s5yt5hzhiF+tYyOwT
	TwVQwDXP8dfUxXENcmmRyr2iWJOUzIYh7IF4IQeBsfAL/IgCMN7OvDqaxdIB4qz3
	TafBAtLZXfqsX0kec6Eg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xv8vsbmbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 19:42:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 443JgXuS023300
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 19:42:33 GMT
Received: from [10.110.114.34] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 May 2024
 12:42:32 -0700
Message-ID: <69b593b7-109c-825f-3dbb-5e8cce63ff01@quicinc.com>
Date: Fri, 3 May 2024 12:42:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] drm/ci: validate drm/msm XML register files
 against schema
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>,
        Helen Koike <helen.koike@collabora.com>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240503-fd-fix-lxml-v2-0-f80a60ce21a1@linaro.org>
 <20240503-fd-fix-lxml-v2-2-f80a60ce21a1@linaro.org>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240503-fd-fix-lxml-v2-2-f80a60ce21a1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WEqClIqYZAfkNL2YIBX1xByGEZaaO_ot
X-Proofpoint-GUID: WEqClIqYZAfkNL2YIBX1xByGEZaaO_ot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_13,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030139



On 5/3/2024 11:15 AM, Dmitry Baryshkov wrote:
> In order to validate drm/msm register definition files against schema,
> reuse the nodebugfs build step. The validation entry is guarded by
> the EXPERT Kconfig option and we don't want to enable that option for
> all the builds.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/ci/build.sh  | 3 +++
>   drivers/gpu/drm/ci/build.yml | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> index 106f2d40d222..28a495c0c39c 100644
> --- a/drivers/gpu/drm/ci/build.sh
> +++ b/drivers/gpu/drm/ci/build.sh
> @@ -12,6 +12,9 @@ rm -rf .git/rebase-apply
>   apt-get update
>   apt-get install -y libssl-dev
>   
> +# for msm header validation
> +apt-get install -y python3-lxml
> +
>   if [[ "$KERNEL_ARCH" = "arm64" ]]; then
>       GCC_ARCH="aarch64-linux-gnu"
>       DEBIAN_ARCH="arm64"
> diff --git a/drivers/gpu/drm/ci/build.yml b/drivers/gpu/drm/ci/build.yml
> index 17ab38304885..9c198239033d 100644
> --- a/drivers/gpu/drm/ci/build.yml
> +++ b/drivers/gpu/drm/ci/build.yml
> @@ -106,6 +106,7 @@ build-nodebugfs:arm64:
>     extends: .build:arm64
>     variables:
>       DISABLE_KCONFIGS: "DEBUG_FS"
> +    ENABLE_KCONFIGS: "EXPERT DRM_MSM_VALIDATE_XML"
>   

Wouldnt this end up enabling DRM_MSM_VALIDATE_XML for any arm64 device.

Cant we make this build rule msm specific?

