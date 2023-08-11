Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9507977930F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbjHKP2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjHKP23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:28:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E07103;
        Fri, 11 Aug 2023 08:28:29 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BFD0xh029825;
        Fri, 11 Aug 2023 15:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=GTLC/9oog8RQrxN6IW0FCIdY74XoZYDDW9/DkbpmGMk=;
 b=Oki+6Vwty2BGlRcI9znoK0KvhBq7SdnViSycIVF8B4kSJtD4WurJLmLZUJQm78pY/jHc
 mg21D4wCS6RTEdqjInYg6hXpCOKA4a1FVKsOtwLQZY9AczPmGw2BvM38XnTj69TLVlpH
 aR9tifWT2e3qc8xaIpjJxyO+c7A5AsA3ShvUiqZmLKwpT6e/8ORgsfYT5+Jf0NyphZ4U
 3lCZrdowbZfXVMiUp6bx+VvOCvqZAW1SMhuyWYvH9anhf4LjsIVtuRz0syXEo/aihB3M
 GksY5/KkcVYW/NBYo2/2+t6MPxM01Vu/c0QeH4p6tSsMbKPMXnmNwgmAZuwQK7ncjJvK Yw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8yuj3y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 15:28:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BFSKxc012614
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 15:28:20 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 11 Aug 2023 08:28:20 -0700
Date:   Fri, 11 Aug 2023 08:28:19 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/20] Retire DEFINE_QBCM/DEFINE_QNODE macros
Message-ID: <20230811152819.GS1428172@hu-bjorande-lv.qualcomm.com>
References: <20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 95bMim_Kaa5V5sWhfdgD6MgPS15McVWH
X-Proofpoint-ORIG-GUID: 95bMim_Kaa5V5sWhfdgD6MgPS15McVWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_06,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=905 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 02:15:11PM +0200, Konrad Dybcio wrote:
> This is ripped out of the bigger patch series at [1], as this part
> doesn't really have any dependencies and (hopefully) brings no
> functional change.
> 
> Compile-tested for the most part, bloat-o-meter reports no size change
> 

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn

> [1] https://lore.kernel.org/linux-arm-msm/20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org/
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (20):
>       interconnect: qcom: sc7180: Retire DEFINE_QNODE
>       interconnect: qcom: sdm670: Retire DEFINE_QNODE
>       interconnect: qcom: sdm845: Retire DEFINE_QNODE
>       interconnect: qcom: sdx55: Retire DEFINE_QNODE
>       interconnect: qcom: sdx65: Retire DEFINE_QNODE
>       interconnect: qcom: sm6350: Retire DEFINE_QNODE
>       interconnect: qcom: sm8150: Retire DEFINE_QNODE
>       interconnect: qcom: sm8250: Retire DEFINE_QNODE
>       interconnect: qcom: sm8350: Retire DEFINE_QNODE
>       interconnect: qcom: icc-rpmh: Retire DEFINE_QNODE
>       interconnect: qcom: sc7180: Retire DEFINE_QBCM
>       interconnect: qcom: sdm670: Retire DEFINE_QBCM
>       interconnect: qcom: sdm845: Retire DEFINE_QBCM
>       interconnect: qcom: sdx55: Retire DEFINE_QBCM
>       interconnect: qcom: sdx65: Retire DEFINE_QBCM
>       interconnect: qcom: sm6350: Retire DEFINE_QBCM
>       interconnect: qcom: sm8150: Retire DEFINE_QBCM
>       interconnect: qcom: sm8250: Retire DEFINE_QBCM
>       interconnect: qcom: sm8350: Retire DEFINE_QBCM
>       interconnect: qcom: icc-rpmh: Retire DEFINE_QBCM
> 
>  drivers/interconnect/qcom/bcm-voter.h |    8 -
>  drivers/interconnect/qcom/icc-rpmh.h  |   10 -
>  drivers/interconnect/qcom/sc7180.c    | 1613 ++++++++++++++++++++++++++---
>  drivers/interconnect/qcom/sdm670.c    | 1386 ++++++++++++++++++++++---
>  drivers/interconnect/qcom/sdm845.c    | 1655 +++++++++++++++++++++++++++---
>  drivers/interconnect/qcom/sdx55.c     |  843 ++++++++++++++--
>  drivers/interconnect/qcom/sdx65.c     |  830 +++++++++++++--
>  drivers/interconnect/qcom/sm6350.c    | 1526 +++++++++++++++++++++++++---
>  drivers/interconnect/qcom/sm8150.c    | 1686 ++++++++++++++++++++++++++++---
>  drivers/interconnect/qcom/sm8250.c    | 1745 ++++++++++++++++++++++++++++----
>  drivers/interconnect/qcom/sm8350.c    | 1798 +++++++++++++++++++++++++++++----
>  11 files changed, 11786 insertions(+), 1314 deletions(-)
> ---
> base-commit: 39a1ff5094638b367bbd17e6a79591c67eed1a67
> change-id: 20230811-topic-icc_retire_macrosd-2d4c4f5356bc
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 
