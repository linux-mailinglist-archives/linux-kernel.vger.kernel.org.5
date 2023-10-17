Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04747CB946
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbjJQD14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQD1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:27:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919EC8F;
        Mon, 16 Oct 2023 20:27:52 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H2eO7a017723;
        Tue, 17 Oct 2023 03:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Qi99beKEnJ50+lr+k/SLPj5d8b2Ds95JabOrZvBX7nY=;
 b=hxXd8elnfUFh1K+Z2H08G0BOznihXBVBvl5ifj0m/LIKEvr8GTg/CWU1QgOPboq7ZRl6
 TqeUOqqZ6uxRmaTuB3PR4C3uJHVsUIOzgvkdkO0J8UvzPU4uYP3JBr/Iu62c4bTUc2/j
 s6A2xQjzIxz5ThII/iCGY3H1pAU0ts147y2/0SDVIHJr2lCm9OJ/Zll87TuRodiZMOHG
 4A54B0rVtAEuQa/du4tv81/8UCe5Ka6n65roiXIVTIfCzF3HDIZVqh2mE5t5nIM2tX4j
 Ii9t9lZ7rBmeqg1AW9KFlW+QTfYRmblmkWaEAW3q6J1UDxKyk0BwY9dqYWyDClY7UUtc Yw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsaky0x6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:27:42 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39H3RfkA031355
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:27:41 GMT
Received: from [10.216.24.217] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 16 Oct
 2023 20:27:38 -0700
Message-ID: <6b1403ac-fe0f-4539-a52d-d6609989c928@quicinc.com>
Date:   Tue, 17 Oct 2023 08:57:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: qcom: add HW_RANDOM dependency
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231016200324.757455-1-arnd@kernel.org>
From:   Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <20231016200324.757455-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uAdQftk0-7j86tY6GH4dg6fq-p4NAROw
X-Proofpoint-ORIG-GUID: uAdQftk0-7j86tY6GH4dg6fq-p4NAROw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=803 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2023 1:32 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver now calls into the hwrng subsystem and causes a link failure if that
> is not reachable:
> 
> x86_64-linux-ld: vmlinux.o: in function `qcom_rng_probe':
> qcom-rng.c:(.text+0xfefc7e): undefined reference to `devm_hwrng_register'
> 
> Add a Kconfig dependency as we have for the pure hw_random drivers. I see
> that there are some other crypto drivers that instead use 'select HW_RANDOM',
> but those seem to be mistakes as that may lead to circular dependencies,
> and a simple driver should not force-enable an entire subsytem.
> 
> Fixes: f29cd5bb64c25 ("crypto: qcom-rng - Add hw_random interface support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>

>   drivers/crypto/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index c761952f0dc6d..79c3bb9c99c3b 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -601,6 +601,7 @@ config CRYPTO_DEV_QCE_SW_MAX_LEN
>   config CRYPTO_DEV_QCOM_RNG
>   	tristate "Qualcomm Random Number Generator Driver"
>   	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on HW_RANDOM
>   	select CRYPTO_RNG
>   	help
>   	  This driver provides support for the Random Number
