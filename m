Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C40E7A910A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjIUCss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIUCsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:48:47 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4E9EA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:48:36 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230921024833epoutp04989deff335daa7b0d75367ce74f34df0~GyhfbIwts0225902259epoutp04Z
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 02:48:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230921024833epoutp04989deff335daa7b0d75367ce74f34df0~GyhfbIwts0225902259epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695264513;
        bh=eQs3oOBUl8TOI88n2KMfQhOFmOGcSow2Eqo6lXtpHck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D72n7FJJZV0cKt8SYsuIHuPk+0Q9pUP8JFse/cKvQm2d2FuvJAJyzvZebOrClLrRs
         xgj3+KX1MBdXcoOLX6DNeJqLQRwwbmpyMvvdzysAsNeVltgTbT/gx/kOPZDUZMe86v
         g19xCwXK5Gyq4fHS+wd0b8WOWGkguce9a/iSxTMU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230921024832epcas2p4fa2cc601cc71563c4a38c5c3159d1c48~Gyheqjm8w0279002790epcas2p4I;
        Thu, 21 Sep 2023 02:48:32 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Rrfwc384qz4x9Pw; Thu, 21 Sep
        2023 02:48:32 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.B5.09693.00FAB056; Thu, 21 Sep 2023 11:48:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230921024831epcas2p36f222c434f41ce80ac2850374868da9a~Gyhd06yjA2381623816epcas2p3Z;
        Thu, 21 Sep 2023 02:48:31 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230921024831epsmtrp12a10fd83224f5efc331755a0c369865b~Gyhd0Bems0377003770epsmtrp1f;
        Thu, 21 Sep 2023 02:48:31 +0000 (GMT)
