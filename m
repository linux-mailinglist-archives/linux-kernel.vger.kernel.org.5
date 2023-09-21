Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0867A9111
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjIUCtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIUCsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:48:51 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354DBE8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:48:45 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230921024834epoutp032d7164471c1cfebd5a80d92c3d38401e~GyhgkMUzo0938609386epoutp03G
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 02:48:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230921024834epoutp032d7164471c1cfebd5a80d92c3d38401e~GyhgkMUzo0938609386epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695264514;
        bh=jknA/5PgwAAcX8sjcvqtG3Zzfs241Bs9cHPvbtP6fc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XUD1R9Lwp+0DN9Po7EsVHeXuBU5MI7oMwuwAF5O4sOsgPUlYFKWBCol2AvP9UOwkk
         bteiXW80EtO5AldZLCYuEB6T3duFDXCqTTruuqPlrib6nOLezakoWWq0FjhZMWA2B1
         UBRtFpq1mJ5z2cQaJ+m1HJ92RxI0XOIX1lCqshQQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230921024833epcas2p4d72d8ca4277b6a8c2d08570a11c2aa82~GyhfZ2LmO0865408654epcas2p4S;
        Thu, 21 Sep 2023 02:48:33 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Rrfwc6RxGz4x9Pw; Thu, 21 Sep
        2023 02:48:32 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.AA.09765.00FAB056; Thu, 21 Sep 2023 11:48:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230921024832epcas2p4ecfc828890e076024e402fd5ef7d8c70~GyheO4BFw0147801478epcas2p4d;
        Thu, 21 Sep 2023 02:48:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230921024832epsmtrp1b18d097d2d3181694d9574dd0713d0c9~GyheN9mWI0377003770epsmtrp1g;
        Thu, 21 Sep 2023 02:48:32 +0000 (GMT)
