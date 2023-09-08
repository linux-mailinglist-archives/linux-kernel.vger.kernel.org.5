Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65879798353
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbjIHHlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbjIHHlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:41:36 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC55F1BD3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 00:41:28 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230908074127epoutp03ec4e0b5ce9ee045474f1428404cd6d79~C3Igpdnna2171021710epoutp03j
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:41:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230908074127epoutp03ec4e0b5ce9ee045474f1428404cd6d79~C3Igpdnna2171021710epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694158887;
        bh=IZ9jCFqwFNiYYg2ZEJwOHCgy8Fz2FKuFY/N9dF4FW9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tFXJvuiIhLy/yiI9haGJ5tszzO2RECvvEx8HZhxHWFY3qmFb2rex0FKpkxCbOnIJi
         0fru/6OB9698psf/uHMsiDiY+Yh52sAR7ok5fhyBYodxmip8PJsn3sOANJjJoWyBJU
         7Q5DpkszbgOLlFpRxghjP9Vb6/v+xkQlP6KXUAT4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230908074126epcas5p3bb2add950c0441b38e343aea29436955~C3IgbGJJu2319023190epcas5p3i;
        Fri,  8 Sep 2023 07:41:26 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Rhp2X4P8Cz4x9Q9; Fri,  8 Sep
        2023 07:41:24 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.CC.09023.320DAF46; Fri,  8 Sep 2023 16:41:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230908063512epcas5p42b8a72d4001d041ed15ee559ee61f4c8~C2Oqlnxa-2265422654epcas5p4F;
        Fri,  8 Sep 2023 06:35:12 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230908063512epsmtrp2e0bdb05b5181d7b786961be972e8ed84~C2Oqk_ZPz0270802708epsmtrp2b;
        Fri,  8 Sep 2023 06:35:12 +0000 (GMT)
