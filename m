Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C415078FF71
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350069AbjIAOqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjIAOqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:46:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5DD18C;
        Fri,  1 Sep 2023 07:46:50 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3818gA9L015675;
        Fri, 1 Sep 2023 14:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=8CMSyXIqwUux7ENV+aKP3a29scUhMnZjeYinx4695w8=;
 b=fKGrmbmjZO2NIYIM3WPecGxQVEi+2cXFLfJp6+Z9hGY7FkFLFpCBV1WQOvojgT748pI+
 0dr0ahMFQBDI4qYdXfp0Yqx2SFU8i5G6AktkkY3jCa3dVn5AhGytP6gGWp1D6VEtXpTn
 9/RgHKzWzEOQafJl81jgYz9Lx0C3U8IPd+aLwXXYYAYbzVVz8xGshCI7HgZlnUFb3okG
 2a2d0CVSkapAWWQt/WyTuEpxcZnQDOMbtAGsZ8rjmNri1PyAxQYEwGAjn2nLcPzaZ7hN
 vzK/Rj6Vru55X5k2lc+Gud1cIuNAXvTsDKYhTJjrEBTzTZC91YW7kXOk7QxjC0TkCJb5 2w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stpy9c77q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 14:46:38 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 381Ekc93025232
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 14:46:38 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 1 Sep 2023 07:46:37 -0700
Date:   Fri, 1 Sep 2023 07:46:36 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Om Prakash Singh <quic_omprsing@quicinc.com>
CC:     <neil.armstrong@linaro.org>, <konrad.dybcio@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marijn.suijten@somainline.org>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>
Subject: Re: [PATCH] crypto: qcom-rng: Add hwrng support
Message-ID: <20230901144636.GP818859@hu-bjorande-lv.qualcomm.com>
References: <20230901131502.1549809-1-quic_omprsing@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230901131502.1549809-1-quic_omprsing@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Q3YWOWJN2aImLyvOgDYGZM4s7Wx0vgvn
X-Proofpoint-GUID: Q3YWOWJN2aImLyvOgDYGZM4s7Wx0vgvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_12,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 06:45:02PM +0530, Om Prakash Singh wrote:
> This is follow patch on top of [1]

This information does not add value to the git history, if you need to
inform the maintainer that the patch should be applied after some
in-flight dependency then state so after the "---" line below.

But, this patch strictly conflicts with [1], so the statement won't make
sense if this is merged.

> to add hwrng support for newer platform with trng capability.

