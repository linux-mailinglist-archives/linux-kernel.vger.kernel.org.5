Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA90F7AB0EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjIVLcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjIVLcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:32:11 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D583E47
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:32:02 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230922113159epoutp03abf5190f0985cf410ad6a5f5a90dd247~HNTzKLZ9R0121401214epoutp03t
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:31:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230922113159epoutp03abf5190f0985cf410ad6a5f5a90dd247~HNTzKLZ9R0121401214epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695382319;
        bh=Hu4+fZLwVIErXQU0I4uMtRAMrlDbtthx0kVVPVEEg58=;
        h=From:To:Cc:Subject:Date:References:From;
        b=HaLTxn+IAfGjAx8T8MY4PuTR5VJwTQgTmuCAXora8eb8YKoQIV9w1HOke718kLkqL
         UsO6snuoVS5wEntkBSyrkkT2jylFI7mYdeJYLocb6j729S6nfdB7ct1CrN/QYyrpNh
         2ukvMLSGrZC7CCo/qxnEjY/8nFwSDQgAAHG6P6EQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230922113158epcas2p28f910e0acc916732f4a10aef2bb1c65c~HNTyIp7ST0531405314epcas2p23;
        Fri, 22 Sep 2023 11:31:58 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RsVV63tyhz4x9Pp; Fri, 22 Sep
        2023 11:31:58 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.38.09693.E2B7D056; Fri, 22 Sep 2023 20:31:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230922113157epcas2p212c253d8fe4f6935ee5cbe284254cc68~HNTxLdqMK3124431244epcas2p2_;
        Fri, 22 Sep 2023 11:31:57 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230922113157epsmtrp105b7265de0f6ff956809ea759a04ef3e~HNTxKmG9s1340313403epsmtrp1q;
        Fri, 22 Sep 2023 11:31:57 +0000 (GMT)
