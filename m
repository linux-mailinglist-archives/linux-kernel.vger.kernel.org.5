Return-Path: <linux-kernel+bounces-43937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DAB841B19
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5814C289C41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E80F381B0;
	Tue, 30 Jan 2024 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BSbwCH+a"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0715376F2;
	Tue, 30 Jan 2024 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706589821; cv=none; b=RQXaNgCprAq6dHtchQPnn2P3gdyUdEVtg39bY6jra2jR2YYmg4On2fUb8xiBhsWkJs/0sPQvNWwNzygCLwB/zyDqw7qyr+apJflxMasO68YqexxGLCM43x4rlbaCoW6jSysdOFvpYwHiJgDl/r2TykMnQyMoXPHosjeaFV3ZTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706589821; c=relaxed/simple;
	bh=JPoxPFTiVNeEELD0yioByjjkHwiYtb0bi/b574VfYY8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJL1487IG1SmjHmhqBQKdyz7PiIp6cS1kv3PnZN9DMaFGs5tRQvPHrBMkBTHowSAt8AB5W2zmouWYsd/VqWDzxLmPdgwEjPBu0kQUOmyvBnoxof0foRFQBhmG1yHNDvhN+uthTvg+W3+NTu7bCdTjKSzj057Rk2aK8+8LWKIwtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BSbwCH+a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U3fFjC009188;
	Tue, 30 Jan 2024 04:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=pWFEskhoP9oDG95LJo7cn
	Oun93WuYdxPtgdyZ6WggcU=; b=BSbwCH+aul6dpJviCTrOZAwOKhxydxmo4iCNj
	+4MSnmRiKKZajdtXePvftSbc9FUvJxK693Y0IeOXO2MhT3UHAxrWeZSgT0k5/DH9
	U+lJXBstFBQHvE+M87e3aQYBV0OU9Skz9nFeb3mhuG/Pr9XUcKg5C0MxJgaVQ1GW
	KHVg5grf6aR0URxxeLfybACXGMW4ueNIYzKnq16hx7aA8eJfm1vlE301c92ccj62
	a/NqKgayFkK37KXjHbf+yLG4Eigr1MMcm+VmagM2S21F89wfZmjAtwF8yYu2nyOm
	x0NB//58xdSbJ4iuaxP2klBypN5PuQ20VQKOVWhgkM/Uh2NnQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxsc403rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:43:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U4hOP1029937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:43:24 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 20:43:21 -0800
Date: Mon, 29 Jan 2024 20:43:20 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Gaurav Kashyap <quic_gaurkash@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <andersson@kernel.org>, <ebiggers@google.com>,
        <neil.armstrong@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <kernel@quicinc.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_omprsing@quicinc.com>, <quic_nguyenb@quicinc.com>,
        <bartosz.golaszewski@linaro.org>, <konrad.dybcio@linaro.org>,
        <ulf.hansson@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <mani@kernel.org>, <davem@davemloft.net>,
        <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v4 02/15] qcom_scm: scm call for deriving a software
 secret
Message-ID: <20240130044320.GV2936378@hu-bjorande-lv.qualcomm.com>
References: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
 <20240127232436.2632187-3-quic_gaurkash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240127232436.2632187-3-quic_gaurkash@quicinc.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6Qi2lqNVEaExsDRler7rksB_ArMqefFy
X-Proofpoint-ORIG-GUID: 6Qi2lqNVEaExsDRler7rksB_ArMqefFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_01,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401300031

On Sat, Jan 27, 2024 at 03:14:00PM -0800, Gaurav Kashyap wrote:

The subject prefix does not match other changes to this file.

