Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0987A7BF59F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442771AbjJJIXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442640AbjJJIXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:23:31 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C8BB4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:23:27 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231010082322epoutp0353497ffab8e216b1f5d8a63ac637e4a7~MsWP81P6D1875718757epoutp03T
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:23:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231010082322epoutp0353497ffab8e216b1f5d8a63ac637e4a7~MsWP81P6D1875718757epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696926202;
        bh=VohcJ8XZreTii18m85LEVdyYDoxa3hhmX1C31sODMhE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Bgj+k5aetH/3MfINYfjsj4PMGuib2J5Rpu07+DnlYDzUZUe2aI+hgUVFCqU3+Q9xH
         1vQc2ty4fNqMOOUE30Rd0FlQiAQ+C5FStxh5EUp4xARsxCFtDthowG6V70V1f1kddP
         G4Rh8zP2aTmG006aCXa/CURWlvvoflqLom21oVko=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231010082321epcas2p130db2538c4ae1e67c6b1df6a91d27666~MsWPWZgnX3103731037epcas2p1a;
        Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.69]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4S4TS93ljBz4x9Q7; Tue, 10 Oct
        2023 08:23:21 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.CD.09649.9F905256; Tue, 10 Oct 2023 17:23:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231010082321epcas2p292c86c6757dcc1cfeeeb796c29a3e07b~MsWOe6y_X1534015340epcas2p2C;
        Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231010082321epsmtrp2cf7803af7a5e5d6ce191abd863383602~MsWOdM6oA2242122421epsmtrp2W;
        Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
X-AuditID: b6c32a46-b9ffa700000025b1-b8-652509f9131b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.52.08788.8F905256; Tue, 10 Oct 2023 17:23:20 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231010082320epsmtip29ed37d4399cf333e6c8c238107b327a0~MsWOK6Prf3044130441epsmtip2h;
        Tue, 10 Oct 2023 08:23:20 +0000 (GMT)
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
Subject: [PATCH v3 0/6] cxl: Fix checkpatch issues
Date:   Tue, 10 Oct 2023 17:26:02 +0900
Message-Id: <20231010082608.859137-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmqe5PTtVUg30PZCzuPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFs2L17NZfHjzj8XiwOsGdoszZ1+yWqxaeI3N4sjaq0wW
        i4/OYLY4uofD4vysUywWl3fNYbO4NeEYk8XG++/YHIQ8ds66y+7RcuQtq8fiPS+ZPDat6mTz
        2D93DbtH35ZVjB5TZ9d7fN4kF8ARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlh
        rqSQl5ibaqvk4hOg65aZA/SKkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECv
        ODG3uDQvXS8vtcTK0MDAyBSoMCE7Y8Vs9oK7HBVzNzeyNTC2s3cxcnJICJhIHFvaCmRzcQgJ
        7GCUuPVzPjOE84lRYuvFZWwQzjdGicWPV7DCtPyb+Y4JIrGXUeLCxm1Qzh9GiR2b3zKDVLEJ
        aElMn9nACpIQEXjIJLHzVR9YFbPAIyaJjydegVUJCxhJTHn2kQ3EZhFQleibcwbI5uDgFbCS
        aNjPCLFOXmL/wbNg5bwCghInZz5hAbGZgeLNW2eDHSshsIND4u+eThaIBheJpU1n2CBsYYlX
        x7dAvSol8fndXjaIhmZGidfPr7BAOC2MEutu74CqMpZ4d/M5K8gVzAKaEut36YOYEgLKEkdu
        QS3mk+g4/JcdIswr0dEmBNGoJDFv6TxmCFtC4tLcLVC2h8S7Q4/BQSckECvx6dMRxgmM8rOQ
        vDMLyTuzEPYuYGRexSiWWlCcm55abFRgBI/W5PzcTYzg9KzltoNxytsPeocYmTgYDzFKcDAr
        ifA+ylRJFeJNSaysSi3Kjy8qzUktPsRoCgzficxSosn5wAyRVxJvaGJpYGJmZmhuZGpgriTO
        e691boqQQHpiSWp2ampBahFMHxMHp1QDk/vGP9UyFybonPY5q+62eal9aFXy5d88dXd67vQv
        j6tNP1n3anNEy0WNPqc1Ha1RF9e63pnEsfdmyc0nQjd9OU8IHTmooO7osM6+f8M+nuq+mPQd
        ysH/I7Pu98nv5fV7/nGug2CyeuHCnSt2ZYlu+iM+LenKpa9z9ROTfpw+lsr5+5lpY+rrg555
        Fn5V05vjpZZXMJ572fz5x6GLH+8eVFw8z+DT2eYJ2utCbjXGpQQff/Sw+stOri3aCvk7TJje
        658S+2M4T9TAt/Axh4P5g6df7RfLO+yMCfv0y+X3XVYnJclnipfnnDR54SFrM8vP2YLzl6WD
        bIYBv+bv48+s2NoCFOW8bzAqvKjU+yqco8RSnJFoqMVcVJwIAEmjSoBYBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvO4PTtVUg+kzzCzuPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFs2L17NZfHjzj8XiwOsGdoszZ1+yWqxaeI3N4sjaq0wW
        i4/OYLY4uofD4vysUywWl3fNYbO4NeEYk8XG++/YHIQ8ds66y+7RcuQtq8fiPS+ZPDat6mTz
        2D93DbtH35ZVjB5TZ9d7fN4kF8ARxWWTkpqTWZZapG+XwJWxYjZ7wV2OirmbG9kaGNvZuxg5
        OSQETCT+zXzH1MXIxSEksJtRovPzUWaIhITE8g0vmCBsYYn7LUdYIYp+MUrc+T+FFSTBJqAl
        MX1mA1hCROA5k8TJN6cYQRxmgVdMEr3/r4ONEhYwkpjy7CMbiM0ioCrRN+cMkM3BwStgJdGw
        nxFig7zE/oNnwcp5BQQlTs58wgJiMwPFm7fOZp7AyDcLSWoWktQCRqZVjJKpBcW56bnFhgVG
        eanlesWJucWleel6yfm5mxjB8aKltYNxz6oPeocYmTgYDzFKcDArifA+ylRJFeJNSaysSi3K
        jy8qzUktPsQozcGiJM777XVvipBAemJJanZqakFqEUyWiYNTqoFJWPj7U1ltcWO1n4tlHRyT
        j1ia7NEXWPqD+e6JL1s5L2pner7UOa5+lrGH6btyToue6ppzj17H2aaUfQ5hjJi6RHzfoyMu
        cU5tV658u7vwoyBTuh3j28vS4rXporrnGb4Jfiwud3EOLZ9+KKZvbfrUrplvryeyfotcoPL/
        yoOD7PW7HwismeD29eWOBtmeDsl9ebX9TgKLWpl+aIT/2X8zkXv9def5u36X7e2fe23Nu/XJ
        mbOPs+/8byh49pVUBLfJ02K2T7HPdrzyMV6qsc7gzu2nDKtWdfFJ6ldxVxecWvPqj6FdtsZG
        uynvM4q52WaK/t13eV7BvKQbph68D77dMUq4K61dvsRg0qeFuzguK7EUZyQaajEXFScCALuo
        InEGAwAA
