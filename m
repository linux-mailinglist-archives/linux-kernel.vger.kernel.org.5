Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83DD75F680
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjGXMkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjGXMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:40:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A15E4E;
        Mon, 24 Jul 2023 05:40:50 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OCNiX3031165;
        Mon, 24 Jul 2023 12:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aTN3pdOEUJI3zDtfX9jUpek3UHvVsMetr9DlPgNCHdM=;
 b=VYq9uYbu2QEY7giYNMAWsBZqVSlJujeP5kjtDdJ1LHULtZE5szI83vi6CL/DYofycARl
 QbP1NhvtuoYGzjAT+uuRvn3gzAducVutJIesX92gVJrUiST2vSgijJuguGQ4mOcsCx79
 A6fa2RMKcaaWYSnHTi0AvBXYvm6rtNK1Cdvy76r53MYPyKwyEKGvngPQX3UZyCVHbsXT
 GVP5y9Kj0xloN/eo3dynhV90sh57p7djEaavzvcmrQAaotd6i0k6o56MLllZZPNmY1iE
 3tPj0aUlEMEfSdL0BU4GB0pMW5R9otrAKtRYB+xy4qfEPXxYfFf0RqumVEW4Wo96fOmA Rg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s04fuufrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 12:40:45 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OCeir3011802
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 12:40:44 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 05:40:41 -0700
Message-ID: <6971e2d5-e97d-cb60-473a-e1966e3818cb@quicinc.com>
Date:   Mon, 24 Jul 2023 18:10:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 4/6] soc: qcom: Add LLCC support for multi channel DDR
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230724084155.8682-1-quic_kbajaj@quicinc.com>
 <20230724084155.8682-5-quic_kbajaj@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230724084155.8682-5-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cnvRQ6UloCk6xaOZmUD9-JFu2PTNqPxf
X-Proofpoint-GUID: cnvRQ6UloCk6xaOZmUD9-JFu2PTNqPxf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_08,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240112
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2023 2:11 PM, Komal Bajaj wrote:
> Add LLCC support for multi channel DDR configuration
> based on a feature register.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>   drivers/soc/qcom/llcc-qcom.c | 26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 321f8d2079f7..1d2b08dfecea 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -12,6 +12,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
> +#include <linux/nvmem-consumer.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
>   #include <linux/regmap.h>
> @@ -997,6 +998,19 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
>   	return ret;
>   }
>   
> +static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index)
> +{
> +	int ret;
> +
> +	ret = nvmem_cell_read_u8(&pdev->dev, "multi-chan-ddr", cfg_index);
> +	if (ret == -ENOENT || ret == -EOPNOTSUPP) {
> +		*cfg_index = 0;
> +		return 0;
> +	}
> +
> +	return ret;
> +}
> +
>   static int qcom_llcc_remove(struct platform_device *pdev)
>   {
>   	/* Set the global pointer to a error code to avoid referencing it */
> @@ -1033,6 +1047,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>   	const struct qcom_llcc_config *cfg;
>   	const struct llcc_slice_config *llcc_cfg;
>   	u32 sz;
> +	u8 cfg_index;
>   	u32 version;
>   	struct regmap *regmap;
>   
> @@ -1050,7 +1065,16 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>   	}
>   
>   	cfgs = of_device_get_match_data(&pdev->dev);
> -	cfg = &cfgs->llcc_config[0];
> +	ret = qcom_llcc_get_cfg_index(pdev, &cfg_index);
> +	 if (ret)

alignment.. ?

-Mukesh

> +		goto err;
> +
> +	if (cfg_index >= cfgs->num_cfgs) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	cfg = &cfgs->llcc_config[cfg_index];
>   
>   	ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
>   	if (ret)
