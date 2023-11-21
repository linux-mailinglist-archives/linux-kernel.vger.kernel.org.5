Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDB77F25D0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjKUGfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKUGfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:35:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924C090;
        Mon, 20 Nov 2023 22:35:18 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL6FfF1000361;
        Tue, 21 Nov 2023 06:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=n+NOZrpLmgyZlIs5dpuqKAuyaTnOay6k8ZB1i6oal7A=;
 b=kV/lkbzkTLmEP4CCZOT1isigZbxo0l9fJWZ4nqkYiKqpRp/oL4kHlsUs6FkgFbN5//g/
 sKVYheMPGuIj8T3lSeysYqpsoEHfJXhwHl3GENZdTLyt3hBtFSdv1LdbsaiAsACj8UTf
 ma2uqoL8jx6+bfSVDZWG9fEZ8ivvvxVMSbz+OCO1KuqLhKdeRqjq4VVUnd6xEhFXaTZy
 m4ACStSZ49/E8a+Og9m7fFEYFr5LgZWE2nLmg93GWpuAfOBCxu3mobmHMprxXwUo9uMn
 rddEtXaKOt/rtyFDs6VnbHDNLfwVp9sPEQjpScwV8jetnSEA9/TGvX5pmUJMgZH/puaL CA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugcqs19mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 06:35:05 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL6Z42Z026285
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 06:35:04 GMT
Received: from [10.110.10.93] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 22:35:01 -0800
Message-ID: <6e189833-b76b-030f-482e-d13e0d6d131a@quicinc.com>
Date:   Mon, 20 Nov 2023 22:35:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RESEND PATCH v5 02/12] firmware: qcom: scm: enable the TZ mem
 allocator
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Maximilian Luz" <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        "Srini Kandagatla" <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@quicinc.com>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>
References: <20231120132118.30473-1-brgl@bgdev.pl>
 <20231120132118.30473-3-brgl@bgdev.pl>
Content-Language: en-US
From:   Prasad Sodagudi <quic_psodagud@quicinc.com>
In-Reply-To: <20231120132118.30473-3-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 56ScQPAA72nHRNHD82t-N3le8YtezNiF
X-Proofpoint-GUID: 56ScQPAA72nHRNHD82t-N3le8YtezNiF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210050
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/20/2023 5:21 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Select the TrustZone memory allocator in Kconfig and create a pool of
> memory shareable with the TrustZone when probing the SCM driver.
>
> This will allow a gradual conversion of all relevant SCM calls to using
> the dedicated allocator.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
> ---
>   drivers/firmware/qcom/Kconfig    |  1 +
>   drivers/firmware/qcom/qcom_scm.c | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+)
>
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index b80269a28224..237da40de832 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -7,6 +7,7 @@
>   menu "Qualcomm firmware drivers"
>   
>   config QCOM_SCM
> +	select QCOM_TZMEM
>   	tristate
>   
>   config QCOM_TZMEM
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 520de9b5633a..0d4c028be0c1 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -8,8 +8,10 @@
>   #include <linux/completion.h>
>   #include <linux/cpumask.h>
>   #include <linux/dma-mapping.h>
> +#include <linux/err.h>
>   #include <linux/export.h>
>   #include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_tzmem.h>
>   #include <linux/init.h>
>   #include <linux/interconnect.h>
>   #include <linux/interrupt.h>
> @@ -20,9 +22,11 @@
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
>   #include <linux/reset-controller.h>
> +#include <linux/sizes.h>
>   #include <linux/types.h>
>   
>   #include "qcom_scm.h"
> +#include "qcom_tzmem.h"
>   
>   static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
>   module_param(download_mode, bool, 0);
> @@ -41,6 +45,8 @@ struct qcom_scm {
>   	int scm_vote_count;
>   
>   	u64 dload_mode_addr;
> +
> +	struct qcom_tzmem_pool *mempool;
>   };
>   
>   struct qcom_scm_current_perm_info {
> @@ -1887,6 +1893,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
>   	if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-enabled"))
>   		qcom_scm_disable_sdi();
>   
> +	ret = qcom_tzmem_enable(__scm->dev);
> +	if (ret)
> +		return dev_err_probe(__scm->dev, ret,
> +				     "Failed to enable the TrustZone memory allocator\n");

Based on my knowledge shmbridge is supported from sm8250 SoC in the 
firmware.

sdm845 and couple of other targets may not have support shmbridge 
support and probe will be fail for these targets right?

> +
> +	__scm->mempool = devm_qcom_tzmem_pool_new(__scm->dev, SZ_256K);
> +	if (IS_ERR(__scm->mempool))
> +		return dev_err_probe(__scm->dev, PTR_ERR(__scm->mempool),
> +				     "Failed to create the SCM memory pool\n");
> +
>   	/*
>   	 * Initialize the QSEECOM interface.
>   	 *
