Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC7475BDDE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjGUFpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjGUFpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:45:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC6A2D7D;
        Thu, 20 Jul 2023 22:44:56 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L2TQCL030734;
        Fri, 21 Jul 2023 05:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=tWQyB77/dwCu0mp01ODhCXMSuGLMGzqCW+s+RhFh+js=;
 b=agYh6bJ0TfXac/gxwQQo1aF2wcFkPb6SYSZH1GEYhfpwdaV+tDiigSrLmuWHHWVU67E0
 NXVGYxwgQwXs+PLbvswXmUN4Kbyg+PM4p901fHgPGu0TfL/uCdlWWZt7l1Zk0c6rjtCh
 DhnDomZbTSnydSruruSS6FwjyLANaQqLvBCUWhuzjBifa57Ka6qt3l1E5XM19JTwJpTW
 MeWNmYHX5YCiYVX43ItGVST4xAtKpXWa5rtD0zO8g4Wm9ZJXoXRBba5vKbU9qT9yMEQb
 cXOalD29bhGqT3/8CXUB/Vq9QKyaBm2SRbEFBi1wxObnAsNRyPaNpsOBcYab4KxhAktH SA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxxqv2whb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 05:44:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L5io58017333
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 05:44:50 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 22:44:47 -0700
Date:   Fri, 21 Jul 2023 11:14:43 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: qcom,rpmhpd: Add Generic RPMh PD
 indexes
Message-ID: <e77c39fe-b7cf-49b3-9260-ecf4872e8fdf@quicinc.com>
References: <1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com>
 <1689744162-9421-2-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1689744162-9421-2-git-send-email-quic_rohiagar@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UyuWoJP7idPVmTkzMHUC-I5XZpVZpUWc
X-Proofpoint-GUID: UyuWoJP7idPVmTkzMHUC-I5XZpVZpUWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_02,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 mlxlogscore=740 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 10:52:41AM +0530, Rohit Agarwal wrote:
> Add Generic RPMh Power Domain indexes that can be used
> for all the Qualcomm SoC henceforth.
> The power domain indexes of these bindings are based on compatibility
> with current targets like SM8[2345]50 targets.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  include/dt-bindings/power/qcom,rpmhpd.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 include/dt-bindings/power/qcom,rpmhpd.h
> 
> diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
> new file mode 100644
> index 0000000..7c201a6
> --- /dev/null
> +++ b/include/dt-bindings/power/qcom,rpmhpd.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_QCOM_RPMHPD_H
> +#define _DT_BINDINGS_POWER_QCOM_RPMHPD_H
> +
> +/* Generic RPMH Power Domain Indexes */
> +#define RPMHPD_CX               0
> +#define RPMHPD_CX_AO		1
> +#define RPMHPD_EBI		2
> +#define RPMHPD_GFX		3
> +#define RPMHPD_LCX		4
> +#define RPMHPD_LMX		5
> +#define RPMHPD_MMCX		6
> +#define RPMHPD_MMCX_AO		7
> +#define RPMHPD_MX		8
> +#define RPMHPD_MX_AO		9
> +#define RPMHPD_MXC		10
> +#define RPMHPD_MXC_AO		11
> +#define RPMHPD_MSS              12
> +#define RPMHPD_NSP		13
> +#define RPMHPD_NSP0             14
> +#define RPMHPD_NSP1             15
> +#define RPMHPD_QPHY             16
> +#define RPMHPD_DDR              17
> +#define RPMHPD_XO               18
> +
> +#endif
> -- 

I see the PD performance levels (RPMH_REGULATOR_LEVEL_xxx) are still
coming from qcom-rpmpd.h. Which means Socs with RPMh also need to
include the older header for these definitions along with this newly
created header. something to improve for the clarity sake?

Thanks,
Pavan
