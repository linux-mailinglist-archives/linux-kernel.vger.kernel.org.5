Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE48A7C6B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377813AbjJLKfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343776AbjJLKfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:35:37 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA7890
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:35:34 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231012103532euoutp0255a476cffdd24e790b977def90f3198d~NVcNs_Gco0819008190euoutp02f
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:35:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231012103532euoutp0255a476cffdd24e790b977def90f3198d~NVcNs_Gco0819008190euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697106932;
        bh=vZ6q5ULxdh0t0IrN2RtBejM5no6tzpOqogEIP27ked8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=PukFaw6DcM0ynvCe3UczXFE/N+z+QyxNvin4LT/oiPqxHbpEloS/LOg0DT4nbRL4y
         GqfwDQOujfWR7lz0hF1cpZaLdt1Gq6rUU2Yo9ebstbQ9/3lgOUcmSfMk58UWPfgF02
         cq6b8h5LM5zJechJHkTMxqnnjWMAnDmZYX5zhIDY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231012103532eucas1p2ed42cf43d90b50b42220fb371f36719c~NVcNf0Ejp2545425454eucas1p2b;
        Thu, 12 Oct 2023 10:35:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 15.F8.37758.4FBC7256; Thu, 12
        Oct 2023 11:35:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231012103531eucas1p1f370bddcb690aa421498e961f4081f2b~NVcNN9K8G3023930239eucas1p1P;
        Thu, 12 Oct 2023 10:35:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231012103531eusmtrp27df298802da261f0feee022569fb4ef4~NVcNNbROS2357523575eusmtrp2q;
        Thu, 12 Oct 2023 10:35:31 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-a8-6527cbf4e7cd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0C.72.25043.3FBC7256; Thu, 12
        Oct 2023 11:35:31 +0100 (BST)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231012103531eusmtip25bf41ad9fefdd2f6b8d5833e9a3d5fbb~NVcM0v_A93168831688eusmtip2K;
        Thu, 12 Oct 2023 10:35:31 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH] media: cec: meson: always include meson sub-directory in
 Makefile