Please rewrite this so that it's clear that the problem you're trying to
solve with this patch (i.e. the problem description) is that newer
platforms has trng. Describe how this relates to the existing driver
(e.g. same/similar hardware interface). State that you purposefully kept
the crypto interface in place for the new hardware as well (so that it's
clear that this isn't an accident or oversight).

> 
> [1] https://lore.kernel.org/lkml/20230824-topic-sm8550-rng-v2-4-dfcafbb16a3e@linaro.org/
> 
> Signed-off-by: Om Prakash Singh <quic_omprsing@quicinc.com>
> ---
>  drivers/crypto/qcom-rng.c | 72 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 63 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
> index fb54b8cfc35f..f78ffdcc66ec 100644
> --- a/drivers/crypto/qcom-rng.c
> +++ b/drivers/crypto/qcom-rng.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/hw_random.h>

Please keep these sorted, alphabetically.

>  
>  /* Device specific register offsets */
>  #define PRNG_DATA_OUT		0x0000
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
>  }
>  
>  static int qcom_rng_generate(struct crypto_rng *tfm,
> @@ -79,7 +85,8 @@ static int qcom_rng_generate(struct crypto_rng *tfm,
>  {
>  	struct qcom_rng_ctx *ctx = crypto_rng_ctx(tfm);
>  	struct qcom_rng *rng = ctx->rng;
> -	int ret;
> +	int ret = -EFAULT;

This initialization is useless, the very first thing you do with ret is
to overwrite it with the return value of clk_prepare_enable().

> +	int read_size = 0;

Similarly, the first use of this variable is an assignment. And "ret"
was a good, short, variable name.

>  
>  	ret = clk_prepare_enable(rng->clk);
>  	if (ret)
> @@ -87,11 +94,14 @@ static int qcom_rng_generate(struct crypto_rng *tfm,
>  
>  	mutex_lock(&rng->lock);
>  
> -	ret = qcom_rng_read(rng, dstn, dlen);
> +	read_size = qcom_rng_read(rng, dstn, dlen);
>  
>  	mutex_unlock(&rng->lock);
>  	clk_disable_unprepare(rng->clk);
>  
> +	if (read_size == dlen)

This function used to return < 0 if qcom_rng_read() returned an error,
and 0 in all other cases.

Now you will pass through negative values, you will return 0 if the loop
in qcom_rng_read() reached "dlen" ("max)", and you will return some
positive number if the break condition in the loop hit.

In other words, this is wrong.

> +		ret = 0;
> +
>  	return ret;
>  }
>  
> @@ -101,6 +111,16 @@ static int qcom_rng_seed(struct crypto_rng *tfm, const u8 *seed,
>  	return 0;
>  }
>  
> +static int qcom_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
> +{
> +	int ret;
> +	struct qcom_rng *qrng;
> +
> +	qrng = (struct qcom_rng *)rng->priv;
> +	ret = qcom_rng_read(qrng, data, max);
> +	return ret;

Initialize qrng directly when you define it, drop ret and just return
qcom_rng_read() directly.

> +}
> +
>  static int qcom_rng_enable(struct qcom_rng *rng)
>  {
>  	u32 val;
> @@ -136,7 +156,7 @@ static int qcom_rng_init(struct crypto_tfm *tfm)
>  
>  	ctx->rng = qcom_rng_dev;
>  
> -	if (!ctx->rng->skip_init)
> +	if (!ctx->rng->of_data->skip_init)
>  		return qcom_rng_enable(ctx->rng);
>  
>  	return 0;
> @@ -157,9 +177,16 @@ static struct rng_alg qcom_rng_alg = {
>  	}
>  };
>  
> +static struct hwrng qcom_hwrng = {
> +	.name = "qcom-hwrng",
> +	.read = qcom_hwrng_read,
> +	.quality = 1024,
> +};
> +
>  static int qcom_rng_probe(struct platform_device *pdev)
>  {
>  	struct qcom_rng *rng;
> +	const struct qcom_rng_of_data *data;

Move this one line up, so we maintain the reverse xmas tree.

>  	int ret;
>  
>  	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
> @@ -177,7 +204,8 @@ static int qcom_rng_probe(struct platform_device *pdev)
>  	if (IS_ERR(rng->clk))
>  		return PTR_ERR(rng->clk);
>  
> -	rng->skip_init = (unsigned long)device_get_match_data(&pdev->dev);
> +	data = of_device_get_match_data(&pdev->dev);
> +	rng->of_data = (struct qcom_rng_of_data *)data;

Why didn't you assign rng->of_data directly?

Also, of_device_get_match_data() returns a void *, so you should have to
explicitly cast this.

>  
>  	qcom_rng_dev = rng;
>  	ret = crypto_register_rng(&qcom_rng_alg);
> @@ -185,6 +213,14 @@ static int qcom_rng_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "Register crypto rng failed: %d\n", ret);
>  		qcom_rng_dev = NULL;
>  	}

Would be nice with a newline here, to get some separation between the
"paragraphs".

> +	if (rng->of_data->hwrng_support) {
> +		qcom_hwrng.priv = (unsigned long)qcom_rng_dev;
> +		ret = hwrng_register(&qcom_hwrng);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Register hwrng failed: %d\n", ret);
> +			qcom_rng_dev = NULL;

You're leaving the rng registered with crypto here. Not sure if that
will result in a use after free, or just a NULL pointer dereference -
but it's not good either way.

> +		}
> +	}
>  
>  	return ret;
>  }
> @@ -193,11 +229,29 @@ static int qcom_rng_remove(struct platform_device *pdev)
>  {
>  	crypto_unregister_rng(&qcom_rng_alg);
>  
> +	if (qcom_rng_dev->of_data->hwrng_support)
> +		hwrng_unregister(&qcom_hwrng);

Why not use devm_hwrng_register() above instead? Then you wouldn't have
to unregister it here.

> +
>  	qcom_rng_dev = NULL;
>  
>  	return 0;
>  }
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

Can you please confirm that it's appropriate to name this "trng" without
the "-ee" suffix. Should all trng instances (v2 and v3) skip
initialization?

> +	.hwrng_support = true,
> +};
> +
>  static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
>  	{ .id = "QCOM8160", .driver_data = 1 },
>  	{}
> @@ -205,9 +259,9 @@ static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
>  MODULE_DEVICE_TABLE(acpi, qcom_rng_acpi_match);
>  
>  static const struct of_device_id __maybe_unused qcom_rng_of_match[] = {
> -	{ .compatible = "qcom,prng", .data = (void *)0},
> -	{ .compatible = "qcom,prng-ee", .data = (void *)1},
> -	{ .compatible = "qcom,trng", .data = (void *)1},
> +	{ .compatible = "qcom,prng", .data = &qcom_prng_of_data },
> +	{ .compatible = "qcom,prng-ee", .data = &qcom_prng_ee_of_data },
> +	{ .compatible = "qcom,trng", .data = &qcom_trng_of_data },

So, should this be qcom,trng or qcom,trng-ee?


Where is your devicetree binding patch?

Regards,
Bjorn
