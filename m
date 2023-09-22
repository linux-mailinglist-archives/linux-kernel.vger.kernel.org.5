Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BACE7AB0F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjIVLeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjIVLeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:34:04 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7740310F4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:33:21 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230922113319epoutp04d56c5d7d50cf429d297e20bb443551e7~HNU9jfFw10685906859epoutp04X
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:33:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230922113319epoutp04d56c5d7d50cf429d297e20bb443551e7~HNU9jfFw10685906859epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695382399;
        bh=Tq0h91ZXPuOiKdlDUexDwGn0SVhCh1sNATEnLYqNZok=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kQVmdG9noCBPX7K7iuHyLtOs0ZR/DLuvIw8zd3kYo9/p9sQWUsKxWkC7aKsgG+k1v
         bynoySpSWUbCyeuX5OwFzO9Jfhi2AJDGcKRe7+/9YhIH48tSGYCTNjQecjx2KYDTbL
         XVCLBCVpia5hzyEDw9+1uRBnHFbt56ZfjEF/oSmA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230922113319epcas2p1083ace4d3f6f85e21a831b3aa2647c76~HNU82AmIc2310223102epcas2p1i;
        Fri, 22 Sep 2023 11:33:19 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RsVWf3n3Rz4x9Pt; Fri, 22 Sep
        2023 11:33:18 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.3F.09649.E7B7D056; Fri, 22 Sep 2023 20:33:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230922113317epcas2p4f6b9ee86aeead4ce8b19473379ecf4bb~HNU704_w82558425584epcas2p4k;
        Fri, 22 Sep 2023 11:33:17 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230922113317epsmtrp16fc9b73dcc482aea95b033f7358381ce~HNU70Bzf_1403814038epsmtrp1l;
        Fri, 22 Sep 2023 11:33:17 +0000 (GMT)
