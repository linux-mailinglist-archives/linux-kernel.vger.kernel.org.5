Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C0C7679A2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjG2Aev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjG2Aer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:34:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C11DC2;
        Fri, 28 Jul 2023 17:34:46 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36T0CUlm023961;
        Sat, 29 Jul 2023 00:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=F27hwl9tI974THVrfkh2OErJAY/cWYVzivqDD+GiXXU=;
 b=WEETP6ln7mRk5V1iU/Kn8ax0G0qg/AksUIgA8+CK3VGDFlohDR7IuZxMXVzuziDneYbI
 F7KdhvJd1n9kS4lVqcErZfL8QBQFhXP+AllY1f0vE9Po+9sKhbKpDLEwdVqI/bfH8yix
 aKE+qhX1bwf+o4rvJ4hqfG16A7y92FnBdCfmRElfDnaLIYS2p2E8e8b2f/jc8xUmoANZ
 ELqfAFG4cDYS1iXchl14PFF+DP+T6mAVsyOZKLWgS5qM215Lvh7ij21bxKSA6s85njll
 VjYxGDjQJyem0jU9G7uUsjvRfnd8qLiarXsLOlEVMQ6KPgG/LPxIyo7NTg80V1Y7gXdH jw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4j0g0phg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Jul 2023 00:34:42 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36T0YfNA012186
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Jul 2023 00:34:41 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 28 Jul
 2023 17:34:41 -0700
Date:   Fri, 28 Jul 2023 17:34:40 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Kathiravan T <quic_kathirav@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_saahtoma@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH V5 1/3] firmware: qcom_scm: provide a read-modify-write
 function
Message-ID: <20230729003440.GB25463@quicinc.com>
References: <20230720070408.1093698-1-quic_kathirav@quicinc.com>
 <20230720070408.1093698-2-quic_kathirav@quicinc.com>
 <fdd4bc8b-1349-485d-18c5-c6d69cd415a1@quicinc.com>
 <3ab86e8d-cc00-d0bb-20f8-4c75c90a7db8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ab86e8d-cc00-d0bb-20f8-4c75c90a7db8@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VTOhw3Imm0ZSF4_uivZokM8wlR6Naa3e
X-Proofpoint-ORIG-GUID: VTOhw3Imm0ZSF4_uivZokM8wlR6Naa3e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=433 mlxscore=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307290003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 23 2023 19:25, Kathiravan T wrote:
> 
> On 7/22/2023 6:47 AM, Trilok Soni wrote:
> >On 7/20/2023 12:04 AM, Kathiravan T wrote:
> >>From: Mukesh Ojha <quic_mojha@quicinc.com>
> >>
> >>It was realized by Srinivas K. that there is a need of read-modify-write
> >>scm exported function so that it can be used by multiple clients.
> >>
> >>Let's introduce qcom_scm_io_update_field() which masks out the bits and
> >>write the passed value to that bit-offset.
> >>
> >>Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >>Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> >>Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> >>---
> >>Changes in V5:
> >>    - No changes
> >>
> >>  drivers/firmware/qcom_scm.c            | 15 +++++++++++++++
> >>  include/linux/firmware/qcom/qcom_scm.h |  2 ++
> >>  2 files changed, 17 insertions(+)
> >>
> >>diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> >>index fde33acd46b7..104d86e49b97 100644
> >>--- a/drivers/firmware/qcom_scm.c
> >>+++ b/drivers/firmware/qcom_scm.c
> >>@@ -407,6 +407,21 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
> >>  }
> >>  EXPORT_SYMBOL(qcom_scm_set_remote_state);
> >>  +int qcom_scm_io_update_field(phys_addr_t addr, unsigned int mask,
> >>unsigned int val)
> >>+{
> >>+    unsigned int old, new;
> >>+    int ret;
> >>+
> >>+    ret = qcom_scm_io_readl(addr, &old);
> >>+    if (ret)
> >>+        return ret;
> >>+
> >>+    new = (old & ~mask) | (val & mask);
> >>+
> >>+    return qcom_scm_io_writel(addr, new);
> >>+}
> >>+EXPORT_SYMBOL(qcom_scm_io_update_field);
> >
> >EXPORT_SYMBO_GPL please.
> 
> 
> Sure, is it okay if I send the patch to convert the existing EXPORT_SYMBOL
> to EXPORT_SYMBOL_GPL as well?

This is done already [1].

[1] https://lore.kernel.org/lkml/19d9ac0bf79f957574ef9b3b73246ea0113cc0fd.1690503893.git.quic_gurus@quicinc.com/
