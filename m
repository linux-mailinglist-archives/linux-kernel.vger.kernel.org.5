Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7F67A9110
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjIUCtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjIUCss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:48:48 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D1CF5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:48:36 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230921024833epoutp03343097f7c1bd7f987da26bf303b9ac90~GyhfV2bVI0820008200epoutp03x
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 02:48:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230921024833epoutp03343097f7c1bd7f987da26bf303b9ac90~GyhfV2bVI0820008200epoutp03x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695264513;
        bh=j1WXPoAl6h8v5nYo1OXjYbjw+/8bZOA7DANmQaSy4Jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bo8Wf1C9gTEeNcC4G3FITuOXlHVbCKwzP3Dpl5hU4S9QvWlLCRaFHVcap8TgLCJSo
         x1KeW3NgoDerdViJEzGsM9iA/49FYicqZmUbtF7Ll5wZjd76rfUvaG66B3Kio3X2mZ
         ucoTiTyLisus7A/mB4sU8Cc0bVpIt/jjX1PDWUMI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230921024832epcas2p40cfd689f4ce287b35a4e1a2ad22b2f8e~GyhevWH3c0279002790epcas2p4K;
        Thu, 21 Sep 2023 02:48:32 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.68]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Rrfwc1wtGz4x9Q6; Thu, 21 Sep
        2023 02:48:32 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.AA.09765.00FAB056; Thu, 21 Sep 2023 11:48:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230921024831epcas2p2580ed6d9ca4e6ade29e7fa6a5bafa881~GyhdsIjFb0036500365epcas2p2_;
        Thu, 21 Sep 2023 02:48:31 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230921024831epsmtrp14cf67ad390b7605d15129fc2c379c5a1~GyhdrK1Oe0473204732epsmtrp1F;
        Thu, 21 Sep 2023 02:48:31 +0000 (GMT)
X-AuditID: b6c32a48-40fff70000002625-95-650baf008713
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.D7.18916.FFEAB056; Thu, 21 Sep 2023 11:48:31 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230921024831epsmtip23cabd84a98f08c1cf3ab6c8abb6255cc~GyhdcQrNI1720017200epsmtip2N;
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
Subject: [PATCH 1/7] cxl/trace: Fix improper SPDX comment style for header
 file
