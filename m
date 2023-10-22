Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D937D2575
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjJVSwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVSw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:52:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC2AA9;
        Sun, 22 Oct 2023 11:52:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39M5l3ks014815;
        Sun, 22 Oct 2023 18:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=Jzh9kcCOCuLXkmCPFQiRjaPF7/bwcwvIZks0MXPYD0Y=;
 b=hhoKf3J17yyUoSbXbL4gdVv1HhQxLckKZzgFFOY+Et2Ol4NQ1i0l583nUyRSmexkqenm
 ncjYemHLUP1vCLuWWt0s8Fb1EQ+f+/BUumMnZ5sdOwcu+YBuv0GsUC7bospsDi6bDWZg
 mLOYCF77MIRf9IXKFzUe1k59m/5j2HbwNZ9nbxlSA/KN/9kzUwICqJcnBnh1iZr0Sama
 +0Zvu7DbShS4uasBsaXSyrWEmQJzY9oMLqRuy92Wzv5cYqc9Uo1vVtpqAISPzp285WHs
 Zu/yDv1+6usRI64suAFVl8POFQp93pIZINOU/hcVfQhfTtdmPZbi0KrBIG4WdJpMVDuy Gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv76u1t0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Oct 2023 18:52:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39MD2Mrr001659;
        Sun, 22 Oct 2023 18:52:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv539pv48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Oct 2023 18:52:14 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39MIqD72021252;
        Sun, 22 Oct 2023 18:52:13 GMT
Received: from localhost.localdomain (dhcp-10-175-52-84.vpn.oracle.com [10.175.52.84])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tv539pv3f-1;
        Sun, 22 Oct 2023 18:52:12 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: usb: rockchip,dwc3: fix reference to nonexistent file
Date:   Sun, 22 Oct 2023 20:51:50 +0200
Message-Id: <20231022185150.919293-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-22_16,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310220174
X-Proofpoint-GUID: m7DhFNR-LBY00qvShb2KrG1Pt5sZyFNZ
X-Proofpoint-ORIG-GUID: m7DhFNR-LBY00qvShb2KrG1Pt5sZyFNZ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file was renamed but left a dangling reference. Fix it.

Fixes: 0f48b0ed356d ("dt-bindings: phy: rename phy-rockchip-inno-usb2.yaml")
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
index 291844c8f3e1..c983dfe0f629 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -15,7 +15,7 @@ description:
   Phy documentation is provided in the following places.
 
   USB2.0 PHY
-  Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
+  Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
 
   Type-C PHY
   Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
-- 
2.34.1

