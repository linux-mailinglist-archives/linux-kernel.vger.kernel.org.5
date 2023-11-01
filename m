Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D527DE41F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjKAPr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjKAPr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:47:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03BE12E;
        Wed,  1 Nov 2023 08:47:44 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1EHSWl000923;
        Wed, 1 Nov 2023 15:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=owa8O8xm4O+CR6cBywaNZb9A1GNgekDluOYlBTuZTVw=;
 b=F+QNmUALlawaqHLKrRu3Iis0CSJ1+0B6R7MRd5pwyCtaUdWGLhl8Gyq0Rc9/y0vC0yvg
 NoGwa9Iiv3YyP5HqqjT3S/dsn2i1EnkbQT/TrB2bTlrYMYUdufJXgiewm6YVOWFEXkrg
 IC+f0Qi6zi0WDz+eU22gWWlbZbioaPhIkv6uksMGu+i0HveEkjyRCBFyhtvz1V21ieJu
 hb/JqNWrh2oFl9fQOo6afim0VHjU8H5OciQBoDZamPdc3wp8ypTxb8K/MvX9h+0jtOy7
 Cjp0fr+9x1lf7jBSriGUKiiMFCXnrVVBcEK5MXVNUHtoQ8peC9YtYijlCrjWYSTHmL5V Dg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u3e06tb98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 15:47:39 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A1FlcRA031748
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Nov 2023 15:47:38 GMT
Received: from [10.216.63.119] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 1 Nov
 2023 08:47:33 -0700
Message-ID: <2683c865-7775-a2ef-0417-01f9aca80b6a@quicinc.com>
Date:   Wed, 1 Nov 2023 21:17:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: power: reset: $ref reboot-mode in
 nvmem-reboot-mode
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231031-ref-nvmem-reboot-mode-v1-1-c1af9070ce52@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20231031-ref-nvmem-reboot-mode-v1-1-c1af9070ce52@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PlbOTgSHSA7NPNztDGjwcT57MQBwB0Zr
X-Proofpoint-GUID: PlbOTgSHSA7NPNztDGjwcT57MQBwB0Zr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_13,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010128
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2023 11:58 PM, Elliot Berman wrote:
> nvmem-reboot-mode.yaml should $ref: reboot-mode.yaml, but instead
> rewrites the properties. Update so it $refs instead.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> ---
>   .../devicetree/bindings/power/reset/nvmem-reboot-mode.yaml        | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> index 14a262bcbf7c..627f8a6078c2 100644
> --- a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> @@ -28,17 +28,15 @@ properties:
>       items:
>         - const: reboot-mode
>   
> -patternProperties:
> -  "^mode-.+":
> -    $ref: /schemas/types.yaml#/definitions/uint32
> -    description: Vendor-specific mode value written to the mode register
> +allOf:
> +  - $ref: reboot-mode.yaml#
>   
>   required:
>     - compatible
>     - nvmem-cells
>     - nvmem-cell-names
>   
> -additionalProperties: false
> +unevaluatedProperties: false
>   
>   examples:
>     - |
> 
> ---
> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
> change-id: 20231031-ref-nvmem-reboot-mode-1369970436e4
> 
> Best regards,