X-AuditID: b6c32a44-c7ffa7000000233f-1a-64fad0236f63
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.6E.18916.F90CAF46; Fri,  8 Sep 2023 15:35:11 +0900 (KST)
Received: from unvme-desktop.sa.corp.samsungelectronics.net (unknown
        [107.99.41.39]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230908063510epsmtip17a6a54675047af2fb769127beb435249~C2Opcd3DV2661226612epsmtip1Q;
        Fri,  8 Sep 2023 06:35:10 +0000 (GMT)
From:   Ankit Kumar <ankit.kumar@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     gost.dev@samsung.com, Ankit Kumar <ankit.kumar@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] block:t10-pi: remove duplicate module license
Date:   Fri,  8 Sep 2023 17:22:31 +0530
Message-Id: <20230908115233.261195-3-ankit.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908115233.261195-1-ankit.kumar@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTXVf5wq8Ug4m3tSzWXPnNbrH6bj+b
        xc0DO5ksJh26xmix95a2xeVdc9gslh//x+TA7nH5bKnHplWdbB4fn95i8ejbsorR4/MmuQDW
        qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAjlBTK
        EnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZ
        GV93T2UpeM5S0XBuL2sDYx9LFyMnh4SAicSmzYuAbC4OIYHdjBI3vsxghnA+MUr8/zoVwWn9
        MAeu5d7LFiaIxE5GiVOtZ6GcTiaJywsfsoFUsQloS7x6e4MZxBYRKJN483AnmM0sUCPReW8W
        E4gtLOAq0bX7PzuIzSKgKnFo5wtWEJtXwFZizYM3zBDb5CVmXvoOVsMpYCfxcNEBNogaQYmT
        M5+wQMyUl2jeOhvsVAmBe+wS237sYIJodpG4928f1NnCEq+Ob2GHsKUkPr/bywZhZ0tsevgT
        qr5A4siLXqjF9hKtp/qBbA6gBZoS63fpQ4RlJaaeWscEsZdPovf3E6hWXokd82BsVYm/925D
        rZWWuPnuKpTtIfGo9SQ0SCcySnz7+pd9AqPCLCT/zELyzyyE1QsYmVcxSqYWFOempyabFhjm
        pZbDozk5P3cTIzhlarnsYLwx/5/eIUYmDsZDjBIczEoivKtFfqUI8aYkVlalFuXHF5XmpBYf
        YjQFBvhEZinR5Hxg0s4riTc0sTQwMTMzM7E0NjNUEud93To3RUggPbEkNTs1tSC1CKaPiYNT
        qoFpo1nwyZ+Jizk9pk/XeLgko+jHgtc1Lx43+rzd8dzkGK8Yr9rhJTEFW9LZnz7r/7vib5+2
        Id9Rp+c2NR/Cw+xes35/F2Mea3h7Z9UC038fV/Qn+b/liV5gxmZ7yMA9848ik9HmMGXhJRtX
        rjetPcsZcWbV8aIz1u7GN7iNJBR6XXP4Kv8ucjmzSjHujWR5+j8Zr58mGSta5FzLJFbl2ibv
        vlp4/pjg7kcsGUIdAZyauXcq9T69eNT7TqanOuLqU/GVeQ/llpmvV34x+7JZWZWrnlrFjqaQ
        5Ll3Vr03jYljl5mveeCT64PbzE7nPrhrNuftXjlR3FW0+NfCeuYbW+QEv1QJPn62uHb9EnF1
        5xYlluKMREMt5qLiRAAuoisPIgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSnO6CA79SDL7aWqy58pvdYvXdfjaL
        mwd2MllMOnSN0WLvLW2Ly7vmsFksP/6PyYHd4/LZUo9NqzrZPD4+vcXi0bdlFaPH501yAaxR
        XDYpqTmZZalF+nYJXBlfd09lKXjOUtFwbi9rA2MfSxcjJ4eEgInEvZctTCC2kMB2Ron1SxK6
        GDmA4tISC9cnQpQIS6z895y9i5ELqKSdSeLKhvuMIAk2AW2JV29vMIPYIgIVEnM+LWUFKWIW
        aGCUmPK5DywhLOAq0bX7PzuIzSKgKnFo5wtWEJtXwFZizYM3zBAb5CVmXvoOVsMpYCfxcNEB
        NoiDbCXeX/7ACFEvKHFy5hOwo5mB6pu3zmaewCgwC0lqFpLUAkamVYyiqQXFuem5yQWGesWJ
        ucWleel6yfm5mxjBYawVtINx2fq/eocYmTgYDzFKcDArifCuFvmVIsSbklhZlVqUH19UmpNa
        fIhRmoNFSZxXOaczRUggPbEkNTs1tSC1CCbLxMEp1cDkxevKlZ4o0dId8ij89yHp4EReq0q5
        tlSfb4mC/f1iNwoui/oEHtDMt5TYHR1Z9rlvU/P94sfXDtVG7XCcbfDLj6NIdHrxFZnlUsq7
        22MkJ3Tfv3YpvshkRf2r1Ibw8xzX7ylvEn8ZV8HwVDX5I3d2iXbASQcX/Zi8BoeMUxxqegG/
        GFf83brL4DiHQ9HXWKbJzSz7eNl+l97sPfjKJ34l6yqHCJX4NV2xnlXbG/vNL2SK7TjzPNVp
        +mauCwIJ+xwM1Xece+ztWNpco7WxTc1J3tKuf6LT+W/XNt4R4JGzuGW2b9nZSrkp7gwxnyYa
        tgnvTtuus43Z2/3XM574pZ+O8eUXarPP7Nx4IslDiaU4I9FQi7moOBEAhT75U9ICAAA=
X-CMS-MailID: 20230908063512epcas5p42b8a72d4001d041ed15ee559ee61f4c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230908063512epcas5p42b8a72d4001d041ed15ee559ee61f4c8
References: <20230908115233.261195-1-ankit.kumar@samsung.com>
        <CGME20230908063512epcas5p42b8a72d4001d041ed15ee559ee61f4c8@epcas5p4.samsung.com>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate MODULE_LICENSE("GPL") from t10-pi.c
Fixes: a7d4383f17e1 ("block: add pi for extended integrity")

Signed-off-by: Ankit Kumar <ankit.kumar@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/t10-pi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index bf0bba01417f..042f21b0e2e5 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -471,4 +471,3 @@ const struct blk_integrity_profile ext_pi_type3_crc64 = {
 EXPORT_SYMBOL_GPL(ext_pi_type3_crc64);
 
 MODULE_LICENSE("GPL");
-MODULE_LICENSE("GPL");
-- 
2.25.1