Date:   Thu, 21 Sep 2023 11:51:04 +0900
Message-Id: <20230921025110.3717583-2-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921025110.3717583-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAJsWRmVeSWpSXmKPExsWy7bCmqS7Deu5Ug6UvOC3uPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFs2L17NZfHjzj8XiwOsGdoszZ1+yWqxaeI3N4sjaq0wW
        i4/OYLY4uofD4vysUywWl3fNYbO4NeEYk8XG++/YHIQ8ds66y+7RcuQtq8fiPS+ZPDat6mTz
        2D93DbtH35ZVjB5TZ9d7fN4kF8ARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlh
        rqSQl5ibaqvk4hOg65aZA/SKkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECv
        ODG3uDQvXS8vtcTK0MDAyBSoMCE7Y97CyWwF31gqPiwTaWCcyNLFyMkhIWAicaF3KpDNxSEk
        sINRoqHzMRuE84lR4sSz34xwzoFJHxlhWl5838cEkdjJKLFpz02oqj+MEhsvQwxmE9CSmD6z
        gRUkISLwkEli56s+sBZmgUdMEh9PvGLuYuTgEBYIlPjx2RLEZBFQlXiy1h7E5BWwlti6xwZi
        mbzE/oNnmUFsTgEbiXMvLjGB2LwCghInZz4BW8UMVNO8dTYzyHQJgTMcEnc+nYN6zkXiZ+MD
        qKuFJV4d38IOYUtJvOxvY4doaGaUeP38CguE08Iose72DqgqY4l3N5+zglzELKApsX6XPogp
        IaAsceQW1GI+iY7Df9khwrwSHW1CEI1KEvOWzmOGsCUkLs3dAmV7SNxsnAwN3n5GiedvjjBN
        YFSYheSfWUj+mYWweAEj8ypGsdSC4tz01GKjAhN4DCfn525iBCdtLY8djLPfftA7xMjEwXiI
        UYKDWUmEN/kTV6oQb0piZVVqUX58UWlOavEhRlNgWE9klhJNzgfmjbySeEMTSwMTMzNDcyNT
        A3Mlcd57rXNThATSE0tSs1NTC1KLYPqYODilGph220v+VfOd8M9mz6GwjKUTg1d02STMr9Vy
        rEz6PtXP0eHivcwVD6tYDndZdk1dfezD1KXF27l2nr+t+CVxk/3y/NV1/1vTTaq15HT37mtr
        e1Ettd/NXWJ+dEhOZeCllx+8rnOpPX7j803myQ3ZlbmFB6xapaRNVBd2Jy+eKpP0evkn3lnv
        dxq8ONwW274gZVLXnmyO48bcHT9Dt2mYMX80Es8wMJC5pc4UtY9P5Fbog1+2O3ft3Fz5xnGi
        zuRgoTyZyYv273ItYZnbVLxmxq7AiYw8POUa2aYLo71VJruc/bRk116l9XsLWpZIJwTYvZkx
        z5XbJnPClDddv93XeZ6vXKHz1mPmyukSyw7a8XxTYinOSDTUYi4qTgQAlOtec2MEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXvf/Ou5Ug32vVS3uPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFs2L17NZfHjzj8XiwOsGdoszZ1+yWqxaeI3N4sjaq0wW
        i4/OYLY4uofD4vysUywWl3fNYbO4NeEYk8XG++/YHIQ8ds66y+7RcuQtq8fiPS+ZPDat6mTz
        2D93DbtH35ZVjB5TZ9d7fN4kF8ARxWWTkpqTWZZapG+XwJUxb+FktoJvLBUflok0ME5k6WLk
        5JAQMJF48X0fUxcjF4eQwHZGiWXXtzFCJCQklm94wQRhC0vcbznCClH0C6ho7kl2kASbgJbE
        9JkNYAkRgedMEiffnGIEcZgFXjFJ9P6/zgxSJSzgL7Fty1mgURwcLAKqEk/W2oOYvALWElv3
        2EAskJfYf/AsWDWngI3EuReXwBYLAZUsv7SXDcTmFRCUODnzCdjVzED1zVtnM09gFJiFJDUL
        SWoBI9MqRtHUguLc9NzkAkO94sTc4tK8dL3k/NxNjOCo0grawbhs/V+9Q4xMHIyHGCU4mJVE
        eJM/caUK8aYkVlalFuXHF5XmpBYfYpTmYFES51XO6UwREkhPLEnNTk0tSC2CyTJxcEo1MMU4
        Ljy/7UuFceHFxrePrndrds/1NPc+zD2rp8xji0szj/gNnX1XGe5wH7Bic+v5933Pham8KieZ
        qvybJVkMwpcvn1R8+mhRefXxo3fPHw/bdvzvpkvM7bNF5awXVP22LX039c1611uiN1P5jTvu
        X47/2r2Hn3Ptiv1779Z/FnD7d4Z/rnLBdra3bC1z7b7xfRe4uO/n27VcSRE6ug3RTw8rn7Vs
        eekqPceuxcvszqT/L4pYp4vxnGD2SjVxiny4MnKe6gHV5R8/5HJuWdwyKUOF+/S+pJXZAhW/
        DaaqiQslzv72rj3/8YV9syaoaydVO/1ysjujHbjtuXHkvSLXm41BaopH7W0aQw93297TXKbE
        UpyRaKjFXFScCAAJLQ5LGQMAAA==
X-CMS-MailID: 20230921024831epcas2p2580ed6d9ca4e6ade29e7fa6a5bafa881
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230921024831epcas2p2580ed6d9ca4e6ade29e7fa6a5bafa881
References: <20230921025110.3717583-1-jtp.park@samsung.com>
        <CGME20230921024831epcas2p2580ed6d9ca4e6ade29e7fa6a5bafa881@epcas2p2.samsung.com>
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

The SPDX license identifier for C header have to be added
in form of a C-like comment.

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
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