> Inline storage encryption may require deriving a software
> secret from storage keys added to the kernel.
> 
> For non-wrapped keys, this can be directly done in the kernel as
> keys are in the clear.
> 
> However, hardware wrapped keys can only be unwrapped by the wrapping
> entity. In case of Qualcomm's wrapped key solution, this is done by
> the Hardware Key Manager (HWKM) from Trustzone.
> Hence, adding a new SCM call which in the end provides a hook
> to the software secret crypto profile API provided by the block
> layer.
> 
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_scm.c       | 65 ++++++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_scm.h       |  1 +
>  include/linux/firmware/qcom/qcom_scm.h |  2 +
>  3 files changed, 68 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 7e17fd662bda..4882f8a36453 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1220,6 +1220,71 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_ice_set_key);
>  
> +/**
> + * qcom_scm_derive_sw_secret() - Derive software secret from wrapped key
> + * @wkey: the hardware wrapped key inaccessible to software
> + * @wkey_size: size of the wrapped key
> + * @sw_secret: the secret to be derived which is exactly the secret size
> + * @sw_secret_size: size of the sw_secret
> + *
> + * Derive a software secret from a hardware wrapped key for software crypto
> + * operations.
> + * For wrapped keys, the key needs to be unwrapped, in order to derive a
> + * software secret, which can be done in the hardware from a secure execution
> + * environment.
> + *
> + * For more information on sw secret, please refer to "Hardware-wrapped keys"
> + * section of Documentation/block/inline-encryption.rst.
> + *
> + * Return: 0 on success; -errno on failure.
> + */
> +int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
> +			      u8 *sw_secret, size_t sw_secret_size)
> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_ES,
> +		.cmd =  QCOM_SCM_ES_DERIVE_SW_SECRET,
> +		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RW,
> +					 QCOM_SCM_VAL, QCOM_SCM_RW,
> +					 QCOM_SCM_VAL),
> +		.args[1] = wkey_size,
> +		.args[3] = sw_secret_size,
> +		.owner = ARM_SMCCC_OWNER_SIP,
> +	};
> +
> +	void *secret_buf;
> +	void *wkey_buf;
> +	int ret;
> +
> +	wkey_buf = qcom_tzmem_alloc(__scm->mempool, wkey_size, GFP_KERNEL);
> +	if (!wkey_buf)
> +		return -ENOMEM;
> +
> +	secret_buf = qcom_tzmem_alloc(__scm->mempool, sw_secret_size, GFP_KERNEL);
> +	if (!secret_buf) {
> +		ret = -ENOMEM;
> +		goto err_free_wrapped;
> +	}
> +
> +	memcpy(wkey_buf, wkey, wkey_size);
> +	desc.args[0] = qcom_tzmem_to_phys(wkey_buf);
> +	desc.args[2] = qcom_tzmem_to_phys(secret_buf);
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, NULL);
> +	if (!ret)
> +		memcpy(sw_secret, secret_buf, sw_secret_size);
> +
> +	memzero_explicit(secret_buf, sw_secret_size);
> +	qcom_tzmem_free(secret_buf);
> +
> +err_free_wrapped:

This code path is shared between error path and normal path, prefixing
it "err_" is not helpful to the reader. Please change this to
out_free_wrapped:

The rest of the patch looks good to me.

Regards,
Bjorn

> +	memzero_explicit(wkey_buf, wkey_size);
> +	qcom_tzmem_free(wkey_buf);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_scm_derive_sw_secret);
> +
>  /**
>   * qcom_scm_hdcp_available() - Check if secure environment supports HDCP.
>   *
> diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
> index cb7273aa0a5e..56ff0806f5d2 100644
> --- a/drivers/firmware/qcom/qcom_scm.h
> +++ b/drivers/firmware/qcom/qcom_scm.h
> @@ -127,6 +127,7 @@ struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void);
>  #define QCOM_SCM_SVC_ES			0x10	/* Enterprise Security */
>  #define QCOM_SCM_ES_INVALIDATE_ICE_KEY	0x03
>  #define QCOM_SCM_ES_CONFIG_SET_ICE_KEY	0x04
> +#define QCOM_SCM_ES_DERIVE_SW_SECRET	0x07
>  
>  #define QCOM_SCM_SVC_HDCP		0x11
>  #define QCOM_SCM_HDCP_INVOKE		0x01
> diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
> index 9b6054813f59..89358478ac67 100644
> --- a/include/linux/firmware/qcom/qcom_scm.h
> +++ b/include/linux/firmware/qcom/qcom_scm.h
> @@ -103,6 +103,8 @@ bool qcom_scm_ice_available(void);
>  int qcom_scm_ice_invalidate_key(u32 index);
>  int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
>  			 enum qcom_scm_ice_cipher cipher, u32 data_unit_size);
> +int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
> +			      u8 *sw_secret, size_t sw_secret_size);
>  
>  bool qcom_scm_hdcp_available(void);
>  int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp);
> -- 
> 2.43.0
> 