X-CMS-MailID: 20231010082321epcas2p292c86c6757dcc1cfeeeb796c29a3e07b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231010082321epcas2p292c86c6757dcc1cfeeeb796c29a3e07b
References: <CGME20231010082321epcas2p292c86c6757dcc1cfeeeb796c29a3e07b@epcas2p2.samsung.com>
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

Changes since v2: [1]
- Modify cxl_region_invalidate_memregion() considering the context (Jonathan) 
- Drop a duplicated fix (Davidlohr)
- Add reviewed-by, acked-by tags

[1]: https://lore.kernel.org/lkml/20230922113443.3297726-1-jtp.park@samsung.com/

---
Cover letter same as v2

This series fixes various checkpatch errors and warnings.
I've been looking at the CXL driver recently and noticed that there are
trivial mistake codes, so I checked all files with the script and fixed
some warnings/errors.

Jeongtae Park (6):
  cxl/trace: Fix improper SPDX comment style for header file
  cxl/region: Fix a checkpatch warning
  cxl/mem: Fix a checkpatch error
  cxl: Fix a checkpatch error
  cxl: Fix block comment style
  cxl/memdev: Fix a whitespace error

 drivers/cxl/core/memdev.c | 10 +++++-----
 drivers/cxl/core/region.c | 20 +++++++-------------
 drivers/cxl/core/trace.h  |  2 +-
 drivers/cxl/cxl.h         |  4 ++--
 drivers/cxl/cxlmem.h      |  2 +-
 5 files changed, 16 insertions(+), 22 deletions(-)


base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
-- 
2.34.1

