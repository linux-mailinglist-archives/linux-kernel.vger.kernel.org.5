Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEAE778BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjHKKVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbjHKKUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:20:53 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0663599
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:20:16 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230811102015epoutp0187d53afac5319686d66f3139b1317063~6TPK4FVvS1077810778epoutp01O
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:20:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230811102015epoutp0187d53afac5319686d66f3139b1317063~6TPK4FVvS1077810778epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691749215;
        bh=c2jLjNWnQ/M9Rw0sJ/cfW/hL9LXxiP2rzuneLjpKg+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u3JjtO8w08CzCEqYZZi0EVjTjjbkfLDPglCybFEkQiulj1cHLR8QNUFsFr7ElLVBh
         z2ruPwWSr3XwnhwW29HrXtXY+DEMkYU/dlQOP9+OD+TJTAttvjdWOl9XGB+3dVRsLF
         CI0TWpxEghwbutlleUT4vhbecbQqhwHjxsL4BZfw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230811102015epcas5p1c3fa8a8e05124e96c0e828a432592ea8~6TPKlq-wA1319413194epcas5p1l;
        Fri, 11 Aug 2023 10:20:15 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RMftj269cz4x9Px; Fri, 11 Aug
        2023 10:20:13 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.3C.57354.B5B06D46; Fri, 11 Aug 2023 19:20:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230811101913epcas5p3a007d4594f5313a04ed5b6414aeb5b61~6TORWLndn0497904979epcas5p3B;
        Fri, 11 Aug 2023 10:19:13 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230811101913epsmtrp1fd2bd3a233f190012a121c571fb7b52f~6TORS0Lzr1422214222epsmtrp1H;
        Fri, 11 Aug 2023 10:19:13 +0000 (GMT)
