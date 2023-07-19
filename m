Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC4675914E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGSJN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjGSJN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:13:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD02173B;
        Wed, 19 Jul 2023 02:13:26 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J4gSwX008449;
        Wed, 19 Jul 2023 09:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Gj2yJp4znK+CIfSIZHigRVEHv6hEKNrVzDu1MeYrYWQ=;
 b=CuT8cBdTbmrwqnDifEHUr3fz9efcCSKpGn03+sYl5qWghQV5ICeiJsvuajABxVjG5S/3
 hQUdb6s2HFpSXfdAIFUT58D089d3/6bCZpL6e5W6N+j697xS6zE5QvgDmnC02XSi8iue
 +X+y7XzTLZdcEyp0T7cRDn2gIx9dKNbx1ls9nPm5sFxDM0Oc12awsEHXWNPc5A3y0beV
 6Sso9LlObNP4PeY9PGOmGknq4J5BMZSVpczOE5jW3u0fwISc2TRwXaliYFE+kMt31ftD
 WXFT4GVJnaEmYwANZwXapnOD9k5snDcCB5/760pyM38buR8IxT+rDxRh3me0rdaD42JH DA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwnrrjx4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 09:13:23 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36J9DMfZ020133
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 09:13:22 GMT
Received: from [10.216.47.173] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 19 Jul
 2023 02:13:18 -0700
Message-ID: <37ab515a-a4b1-09fa-6ec4-e2dae17fb58c@quicinc.com>
Date:   Wed, 19 Jul 2023 14:43:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: power: qcom,rpmhpd: Add Generic RPMh PD
 indexes
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com>
 <1689744162-9421-2-git-send-email-quic_rohiagar@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1689744162-9421-2-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pV2YhOuCdK5Fn9cLY1UA0f4Kyi1_8HUZ
X-Proofpoint-ORIG-GUID: pV2YhOuCdK5Fn9cLY1UA0f4Kyi1_8HUZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_05,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=838 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190083
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/2023 10:52 AM, Rohit Agarwal wrote:
> Add Generic RPMh Power Domain indexes that can be used
> for all the Qualcomm SoC henceforth.
> The power domain indexes of these bindings are based on compatibility
> with current targets like SM8[2345]50 targets.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Signed-off-by should be followed by Suggested-by ?

-Mukesh

> ---
>   include/dt-bindings/power/qcom,rpmhpd.h | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>   create mode 100644 include/dt-bindings/power/qcom,rpmhpd.h
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