X-AuditID: b6c32a48-66ffa70000002625-9a-650baf000c5e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.B5.08788.00FAB056; Thu, 21 Sep 2023 11:48:32 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230921024831epsmtip23b546875b8c5395a3c62a2380d86d166~Gyhd760Ij1720017200epsmtip2O;
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
Subject: [PATCH 5/7] cxl: Fix block comment style
Date:   Thu, 21 Sep 2023 11:51:08 +0900
Message-Id: <20230921025110.3717583-6-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921025110.3717583-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmhS7Deu5Ug5WvjC3uPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFs2L17NZfHjzj8XiwOsGdoszZ1+yWqxaeI3N4sjaq0wW
        i4/OYLY4uofD4vysUywWl3fNYbO4NeEYk8XG++/YHIQ8ds66y+7RcuQtq8fiPS+ZPDat6mTz
        2D93DbtH35ZVjB5TZ9d7fN4kF8ARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlh
        rqSQl5ibaqvk4hOg65aZA/SKkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECv
        ODG3uDQvXS8vtcTK0MDAyBSoMCE74/aDN8wF01krfj48yN7AOIeli5GTQ0LAROLRvzOMILaQ
        wA5GiV2PQroYuYDsT4wSnRc/sUEkvjFKbG5Tg2mYtv4tC0TRXkaJIzs2M0M4fxglDk86zgxS
        xSagJTF9ZgMrSEJE4CGTxM5XfUwgDrPAIyaJjydegVUJCxhKHG3ZALaDRUBVYlfnb7CjeAWs
        JQ4vXM8EsU9eYv/Bs2D1nAI2EudeXGKCqBGUODnzCVg9M1BN89bZYGdICJzhkHi7fDZUs4vE
        pFUToWxhiVfHt7BD2FISL/vb2CEamhklXj+/wgLhtDBKrLu9A6rKWOLdzedAT3AArdCUWL9L
        H8SUEFCWOHILajGfRMfhv+wQYV6JjjYhiEYliXlL5zFD2BISl+ZugbI9JM687mKEBFc/o8Tf
        k/2sExgVZiH5ZxaSf2YhLF7AyLyKUSy1oDg3PbXYqMAEHsfJ+bmbGMGJW8tjB+Pstx/0DjEy
        cTAeYpTgYFYS4U3+xJUqxJuSWFmVWpQfX1Sak1p8iNEUGNoTmaVEk/OBuSOvJN7QxNLAxMzM
        0NzI1MBcSZz3XuvcFCGB9MSS1OzU1ILUIpg+Jg5OqQYmb2GVmNAcz90OVWWGZzM6/kyvj143
        Q0mqJqcnrdCixLWlJvqRxv4VdRv/vt7A5W9X5VK4XWu24YsdNX9FZReGRooszsz/3Vq2aVnT
        sRDbL4/M5a7wzxGd+Sf2Quvs7H0P+PksGa51/2e7/lOuPsX3zg4P2SkOvw3e7GqV4m1qy96+
        Ylf/vZPSdzqiyy9ZPpRfujttucRmjkPn1r3Z3PzZ4knhsqxtzJX3RQP3FG+4MCvqySrxP9cf
        LskRUdA5Kub67cG0X4yR5rsKHIKa/tnbsNqriq9ZfK5jr+WLp8rWLPeeHd3Aufv4t2utPxPW
        OZauCa3XfrfHqeHGkThTh8sHPoZN7UkIdPz871emxfWrSizFGYmGWsxFxYkAjdg85GUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXpdhPXeqwYQWTou7jy+wWTRPXsxo
        MX3qBUaLEzcb2SxW31zDaNG0+i6rRfPi9WwWH978Y7E48LqB3eLM2ZesFqsWXmOzOLL2KpPF
        4qMzmC2O7uGwOD/rFIvF5V1z2CxuTTjGZLHx/js2ByGPnbPusnu0HHnL6rF4z0smj02rOtk8
        9s9dw+7Rt2UVo8fU2fUenzfJBXBEcdmkpOZklqUW6dslcGXcfvCGuWA6a8XPhwfZGxjnsHQx
        cnJICJhITFv/Fsjm4hAS2M0o8f7fd3aIhITE8g0vmCBsYYn7LUdYIYp+MUqseb0SrIhNQEti
        +swGsISIwHMmiZNvTjGCOMwCr5gkev9fZwapEhYwlDjasoENxGYRUJXY1fkbbDevgLXE4YXr
        oVbIS+w/eBasnlPARuLci0tgcSGgmuWX9rJB1AtKnJz5BKyXGai+eets5gmMArOQpGYhSS1g
        ZFrFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcY1paOxj3rPqgd4iRiYPxEKMEB7OS
        CG/yJ65UId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzfXvemCAmkJ5akZqemFqQWwWSZODilGpgi
        co8t7zhv9ThWItFNQXl9Fvuvdd27/5zrXiFiZb7mAjvn1lUx4atPJp96VrmYfX1ViraYpZnE
        8V9XLGvlViXUJ1TdbA9YLMhW8GRVScZtWckL918Z1K5TN1z+9dia3Ovz8q77sK14/GOrT4/d
        VR2xE8YXfi5aY+rDfjwt6dD1MmPGLbU9z6/Y6kevq3mT9uzMi3dFf2MLOSfqzJEWWSLn6BR7
        4tj5aBZj0QUby7ZIqnOdPfsuet5j2f4VF85tSX/AeP91j2dyL3PS05SlEy2Z93yd8FwiceGz
        LO4FCvufB6hY3pvKts2vN7V+GkPD7jd9mkG/5Y69nd+Q/Gxzx4aJLHqeb/c9W3bUZtkb+1m6
        SizFGYmGWsxFxYkAguEdhSADAAA=
X-CMS-MailID: 20230921024832epcas2p4ecfc828890e076024e402fd5ef7d8c70
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230921024832epcas2p4ecfc828890e076024e402fd5ef7d8c70
References: <20230921025110.3717583-1-jtp.park@samsung.com>
        <CGME20230921024832epcas2p4ecfc828890e076024e402fd5ef7d8c70@epcas2p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Block comments should align the * on each line

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
---
 drivers/cxl/cxl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 545381355efb..0bbe0c15bfa9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -334,7 +334,7 @@ enum cxl_decoder_type {
  * @flags: memory type capabilities and locking
  * @commit: device/decoder-type specific callback to commit settings to hw
  * @reset: device/decoder-type specific callback to reset hw settings
-*/
+ */
 struct cxl_decoder {
 	struct device dev;
 	int id;
-- 
2.34.1