X-AuditID: b6c32a45-abbfd700000025dd-5a-650baf0099d0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.53.08649.FFEAB056; Thu, 21 Sep 2023 11:48:31 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230921024831epsmtip2498376f7b0e70aecb694089554e334b1~GyhdkW2Jr1644616446epsmtip26;
        Thu, 21 Sep 2023 02:48:31 +0000 (GMT)
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
Subject: [PATCH 2/7] cxl/region: Fix a checkpatch warning
Date:   Thu, 21 Sep 2023 11:51:05 +0900
Message-Id: <20230921025110.3717583-3-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921025110.3717583-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxj2O6c9PYC4s4Lbt/6YzWHLAhNouX4gON3QdNElZP6aiWOH9kgZ
        0JaeYphZNjbAUZ3gRLmUS1w6Q+Q6KmzQoEApQhWQgRfaiQSZMsolFaNZMlxWeurmv+d5v+d9
        nu/9LiQuniIkZLbGwOo1TC5NBAp+GQpPiNzSEcTKLl0Qo9mFSQIVV5oBqj4/CdCo8xsCtThb
        Afq2ZVaIis0dBPKs/CNAA8tFIjQ2viREzT/eIZC97TaGzMM1OBruI9FN03UBmrbWE8h15hqG
        OufWiD1iRa9pVqQosa8KFea+JUxhaTYSiv6GVpGivKsZKM7Xfa14YnkznTyck6JmGRWrl7Ia
        pVaVrclKpQ8cyvggIz5BJo+UJ6FEWqph8thUOu1geuT+7FzvKLT0GJNb4C2lMxxHR+9O0WsL
        DKxUreUMqTSrU+XqEnVRHJPHFWiyojSsIVkuk8XEe4Wf5ajXBqpw3T2icGx6migCg8KTIICE
        VBx0NA5iJ0EgKaZ6AGx6PCHkyTqAl+sW/eSZl/xsxF60jN89J+AXrgDoGbXiPNkA0DxnAZsq
        goqA1bVFvvZQah6Dve5yXwpOPcDg41E3vqkKoZJgU9mG14skBdTbsLQ1fbMcTO2C3522EHzc
        Dtg/OO6TB1ApcOLPKYzXvAodtX8INjHu1RR31/l2AalJEhodTuGmJ6TS4Jork/cJge6RLhGP
        JXCp4oSI1xcDuLx4S8CTEgDbf+/xq2LhmnPRZ4RT4bDDGs17hkG7y5+7DZYNPRfx5WBYdkLM
        N9Kw8WIjzmMIpxq6/FgBH9qm/YddAWCdtQY7A6Sml8YxvTSO6f/gCwBvBq+xOi4vi+VidPL/
        7lipzbMA3+OO2NcDKlc9UTaAkcAGIInTocHK9UBWHKxivjjO6rUZ+oJclrOBeO9Z/4BLtiu1
        3t+hMWTI45JkcQkJ8sSYeFki/Xrw/dIGlZjKYgxsDsvqWP2LPowMkBRhMvLovRvhvXHPzdMp
        7FkLUGlsD1rsUdKagNaVKxF33RRmQo7DFm7He0HJfUEHYi+NqVfaHFv0fy1e27m69NAx8qln
        9/WVO57vr1Y8ql44Je02bsV/2vtRj2sC1t8aaB1+UlBq69+X/76rtLPpaW298vY77VVMRuHZ
        j0uO6Jcv2xtDFtb7iiKRMfXg0Lw+/61nx2P7fwszNc3ohLMbvZ1vjEC4v8u4a43Kdm51iZ4m
        w7y2+S8//yqg6tdDN4+YleVVN8rv5xdmqsNSQxdfcW87Wh/kcM60z4RkXpWYdp7aHtstGZqz
        CnXHGj+pp6MvdsSfTlN0PRL+Te35cKgydu+7rhlawKkZeQSu55h/AUE+2jRlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXvf/Ou5Ug53fdS3uPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFs2L17NZfHjzj8XiwOsGdoszZ1+yWqxaeI3N4sjaq0wW
        i4/OYLY4uofD4vysUywWl3fNYbO4NeEYk8XG++/YHIQ8ds66y+7RcuQtq8fiPS+ZPDat6mTz
        2D93DbtH35ZVjB5TZ9d7fN4kF8ARxWWTkpqTWZZapG+XwJXx7sA05oI7bBVnLl9ma2A8yNrF
        yMkhIWAicfb6FJYuRi4OIYHdjBJrH85kgUhISCzf8IIJwhaWuN9yhBWi6BejxJ9Di9lBEmwC
        WhLTZzaAJUQEnjNJnHxzihHEYRZ4xSTR+/86M0iVsIClxPKOP0BjOThYBFQlWtcEgIR5Bawl
        2ns3sUFskJfYf/AsWDmngI3EuReXwDYLAdUsv7SXDaJeUOLkzCdg1zED1Tdvnc08gVFgFpLU
        LCSpBYxMqxglUwuKc9Nzkw0LDPNSy/WKE3OLS/PS9ZLzczcxgiNMS2MH4735//QOMTJxMB5i
        lOBgVhLhTf7ElSrEm5JYWZValB9fVJqTWnyIUZqDRUmc13DG7BQhgfTEktTs1NSC1CKYLBMH
        p1QDk4LljA3PJGbUPnFe8G3bB75pW56we6ZpT7v6m+t45aPNzFdL3X+tNPKLebc15RS/+Io9
        FilZn82zzWImsJia3mOPCQnTFe92aN+zIULgRurfuxX76/lzGNgnemgYXitZzm+3ela2n71S
        38/Zt2aud/BdqpU4a3XcKtXSPfMaruspv2DefWCb21b+hBcRh3pbIs+fd9az4fp1KirfZFHr
        qql/3wtvtOphFI//JDLn7dNViTcbwrgnzXIuatuR3yz/bgbzn30Vr/odBcU2PBXgz7jmJx5o
        vN3fJ+v2Y+spui9/Mr7zOf/9HnOH6YUlS+MXaemLpsX9+/bMuqTiI8vsHGkny7SC8NTvLxlu
        7j4YrsRSnJFoqMVcVJwIAICE5AwfAwAA
X-CMS-MailID: 20230921024831epcas2p36f222c434f41ce80ac2850374868da9a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230921024831epcas2p36f222c434f41ce80ac2850374868da9a
References: <20230921025110.3717583-1-jtp.park@samsung.com>
        <CGME20230921024831epcas2p36f222c434f41ce80ac2850374868da9a@epcas2p3.samsung.com>
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

WARNING: else is not generally useful after a break or return

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
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

