Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE92A7AB0DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjIVLde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjIVLdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:33:18 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8C6CF7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:32:38 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230922113236epoutp02f6a159da71793a78a32fd140e4b7ef64~HNUVfNpeE2300223002epoutp025
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:32:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230922113236epoutp02f6a159da71793a78a32fd140e4b7ef64~HNUVfNpeE2300223002epoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695382356;
        bh=CJozgS+cxiIPZXmV9pUlDsRXFlvycRHAVRzCiYtEyqM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BPigux2l4UVuEDR5ML2QkpJDxhF2h5hW/5Srx3MAfWzZNTUKDK7R7DDMk07K1DIfE
         uuW7pdAP9bY3b3xuk7sxvoPVwP884z52ZapuanPlcw3d3N5b3MCcNE9/OBWpBzo6nH
         LjJYi4wCbw1IwjJ6wWwvHDT8slrR9lO1mv8k8SrE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230922113235epcas2p1b06a8217ab74094bd5f48149548a66d5~HNUUVEcmx2310223102epcas2p1w;
        Fri, 22 Sep 2023 11:32:35 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.90]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RsVVq0FfCz4x9Pp; Fri, 22 Sep
        2023 11:32:35 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.01.19471.25B7D056; Fri, 22 Sep 2023 20:32:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230922113233epcas2p2cd57df10dde36b0da3b2fc5a916132e8~HNUS2tVMP2731427314epcas2p2F;
        Fri, 22 Sep 2023 11:32:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230922113233epsmtrp126c99db727ff95e052c7a919ca37dc3e~HNUS0jbBb1340313403epsmtrp1d;
        Fri, 22 Sep 2023 11:32:33 +0000 (GMT)
X-AuditID: b6c32a4d-b07ff70000004c0f-97-650d7b521e29
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.27.08788.15B7D056; Fri, 22 Sep 2023 20:32:33 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230922113233epsmtip24f39126144d0bc0340b81dbfd9cd5bba~HNUSe7CNM2030120301epsmtip2k;
        Fri, 22 Sep 2023 11:32:33 +0000 (GMT)
From:   Jeongtae Park <jtp.park@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>,
        Jeongtae Park <jtp.park@samsung.com>
