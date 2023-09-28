Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F28F7B2367
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjI1RKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjI1RKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:10:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992E11B3;
        Thu, 28 Sep 2023 10:10:02 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SFfWsP004752;
        Thu, 28 Sep 2023 17:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3tON1gLIqp/tPlDuSOu5ArpoTQRgcHQEUzTqf6Wzfz0=;
 b=jYfUeaC76/EwCEtukk2drHBKFjsGPP/w5dZKTRyynti71Wki++zlQGv+v8Bn8Q9LgTqp
 40hELgcx8LsDktUfpYyUY40AvTg8tGKvwauooarl9dyqevyKO2E18iLkWrd+VONQgJcn
 xNhOBFPehC9o1J6eb6jA9aToa0tzDNwH12UxRKiIVkDpnYX4d1ZVaDZ228YHWGAhHuSP
 HuRG2IqU1aRSJZpu3RNYolC27t/dTlsc0SKY63k8azJ3Gz0ZqflhwEdQ2IKkccYV7Crp
 boymnAkqHJLkT6RYVdo8sgUZaRtgibCZEtkbniFepnPQ0QHb4ppKJg1McMVSdA7InkLm rg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tcra22xry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 17:09:48 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38SH9mZ4008722
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 17:09:48 GMT
Received: from [10.110.102.158] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 28 Sep
 2023 10:09:43 -0700
Message-ID: <4c7a0ba9-754a-4feb-b078-4b14a96b4a23@quicinc.com>
Date:   Thu, 28 Sep 2023 10:09:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] firmware: qcom-scm: add support for SHM bridge
 operations
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230928092040.9420-1-brgl@bgdev.pl>
 <20230928092040.9420-11-brgl@bgdev.pl>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230928092040.9420-11-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UVpfw5UZLruojDcAOEqrKOGuquEM0OdD
X-Proofpoint-GUID: UVpfw5UZLruojDcAOEqrKOGuquEM0OdD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/28/2023 2:20 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add low-level primitives for enabling SHM bridge support, creating SHM
> bridge pools and testing the availability of SHM bridges to qcom-scm. We
> don't yet provide a way to destroy the bridges as the first user will
> not require it.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

After fixing the typo:

Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

> ---
>  drivers/firmware/qcom/qcom_scm.c       | 43 ++++++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_scm.h       |  2 ++
>  include/linux/firmware/qcom/qcom_scm.h |  6 ++++
>  3 files changed, 51 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 1fa27c44f472..5969ff0c0beb 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1296,6 +1296,49 @@ bool qcom_scm_lmh_dcvsh_available(void)
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh_available);
>  
> +int qcom_scm_enable_shm_bridge(void)
> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_MP,
> +		.cmd = QCOM_SCM_MP_SHM_BRIDGE_ENABLE,
> +		.owner = ARM_SMCCC_OWNER_SIP
> +	};
> +
> +	struct qcom_scm_res res;
> +
> +	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_MP,
> +					  QCOM_SCM_MP_SHM_BRIDGE_ENABLE))
> +		return -EOPNOTSUPP;
> +
> +	return qcom_scm_call(__scm->dev, &desc, &res) ?: res.result[0];
> +}
> +EXPORT_SYMBOL_GPL(qcom_scm_enable_shm_bridge);
> +
> +int qcom_scm_create_shm_bridge(struct device *dev, u64 pfn_and_ns_perm_flags,
> +			       u64 ipfn_and_s_perm_flags, u64 size_and_flags,
> +			       u64 ns_vmids)
> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_MP,
> +		.cmd = QCOM_SCM_MP_SHM_BRDIGE_CREATE,

s/BRDIGE/BRIDGE/g

> +		.owner = ARM_SMCCC_OWNER_SIP,
> +		.args[0] = pfn_and_ns_perm_flags,
> +		.args[1] = ipfn_and_s_perm_flags,
> +		.args[2] = size_and_flags,
> +		.args[3] = ns_vmids,
> +		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_VAL, QCOM_SCM_VAL,
> +					 QCOM_SCM_VAL, QCOM_SCM_VAL),
> +	};
> +
> +	struct qcom_scm_res res;
> +	int ret;
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +
> +	return ret ?: res.result[0];
> +}
> +EXPORT_SYMBOL_GPL(qcom_scm_create_shm_bridge);
> +
>  int qcom_scm_lmh_profile_change(u32 profile_id)
>  {
>  	struct qcom_scm_desc desc = {
> diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
> index 8c97e3906afa..f5a29bc0f549 100644
> --- a/drivers/firmware/qcom/qcom_scm.h
> +++ b/drivers/firmware/qcom/qcom_scm.h
> @@ -116,6 +116,8 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
>  #define QCOM_SCM_MP_IOMMU_SET_CP_POOL_SIZE	0x05
>  #define QCOM_SCM_MP_VIDEO_VAR			0x08
>  #define QCOM_SCM_MP_ASSIGN			0x16
> +#define QCOM_SCM_MP_SHM_BRIDGE_ENABLE		0x1c
> +#define QCOM_SCM_MP_SHM_BRDIGE_CREATE		0x1e

s/BRDIGE/BRIDGE/g

>  
>  #define QCOM_SCM_SVC_OCMEM		0x0f
>  #define QCOM_SCM_OCMEM_LOCK_CMD		0x01
> diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
> index 291ef8fd21b0..dc26cfd6d011 100644
> --- a/include/linux/firmware/qcom/qcom_scm.h
> +++ b/include/linux/firmware/qcom/qcom_scm.h
> @@ -6,6 +6,7 @@
>  #define __QCOM_SCM_H
>  
>  #include <linux/cleanup.h>
> +#include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/gfp.h>
>  #include <linux/types.h>
> @@ -122,6 +123,11 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>  int qcom_scm_lmh_profile_change(u32 profile_id);
>  bool qcom_scm_lmh_dcvsh_available(void);
>  
> +int qcom_scm_enable_shm_bridge(void);
> +int qcom_scm_create_shm_bridge(struct device *dev, u64 pfn_and_ns_perm_flags,
> +			       u64 ipfn_and_s_perm_flags, u64 size_and_flags,
> +			       u64 ns_vmids);
> +
>  #ifdef CONFIG_QCOM_QSEECOM
>  
>  int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id);
