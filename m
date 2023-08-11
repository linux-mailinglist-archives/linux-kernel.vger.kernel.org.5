Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3856779B6B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbjHKXgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbjHKXgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:36:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F9310F5;
        Fri, 11 Aug 2023 16:36:44 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BNV01M017838;
        Fri, 11 Aug 2023 23:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Wz/s1t3Tr5SELcyNkAxXzTZrYb2YMuANF05aY9pa+Do=;
 b=oPDo7c2fDfQfCuab6dpTNzPEz3IQzj3wCmmo3bAdFrFKBQtNivLCM1QAtqSMe5nts/Nw
 X8ZEAOhJSQ2gnlZN5phTHec0B64p5o/oV1JbEd3w0aGYAG38xXsbPIT7xcYmq+Uqw0v/
 R9H5ebVi6EkPazxDIlwgzp6WAOXPs7OuuorL2XY9DDCY2V1Nlpl3t7IDX7+mGqQuXOc4
 xx6cVz8dFctLjB0qmTa8SkhQvkFl9DBZKAwctsLHGcqVb1cOskQwREv106qy6Jbn6bpq
 hVLNGwOJ9S9SBSDCmFO2l5X+yQ4QuhhHMl+rTmqGC2dYE7NMcIjWBDBSymBKajMfFLWw Vw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd9032yaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 23:36:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BNaajM013921
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 23:36:36 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 11 Aug 2023 16:36:36 -0700
Date:   Fri, 11 Aug 2023 16:36:34 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>
CC:     Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 2/4] soc: qcom: aoss: Add debugfs interface for
 sending messages
Message-ID: <20230811233634.GU1428172@hu-bjorande-lv.qualcomm.com>
References: <20230811205839.727373-1-quic_bjorande@quicinc.com>
 <20230811205839.727373-3-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230811205839.727373-3-quic_bjorande@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 40COawU98F_ix_CpRWSSooNik5pJkQUH
X-Proofpoint-GUID: 40COawU98F_ix_CpRWSSooNik5pJkQUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 01:58:37PM -0700, Bjorn Andersson wrote:
> From: Chris Lew <clew@codeaurora.org>
> 
> In addition to the normal runtime commands, the Always On Processor
> (AOP) provides a number of debug commands which can be used during
> system debugging for things such as preventing power collapse or placing
> floor votes for certain resources. Some of these are documented in the
> Robotics RB5 "Debug AOP ADB" linked below.
> 
> Provide a debugfs interface for the developer/tester to send these
> commands to the AOP.
> 
> Link: https://docs.qualcomm.com/bundle/publicresource/topics/80-88500-3/85_Debugging_AOP_ADB.html
> Signed-off-by: Chris Lew <clew@codeaurora.org>
> [bjorn: Dropped debugfs guards, improve error codes, rewrote commit message]
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/soc/qcom/qcom_aoss.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
> index 880fe234ca0a..13bf13ab78d6 100644
> --- a/drivers/soc/qcom/qcom_aoss.c
> +++ b/drivers/soc/qcom/qcom_aoss.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2019, Linaro Ltd
>   */
>  #include <linux/clk-provider.h>
> +#include <linux/debugfs.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/mailbox_client.h>
> @@ -82,6 +83,7 @@ struct qmp {
>  
>  	struct clk_hw qdss_clk;
>  	struct qmp_cooling_device *cooling_devs;
> +	struct dentry *debugfs_file;

Simon Horman pointed out in the previous version that this isn't added
to kernel-doc, and I missed correcting this.

Regards,
Bjorn
