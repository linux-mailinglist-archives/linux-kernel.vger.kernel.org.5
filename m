Return-Path: <linux-kernel+bounces-90426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A0886FEF6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8196CB24446
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AC536118;
	Mon,  4 Mar 2024 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mu4pUqfs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AA936AF3;
	Mon,  4 Mar 2024 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547717; cv=none; b=dgyeya2PQACxG/TZOFQVK/CIxXUl7rh+NTUQSZVeO8YT65tb2CkuqLd3HETgB+mjheuQ3kNTQZNc18j9igu7rzhnjlqQeUMhkhRBdYpiAIFFwgGp2vgrEQVUphDCAeuSY3vK5vEdfSXvFN2AB+XzXdjGuAql5QLJstpM5lVQsC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547717; c=relaxed/simple;
	bh=c/tbGWLUKFP9EhkQEqBxa/3Kj+2klMd4g8/coz+eCdQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S201cNw6J9koTwpLWv+TI3SvpCPNmTXV4kg43SF7+wE9EWQEuF7BwcAS9J///MFCFVMku2N5kVf5mT3zaO3JAp1IIVqP2nM8E9HeXjauVPuyt81x41IjK/3XM3OrsgPde1iTPl1kDKwt8g8KCbrEFIhXcxlO6JUWLSUu2uWr0J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mu4pUqfs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4248NdXW017245;
	Mon, 4 Mar 2024 10:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=Tklo4Ga1t15WWJ8MxR9Gn
	kKPj0rEEtSL15SD9X8GLnA=; b=Mu4pUqfs5pP1yU0QbVhCGLSRqVIif7k931g4d
	Q40zjB/+LwL5CLUXSAUl++z2JRaOY2AEgEqEduj0ziL7gMczkCCXdRywSpjUPCDc
	jagrtIKMtRSbB7F3Y6Cz5e+aV0Oi2k6ypbjd0AmhD2jT48EGAa9tj1GL2cX+69lM
	QGAQ116JC+RUcEEopDQUO+2meq01B/jhayQ11MRjxcHneE6RVtf5yPoCOT8VhKDz
	bk0n6S/acQL7J77/9GG6knjY5hyyKVU6mwDJjQYtnUdXGGimSL/T46/eZzdG/QTw
	i7x9uyrSYvG77/UR4TU436Q+A2V/6HNKWefkBx5gWzjvHZEyw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnarj0775-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 10:21:42 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 424ALf8H000480
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 10:21:41 GMT
Received: from hu-kuldsing-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 02:21:32 -0800
Date: Mon, 4 Mar 2024 15:51:28 +0530
From: Kuldeep Singh <quic_kuldsing@quicinc.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
CC: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh
	<quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Maximilian
 Luz" <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        "Srini
 Kandagatla" <srinivas.kandagatla@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel@quicinc.com>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Deepti Jaggi
	<quic_djaggi@quicinc.com>
Subject: Re: [PATCH v8 10/12] firmware: qcom: tzmem: enable SHM Bridge support
Message-ID: <20240304102127.GA27910@hu-kuldsing-hyd.qualcomm.com>
References: <20240303150115.133633-1-brgl@bgdev.pl>
 <20240303150115.133633-11-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240303150115.133633-11-brgl@bgdev.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g9V6OnY1YhdhvAj22hAJWmwk29_ZtmQ3
X-Proofpoint-GUID: g9V6OnY1YhdhvAj22hAJWmwk29_ZtmQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_06,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040078

On Sun, Mar 03, 2024 at 04:01:13PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> SHM Bridge is a safety mechanism allowing to limit the amount of memory
> shared between the kernel and the TrustZone to regions explicitly marked
> as such.
> 
> Add a variant of the tzmem allocator that configures the memory pools as
> SHM bridges. It also enables the SHM bridge globally so non-SHM bridge
> memory will no longer work with SCM calls.
> 
> If enabled at build-time, it will still be checked for availability at
> run-time. If the architecture doesn't support SHM Bridge, the allocator
> will fall back to the generic mode.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
> Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/firmware/qcom/Kconfig      | 10 +++++
>  drivers/firmware/qcom/qcom_tzmem.c | 65 +++++++++++++++++++++++++++++-
>  2 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index 4634f8cecc7b..7f6eb4174734 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -28,6 +28,16 @@ config QCOM_TZMEM_MODE_GENERIC
>  	  Use the generic allocator mode. The memory is page-aligned, non-cachable
>  	  and physically contiguous.
>  
> +config QCOM_TZMEM_MODE_SHMBRIDGE
> +	bool "SHM Bridge"
> +	help
> +	  Use Qualcomm Shared Memory Bridge. The memory has the same alignment as
> +	  in the 'Generic' allocator but is also explicitly marked as an SHM Bridge
> +	  buffer.
> +
> +	  With this selected, all buffers passed to the TrustZone must be allocated
> +	  using the TZMem allocator or else the TrustZone will refuse to use them.
> +
>  endchoice
>  
>  config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
> index 23f364afa6ca..244615e8c505 100644
> --- a/drivers/firmware/qcom/qcom_tzmem.c
> +++ b/drivers/firmware/qcom/qcom_tzmem.c
> @@ -67,7 +67,70 @@ static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
>  
>  }
>  
> -#endif /* CONFIG_QCOM_TZMEM_MODE_GENERIC */
> +#elif IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
> +
> +#include <linux/firmware/qcom/qcom_scm.h>
> +
> +#define QCOM_SHM_BRIDGE_NUM_VM_SHIFT 9
> +
> +static bool qcom_tzmem_using_shm_bridge;
> +
> +static int qcom_tzmem_init(void)
> +{
> +	int ret;
> +
> +	ret = qcom_scm_shm_bridge_enable();
> +	if (ret == -EOPNOTSUPP) {
> +		dev_info(qcom_tzmem_dev, "SHM Bridge not supported\n");
> +		return 0;
> +	}
> +
> +	if (!ret)
> +		qcom_tzmem_using_shm_bridge = true;
> +
> +	return ret;
> +}
> +
> +static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
> +{
> +	u64 pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_perms;
> +	int ret;
> +
> +	if (!qcom_tzmem_using_shm_bridge)
> +		return 0;
> +
> +	ns_perms = (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);

Above expr can be replaced with QCOM_SCM_PERM_RW.
https://elixir.bootlin.com/linux/v6.8-rc7/source/include/linux/firmware/qcom/qcom_scm.h#L59

Regards
Kuldeep