Date:   Thu, 12 Oct 2023 12:35:25 +0200
Message-Id: <20231012103525.3381314-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduznOd0vp9VTDRb8Y7e4OPMui8WC2dwW
        l3fNYbPo2bCV1WLtkbvsFss2/WFyYPPYtKqTzWPzknqPvi2rGD0+b5LzOPX1M3sAaxSXTUpq
        TmZZapG+XQJXxu7vMxgLOtkrtu+/wNjA2M3WxcjBISFgIrFzs2kXIxeHkMAKRon7Z46zQThf
        GCXO/Z3P2sXICeR8ZpRYcB7MBmnY0P6DCaJoOaPE1RdnEDruf9nFBFLFJmAo0fW2iw3EFhFI
        kng67w0zSBGzQBujxP6Hx5lBEsICIRL33s4Ha2ARUJV4u3U5WAOvgL3Ejyf3GSHWyUvsP3iW
        GSIuKHFy5hMWEJsZKN68dTbYUAmBqRwSh07+YIZocJE4tOwX1K3CEq+Ob2GHsGUk/u+czwTR
        0A70z+/7UM4ERomG57eg1llL3Dn3Cxw0zAKaEut36UOEHSX+rL3OCgkxPokbbwUhjuCTmLRt
        OjNEmFeio00IolpNYtbxdXBrD164BHWah8SFF9vYIUEaK3Fy4RHGCYwKs5C8NgvJa7MQbljA
        yLyKUTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMjML2c/nf86w7GFa8+6h1iZOJgPMQowcGs
        JML7KFMlVYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBAemJJanZqakFqEUyWiYNTqoHJ
        mPFVopXdeWGjHiPHnZPl7Cz6JUrKr75Y/X3iVJNpE57NeGEy8/FeVqVGxo0BezfqsQeeiVi1
        QYxvatar5RF6zx2EdrJO3X6hsiSTOyAiT5Iloqjg5onz7rVN8ZO7dPuv8vfm9Gv9yl+lc3KZ
        QuDUbf3Bl8VfsdQdnflj4t6jnmaLU6qYPeWql1uLvuho7PVQfHlkggd73KsegSsXI4V6vv9n
        W/Nvrjabvba8zMH/Jwxn/fl5ysVM6FJFjN9/l4CYaf92SL876BzTdZzrxI2pDE/yJb8nvXwt
        JS5recCy+tTHwPvHDQ5mG2/9yqe34iu3um3qcfdd229wByVJ7Nq24EtM6i6ZDS11bSoHH4kr
        sRRnJBpqMRcVJwIATfK7zp4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t/xe7qfT6unGvw7YmxxceZdFosFs7kt
        Lu+aw2bRs2Erq8XaI3fZLZZt+sPkwOaxaVUnm8fmJfUefVtWMXp83iTncerrZ/YA1ig9m6L8
        0pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jN3fZzAWdLJX
        bN9/gbGBsZuti5GTQ0LARGJD+w+mLkYuDiGBpYwSjdunMUIkZCROTmtghbCFJf5c62KDKPrE
        KPFw8RawIjYBQ4mut11gk0QEUiQWT7zDCFLELNDBKPHq0jGWLkYODmGBIIkdi8JBalgEVCXe
        bl0OVs8rYC/x48l9qGXyEvsPnmWGiAtKnJz5hAXEZgaKN2+dzTyBkW8WktQsJKkFjEyrGEVS
        S4tz03OLjfSKE3OLS/PS9ZLzczcxAsN627GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHeR5kqqUK8
        KYmVValF+fFFpTmpxYcYTYHum8gsJZqcD4ysvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTE
        ktTs1NSC1CKYPiYOTqkGpirNyy/ZKjO0fhwWXl686fkcV0uNjg39aZHtz9XOSV68VKMdJTRr
        KufiF7vWuTkvidyfuvW/UW1YB7es4g1WDvbjfnpHnbXl/CM75viadb79F5Xb/ipKccvG4uXM
        c1122+e5b+r2mJU1KelGhPalyR8D04I1jCsfTN5aZCCtPVmsP/NP9oOFLwSrWha3FyiwXEk1
        K2tc+XP3ufJzpxpn9OvYHM7qXW8jeruqZ9mq0qWVU5M8lnqydXYuNrVcalxa8SJ2ykPljd85
        vhfKly399XaK0aYTy6I6NjRzKGi3NbNMWLPP/1+0wGMugWePV/Td63/La3XzfLPt4iXhr9e9
        2rKs8a2RkNUD1uo35W1VSizFGYmGWsxFxYkAgR5yhvQCAAA=
X-CMS-MailID: 20231012103531eucas1p1f370bddcb690aa421498e961f4081f2b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231012103531eucas1p1f370bddcb690aa421498e961f4081f2b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231012103531eucas1p1f370bddcb690aa421498e961f4081f2b
References: <CGME20231012103531eucas1p1f370bddcb690aa421498e961f4081f2b@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'meson' directory contains two separate drivers, so it should be added
to Makefile compilation hierarchy unconditionally, because otherwise the
meson-ao-cec-g12a won't be compiled if meson-ao-cec is not selected.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/media/cec/platform/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/cec/platform/Makefile b/drivers/media/cec/platform/Makefile
index 26d2bc778394..a51e98ab4958 100644
--- a/drivers/media/cec/platform/Makefile
+++ b/drivers/media/cec/platform/Makefile
@@ -6,7 +6,7 @@
 # Please keep it in alphabetic order
 obj-$(CONFIG_CEC_CROS_EC) += cros-ec/
 obj-$(CONFIG_CEC_GPIO) += cec-gpio/
-obj-$(CONFIG_CEC_MESON_AO) += meson/
+obj-y += meson/
 obj-$(CONFIG_CEC_SAMSUNG_S5P) += s5p/
 obj-$(CONFIG_CEC_SECO) += seco/
 obj-$(CONFIG_CEC_STI) += sti/
-- 
2.34.1

