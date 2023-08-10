Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB32E7779B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbjHJNg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjHJNgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:36:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60422108;
        Thu, 10 Aug 2023 06:36:53 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ACJB5B025613;
        Thu, 10 Aug 2023 13:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WosU3mZZv4If5RZRzpaKIsoNLeDov51QZ4taRcdq6Qk=;
 b=NYcvkYN3vKHyqmLvor7hlwS6rqEyAU01eQ+6yhE3GUUoKdi9r2bS1ZcoCNfrVh+wuE1x
 UqexumGTONh91FD25OuBBWkuTd+UN9FzRInxOWOyXz3LlnacdY5dnWxCLZ/O1EhGTxhB
 z5AlL8nY39IRVlwlIwpHcaqsAXspY7mtHP4xJepZRAVlLT7/7cG1PTediZ5avazjDJj+
 9XrK+lnOjsjfpPLsWLEyw/SwhW90Hl/lqG+zD6jDfydKp3zsEbla6asbK3/RdCSHU8Jl
 fY5rKlTOActw+bWLELGfEq6O58DB9v4R+96GDNrIMnOYzMv90XMPidP3a0dEh50FJO29 3w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc5ffbh39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 13:36:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37ADageg014538
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 13:36:42 GMT
Received: from [10.111.180.219] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 06:36:42 -0700
Message-ID: <3fc73725-2b17-4c89-0e61-1dd01f659bfa@quicinc.com>
Date:   Thu, 10 Aug 2023 06:36:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] wifi: ath10k: fix Wvoid-pointer-to-enum-cast
 warning
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kalle Valo <kvalo@kernel.org>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ath11k@lists.infradead.org>
CC:     Andi Shyti <andi.shyti@kernel.org>
References: <20230810091224.70088-1-krzysztof.kozlowski@linaro.org>
 <20230810091224.70088-2-krzysztof.kozlowski@linaro.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230810091224.70088-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rTSasbpruEtdEroTYuvB0na2F77FqxR2
X-Proofpoint-GUID: rTSasbpruEtdEroTYuvB0na2F77FqxR2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/2023 2:12 AM, Krzysztof Kozlowski wrote:
> 'hw_rev' is an enum, thus cast of pointer on 64-bit compile test with W=1
> causes:
> 
>    ath10k/ahb.c:736:11: error: cast to smaller integer type 'enum ath10k_hw_rev' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath10k/ahb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
> index 4a006fb4d424..95bcf54ddc3f 100644
> --- a/drivers/net/wireless/ath/ath10k/ahb.c
> +++ b/drivers/net/wireless/ath/ath10k/ahb.c
> @@ -733,7 +733,7 @@ static int ath10k_ahb_probe(struct platform_device *pdev)
>   	int ret;
>   	struct ath10k_bus_params bus_params = {};
>   
> -	hw_rev = (enum ath10k_hw_rev)of_device_get_match_data(&pdev->dev);
> +	hw_rev = (uintptr_t)of_device_get_match_data(&pdev->dev);
>   	if (!hw_rev) {
>   		dev_err(&pdev->dev, "OF data missing\n");
>   		return -EINVAL;

