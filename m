Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12D47AB0FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjIVLfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbjIVLeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:34:46 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64002E72
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:34:07 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230922113405epoutp016207c10bea131a02365c1c13e95ed880~HNVobhUIZ0569705697epoutp01h
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:34:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230922113405epoutp016207c10bea131a02365c1c13e95ed880~HNVobhUIZ0569705697epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695382445;
        bh=IiXu2AYNIYoo2V1VNpbrYx60xxgZ3GE5ewwmFgU1WC4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=HI58dJ2MPCoRxHufo7jJzp7EwcnAjjtzMJBz9pqyqVr9f1uv3Frend9Ht11S9O595
         xnScF7iWt5f7qf/1UYRJc+01bCUDbDJzQmOmgJzDPpAMKmJqLC7Y+qRS/JJSibLFIu
         WUpRksqvbVMoCeFCRQ660ohsciGUVFXzzBGNghxU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230922113405epcas2p4bcd13fc6e7aed84bd85f14e6d685080e~HNVn3teQ32558425584epcas2p4d;
        Fri, 22 Sep 2023 11:34:05 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RsVXX6gk4z4x9Pv; Fri, 22 Sep
        2023 11:34:04 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.5F.09649.CAB7D056; Fri, 22 Sep 2023 20:34:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230922113404epcas2p3995ec7890319931c33b0a549214c95ca~HNVm1gO0V0308103081epcas2p3L;
        Fri, 22 Sep 2023 11:34:04 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230922113404epsmtrp205a31e6cfce85ee6f96364e6ee371999~HNVmy5QMy3104531045epsmtrp24;
        Fri, 22 Sep 2023 11:34:04 +0000 (GMT)
