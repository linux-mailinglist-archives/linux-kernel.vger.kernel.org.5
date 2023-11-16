Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778377EDB15
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344894AbjKPFPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjKPFO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:14:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8066919D;
        Wed, 15 Nov 2023 21:14:52 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG4GGxv024428;
        Thu, 16 Nov 2023 05:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=NUHMr9J3BC7DOHJPpsAkaV77crTZzWD0PtrdKPemPOo=;
 b=mdbroBl2oifyjz2Nd8kB+XUPfmKe08fTL5qXimAa0Br91SdEC4n/drDzQ5WdoDSd+262
 L6jMmECzcovwM6rPhI8SjUjaEuSMizyusszIuVK7OctkwO8M30j+PO7SnQvlGNACR+CR
 dhPvBCQBEtMIHaFGRitKSYG/ZRzt5Vp+CctpBmYG2H9ANalTpbfEPJF/k7LmV5L1XmRA
 jHHS25bndJl7PecbFrFCc1WDgPA2RIRHyXD0KHZC/4iD0/A+U4N3zoaMyE83fjAoXfVi
 SRvFvzMzzsINB3pC5icc2O6zi/D1y0ok0jKwnq7KcsTYHkL6pSETCCgZTrrH8VMUDfpQ lw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucq5fau66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 05:14:27 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AG5EOmK004930;
        Thu, 16 Nov 2023 05:14:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3ua2pkk618-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 05:14:24 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AG5EN08004914;
        Thu, 16 Nov 2023 05:14:23 GMT
Received: from hu-devc-hyd-u20-c-new.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.147.246.70])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3AG5ENZW004911
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 05:14:23 +0000
Received: by hu-devc-hyd-u20-c-new.qualcomm.com (Postfix, from userid 3970568)
        id 38B0022070; Thu, 16 Nov 2023 10:44:22 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, geert+renesas@glider.be,
        konrad.dybcio@linaro.org, arnd@arndb.de,
        krzysztof.kozlowski@linaro.org, neil.armstrong@linaro.org,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        m.szyprowski@samsung.com, u-kumar1@ti.com, peng.fan@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/3] Enable configs required to boot SDX75
Date:   Thu, 16 Nov 2023 10:43:58 +0530
Message-Id: <20231116051401.4112494-1-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jyElp1vsztzRKz2wJwHns79n0DK9-rzY
X-Proofpoint-ORIG-GUID: jyElp1vsztzRKz2wJwHns79n0DK9-rzY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_02,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 clxscore=1011 impostorscore=0 mlxlogscore=307
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160038
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds configs related to GCC, Pinctrl and Interconnect
that lets enable these frameworks for Qualcomm's SDX75 SoC to boot
to shell.

Thanks,
Rohit.

Rohit Agarwal (3):
  arm64: defconfig: Enable GCC for SDX75
  arm64: defconfig: Enable pinctrl for SDX75
  arm64: defconfig: Enable Interconnect for SDX75

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.25.1

