Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E9A7B7A80
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbjJDIqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241828AbjJDIqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:46:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697FEB4;
        Wed,  4 Oct 2023 01:45:58 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3945gWi6010655;
        Wed, 4 Oct 2023 08:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bUTwAgBTkAW73VZQU7ly3NnRTsZxNPhoaf8XJA07n7A=;
 b=RhLv9DYh6Lh1lkkoXcoa72jFr9Xidwf36//xZU1zkOpEK5FYVeoh4t/2u9J0JfPA55rk
 +ojyZnAjO1GOcLftxRxsJ9/NCJdoviFJfeTP7InZaxdeOwnfQri/6CXQe27IaWE/MO2x
 +Kt02QhORC2DQjYR/OHcVuULbS/yMdQBN1fEc7VCmGyfDOpE0+lqSW+QX33vHRHi45Jb
 7ucdN7UjUbvCluDekCx63sWJIBh3C4uU1Opn42UDWlB4RTnJ0lx/OmxPZ5vvaUuMk1J4
 jrRUVGhk3D0Vt8mm5rTmZw84qRQqZQ5534wT1846hhnKQJQbEoty/DsiNIPj8PLtj949 dw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th1cy0cyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 08:45:45 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3948jiPB021039
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 08:45:44 GMT
Received: from [10.218.47.181] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 4 Oct
 2023 01:45:39 -0700
Message-ID: <23dd01f1-a772-475f-aa0b-cb4cf34f39e3@quicinc.com>
Date:   Wed, 4 Oct 2023 14:15:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] crypto: qcom-rng - Add hw_random interface support
Content-Language: en-US
To:     <neil.armstrong@linaro.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20231003-topic-sm8550-rng-v4-0-255e4d0ba08e@linaro.org>
 <20231003-topic-sm8550-rng-v4-3-255e4d0ba08e@linaro.org>
From:   Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <20231003-topic-sm8550-rng-v4-3-255e4d0ba08e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Sb9CQg0oKJwqCZuG5s89SYkHX-DMCkJT
X-Proofpoint-GUID: Sb9CQg0oKJwqCZuG5s89SYkHX-DMCkJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/2023 12:40 PM, neil.armstrong@linaro.org wrote:
> From: Om Prakash Singh <quic_omprsing@quicinc.com>
> 
> Add hw_random interface support in qcom-rng driver as new IP block
> in Qualcomm SoC has inbuilt NIST SP800 90B compliant entropic source
> to generate true random number.
> 
> Keeping current rng_alg interface as well for random number generation
> using Kernel Crypto API.
> 
> Signed-off-by: Om Prakash Singh <quic_omprsing@quicinc.com>
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Acked-by: Om Prakash Singh <quic_omprsing@quicinc.com>

