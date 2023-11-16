Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FEE7EDDB3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbjKPJf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKPJft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:35:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E081B2;
        Thu, 16 Nov 2023 01:35:46 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG2LsOm018760;
        Thu, 16 Nov 2023 09:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=ji2aruV2fK/7GKyIMJTR5DS42OxRi10WnpQFHX80cvQ=;
 b=WGeYg6RgDVs8iyI54jG28nJ7eTtIBdq6UQmUXrxQ3YhhAsebG53mXJBlHiFE7LdmcJAC
 KViu+QByKln2ZUYPfCaTHR6Ht2hu0SA0e8IoOZhBB+tVbf+Vy9keGgeH/XmiKmpmQ4mq
 lHKrKjAqc7KirE4vD4nG50/3UShtXQsyjCz8WrZoPEvCTY+5nUV37MIofQYC8EWDgBwP
 gTY0QoDDNDB/GHW1soz6bxU/K+VXU1wiHzJbxyGNx//FJbWDnco0MO3QrVWqMjrLEdby
 bd4p32mw6SWNrPjjTmyjGzK32apWIJ4FjDLFN5yf7LEgV2r/79X0KL7PZNvmUoDVJJzn JQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucuac2wsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 09:35:24 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AG9ZJrs029200;
        Thu, 16 Nov 2023 09:35:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3ua2pmgd82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 09:35:19 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AG9ZJZL029186;
        Thu, 16 Nov 2023 09:35:19 GMT
Received: from hu-devc-hyd-u20-c-new.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.147.246.70])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3AG9ZIvB029172
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 09:35:19 +0000
Received: by hu-devc-hyd-u20-c-new.qualcomm.com (Postfix, from userid 3970568)
        id 9BE7D220C3; Thu, 16 Nov 2023 15:05:17 +0530 (+0530)
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
Subject: [PATCH v2 0/3] Enable configs required to boot SDX75
Date:   Thu, 16 Nov 2023 15:05:10 +0530
Message-Id: <20231116093513.14259-1-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NCdeT_Etwg5Fo5lMO6EsnxTo8d9lxrok
X-Proofpoint-GUID: NCdeT_Etwg5Fo5lMO6EsnxTo8d9lxrok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_07,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=386
 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160076
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in v2:
 - Updated the commit message for the patches.

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

