Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F237599E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjGSPfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjGSPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:35:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8E810D4;
        Wed, 19 Jul 2023 08:35:43 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J4nCYf031657;
        Wed, 19 Jul 2023 15:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=z2kqcAiN17zcQvQvp6Cgh0t0y4GNa7KYZjk6NzUz7uo=;
 b=oiTblxt781uZ298hvVwkgu5udYZmteMF/dxVf9kW5JHebMQm2rksUwexi4fkQU/Uxlz1
 lNYjC9QUzWut8Q3uy/RsBns6la/hx0MBNaoI+2nSHax6QWfJHARgB2uDRG3kihLGVYbf
 01VnDUIyRvDO9zVrPf029aE4dF9ilqzdXNR7RrBz2hB1OzBhVeqLTd/HQlP749+nM4gT
 bA25aiP72HD8sxu3lvC63R1Lc3/FA6ksbVxgXwSdSBnjjbswNy3hOWvZM8FC8KQ+OA0y
 9uwzkn7rCwoTMyf4m/wgyVDTuG4nldmBQ23pk1VljGSHAaM9o0pKmHZ+7Gi9XCJOHZFu JQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rx7411jxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 15:35:38 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36JFZbVd011697
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 15:35:37 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 08:35:36 -0700
Date:   Wed, 19 Jul 2023 08:35:35 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Imran Shaik <quic_imrashai@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V4 1/7] dt-bindings: clock: Update GCC clocks for QDU1000
 and QRU1000 SoCs
Message-ID: <20230719153535.GC4176673@hu-bjorande-lv.qualcomm.com>
References: <20230719041450.737929-1-quic_imrashai@quicinc.com>
 <20230719041450.737929-2-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230719041450.737929-2-quic_imrashai@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uKfMfjqpW6C3An_cjq_RB26stxsET5F7
X-Proofpoint-ORIG-GUID: uKfMfjqpW6C3An_cjq_RB26stxsET5F7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_10,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 09:44:44AM +0530, Imran Shaik wrote:
> Update the qcom GCC clock bindings for QDU1000 and QRU1000 SoCs.
> 

Please read [1], and as it says "Describe your problem.". This goes for
the most of the series.

There are changes in this series which could be applicable to existing
or future platforms. Your description of the problems you're solving
will help others solve the same problem, not make the same mistake, and
anyone fixing adjacent issues in the future can rely on your
documentation of why things looks the way they look.

[1] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-your-changes

> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>

Please don't use co-developed-by excessively. This patch is beyond
trivial, did you really both author it?

Regards,
Bjorn

> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes since v3:
>  - None
> Changes since v2:
>  - None
> Changes since v1:
>  - Removed the v2 variant compatible string changes
>  - Updated the maintainers list
> 
>  Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml | 3 ++-
>  include/dt-bindings/clock/qcom,qdu1000-gcc.h                  | 4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
> index 767a9d03aa32..d712b1a87e25 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Qualcomm Global Clock & Reset Controller for QDU1000 and QRU1000
>  
>  maintainers:
> -  - Melody Olvera <quic_molvera@quicinc.com>
> +  - Taniya Das <quic_tdas@quicinc.com>
> +  - Imran Shaik <quic_imrashai@quicinc.com>
>  
>  description: |
>    Qualcomm global clock control module which supports the clocks, resets and
> diff --git a/include/dt-bindings/clock/qcom,qdu1000-gcc.h b/include/dt-bindings/clock/qcom,qdu1000-gcc.h
> index ddbc6b825e80..2fd36cbfddbb 100644
> --- a/include/dt-bindings/clock/qcom,qdu1000-gcc.h
> +++ b/include/dt-bindings/clock/qcom,qdu1000-gcc.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>  /*
> - * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2021-2023, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #ifndef _DT_BINDINGS_CLK_QCOM_GCC_QDU1000_H
> @@ -138,6 +138,8 @@
>  #define GCC_AGGRE_NOC_ECPRI_GSI_CLK			128
>  #define GCC_PCIE_0_PIPE_CLK_SRC				129
>  #define GCC_PCIE_0_PHY_AUX_CLK_SRC			130
> +#define GCC_GPLL1_OUT_EVEN				131
> +#define GCC_DDRSS_ECPRI_GSI_CLK				132
>  
>  /* GCC resets */
>  #define GCC_ECPRI_CC_BCR				0
> -- 
> 2.25.1
> 
