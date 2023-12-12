Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73BF80E705
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjLLJEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLJEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:04:37 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC94B7;
        Tue, 12 Dec 2023 01:04:43 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BC8GADT005417;
        Tue, 12 Dec 2023 09:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=ac2zjLMEHeUmJU/ZYFnnFqnuNOtRLiobPEYCuI5Lfq0=; b=bF
        8vs1f8L67iTtBZcsmDVM7bkU7F/EUllBqjy9ybWWWD2nJrhDkAqeJyQPrD3g2Wx6
        KIJxnEbLpvoywfjn5pkkSgSmBYew4XOc7Psktjt51Of8x/vAXnwfjtUq10Z++h83
        /u6uONkwBG8sUCe14aov2FXSheOGy3KcrMU/nUoTCT7RPmvE+C5RHI1VhVoBcZdj
        unLUD99BB3uKaNU7btb+nUbdnnykfa/6q6NhzjBJzu+5NJamQIn9LGKHpx38IOFb
        E6M6NA9i61zDLlwmlLmMCIR8I7sEGND0TMUYhXov0u9hknjk613VpfHOV6943sI9
        JVGNfgEIDdRlJHlz2Sog==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ux6531v1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 09:04:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BC94W60030456
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 09:04:32 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Dec
 2023 01:04:29 -0800
Message-ID: <02305d95-0d74-2dc1-e7f0-c81e15da0896@quicinc.com>
Date:   Tue, 12 Dec 2023 14:34:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: linux-next: build failure after merge of the devicetree tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>
CC:     Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231211160510.0aef871b@canb.auug.org.au>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20231211160510.0aef871b@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -kd30rdgpSnzIv-MTBJb9XkQId7I4Mr3
X-Proofpoint-GUID: -kd30rdgpSnzIv-MTBJb9XkQId7I4Mr3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1011 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312120071
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/23 10:35, Stephen Rothwell wrote:
> Hi all,

Hey Stephen,
Thanks for the fix.

> 
> After merging the devicetree tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/clk/qcom/gcc-x1e80100.c:6786:15: error: variable 'gcc_x1e80100_driver' has initializer but incomplete type
>   6786 | static struct platform_driver gcc_x1e80100_driver = {
>        |               ^~~~~~~~~~~~~~~
> drivers/clk/qcom/gcc-x1e80100.c:6787:10: error: 'struct platform_driver' has no member named 'probe'
>   6787 |         .probe = gcc_x1e80100_probe,
>        |          ^~~~~
> drivers/clk/qcom/gcc-x1e80100.c:6787:18: warning: excess elements in struct initializer
>   6787 |         .probe = gcc_x1e80100_probe,
>        |                  ^~~~~~~~~~~~~~~~~~
> drivers/clk/qcom/gcc-x1e80100.c:6787:18: note: (near initialization for 'gcc_x1e80100_driver')
> drivers/clk/qcom/gcc-x1e80100.c:6788:10: error: 'struct platform_driver' has no member named 'driver'
>   6788 |         .driver = {
>        |          ^~~~~~
> drivers/clk/qcom/gcc-x1e80100.c:6788:19: error: extra brace group at end of initializer
>   6788 |         .driver = {
>        |                   ^
> drivers/clk/qcom/gcc-x1e80100.c:6788:19: note: (near initialization for 'gcc_x1e80100_driver')
> drivers/clk/qcom/gcc-x1e80100.c:6788:19: warning: excess elements in struct initializer
> drivers/clk/qcom/gcc-x1e80100.c:6788:19: note: (near initialization for 'gcc_x1e80100_driver')
> drivers/clk/qcom/gcc-x1e80100.c: In function 'gcc_x1e80100_init':
> drivers/clk/qcom/gcc-x1e80100.c:6796:16: error: implicit declaration of function 'platform_driver_register' [-Werror=implicit-function-declaration]
>   6796 |         return platform_driver_register(&gcc_x1e80100_driver);
>        |                ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/clk/qcom/gcc-x1e80100.c: In function 'gcc_x1e80100_exit':
> drivers/clk/qcom/gcc-x1e80100.c:6802:9: error: implicit declaration of function 'platform_driver_unregister'; did you mean 'driver_unregister'? [-Werror=implicit-function-declaration]
>   6802 |         platform_driver_unregister(&gcc_x1e80100_driver);
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>        |         driver_unregister
> drivers/clk/qcom/gcc-x1e80100.c: At top level:
> drivers/clk/qcom/gcc-x1e80100.c:6786:31: error: storage size of 'gcc_x1e80100_driver' isn't known
>   6786 | static struct platform_driver gcc_x1e80100_driver = {
>        |                               ^~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>    0d18bcdebb2f ("of: Stop circularly including of_device.h and of_platform.h")
> 
> interacting with commit
> 
>    161b7c401f4b ("clk: qcom: Add Global Clock controller (GCC) driver for X1E80100")
> 
> from the qcom tree.
> 
> I have applied the following merge resolution patch.  This patch could
> be applied to the gcom tree.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 11 Dec 2023 15:47:55 +1100
> Subject: [PATCH] fix up for "of: Stop circularly including of_device.h and of_platform.h"
> 
> interacting with
> "clk: qcom: Add Global Clock controller (GCC) driver for X1E80100"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
>   drivers/clk/qcom/gcc-x1e80100.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
> index 74db7fef237b..d7182d6e9783 100644
> --- a/drivers/clk/qcom/gcc-x1e80100.c
> +++ b/drivers/clk/qcom/gcc-x1e80100.c
> @@ -4,8 +4,9 @@
>    */
>   
>   #include <linux/clk-provider.h>
> +#include <linux/mod_devicetable.h>
>   #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   
>   #include <dt-bindings/clock/qcom,x1e80100-gcc.h>