X-AuditID: b6c32a44-007ff7000001e00a-e6-64d60b5b361c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.FF.14748.12B06D46; Fri, 11 Aug 2023 19:19:13 +0900 (KST)
Received: from unvme-desktop.sa.corp.samsungelectronics.net (unknown
        [107.99.41.39]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230811101912epsmtip1bf5b373082dc71d4fe6a38b17a225e6d~6TOQNw61V1269712697epsmtip1L;
        Fri, 11 Aug 2023 10:19:12 +0000 (GMT)
From:   Ankit Kumar <ankit.kumar@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     gost.dev@samsung.com, Ankit Kumar <ankit.kumar@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] block:t10-pi: remove duplicate module license
Date:   Fri, 11 Aug 2023 21:03:13 +0530
Message-Id: <20230811153313.93786-3-ankit.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811153313.93786-1-ankit.kumar@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTSzea+1qKwfyTahZrrvxmt1h9t5/N
        4uaBnUwWkw5dY7TYe0vb4vKuOWwWy4//Y3Jg97h8ttRj06pONo+PT2+xePRtWcXo8XmTXABr
        VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtARSgpl
        iTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL281BIrQwMDI1OgwoTs
        jL/NR9kLVrJULLtzlamB8RpzFyMnh4SAicTxxU1ANheHkMBuRonpj/cwQjifGCXuzDvFCFIl
        JPCNUWL1Wj2YjgV3XrJAFO1llNi0cwkThNPJJHGl+S3YXDYBbYlXb2+A2SICZRJvHu4Es5kF
        aiQ6781iArGFBZwk7q5/xAZiswioSixYvhmshlfARmLl/v3sENvkJWZe+g5mcwrYSkz98YYR
        okZQ4uTMJywQM+UlmrfOBvtBQuAtu8TjKXuhml0kHn5YzwJhC0u8Or4FKi4l8bK/DcrOltj0
        8CcThF0gceRFLzRg7CVaT/UD2RxACzQl1u/ShwjLSkw9tY4JYi+fRO/vJ1CtvBI75sHYqhJ/
        792GWistcfPdVSjbQ+L1vpXQ4J3AKNH/7yPrBEaFWUj+mYXkn1kIqxcwMq9ilEwtKM5NT002
        LTDMSy2Hx3Jyfu4mRnDC1HLZwXhj/j+9Q4xMHIyHGCU4mJVEeG2DL6UI8aYkVlalFuXHF5Xm
        pBYfYjQFBvhEZinR5Hxgys4riTc0sTQwMTMzM7E0NjNUEud93To3RUggPbEkNTs1tSC1CKaP
        iYNTqoEpLPPDOZdjBjdmbf+a3zVZfpbsXV+Vk8W+zuFf9sc/tu7yznKXv8JxYeuKZq7u7SdX
        fYz/ylZ29XNQdnFXKfsX0YW5yiUv2ZI8dwu3+sQ//LiZ1bz4Tw5XM6e+V87ayT1X/lnv/3Vm
        YeI/k19RTo2vrfsblAwVeg8+a9x85rxWVN+KWbyC7RVueyq38jlc7joUsLhAee8myYow21ST
        7kf9q790rpB8d/mAyj5bH1Xz+SWTtbolbnqEPF83J/DFSsHjapuLmNY83Cj0Z9a120V6Fp+z
        lE+flcmZN9eBvc87pXa6w8f1t7Yq3/q9p76u0jNvluzUTzPVtEQKhLXtF65Um3F4/qKlcyoK
        GY+zv1JVYinOSDTUYi4qTgQAxq70vSEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSnK4i97UUg8MHZSzWXPnNbrH6bj+b
        xc0DO5ksJh26xmix95a2xeVdc9gslh//x+TA7nH5bKnHplWdbB4fn95i8ejbsorR4/MmuQDW
        KC6blNSczLLUIn27BK6Mv81H2QtWslQsu3OVqYHxGnMXIyeHhICJxII7L1m6GLk4hAR2M0qs
        fHqFvYuRAyghLbFwfSJEjbDEyn/P2UFsIYF2JontHyJAbDYBbYlXb2+AzRERqJCY82kpK8gc
        ZoEGRokpn/vAEsICThJ31z9iA7FZBFQlFizfDBbnFbCRWLl/PzvEAnmJmZe+g9mcArYSU3+8
        YYRYZiNxdNUVNoh6QYmTM5+wgNjMQPXNW2czT2AUmIUkNQtJagEj0ypGydSC4tz03GTDAsO8
        1HK94sTc4tK8dL3k/NxNjOCA1tLYwXhv/j+9Q4xMHIyHGCU4mJVEeG2DL6UI8aYkVlalFuXH
        F5XmpBYfYpTmYFES5zWcMTtFSCA9sSQ1OzW1ILUIJsvEwSnVwJRwOUfg3ZUDdiHnnFvXWmh3
        SvicKLjNNFmCv67/tUJKhM6ErzM+CVxduaZH/emceSsjC2V3z7Wt2TFP+vjaeTMOZ96t/7n3
        vm3Hp1uxezU0xRbdkNCfyrTuAe++pC23Mopm50XNsHesCVwQkZ4yJeXqNkXN/ZO4W4P4Vxye
        fanWkcEzX9Odt6Ble73eBp00x1TBgljz88fVUni125W9Z3Fk7Ks/9sKzd03Zlv9HFm1pdzrE
        Ne3CJGYjnxXx7/ufRq/q6Ypdc32BfdRsC5NFL98d5eVNN4h/n8n2Xf6Wp6mOvmVA7sUH++Vv
        eO248Ec3QG/nN9Vdanx6f5e88d61ZlvZZlXmvLdMk87PK572q1WJpTgj0VCLuag4EQDO5JFd
        1wIAAA==
X-CMS-MailID: 20230811101913epcas5p3a007d4594f5313a04ed5b6414aeb5b61
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811101913epcas5p3a007d4594f5313a04ed5b6414aeb5b61
References: <20230811153313.93786-1-ankit.kumar@samsung.com>
        <CGME20230811101913epcas5p3a007d4594f5313a04ed5b6414aeb5b61@epcas5p3.samsung.com>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate MODULE_LICENSE("GPL") from t10-pi.c
Fixes: a7d4383f17e1 ("block: add pi for extended integrity")

Signed-off-by: Ankit Kumar <ankit.kumar@samsung.com>
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

