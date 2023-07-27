Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5963764F62
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjG0JUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbjG0JUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:20:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB30422A;
        Thu, 27 Jul 2023 02:10:38 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R34e6m004788;
        Thu, 27 Jul 2023 09:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=LckumSnhkivflKbnAkm9lDusQZZfojIqolca47VIsiI=;
 b=Y4lXNVqFzpHrxvB7Zyn49pObeVZHcYrymBA7QJ+jUWCjAQDORQe+wGLiV2zAYdWs3Otp
 SmduHMOWs4yYexGIQtLS1hsRpPRlPqnx24S6pvDKluq2hOAVxXiwt+8BKwvY0/tf7BYn
 SmypFmBO6mW3pcchC+OEJzxDacUEqh7IqB2F14VPJV7HiLFoRXt0VgE05tZBWotrVDA4
 7b4P2s56jsQOiFaQj5Ilt22gc6ngJqUseVXRQ/7pkSkZ+r2oxOcVhBlptMbj6LCI4/af
 g9XqVvhHWJmKtuQX3cMVfISZD9zxfbIMfLAMlLpZKXxAjxfMLuqMC+LcbEiJ9FS0Agvi pA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s336t29t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 09:10:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R9AFtp008212
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 09:10:15 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 02:09:44 -0700
Date:   Thu, 27 Jul 2023 14:39:41 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: nvmem: sec-qfprom: Add bindings for
 secure qfprom
Message-ID: <33f2d056-e65d-4bc2-8a1b-bb5815752014@quicinc.com>
References: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
 <20230724083849.8277-2-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230724083849.8277-2-quic_kbajaj@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ad-4Zcd3NQnhbtWhvuoIyPjP1a_X3ZAt
X-Proofpoint-GUID: ad-4Zcd3NQnhbtWhvuoIyPjP1a_X3ZAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1011 mlxlogscore=472 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 02:08:48PM +0530, Komal Bajaj wrote:
> This patch adds bindings for secure qfprom found in QCOM SOCs.
> Secure QFPROM driver is based on simple nvmem framework.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  .../bindings/nvmem/qcom,sec-qfprom.yaml       | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
> 

[...]

> +$id: http://devicetree.org/schemas/nvmem/qcom,sec-qfprom.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies Inc, Secure QFPROM Efuse
> +
> +maintainers:
> +  - Komal Bajaj <quic_kbajaj@quicinc.com>
> +
> +description: |
> +  For some of the Qualcomm SoC's, it is possible that
> +  the qfprom region is protected from non-secure access.
> +  In such situations, linux will have to use secure calls
> +  to read the region.
> +
> +allOf:
> +  - $ref: nvmem.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,qdu1000-sec-qfprom
> +      - const: qcom,sec-qfprom
> +
> +  reg:
> +    items:
> +      - description: The secure qfprom corrected region.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
> +

minor nitpick:

Since this device does not have any clocks, the above header inclusion
can be dropped.

> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      efuse@221c8000 {
> +        compatible = "qcom,qdu1000-sec-qfprom", "qcom,sec-qfprom";
> +        reg = <0 0x221c8000 0 0x1000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        multi_chan_ddr: multi-chan-ddr@12b {
> +          reg = <0x12b 0x1>;
> +          bits = <0 2>;
> +        };
> +      };
> +    };
> +

Thanks,
Pavan
