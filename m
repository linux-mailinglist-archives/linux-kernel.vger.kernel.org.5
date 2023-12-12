Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884A980F70F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377271AbjLLTmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjLLTmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:42:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705C9A1;
        Tue, 12 Dec 2023 11:42:19 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCH6Qm0002891;
        Tue, 12 Dec 2023 19:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=UjdXqRSPf/hsBh6oj1SyTOINg6+2c8f3cHQ1cAmvBJU=; b=Rm
        UXRvGvpYBOoHs5fsn8kRw9geB4pLoYrZg9bpfiB1aTgXfpUhke872NoYMFJmCHgS
        ue/06YKl5Gi/uKeBn+HzfVrt34uhKKgeKXkr4Kz4a6n8blwczOZrwDRlFU6fXa5K
        ogMfDBP5+cij8HhF8lUnaIwxOvKF+j0q2R0XwPQUbvsckKB6FGJ8qZT8DV9cWmI4
        d1HI+IqY6Kn330UZW09ZLeD2pVMW/jG+9JBQ6ftHvKJs4PFN/YC12K8OA1tPzDIJ
        1h7p8C1orkiGGLg0NKdHAiJfwQ7l+okH5AMfiToVsbYqP1QbJDRHNf++oRP1L/Fe
        BsQWpysmhtRKNIJrKoJg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxnf71bve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 19:41:46 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BCJfinE028151
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 19:41:44 GMT
Received: from [10.110.0.246] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Dec
 2023 11:41:43 -0800
Message-ID: <69874f27-46ea-4991-a735-6609233ddb8a@quicinc.com>
Date:   Tue, 12 Dec 2023 11:41:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: panel-simple-dsi: move LG 5" HD TFT LCD
 panel into DSI yaml
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231212175356.72062-1-david@ixit.cz>
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20231212175356.72062-1-david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: x3ShBaoQjEKp5EOE40M_7PRaTdZldalO
X-Proofpoint-GUID: x3ShBaoQjEKp5EOE40M_7PRaTdZldalO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1011 adultscore=0 mlxlogscore=604
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2023 9:53 AM, David Heidelberg wrote:
> Originally was in the panel-simple, but belongs to panel-simple-dsi.
> 
> See arch/arm/boot/dts/nvidia/tegra114-roth.dts for more details.
> 
> Fixes:
> ```
> arch/arm/boot/dts/tegra114-roth.dt.yaml: panel@0: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
>          From schema: Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> ```

Hi David,

Would "Fixes: 310abcea76e9 ("dt-bindings: display: convert simple lg 
panels to DT Schema")" be appropriate here?

Thanks,

Jessica Zhang

> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
>   .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 --
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
> index 73674baea75d..f9160d7bac3c 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
> @@ -42,6 +42,8 @@ properties:
>         - lg,acx467akm-7
>           # LG Corporation 7" WXGA TFT LCD panel
>         - lg,ld070wx3-sl01
> +        # LG Corporation 5" HD TFT LCD panel
> +      - lg,lh500wx1-sd03
>           # One Stop Displays OSD101T2587-53TS 10.1" 1920x1200 panel
>         - osddisplays,osd101t2587-53ts
>           # Panasonic 10" WUXGA TFT LCD panel
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 2021aa82871a..634a10c6f2dd 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -212,8 +212,6 @@ properties:
>         - lemaker,bl035-rgb-002
>           # LG 7" (800x480 pixels) TFT LCD panel
>         - lg,lb070wv8
> -        # LG Corporation 5" HD TFT LCD panel
> -      - lg,lh500wx1-sd03
>           # LG LP079QX1-SP0V 7.9" (1536x2048 pixels) TFT LCD panel
>         - lg,lp079qx1-sp0v
>           # LG 9.7" (2048x1536 pixels) TFT LCD panel
> -- 
> 2.43.0
> 
