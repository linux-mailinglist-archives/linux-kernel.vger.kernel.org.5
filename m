Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31A178EEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjHaNqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjHaNqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:46:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483C9CEB;
        Thu, 31 Aug 2023 06:46:49 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VCigCe021519;
        Thu, 31 Aug 2023 13:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0QAbPOvUPYlwqzR4arIl7bIDgtzRg35Vg/MUk0OueI4=;
 b=fhqSwamdiSfkVKnxYmqLa6jFVqCQyDt6VNrAiKSQ6lidR9FvQZXnzsleA4oN2PsLM/Sx
 HfzDRfWMplijxH7LGC7F/2A5Ec7LyLqxQY7+kvUWSHp+SgNycYQSDPZ/EB+RH14jIFhs
 om8sa5iJtiKzXtZg82MCGCuHVNmZq+m+GNs9dYud2KKysm0c6Ac1+CCcDbco8W+29aV0
 0hLH9kktSoJyj5EJuZbS/2gPSlZgVhnrqZdUYfs+yU/3LWKcmEm5BVax8+T/oxipopZ9
 EuaGQ6EoxM3qR8xXkN8iuHyd8OGQVjXlt8ahTmSzm4lc1WW0juCcLfcqwwUOM6ZeRH68 Nw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st0taucv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 13:46:42 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37VDkg2t003607
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 13:46:42 GMT
Received: from [10.216.37.211] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 31 Aug
 2023 06:46:38 -0700
Message-ID: <be11039a-02e8-0aaa-a2f9-4e5f8e41b5ca@quicinc.com>
Date:   Thu, 31 Aug 2023 19:16:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 4/6] soc: qcom: Add LLCC support for multi channel DDR
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>,
        <bryan.odonoghue@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230830105654.28057-1-quic_kbajaj@quicinc.com>
 <20230830105654.28057-5-quic_kbajaj@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230830105654.28057-5-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TZEQb_9IKqLTgEeJ1zRqI4xCFSxmVX96
X-Proofpoint-ORIG-GUID: TZEQb_9IKqLTgEeJ1zRqI4xCFSxmVX96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_11,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310123
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/2023 4:26 PM, Komal Bajaj wrote:
> Add LLCC support for multi channel DDR configuration
> based on a feature register.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>

LGTM, thanks for the regular follow up on this.

Reviewed-by : Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> ---
>   drivers/soc/qcom/llcc-qcom.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index cbef8d825361..c31d9e39e864 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -12,6 +12,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
> +#include <linux/nvmem-consumer.h>
>   #include <linux/of.h>
>   #include <linux/regmap.h>
>   #include <linux/sizes.h>
> @@ -995,6 +996,24 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
>   	return ret;
>   }
> 
> +static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index, int num_config)
> +{
> +	int ret;
> +
> +	ret = nvmem_cell_read_u8(&pdev->dev, "multi-chan-ddr", cfg_index);
> +	if (ret == -ENOENT || ret == -EOPNOTSUPP) {
> +		if (num_config > 1)
> +			return -EINVAL;
> +		*cfg_index = 0;
> +		return 0;
> +	}
> +
> +	if (!ret && *cfg_index >= num_config)
> +		ret = -EINVAL;
> +
> +	return ret;
> +}
> +
>   static int qcom_llcc_remove(struct platform_device *pdev)
>   {
>   	/* Set the global pointer to a error code to avoid referencing it */
> @@ -1031,6 +1050,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>   	const struct qcom_llcc_config *cfg;
>   	const struct llcc_slice_config *llcc_cfg;
>   	u32 sz;
> +	u8 cfg_index;
>   	u32 version;
>   	struct regmap *regmap;
> 
> @@ -1052,7 +1072,10 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>   		ret = -EINVAL;
>   		goto err;
>   	}
> -	cfg = &cfgs->llcc_config[0];
> +	ret = qcom_llcc_get_cfg_index(pdev, &cfg_index, cfgs->num_config);
> +	if (ret)
> +		goto err;
> +	cfg = &cfgs->llcc_config[cfg_index];
> 
>   	ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
>   	if (ret)
> --
> 2.41.0
> 
