Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047B97AB48E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjIVPRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjIVPRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:17:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046DBA1;
        Fri, 22 Sep 2023 08:17:07 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MEcPXC007646;
        Fri, 22 Sep 2023 15:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=j+Qc3pIBgo5kicmDkbyiNqlYk1YzVlOWKWhwzFhQ6vo=;
 b=kwRtLKmCekSZfYQY7MQspD07uAwriFQUcuQ77QVAZA10Ud4dW3VP6Cvt6yVGCYYWu/pL
 hJ/stH/6ywyW4GD+iqVhcCpqf31pVVx8dWs5ny3rz9tcM8xBB8tVLH4K0R0gV2gfiNKN
 zPE6Z50ho9Le4SPvA9wquHusTCVrvIAKAvF8lMHz31IUoG6YC8Yds6qr80L4+mtnP1vA
 RgGbFPwqsim4LIbJUsJ52z3Z9ZUcxSKL7rvN5oQwxGqIE0D3ZHKBAVOjiQL5iF2oPlEE
 HVAb2NJmOrXvgrrBDlKIJ3cJbkLxpLgY1P5PBo8I9+EZoezwuLVIZi5YwPUMdH28xcy8 Dg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u5n289a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 15:16:53 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38MFGqHR000592
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 15:16:52 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 22 Sep 2023 08:16:52 -0700
Date:   Fri, 22 Sep 2023 08:16:51 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Om Prakash Singh <quic_omprsing@quicinc.com>
CC:     <neil.armstrong@linaro.org>, <konrad.dybcio@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marijn.suijten@somainline.org>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>
Subject: Re: [PATCH V2] crypto: qcom-rng - Add hw_random interface support
Message-ID: <20230922151651.GA437346@hu-bjorande-lv.qualcomm.com>
References: <20230905062420.3983268-1-quic_omprsing@quicinc.com>
 <20230920030408.3181394-1-quic_omprsing@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230920030408.3181394-1-quic_omprsing@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Tr-6h0JYolkqjt6KcstqhMzgElmMyY4z
X-Proofpoint-GUID: Tr-6h0JYolkqjt6KcstqhMzgElmMyY4z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_13,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1011 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220131
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 08:34:08AM +0530, Om Prakash Singh wrote:
> Add hw_random interface support in qcom-rng driver as new IP block
> in Qualcomm SoC has inbuilt NIST SP800 90B compliant entropic source
> to generate true random number.
> 
> Keeping current rng_alg interface as well for random number generation
> using Kernel Crypto API.
> 
> Signed-off-by: Om Prakash Singh <quic_omprsing@quicinc.com>
> ---
> 
> Changes in V2:
> - Updated patch to fix the return value from qcom_rng_generate() to be
>   consistent with current implementation

As far as I can tell you didn't change this, see below.

> - Updated patch to make it more concise
> - Removed unnecessary use local variable and it's initialization
> - Updated patch to use devm_hwrng_register() instead of hwrng_register()
> - Updated subject line of the patch
> 
> This patch is depends on [1]
> [1] https://lore.kernel.org/lkml/20230824-topic-sm8550-rng-v2-4-dfcafbb16a3e@linaro.org/
> 
>  drivers/crypto/qcom-rng.c | 65 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 58 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
> index fb54b8cfc35f..e5a574a3cc59 100644
> --- a/drivers/crypto/qcom-rng.c
> +++ b/drivers/crypto/qcom-rng.c
> @@ -7,6 +7,7 @@
>  #include <linux/acpi.h>
>  #include <linux/clk.h>
>  #include <linux/crypto.h>
> +#include <linux/hw_random.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> @@ -32,13 +33,18 @@ struct qcom_rng {
>  	struct mutex lock;
>  	void __iomem *base;
>  	struct clk *clk;
> -	unsigned int skip_init;
> +	struct qcom_rng_of_data *of_data;
>  };
>  
>  struct qcom_rng_ctx {
>  	struct qcom_rng *rng;
>  };
>  
> +struct qcom_rng_of_data {
> +	bool skip_init;
> +	bool hwrng_support;
> +};
> +
>  static struct qcom_rng *qcom_rng_dev;
>  
>  static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
> @@ -70,7 +76,7 @@ static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
>  		}
>  	} while (currsize < max);
>  
> -	return 0;
> +	return currsize;

As I pointed out in my previous review, if the qcom_rng_read() is
requested to read a number of bytes (max) that is not evenly divisible
with 4 (WORD_SZ) the loop will exit without accounting for the last
bytes copied...

>  }
>  
>  static int qcom_rng_generate(struct crypto_rng *tfm,
> @@ -92,6 +98,9 @@ static int qcom_rng_generate(struct crypto_rng *tfm,
>  	mutex_unlock(&rng->lock);
>  	clk_disable_unprepare(rng->clk);
>  
> +	if (ret == dlen)

...this means that if dlen % 4, you're changing the return value of this
function from 0 to dlen.

> +		ret = 0;
> +
>  	return ret;
>  }
>  
> @@ -101,6 +110,13 @@ static int qcom_rng_seed(struct crypto_rng *tfm, const u8 *seed,
>  	return 0;
>  }
>  
> +static int qcom_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
> +{
> +	struct qcom_rng *qrng = (struct qcom_rng *)rng->priv;

You missed Herbert's request in [1], which I presume implies that
qcom_hwrng should be moved into struct qcom_rng, which would mean that
you can get the qrng by container_of().

[1] https://lore.kernel.org/lkml/ZQQvlXvGy8p01uJS@gondor.apana.org.au/

> +
> +	return qcom_rng_read(qrng, data, max);
> +}
> +
>  static int qcom_rng_enable(struct qcom_rng *rng)
>  {
>  	u32 val;
> @@ -136,7 +152,7 @@ static int qcom_rng_init(struct crypto_tfm *tfm)
>  
>  	ctx->rng = qcom_rng_dev;
>  
> -	if (!ctx->rng->skip_init)
> +	if (!ctx->rng->of_data->skip_init)
>  		return qcom_rng_enable(ctx->rng);
>  
>  	return 0;
> @@ -157,6 +173,12 @@ static struct rng_alg qcom_rng_alg = {
>  	}
>  };
>  
> +static struct hwrng qcom_hwrng = {
> +	.name = "qcom-hwrng",
> +	.read = qcom_hwrng_read,
> +	.quality = 1024,
> +};

Which would mean not adding this static global variable...

Regards,
Bjorn