Subject: [PATCH v2 2/7] cxl/region: Fix a checkpatch warning
Date:   Fri, 22 Sep 2023 20:35:20 +0900
Message-Id: <20230922113520.3298976-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmqW5QNW+qwawWa4u7jy+wWTRPXsxo
        MX3qBUaLEzcb2SxW31zDaNG0+i6rRfPi9WwWH978Y7E48LqB3eLM2ZesFqsWXmOzOLL2KpPF
        4qMzmC2O7uGwOD/rFIvF5V1z2CxuTTjGZLHx/js2ByGPnbPusnu0HHnL6rF4z0smj02rOtk8
        9s9dw+7Rt2UVo8fU2fUenzfJBXBEZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqY
        KynkJeam2iq5+AToumXmAL2ipFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9Ar
        TswtLs1L18tLLbEyNDAwMgUqTMjO6HuXUNDDXjFp/wG2BsY3rF2MHBwSAiYS3Y/ruxi5OIQE
        9jBK/Pv1gBHC+cQocfP7ahYI5xujxMGXV5m6GDnBOt41PWOHSOxllHh8Yz9Uyx9GicZDR9lA
        qtgEtCSmz2xgBUmICDxkktj5qo8JxGEWeMQk8fHEK2aQ7cICNhI7X4eBNLAIqEps3HuRBcTm
        FbCWWHb0LzvEOnmJ/QfPMkPEBSVOznwCVsMMFG/eOpsZZKaEwBYOidYXa1kgPnKReLjFAKJX
        WOLV8S1Qc6QkXva3sUPUNzNKvH5+hQXCaWGUWHd7B1SVscS7m8/BQcMsoCmxfpc+xExliSO3
        oPbySXQcBrkNJMwr0dEmBNGoJDFv6TxmCFtC4tLcLVC2h8TtdafBhgsJxEp8m7WXbQKj/Cwk
        38xC8s0shL0LGJlXMUqlFhTnpqcmGxUY6uallsMjNjk/dxMjOEVr+e5gfL3+r94hRiYOxkOM
        EhzMSiK8yZ+4UoV4UxIrq1KL8uOLSnNSiw8xmgLDeCKzlGhyPjBL5JXEG5pYGpiYmRmaG5ka
        mCuJ895rnZsiJJCeWJKanZpakFoE08fEwSnVwNT1q0el7ZHLhTi7JU6nWbrsrK4suXRxyXQ9
        Vn03m+NLNSQ3f6gxXlZ6+XjoVm3mV9N+9UzpN97T/ufJ7q7o6b8cmC8WlD9f2pEtpvxO8Stf
        /X3vj16N6dP5zyjOE2QuK7S7taRndqbx9wVXtJhYWA0frDAyEqi7whzvu/umX3Xmi12/rKSf
        Xgs1jfT1uzO39dC5jTIvpmpI7vt/VcTBx1v2+rdVkf5CTw4l70g9LCT0LpEzYYOZ5tZD576u
        naYsL9Bu7zN1b9n6RCmNlckdPw3PsqdkheY8dojQ0V8Wy31OaJ6a0pSl7c5qSivEpz5dteh9
        /qzPGT7Vfxd8Ys96a3airXFf/Vq5riNnmESj0pRYijMSDbWYi4oTAXdoWIlaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvG5gNW+qwZuzuhZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmcWTtVSaL
        xUdnMFsc3cNhcX7WKRaLy7vmsFncmnCMyWLj/XdsDkIeO2fdZfdoOfKW1WPxnpdMHptWdbJ5
        7J+7ht2jb8sqRo+ps+s9Pm+SC+CI4rJJSc3JLEst0rdL4Mroe5dQ0MNeMWn/AbYGxjesXYyc
        HBICJhLvmp6xdzFycQgJ7GaUmHBkPjNEQkJi+YYXTBC2sMT9liOsEEW/GCVeNF1gAUmwCWhJ
        TJ/ZAJYQEXjOJHHyzSlGEIdZ4BWTRO//60CjODiEBWwkdr4OA2lgEVCV2Lj3Ilgzr4C1xLKj
        f9khNshL7D94lhkiLihxcuYTsBpmoHjz1tnMExj5ZiFJzUKSWsDItIpRMrWgODc9t9iwwCgv
        tVyvODG3uDQvXS85P3cTIzhetLR2MO5Z9UHvECMTB+MhRgkOZiUR3uRPXKlCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeb+97k0REkhPLEnNTk0tSC2CyTJxcEo1MDm0Cz/t32tWvGNqRszpqbWn
        jNau6blVdn/JHwsz3k0ep9ddndirHFTd93iebMnMhit8TyvS3Lcpzlc+f8lK9M4uqyUPfapO
        Jp9dyGuTPPn8s5p7BWzfXV0UdhneZdtSayLmfnxDc7CNzGTlEMWQq1NL18+RPFb/sismY6dT
        cY292K31L5xvemaxO88wXPdKhqEuzk+w8Z9Ego7Yh8knXZRY0sTNonvyz3Me/Rr7qiq8aMuB
        44qTqpQvss+2e7Pn/f3vls8efRJ56v5xbtEyH42Q+AvP+orONFecN9LTU9v/sq24Zb3sh5cd
        3dyCXbYqwjPl2vgPzWy1W3Z41aYHXz0TL79z1V86z/aZYKS3qRJLcUaioRZzUXEiAAodG1MG
        AwAA
X-CMS-MailID: 20230922113233epcas2p2cd57df10dde36b0da3b2fc5a916132e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922113233epcas2p2cd57df10dde36b0da3b2fc5a916132e8
References: <CGME20230922113233epcas2p2cd57df10dde36b0da3b2fc5a916132e8@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: else is not generally useful after a break or return

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e115ba382e04..1fc9d01c1ac0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -133,11 +133,10 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 				&cxlr->dev,
 				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
 			return 0;
-		} else {
-			dev_err(&cxlr->dev,
-				"Failed to synchronize CPU cache state\n");
-			return -ENXIO;
 		}
+
+		dev_err(&cxlr->dev, "Failed to synchronize CPU cache state\n");
+		return -ENXIO;
 	}
 
 	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
-- 
2.34.1