>   drivers/crypto/qcom-rng.c | 65 ++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 58 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
> index 825a729f205e..8b506abb934c 100644
> --- a/drivers/crypto/qcom-rng.c
> +++ b/drivers/crypto/qcom-rng.c
> @@ -7,6 +7,7 @@
>   #include <linux/acpi.h>
>   #include <linux/clk.h>
>   #include <linux/crypto.h>
> +#include <linux/hw_random.h>
>   #include <linux/io.h>
>   #include <linux/iopoll.h>
>   #include <linux/kernel.h>
> @@ -28,17 +29,25 @@
>   
>   #define WORD_SZ			4
>   
> +#define QCOM_TRNG_QUALITY	1024
> +
>   struct qcom_rng {
>   	struct mutex lock;
>   	void __iomem *base;
>   	struct clk *clk;
> -	unsigned int skip_init;
> +	struct hwrng hwrng;
> +	struct qcom_rng_of_data *of_data;
>   };
>   
>   struct qcom_rng_ctx {
>   	struct qcom_rng *rng;
>   };
>   
> +struct qcom_rng_of_data {
> +	bool skip_init;
> +	bool hwrng_support;
> +};
> +
>   static struct qcom_rng *qcom_rng_dev;
>   
>   static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
> @@ -66,11 +75,11 @@ static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
>   		} else {
>   			/* copy only remaining bytes */
>   			memcpy(data, &val, max - currsize);
> -			break;
> +			currsize = max;
>   		}
>   	} while (currsize < max);
>   
> -	return 0;
> +	return currsize;
>   }
>   
>   static int qcom_rng_generate(struct crypto_rng *tfm,
> @@ -92,6 +101,9 @@ static int qcom_rng_generate(struct crypto_rng *tfm,
>   	mutex_unlock(&rng->lock);
>   	clk_disable_unprepare(rng->clk);
>   
> +	if (ret >= 0)
> +		ret = 0;
> +
>   	return ret;
>   }
>   
> @@ -101,6 +113,13 @@ static int qcom_rng_seed(struct crypto_rng *tfm, const u8 *seed,
>   	return 0;
>   }
>   
> +static int qcom_hwrng_read(struct hwrng *hwrng, void *data, size_t max, bool wait)
> +{
> +	struct qcom_rng *qrng = container_of(hwrng, struct qcom_rng, hwrng);
> +
> +	return qcom_rng_read(qrng, data, max);
> +}
> +
>   static int qcom_rng_enable(struct qcom_rng *rng)
>   {
>   	u32 val;
> @@ -136,7 +155,7 @@ static int qcom_rng_init(struct crypto_tfm *tfm)
>   
>   	ctx->rng = qcom_rng_dev;
>   
> -	if (!ctx->rng->skip_init)
> +	if (!ctx->rng->of_data->skip_init)
>   		return qcom_rng_enable(ctx->rng);
>   
>   	return 0;
> @@ -177,15 +196,31 @@ static int qcom_rng_probe(struct platform_device *pdev)
>   	if (IS_ERR(rng->clk))
>   		return PTR_ERR(rng->clk);
>   
> -	rng->skip_init = (unsigned long)device_get_match_data(&pdev->dev);
> +	rng->of_data = (struct qcom_rng_of_data *)of_device_get_match_data(&pdev->dev);
>   
>   	qcom_rng_dev = rng;
>   	ret = crypto_register_rng(&qcom_rng_alg);
>   	if (ret) {
>   		dev_err(&pdev->dev, "Register crypto rng failed: %d\n", ret);
>   		qcom_rng_dev = NULL;
> +		return ret;
> +	}
> +
> +	if (rng->of_data->hwrng_support) {
> +		rng->hwrng.name = "qcom_hwrng";
> +		rng->hwrng.read = qcom_hwrng_read;
> +		rng->hwrng.quality = QCOM_TRNG_QUALITY;
> +		ret = devm_hwrng_register(&pdev->dev, &rng->hwrng);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Register hwrng failed: %d\n", ret);
> +			qcom_rng_dev = NULL;
> +			goto fail;
> +		}
>   	}
>   
> +	return ret;
> +fail:
> +	crypto_unregister_rng(&qcom_rng_alg);
>   	return ret;
>   }
>   
> @@ -198,6 +233,21 @@ static int qcom_rng_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +struct qcom_rng_of_data qcom_prng_of_data = {
> +	.skip_init = false,
> +	.hwrng_support = false,
> +};
> +
> +struct qcom_rng_of_data qcom_prng_ee_of_data = {
> +	.skip_init = true,
> +	.hwrng_support = false,
> +};
> +
> +struct qcom_rng_of_data qcom_trng_of_data = {
> +	.skip_init = true,
> +	.hwrng_support = true,
> +};
> +
>   static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
>   	{ .id = "QCOM8160", .driver_data = 1 },
>   	{}
> @@ -205,8 +255,9 @@ static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
>   MODULE_DEVICE_TABLE(acpi, qcom_rng_acpi_match);
>   
>   static const struct of_device_id __maybe_unused qcom_rng_of_match[] = {
> -	{ .compatible = "qcom,prng", .data = (void *)0},
> -	{ .compatible = "qcom,prng-ee", .data = (void *)1},
> +	{ .compatible = "qcom,prng", .data = &qcom_prng_of_data },
> +	{ .compatible = "qcom,prng-ee", .data = &qcom_prng_ee_of_data },
> +	{ .compatible = "qcom,trng", .data = &qcom_trng_of_data },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, qcom_rng_of_match);
> 
