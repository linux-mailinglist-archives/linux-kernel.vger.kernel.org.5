Return-Path: <linux-kernel+bounces-90906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C54870698
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270431F22206
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074294D58E;
	Mon,  4 Mar 2024 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p7UIhgCe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7129487BC;
	Mon,  4 Mar 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568457; cv=none; b=gmGIn4WVctz8nmDiIJ/mJ+KCvdJPB1cVk7nitki/m8fSrQNQIwS/AQuFfrevNuLg71hu/lwNPhMUwymGeATRQSmvahnS72rOlgN+r85mW2MLeHfbYRgMEuGhVrmd2qO49JQSknwIRvnXZ7PSmSyJjjdN8a8tfyPRTXrCG7mCMMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568457; c=relaxed/simple;
	bh=WF/EEFZrmJjMBQfMivy5LrAaq/VlLYeGCZlYf791WMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u48CODQ8E/rhH1LlAwV8K7NKBQzPaM7ItlY93+Wzz40MUFpvitKvd54WmCmpVuQVL2t2yLTY1HTAe1y+Y7oHZwht7lNjYqS8+ffXQ7unzJFwi9Nl2sIEF6ZqXSlu/CV0l8vRxd3bwwPSQ11KhlU9XjWPiLze1AVsr2DuZsc5F7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p7UIhgCe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 424F02dG017300;
	Mon, 4 Mar 2024 16:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5o9R0X1NzIFRxEN2M3lWd3jajs/abX3dUuumtfderu8=; b=p7
	UIhgCeN6GIGppHBVOF1EhnPFpsT6ntO6HT7BY2RClap8Ihd1lwRaHGMHJsidY1Me
	V9XJ3dwN4eYZQgR6prhllr5pxDqgx2159P/tGprlAQYAtrTh/vgQo1/aCAt9LaDN
	aK1GyUTeyYAqZou08JZSh7Pu9X3H4wB84DEbStXGMNiP/s35Bu+URuZ+He4lst64
	kVhFWcSr9i7rRrEKhkF0qZrWDN+pg9gjyCwmACq6eQ0n1iwHLVA3K5U5OHHpQ2SR
	ZcRkdSYXYaIcN3Sxt3mGLpYBkBwJ5oPMgLXDXRxIiYniOJglN1oAv85lLEkPkQoW
	FVa07jPzysRTSsZAUlhQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnarj0wmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 16:07:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 424G7LoL011139
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 16:07:21 GMT
Received: from [10.110.86.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Mar
 2024 08:07:17 -0800
Message-ID: <2f88d113-96c5-425f-9efa-34269581da09@quicinc.com>
Date: Mon, 4 Mar 2024 08:07:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/12] firmware: qcom: add a dedicated TrustZone buffer
 allocator
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh
	<quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Maximilian
 Luz" <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        "Srini
 Kandagatla" <srinivas.kandagatla@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@quicinc.com>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Deepti Jaggi
	<quic_djaggi@quicinc.com>
References: <20240303150115.133633-1-brgl@bgdev.pl>
 <20240303150115.133633-2-brgl@bgdev.pl>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240303150115.133633-2-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: koqonFUvRqPBOXQ99tpszGborhmpsQNL
X-Proofpoint-GUID: koqonFUvRqPBOXQ99tpszGborhmpsQNL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_12,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040123

On 3/3/2024 7:01 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We have several SCM calls that require passing buffers to the TrustZone
> on top of the SMC core which allocates memory for calls that require
> more than 4 arguments.
> 
> Currently every user does their own thing which leads to code
> duplication. Many users call dma_alloc_coherent() for every call which
> is terribly unperformant (speed- and size-wise).
> 
> Provide a set of library functions for creating and managing pools of
> memory which is suitable for sharing with the TrustZone, that is:
> page-aligned, contiguous and non-cachable as well as provides a way of
> mapping of kernel virtual addresses to physical space.
> 
> Make the allocator ready for extending with additional modes of operation
> which will allow us to support the SHM bridge safety mechanism once all
> users convert.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
> Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  MAINTAINERS                              |   8 +
>  drivers/firmware/qcom/Kconfig            |  20 ++
>  drivers/firmware/qcom/Makefile           |   1 +
>  drivers/firmware/qcom/qcom_tzmem.c       | 392 +++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_tzmem.h       |  13 +
>  include/linux/firmware/qcom/qcom_tzmem.h |  56 ++++
>  6 files changed, 490 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_tzmem.c
>  create mode 100644 drivers/firmware/qcom/qcom_tzmem.h
>  create mode 100644 include/linux/firmware/qcom/qcom_tzmem.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1794b8d7c76b..c1138c709365 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18327,6 +18327,14 @@ L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/firmware/qcom/qcom_qseecom.c
>  
> +QUALCOMM TRUST ZONE MEMORY ALLOCATOR
> +M:	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/firmware/qcom/qcom_tzmem.c
> +F:	drivers/firmware/qcom/qcom_tzmem.h
> +F:	include/linux/firmware/qcom/qcom_tzmem.h
> +
>  QUALCOMM QSEECOM UEFISECAPP DRIVER
>  M:	Maximilian Luz <luzmaximilian@gmail.com>
>  L:	linux-arm-msm@vger.kernel.org

entries should be in alphabetic order so at a minimum QUALCOMM TRUST...
should be after QUALCOMM QSEECOM...

seems your addition belong just before QUALCOMM TSENS THERMAL DRIVER

/jeff

