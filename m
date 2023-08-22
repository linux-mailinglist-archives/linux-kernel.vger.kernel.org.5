Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48715784811
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbjHVQzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjHVQzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:55:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BBC1B0;
        Tue, 22 Aug 2023 09:55:40 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MGooOa015109;
        Tue, 22 Aug 2023 16:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nlCgUc97OahRC0pXUl3qCZzkBvzU7IqDFI7L4OEsJDI=;
 b=bNj8hRPlszpM+hivuATis6N/vcBJKG9VVxL3ZTUjA8OQVcZN80RE1oluF0DpKFN/4gK7
 MJmbsW1FFqfTavOPIW4gEoVl7I2vnie8GMp8DbckybedsB5sGPdBf9HS1m7sy85pWLJ2
 i4teaFwpfMXGByn0CtoZ6vDMlN5lmKJbaz7tNPdsWtbdtP0Nv6yjCwaNuti86AEOU4ae
 Ip/YWNoruRbFg2pbZFWJAUy+hy337Ibn3gu2hmXBOSrapVnjDx0bJ+rbTdDsMAg1BtyE
 NQOAzvE+/C9EDtTX60lsCbIkk6TkSTr8KldMZAh0Eyy5KSMxhgAI9WVlSPr62fxpj6xm Hg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smusbrwbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 16:55:28 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MGtSwF009627
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 16:55:28 GMT
Received: from [10.216.24.163] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 22 Aug
 2023 09:55:24 -0700
Message-ID: <659e5362-814a-a01d-bb5b-d960a63dabeb@quicinc.com>
Date:   Tue, 22 Aug 2023 22:25:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/4] dt-bindings: firmware: qcom,scm: support
 indicating SDI default state
To:     Robert Marko <robimarko@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <computersforpeace@gmail.com>
References: <20230816164641.3371878-1-robimarko@gmail.com>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230816164641.3371878-1-robimarko@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: s-uOyspWs5rwsmGqGEuKHFZyXciFghyH
X-Proofpoint-GUID: s-uOyspWs5rwsmGqGEuKHFZyXciFghyH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220133
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/2023 10:15 PM, Robert Marko wrote:
> IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
> means that WDT being asserted or just trying to reboot will hang the board
> in the debug mode and only pulling the power and repowering will help.
> Some IPQ4019 boards like Google WiFI have it enabled as well.
> 
> So, lets add a boolean property to indicate that SDI is enabled by default
> and thus needs to be disabled by the kernel.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> ---
> Changes in v3:
> * Change the property so it indicates that SDI has been enabled by default
> ---
>   Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> index 4233ea839bfc..590bbbd61de5 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -89,6 +89,14 @@ properties:
>         protocol to handle sleeping SCM calls.
>       maxItems: 1
>   
> +  qcom,sdi-enabled:
> +    description:
> +      Indicates that the SDI (Secure Debug Image) has been enabled by TZ
> +      by default and it needs to be disabled.
> +      If not disabled WDT assertion or reboot will cause the board to hang
> +      in the debug mode.
> +    type: boolean
> +
>     qcom,dload-mode:
>       $ref: /schemas/types.yaml#/definitions/phandle-array
>       items:
