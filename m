Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C297AB0D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjIVLdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjIVLdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:33:07 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F3FCDC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:32:22 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230922113221epoutp024b846f156f40d724fb0f006f592beb22~HNUHFwt392482424824epoutp02z
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:32:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230922113221epoutp024b846f156f40d724fb0f006f592beb22~HNUHFwt392482424824epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695382341;
        bh=fZWTp9OdgIx+t9GiysVUZPuZfmjmaZY9ogshuZbbQ6I=;
        h=From:To:Cc:Subject:Date:References:From;
        b=T/MbGXtxkQt0dDBzA/2BamxdOW+UyuXONptH84Ar1ZUxlZAFqK+Vt8Ohe2mTI193Z
         OPEV/KLI/izMqK3YUnhNV9OvOL2WDYZBcgf+HD36hYVaAqiaIoyKp5As7ZGsrBpp9e
         TS8qw2+oa7YjSdku8qhzhzdXBMZxH/45qeK5xsKU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230922113220epcas2p3db01f6414da18cb24cdfb95714a946ce~HNUGkqZYJ2363623636epcas2p3Y;
        Fri, 22 Sep 2023 11:32:20 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.102]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RsVVX1bMdz4x9Pp; Fri, 22 Sep
        2023 11:32:20 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.01.19471.44B7D056; Fri, 22 Sep 2023 20:32:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230922113219epcas2p1293d292c81a400a8347328d78217a498~HNUFlSsOU1098010980epcas2p1k;
        Fri, 22 Sep 2023 11:32:19 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230922113219epsmtrp2fbb9c888360f25c2a045e6ad47cd779f~HNUFkamLh2946829468epsmtrp2A;
        Fri, 22 Sep 2023 11:32:19 +0000 (GMT)
X-AuditID: b6c32a4d-dc5ff70000004c0f-82-650d7b4401ef
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.08.18916.34B7D056; Fri, 22 Sep 2023 20:32:19 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230922113219epsmtip2bcf203a62716fa38ee3304019e74f10a~HNUFTwN8X2026320263epsmtip2Q;
        Fri, 22 Sep 2023 11:32:19 +0000 (GMT)
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
Subject: [PATCH v2 1/7] cxl/trace: Fix improper SPDX comment style for
 header file
Date:   Fri, 22 Sep 2023 20:35:05 +0900
Message-Id: <20230922113505.3298473-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmha5LNW+qwZM17BZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmcWTtVSaL
        xUdnMFsc3cNhcX7WKRaLy7vmsFncmnCMyWLj/XdsDkIeO2fdZfdoOfKW1WPxnpdMHptWdbJ5
        7J+7ht2jb8sqRo+ps+s9Pm+SC+CIyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpFSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBX
        nJhbXJqXrpeXWmJlaGBgZApUmJCd0fDtJWvBMtaKyS+vszYw7mHpYuTkkBAwkTjWNw3I5uIQ
        EtjDKHHtyW0mCOcTo0TTk4VMIFVgTmtnIkzHw5UvoDp2Mkp0v98F1fGHUaL5/jVGkCo2AS2J
        6TMbWEESIgIPmSR2vuoDq2IWeMQk8fHEK2aQKmGBEInlV6+wgtgsAqoSd6+tB+vmFbCWmHZ6
        GhvEPnmJ/QfPMkPEBSVOznwCdjkzULx562xmkKESAms5JGacWgfV4CJxev0kJghbWOLV8S3s
        ELaUxOd3e9kgGpoZJV4/v8IC4bQwSqy7vQOqylji3c3nQCdxAK3QlFi/Sx/ElBBQljhyC2ox
        n0TH4b/sEGFeiY42IYhGJYl5S+cxQ9gSEpfmboGyPSS23+sGGygkECsxs69yAqP8LCTfzELy
        zSyEtQsYmVcxSqUWFOempyYbFRjq5qWWw6M2OT93EyM4TWv57mB8vf6v3iFGJg7GQ4wSHMxK
        IrzJn7hShXhTEiurUovy44tKc1KLDzGaAsN4IrOUaHI+MFPklcQbmlgamJiZGZobmRqYK4nz
        3mudmyIkkJ5YkpqdmlqQWgTTx8TBKdXA5MH/7+Ta+Ye1BVQ3XlLP9H6xUWGeOIMWy+HwxPdP
        a9fNWcI6z/tTlY3A3RrWf88OHzt77VINq8ilY2bnmDSyP+Vod+5ibTx3bMVr7gYt9ffFLK9W
        xoXGvrrzYqZxVvHx6hidWSc/aH3L3q5jvbvdSbAp8Ip+qQO746Lvxbe2NnDNtdkyzemynsy7
        4OIvnLvPFGYd8lmcqXgjZH9s7mu7V16fWrrstx8SaDx1qWjbT9lU83yPHdGvA/70ONmeERdV
        qOl5WfPqW2Re9MIQ/v7DtQ82xRm6tvxUT1zn1RQlcC5E+CFj7rcjvB2zhabb3jmm+XyxZvaq
        zPpj603qkq7obuJg6Q6dovZL6s3iFhsxJZbijERDLeai4kQAKclWfVwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvK5zNW+qwbNbKhZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmcWTtVSaL
        xUdnMFsc3cNhcX7WKRaLy7vmsFncmnCMyWLj/XdsDkIeO2fdZfdoOfKW1WPxnpdMHptWdbJ5
        7J+7ht2jb8sqRo+ps+s9Pm+SC+CI4rJJSc3JLEst0rdL4Mpo+PaStWAZa8Xkl9dZGxj3sHQx
        cnJICJhIPFz5Asjm4hAS2M4osfHuZkaIhITE8g0vmCBsYYn7LUdYIYp+MUr8vbAUrIhNQEti
        +swGsISIwHMmiZNvTjGCOMwCr5gkev9fZwapEhYIkpjQ1wi2j0VAVeLutfVg3bwC1hLTTk9j
        g1ghL7H/4FlmiLigxMmZT8DqmYHizVtnM09g5JuFJDULSWoBI9MqRtHUguLc9NzkAkO94sTc
        4tK8dL3k/NxNjOBY0Qrawbhs/V+9Q4xMHIyHGCU4mJVEeJM/caUK8aYkVlalFuXHF5XmpBYf
        YpTmYFES51XO6UwREkhPLEnNTk0tSC2CyTJxcEo1MJno9O2UbZuv4a5dssSo48XsLXYbttaV
        rV6a4LWo4w+3z653Ur8/X4mdfZNZNDKr5sn7hODOLvaFIdxTCnctNP6m6LVpVaxnvMAaDg47
        xfK1S6w3qKd4JzeFqfLurN4xofD28rO7n792LvT7vvR5iP+cK9GF6leePT2hwz1d9oH35X/b
        Z0lUcKzcsjju5fIEj+jNAjeK1/+4e/NDqfvW2BP1rw4m7XvTmPtW/kTJTnl3zdBjaurVu1tq
        faMWX7Ar+retO+Cr5dxt/yKXPf9/sFnj5sFY3ZVKRpd9bXbfemBSGW1iUlj7ouL793n7la2Z
        uM7fC7J+rW43s2Ldhde1YV1Z07QW2pSsCyxLej39Ho8SS3FGoqEWc1FxIgCnkDZ8BAMAAA==
X-CMS-MailID: 20230922113219epcas2p1293d292c81a400a8347328d78217a498
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922113219epcas2p1293d292c81a400a8347328d78217a498
References: <CGME20230922113219epcas2p1293d292c81a400a8347328d78217a498@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPDX license identifier for C header have to be added
in form of a C-like comment.

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a0b5819bc70b..7aee7fb008a5 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM cxl
-- 
2.34.1

