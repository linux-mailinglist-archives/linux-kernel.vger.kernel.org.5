Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C753C7671C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjG1QXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjG1QXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:23:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309372D60;
        Fri, 28 Jul 2023 09:23:38 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SCqTfs003444;
        Fri, 28 Jul 2023 16:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=lWGAci/KOkjpqLOcPETyCVFfVvIyWWpQGhhU8B1Exts=;
 b=W4t1TH6cXNjx4FgdmkHuMHXf6MDdAuzjs1TGdWrmYbUbRJ30C4RAJlEN4mUKTXxv513l
 606L+GiF4NqVRrX9+UWMXiWFsiQ/j3ZYIvF10LB3i3Ja/ky9fU5ip8MR0MFo4tG8CPqP
 5MvBR40qdiDfGWIllCKfk665wxzQNlTf6AMVvQUpZUofKGGfg0FC72d87L1Z19vDOEGM
 G2XI3TtlKnL4Nui6z0hR5yP9SlmxtLZGSxACNF64K6LNCEZXldXf+RNSTdZnailp0lKC
 Y4vzqzfnvo+1/ltlD+uC9e0NCtDTurlUW6a9bsOu/1AthwV2Doqwcw55lXKsjlByuS6v tg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4e270gma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 16:23:32 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SGNWh0007692
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 16:23:32 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 09:23:31 -0700
Date:   Fri, 28 Jul 2023 09:23:30 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Vikash Garodia <quic_vgarodia@quicinc.com>
CC:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_dikshita@quicinc.com>
Subject: Re: [PATCH 03/33] iris: vidc: add v4l2 wrapper file
Message-ID: <20230728162330.GD1428172@hu-bjorande-lv.qualcomm.com>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-4-git-send-email-quic_vgarodia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1690550624-14642-4-git-send-email-quic_vgarodia@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0jajW1wvITPnN36B-O1gEkW4knp0dzab
X-Proofpoint-ORIG-GUID: 0jajW1wvITPnN36B-O1gEkW4knp0dzab
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=714
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280149
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 06:53:14PM +0530, Vikash Garodia wrote:
> Here is the implementation of v4l2 wrapper functions for all
> v4l2 IOCTLs.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>

In patch 2 you got this right, where the first Signed-off-by is that of
the author (defined by a From:), in the rest you should up as the
author, but Dikshita was the first one certifying the origin of this
code.

I suspect you need a Co-developed-by: Dikshita throughout the series?


Your subject should include the subsystem prefix (media: ), it's not
clear from the presented description if the "vidc" string adds value -
are there other functionality under iris?

For all the patches, do read:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes


> ---
>  .../platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h    |  77 ++
>  .../platform/qcom/iris/vidc/src/msm_vidc_v4l2.c    | 953 +++++++++++++++++++++
>  2 files changed, 1030 insertions(+)
>  create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h
>  create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_v4l2.c
> 
> diff --git a/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h
> new file mode 100644
> index 0000000..3766c9d
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_v4l2.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _MSM_VIDC_V4L2_H_
> +#define _MSM_VIDC_V4L2_H_
> +
> +#include <linux/fs.h>
> +#include <linux/poll.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-dev.h>
> +#include <media/v4l2-ioctl.h>
> +
> +int msm_v4l2_open(struct file *filp);

We already have a v4l2 driver for msm platforms.

If it is concluded that there needs to be two (as was asked by others),
then this isn't "the one and only MSM video codec/controller/c???
driver". This would be the qcom_iris_ driver, or something along those
lines. All functions, variables, defines etc should be named
accordingly.

Regards,
Bjorn