X-AuditID: b6c32a46-b9ffa700000025b1-55-650d7bacc5a1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.18.18916.BAB7D056; Fri, 22 Sep 2023 20:34:04 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230922113403epsmtip266858725f682d73a2c951f8ca43d9afb~HNVmkgv4x2249622496epsmtip2T;
        Fri, 22 Sep 2023 11:34:03 +0000 (GMT)
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
Subject: [PATCH v2 7/7] cxl/memdev: Fix a whitespace warning
Date:   Fri, 22 Sep 2023 20:36:50 +0900
Message-Id: <20230922113650.3301992-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxz23Nve3uIq18LgjEysd5IFEmpbKVyFmiWiKdFkMOLMFhxeyx0l
        lLb2tsbNLGNUNtDE6cRHC3VbSpelFFFWFmAStfJUYDzUBaWQlS0VHKCgmw7EtbQ6//u+7/xe
        3++cg6PCTiwOL9IaGYOW1pBYBOfna4nyZNchASPpHt9IeScGMMp80g6oM6cGANU98gVG1Y24
        AFVW5+VSZnsDRj34a4lDXblfyqN6+ya5lPP72xjVXn8LoewdZ1Gq4xJO/Wq9zqGGW2sw6s7x
        ToS6OD6DvSNUtli9POXh9mmu0n5pElE2Oisx5WWbi6c85nYC5anqz5XzjfHZ+IfFGWqGLmAM
        Ikar0hUUaQsV5I7c/K358lSJNFm6iUojRVq6hFGQmTuzk7cXaQJWSNEBWmMKSNk0y5IbtmQY
        dCYjI1LrWKOCZPQFGn2aXszSJaxJWyjWMsbNUolEJg8E7i1Wd1V4Mf0TzsEbS7XcUnCScwTw
        cUikwKbFiwEcgQuJZgC7Zp9gITIH4Lflz3gvycOaGvRFytEjtnBUC4BPx0dAiCwCWDvr5gaj
        MCIJnrGUcoMH0cTvCGyZOoYECUr4EPiwe2q5VhSRAR0DdwO1cJxDJEBfnTQoC4h0uPSPHwu1
        WwsvX+1DQ/pq2GP5Y3lyNKCbm6rRYE1I1OPw38fTYUuZsNw5zAvhKDjV5Q7jODg/04aFEswA
        3vff5ITIYQDP320OR22EMyN+bnAilEiEDa0bghASb8H2O+HGq2DFteBigrIAVnwpDCWS8Jzj
        XHhFEA7Z3GGshINu/3JxIbEHzlqmecfBWusrdqyv2LH+3/c7gDpBDKNnSwoZVqaXvbxXla6k
        ESw/6KTtzaBq+oHYAxAceADEUTJaoJqLYISCAvqTTxmDLt9g0jCsB8gD+z2Bxr2u0gV+hNaY
        L03ZJElJTZWmyeSSNDJWMFZuKxAShbSRKWYYPWN4kYfg/LhSJFfoWblu1PjaV3uGxOwB9dcX
        cvYu4gJfJdeZXtRW2V0/Ovfm1YmOTNWJjBsJP97KctXuuJDunMGyiraMkjXzbdGj71YhuZaR
        3s7WspynaZGDpMfelHf67GeP+Px1eSuwKv3q9c/p3mGvCI2Fj7Pc/H2OnJbnuxwNt69I8cp9
        7WLFqGJ9nq0j8qOZ+J/6BUcT5vsMclXL5pUT2Tfvaej+qJ5HMtP7533iN1ZI/jbE+8YM6lVz
        28bcu4qHmP2qyvRv6iOu/9ZzsGq8DGr2LyysEZh/GHRMxfj7h9LH/GtiosDHk9Xmha1v+xyu
        WO8vec+WGra9Z/lg95/MadmhRPu9yN0kh1XT0iTUwNL/AVqN++JZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvO6aat5Ugzu9TBZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmcWTtVSaL
        xUdnMFsc3cNhcX7WKRaLy7vmsFncmnCMyWLj/XdsDkIeO2fdZfdoOfKW1WPxnpdMHptWdbJ5
        7J+7ht2jb8sqRo+ps+s9Pm+SC+CI4rJJSc3JLEst0rdL4Mo43nGXreAHS8Xpf0tYGxgns3Qx
        cnJICJhIdHfNZeti5OIQEtjOKLHq/x5WiISExPINL5ggbGGJ+y1HWCGKfjFKXD3/mREkwSag
        JTF9ZgNYQkTgOZPEyTenGEEcZoFXTBK9/68zg1QJC9hILL1wG2gHBweLgKrEo9WGIGFeAWuJ
        f9+fs0FskJfYf/AsM0RcUOLkzCdg5zEDxZu3zmaewMg3C0lqFpLUAkamVYyiqQXFuem5yQWG
        esWJucWleel6yfm5mxjBkaIVtINx2fq/eocYmTgYDzFKcDArifAmf+JKFeJNSaysSi3Kjy8q
        zUktPsQozcGiJM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamCKnavWPNt9Xpq+iX9t4UYDO6Oj
        jmvUfrKnO3voFSx6FlDyWX35/819S4tXc24zYL/6xmru/WdN08SjDZ0//y9/K/0uvkz4w9SC
        6amN/1/OZyuom2t15Yj9/a38LE9aMiUCZCvuLzZ+Z99Tlamy+NmbM4u3RVe45woYJLidn6yu
        2NihynmBKe109oq3Z89aeRz8M6ksYQ1zef2XA039iz8yCsrY6i1f+9ZggaP+1EVvcvx2mLMu
        f+snXNuYUqz/WqOXOT7tpaaV0NMIkcTm6cckku0Upy/59UsvMrC6kkV31qVFKVmNwbqzBQ4l
        HF4/V3OB9gO5ZWpCDxwsXmd9ZynYI+3f8/X53zohQ8/YdUosxRmJhlrMRcWJAPIIQYcDAwAA
X-CMS-MailID: 20230922113404epcas2p3995ec7890319931c33b0a549214c95ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922113404epcas2p3995ec7890319931c33b0a549214c95ca
References: <CGME20230922113404epcas2p3995ec7890319931c33b0a549214c95ca@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: please, no spaces at the start of a line

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
---
 drivers/cxl/core/memdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 7e8fca4707c0..ce67df163452 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1010,7 +1010,7 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
 	}
 
 	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
- }
+}
 
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
-- 
2.34.1