X-AuditID: b6c32a46-b9ffa700000025b1-0b-650d7b7e27b2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.27.08788.D7B7D056; Fri, 22 Sep 2023 20:33:17 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230922113317epsmtip113d8ddb51e615d500a7e104aef5a9e61~HNU7jLSaE0701807018epsmtip1Y;
        Fri, 22 Sep 2023 11:33:17 +0000 (GMT)
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
Subject: [PATCH v2 4/7] cxl: Fix a checkpatch error
Date:   Fri, 22 Sep 2023 20:36:04 +0900
Message-Id: <20230922113604.3300468-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxbVRz19rWvD7KaZ9nwpuqoz80ICdAChTtWiOJgNWOTRBINC0KlD4qU
        tva1Zh9qKyAwiFAyECgrwZBF0gHVwhyMLbSFdczYwcRNmZS5YVz4zECzKRnTlna6/8753XN+
        5/7uB4HxPbiAKFXraZ1arqLwcPa3Y9EpsZ8c59Gir6cjkW9+CkeVJ7sBam2ZAmhi5lMcnZnp
        BajijI+DKrvtOLq3/IiNnEsmLvreu8BBti9v4Gi87zoLdV9qw9ClCwSatHzHRtPnT+HoptnD
        Qt/cWsVf5cuGLT6urGp8hSPrvrDAkjlsJ3DZqLWXK2sYtAFZS4dR9odjZw6RVyZV0nIFrRPS
        6iKNolRdkkYdeKvg9QJJskgcK96DUiihWl5Op1H7snNis0pV/lEo4YdylcFfypEzDBWfLtVp
        DHpaqNQw+jSK1ipU2hRtHCMvZwzqkjg1rU8Vi0QJEr+wsEzp9r2mHcCPnFve4JrAEKcOhBGQ
        TIIn5jvwOhBO8MkhAAc6a1lBsg5gvXMyRO4DOGL7Ezy2nK5fDy1cBPD3rx5yg+QhgM2tG1hA
        hZMxsLXdxAksbCdvs+DwYsOWBSPvsODaxOKWKoJMhD2T1Vt92eRuaB6twgOYR+6Ffy17uMG8
        KDjq8mLB+jPwSvtv7ADG/PXKsx1YoCkkBwl4zenCgoZ9sKni1xCOgIuXB0ONBHChsZobNFQC
        uHT3R3aQVAHY/8tQSJUIV2fu+jdO+COiof18fABC8iU4fjMU/DSsHdvkBss8WFvNDxop2Hm6
        MxQL4Q/WwRCWQdNYIyuA+WQ+nLhsZptBlOWJcSxPjGP5P7cLYDYQSWuZ8hKaSdAm/HevRZpy
        B9h60DFZQ6B55V6cG7AI4AaQwKjtvKL1cJrPU8iPHqN1mgKdQUUzbiDxH3ATJthRpPH/CLW+
        QJy0R5SUnCxOSZCIUqhneXOfWRV8skSup8toWkvrHvtYRJjAxMq1zlbulxzWtPd47r+jsOY1
        FBm98bm0nXfnirBh28jqtfd6iG01GYeyR/omIn/KHr/aNofxhtNfeS7KVXNy1h3mOVS/5vRd
        N298rhD0LgsLM1zKWTsqfrcvrynfHNMyenjTNtAovdgmnXv7Z2lLfV6cl7BYUoWpFTtdH0en
        P7WWmUFbHyyF1/Gaj5/b3dq4+kXFXtNCvhJObb5c/EHukWNdVxfL5v9ZqnqB5+NnHhxsvv18
        4d85K6lt/Ac7io1vPjo47Sg7O9WQeRSTvj8Z0R9ur5EOZy6dSuerYLxRdOPFXW+wq/VIYv/I
        qB/oYhyJTmeW127ov1XKzslNE8WahRSbUcrFMZiOkf8LfYZuqVkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSnG5tNW+qwaRdxhZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmcWTtVSaL
        xUdnMFsc3cNhcX7WKRaLy7vmsFncmnCMyWLj/XdsDkIeO2fdZfdoOfKW1WPxnpdMHptWdbJ5
        7J+7ht2jb8sqRo+ps+s9Pm+SC+CI4rJJSc3JLEst0rdL4Mo4dNexYDNbxfY3v9gbGHewdjFy
        ckgImEgs7f7E1MXIxSEksJtRYtLa88wQCQmJ5RteMEHYwhL3W46wQhT9YpQ4eGUOWDebgJbE
        9JkNYAkRgedMEiffnGIEcZgFXjFJ9P6/DjZKWMBYYsX5NkYQm0VAVWLC/hY2EJtXwFrix5tj
        7BAr5CX2HzzLDBEXlDg58wkLiM0MFG/eOpt5AiPfLCSpWUhSCxiZVjFKphYU56bnFhsWGOWl
        lusVJ+YWl+al6yXn525iBEeMltYOxj2rPugdYmTiYDzEKMHBrCTCm/yJK1WINyWxsiq1KD++
        qDQntfgQozQHi5I477fXvSlCAumJJanZqakFqUUwWSYOTqkGJhm3IPFOv7/XMx+r2zeuK8rz
        O7t8z9I5AZuj9ZdV+XR8vns+1t5ie0HWns3+z/z1Yv1K0pf4WtwyT7d7nGDRd6LFJdVNIDFw
        1b9n6xMmxqqJfgz8yjHRMKP31f4s/hMr1/N0/rp4rWq3UdpM9rig6GtVix99d/pySnrtoksW
        zNN1gjaEfqmoSt8ka6kVyDUjxkZ8d0Xdko+pS8KnesVW8r77oOe9XWZRqobKtoxlbAyvo7Q8
        pOoM2506Yvnf3i5idbKWOjVdZKO7xXulvfOfBVww22wakH+sQP34+S53lguzzdpfBd/MuSJp
        LzD/b8k8A84q+TOyoY1uT14c0PCdzfwrf/2x1HZ+y5IVd58qsRRnJBpqMRcVJwIAYUPT0gcD
        AAA=
X-CMS-MailID: 20230922113317epcas2p4f6b9ee86aeead4ce8b19473379ecf4bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922113317epcas2p4f6b9ee86aeead4ce8b19473379ecf4bb
References: <CGME20230922113317epcas2p4f6b9ee86aeead4ce8b19473379ecf4bb@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: Macros with complex values should be enclosed in parentheses

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 76d92561af29..545381355efb 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -142,7 +142,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXL_RAS_HEADER_LOG_OFFSET 0x18
 #define CXL_RAS_CAPABILITY_LENGTH 0x58
 #define CXL_HEADERLOG_SIZE SZ_512
-#define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
+#define CXL_HEADERLOG_SIZE_U32 (SZ_512 / sizeof(u32))
 
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
-- 
2.34.1

