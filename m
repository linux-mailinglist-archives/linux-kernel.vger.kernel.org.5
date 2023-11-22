Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2DF7F3D21
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjKVFIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKVFH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:07:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4810391;
        Tue, 21 Nov 2023 21:07:55 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM55rru029773;
        Wed, 22 Nov 2023 05:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=+iKjVTLEXsD1yIA4BymXbnpVr4vVCZ7hyvrTEHT5zD4=;
 b=IV4TqcQjE0hKG9CKb+AnPiKfoT2sq6h5qGS1vL0MnEFAZRV9y/O+lVWwUuXHIow5aUDI
 GZWvdFS6utkFzEnPxgEX5NWs8oU1dl2QAoBMu81Y7lihn8ci6+HkA5EOVrI+YO3TI6Ze
 2whWHgEumMODNGV4SrhzcWihAT+aFdp1a1hL2fQXNRsjNUZ8RQVM4RNk4yrkVcaI/CZh
 bsQoEk6ZOSqpJtq3XbQU5dTPdYx/RqUrZZL5CIJn0OPVII2ZEuLBO1sK3uU02BS5j+ON
 7R9gjFYSKVcdbaYAMu9PZye1dB4oQ1nT/UF/U20ixO4PCC2q79AfVEmaD7dyBwgkz2h0 eQ== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug7eadcsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 05:07:12 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AM5794t031639;
        Wed, 22 Nov 2023 05:07:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3uepbkjnta-1;
        Wed, 22 Nov 2023 05:07:09 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AM579Wu031634;
        Wed, 22 Nov 2023 05:07:09 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3AM579df031633;
        Wed, 22 Nov 2023 05:07:09 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 393357)
        id 7BFD85488; Wed, 22 Nov 2023 13:07:07 +0800 (CST)
From:   Ziqi Chen <quic_ziqichen@quicinc.com>
To:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        quic_ziqichen@quicinc.com, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] dt-bindings: ufs: Add msi-parent for UFS MCQ
Date:   Wed, 22 Nov 2023 13:06:52 +0800
Message-Id: <1700629624-23571-1-git-send-email-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VYPR1uzVTSdy5uXqpBSIneMIl2St_z9c
X-Proofpoint-ORIG-GUID: VYPR1uzVTSdy5uXqpBSIneMIl2St_z9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_02,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=954 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220036
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Message Signaled Interrupts (MSI) support has been
introduced in UFSHCI version 4.0 (JESD223E). The MSI is
the recommended interrupt approach for MCQ. If choose to
use MSI, In UFS DT, we need to provide msi-parent property
that point to the hardware entity which serves as the MSI
controller for this UFS controller.

Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>

Changes to v1:

- Rebased on Linux 6.7-rc1.

- Updated the commit message to incorporate the details about
  when MCQ/MSI got introduced.
---
 Documentation/devicetree/bindings/ufs/ufs-common.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/ufs-common.yaml b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
index 985ea8f..31fe7f3 100644
--- a/Documentation/devicetree/bindings/ufs/ufs-common.yaml
+++ b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
@@ -87,6 +87,8 @@ properties:
     description:
       Specifies max. load that can be drawn from VCCQ2 supply.
 
+  msi-parent: true
+
 dependencies:
   freq-table-hz: [ clocks ]
   operating-points-v2: [ clocks, clock-names ]
-- 
2.7.4