X-AuditID: b6c32a45-84fff700000025dd-e8-650d7b2e59f8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.F7.18916.D2B7D056; Fri, 22 Sep 2023 20:31:57 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230922113157epsmtip14b48036330f26ec10f7cb110efe2c874~HNTw7nBrb3062230622epsmtip1Z;
        Fri, 22 Sep 2023 11:31:57 +0000 (GMT)
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
Subject: [PATCH v2 0/7] cxl: Fix checkpatch issues
Date:   Fri, 22 Sep 2023 20:34:43 +0900
Message-Id: <20230922113443.3297726-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjOd045PbJ1nlWYXxBHd+aWgAHbSunHBpMFJE28hLHMXZIFzugJ
        dKWX9bQENZm1BYMykKvMQgFT3ULrJDJEIIzKTRkbCBuMwQDndCAVkcmW/RG20tbNf8/75nne
        532+C4kLB4gwUqU1sgYtk0sTwby2vkhZdMxRASu2OMPR7J1RAlkrHQDVVI8CNDh1nECuqYsA
        WVyzQcjqaCbQytI6D127b+aj74cXg5Dz3E8E6v9qAkOOgc9xNNBFopu2IR76sbOOQNNl1zF0
        +dYykSRUdNhm+YqC/gdBCkfXIqZocZ4kFG77Rb6itNUJFNW1xxSrLS+mkR+oE3JYRskaRKw2
        S6dUabMT6X1vZyRnyOLEkmhJPJLTIi2jYRPplP1p0amqXG8UWpTH5Jq8rTSG4+hdbyQYdCYj
        K8rRccZEmtUrc/VyfQzHaDiTNjtGyxpfk4jFUpmXmKnOWSouAfp7ZH71hAuYQSH/FNhEQioW
        WuyVQadAMCmk2gHsdM5h/uIRgBUz17ENlq847TjyRNEydpnwkzoAnO87EyA9BrC4kbeBCSoK
        1pw1+8aGULcx2OEp9Y3Fqd8w+MegB99gbaGksGG9xqfmUa/AtnKrbykB9Tp0uwcxv10EdPcM
        4/7+8/Dbs3d9Dri3b71Si28MhVQTCS3dq4FEKbCn3hHAW6DnRmsAh8HF0yf4foEVwPsL4zx/
        UQDgpV/aA6zdcHlqwbs46bWIhM2duzYgpF6G/dMB4+dgUd8a398WwKITQr+QhvUX6nE/hvAH
        e2sAK+C45xbwn9CH8MZnv4MyEGF7Ko7tqTi2/30bAe4EL7B6TpPNclK95L9rzdJpWoDvPUft
        bQeVD1ZiegFGgl4ASZwOEWQ9CmaFAiVz+Ahr0GUYTLks1wtk3gMux8NCs3TeD6E1Zkhi48Wx
        cXESuVQmltNbBXOFdqWQymaMrJpl9azhiQ4jN4WZsXA174Dyr2357rre785VXVO/g7Wt2N5U
        t5eBzE6T+eS7d7pSe8bP6weH/j44uXMr2D5nvepZrB1J+bikq9ZTRH/BpOcJM1asI8rhoTgN
        NVGePvvPsq4HjDx7r2hzaFPFPDd1iNS5D1cMLBW4Zg5aqrTJppu/Xrm0lrzj1eNjHV/LPo1s
        vLuQs37GNS0Q8ySi+AtRwVWH2s7Hb4//Eu7GVIUl8vyXDkyq3Nl7UhtSJt//83bmcqP8m5nN
        892l2+pCSlvTIpI+2af3FLfXopUdj38eDQ7/qClhXtrcsMcyh9SRq7ax9x7uN6+BhxFYsUu1
        M+/Y0da3up+xh6ZrR6/SoZIkmsflMJIo3MAx/wLIXhV+WAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnK5uNW+qwYYZOhZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmcWTtVSaL
        xUdnMFsc3cNhcX7WKRaLy7vmsFncmnCMyWLj/XdsDkIeO2fdZfdoOfKW1WPxnpdMHptWdbJ5
        7J+7ht2jb8sqRo+ps+s9Pm+SC+CI4rJJSc3JLEst0rdL4Mp4093LWPCCo2Lq1dWMDYyt7F2M
        nBwSAiYSmy5uZOti5OIQEtjOKPF46XMmiISExPINL6BsYYn7LUdYIYp+MUqcXvuHGSTBJqAl
        MX1mA1hCROA5k8TJN6cYQRxmgVdMEr3/r4NVCQsYScz/Nx1sFIuAqsS2ic1gu3kFrCX27z8B
        tUJeYv/Bs8wQcUGJkzOfsIDYzEDx5q2zmScw8s1CkpqFJLWAkWkVo2hqQXFuem5ygaFecWJu
        cWleul5yfu4mRnCsaAXtYFy2/q/eIUYmDsZDjBIczEoivMmfuFKFeFMSK6tSi/Lji0pzUosP
        MUpzsCiJ8yrndKYICaQnlqRmp6YWpBbBZJk4OKUamBjEw3JOH3rMpuzbuFZ2ewdP1SVBz5bs
        pb9kN0tHyJl2ycrncFX4lR6p3TcxYELuZ111UXPPjy/NTVfqNH+6xrvXo/T77KNuTdvOn+79
        51hnpPx67pPX9553XuCb3eR/U2WTd/bah+HH9tm0PXF4PPH2bdNkz7YfCtsOJ/7gk3utsPfy
        7ZbJrypkbV5HndjNvdCzatOvds7FyxMeKxkFnZoTflbHSnv14zr2GY/k3LYobntTsjt7c0cw
        wxr3VX7NTddl51onxi5seJN2qaCq/gbXqdCdyg8D9tbu+lswwcG7zVjxcujnxqTapnq5zoee
        vbWp3DNOSOj3ibqttr74eW7M9u3W3bOUfzGuML93SYmlOCPRUIu5qDgRAClB9wcEAwAA
X-CMS-MailID: 20230922113157epcas2p212c253d8fe4f6935ee5cbe284254cc68
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922113157epcas2p212c253d8fe4f6935ee5cbe284254cc68
References: <CGME20230922113157epcas2p212c253d8fe4f6935ee5cbe284254cc68@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1: [1]
- Seperate a fix for whitespace error/warnings in memdev (Dave)
- Drop a fix for a traceevent macro (Dave)
- Add reviewed-by tags

[1]: https://lore.kernel.org/lkml/20230921025110.3717583-1-jtp.park@samsung.com/

---
Cover letter same as v1

This series fixes various checkpatch errors and warnings.
I've been looking at the CXL driver recently and noticed that there are
trivial mistake codes, so I checked all files with the script and fixed
some warnings/errors.

Jeongtae Park (7):
  cxl/trace: Fix improper SPDX comment style for header file
  cxl/region: Fix a checkpatch warning
  cxl/mem: Fix a checkpatch error
  cxl: Fix a checkpatch error
  cxl: Fix block comment style
  cxl/memdev: Fix a whitespace error
  cxl/memdev: Fix a whitespace warning

 drivers/cxl/core/memdev.c | 12 ++++++------
 drivers/cxl/core/region.c |  7 +++----
 drivers/cxl/core/trace.h  |  2 +-
 drivers/cxl/cxl.h         |  4 ++--
 drivers/cxl/cxlmem.h      |  2 +-
 5 files changed, 13 insertions(+), 14 deletions(-)


base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
-- 
2.34.1

