Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6232D806795
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376842AbjLFGiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376855AbjLFGh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:37:57 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29EB1713
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:37:25 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231206063723epoutp039b00d26df8a659de449a7e14c64a4be0~eKq_5f7Od1364213642epoutp036
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:37:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231206063723epoutp039b00d26df8a659de449a7e14c64a4be0~eKq_5f7Od1364213642epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701844643;
        bh=sUjpf4J6EPjRz39tJ2nYMQaPVuJGRvfjwr76yMwFWGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VAMGBs/F33/VazQNUa9UOIkhF6JoK52SsRd1qhTcmg5XcxUo8h6eG3yF6BP9O0sbS
         E/ACpgGMy0rUEMM+KJvwLiBANFyRO0ZVLSjxOqouOhFRPo/Jjep9qjMxI2OY/DL++A
         Xw0x2DGirE8C8z4Q6Np6Qt5F1X2/Bo2JnQtdWJLg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231206063722epcas5p1ce220689ab35a1c57f5b7243ef650006~eKq_ZceS31836918369epcas5p1K;
        Wed,  6 Dec 2023 06:37:22 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SlSPX6BBZz4x9Q6; Wed,  6 Dec
        2023 06:37:20 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.B6.09634.0A610756; Wed,  6 Dec 2023 15:37:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20231206063134epcas5p2b3b9ca0351cd9c1cb169d7a4a3a30b80~eKl6ChNmL0996309963epcas5p2X;
        Wed,  6 Dec 2023 06:31:34 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231206063134epsmtrp206d7b59e78d1127279e4f601db0d9e56~eKl6Bculq1483414834epsmtrp2f;
        Wed,  6 Dec 2023 06:31:34 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-19-657016a0e7e1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.96.07368.64510756; Wed,  6 Dec 2023 15:31:34 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231206063131epsmtip25bc57c9c9368a9261509f30882ede592~eKl3MGy250501105011epsmtip2z;
        Wed,  6 Dec 2023 06:31:31 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
        andi@etezian.org, gost.dev@samsung.com, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        ajaykumar.rs@samsung.com, aakarsh.jain@samsung.com,
        linux-fsd@tesla.com, Smitha T Murthy <smithatmurthy@gmail.com>
Subject: [Patch v5 09/11] media: s5p-mfc: Load firmware for each run in
 MFCv12.
Date:   Wed,  6 Dec 2023 12:00:43 +0530
Message-Id: <20231206063045.97234-10-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231206063045.97234-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTbUxTZxTH89zb29421twU0WeEISlzipHaYlsfTHHozLy+ZLI4w9yW4ZXe
        AFLarrfgxhfASAY4GYaiwHgb4MaoiqtQK9ANC4sJokQhEAQGyHC8LA5hEBiia2nZvv3OP+f8
        T845z0PikmZ+AJmoN7MmPaOT8kU8e1votrDKjUZWPjYtQ+OOYgK1/nWXh0bK7XxUvfgHhoar
        53jIdatRgK45H2Koov0hgfpb72DoUfEQD+VNjOLINtZLoNGpGNTdVMpHX99sJFBR188Yut4+
        JEDf215iqKrxbwHKcrYL0PnMGiLKn+6rmcXpOyVDArq6ZRKjbXU5fHqwt4VP36pJp/Ma6gD9
        6lyZgJ6zBdEd83OCaNHHSZoEltGypmBWH2fQJurjI6VHjse+G6tSyxVhigi0WxqsZ5LZSOmB
        o9Fh7yXq3DNKg1MZXYpbimY4Trpzr8ZkSDGzwQkGzhwpZY1anVFplHFMMpeij5fpWfMehVwe
        rnInnkpK+NNajht/Ib+wLC3jGaBQkAuEJKSUsHO2kJ8LRKSEagawaKHbF8wC+Mx50RcsANhi
        ec5bKym7PUN4WEI5AayY2O3lLAza8z7JBSTJp8Lgg9s6j7yBygRwLNvs8cGpeziszC9e9fGj
        PoCDCz+tMo/aAkefWoCHxdRe2J9h9/XaDK03W3EPC9265Vol4TGCVA8Je7PyCU8zSB2AUxmU
        N98PTt1r8I0WAOeeO/lejoNjVZO4l3WwvsXi838HtvaU8jw2OBUK65t2euU3YWHHDczDOLUe
        Xlz+HfPqYugoX+O3YengIuHlQNhmvQq8TEPLtzbf3i4B2NAzxs8HQSX/t6gEoA68wRq55HiW
        UxkVevbsfzeLMyTbwOor3n7IAYZGZmQugJHABSCJSzeIdV0GViLWMl+msSZDrClFx3IuoHLv
        7xIe4B9ncH8DvTlWoYyQK9VqtTJil1oh3SSezirTSqh4xswmsayRNa3VYaQwIAO7shxpXYwp
        +CHt043bxs8MXnmsCXnBRNeqXLLJgfnQHSOf5VZa1en0hP2Cw7A++/BxSeehZucRv9eS9syP
        lpSau07emaOvej+XVGn+CU0/mI6Z71cI03/tXxHNf9etKMk+Kc/O2fW4jXDUR0127DsW+Fbt
        67Mz6nVcwhbF4YH79Y6YgdKCqk0XUju3ng8fVYeYRecSlx5dl4CVr/qLttbduLw/sLhAmzh9
        6slBVdf7M31zafltORVJJ0QvngzLpoI7NPbLp0n/pyGBsylLK5vLgj4ctA5/88BPTP6WpY7a
        UxsQlT1+MhUxZGPLyx0nhDxi3Y/VzxzVp+eX9jfR4X37XKyflMclMIrtuIlj/gWM0PhkTgQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvK6baEGqwe210hZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        ePgq3OLyrjlsFj0btrJazDi/j8li7ZG77BbLNv1hsli09Qu7ReveI+wWLY1LWB1EPa4v+cTs
        sXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j36tqxi9PjXNJfd4/MmOY9TXz+zB3BFcdmkpOZk
        lqUW6dslcGW8WT2PuWA/R8WUn7+ZGxinsncxcnJICJhIzN3+gbWLkYtDSGA3o8TnJdsYIRIy
        Ev/bjkEVCUus/PecHaKomUnixZP7LF2MHBxsAroSZ7fngMRFBFoZJa6v7GQCcZgFbjNLbJrw
        EKxbWMBf4sX/bcwgNouAqsTDR1PANvAK2EncbNjGArFBXmL1hgNgNZxA8SlrFrCCLBASsJVY
        edJxAiPfAkaGVYySqQXFuem5yYYFhnmp5XrFibnFpXnpesn5uZsYwRGjpbGD8d78f3qHGJk4
        GA8xSnAwK4nw5pzPTxXiTUmsrEotyo8vKs1JLT7EKM3BoiTOazhjdoqQQHpiSWp2ampBahFM
        lomDU6qBSX6ts/P7j+q7X0lln48pCVy/203QxErZUEh5r2xQ+4/1HNUBL+cfSvH4w3J1rxOj
        S/ehPeK9HqEm6zSuLNn8NuZUxa3A3OsNM+deDuta9eVQ966J0+JfJ3RlLtatTKl1E2Z2rxDz
        l71+2vafHLdRxtLKM3uVq9oD7dklJuUHvLtTWfaMt4pt0dmiaXEbJhVKaW26fMnduWe9Xu0v
        XY3JzxeaamdN0radMvtYeM5h+e1eRR+FlOzep4lIfr2ZprmxYFbb2l+/o+bb/Q9d9kDJrXK9
        tpDIy/DLZ3UP+0Q9CJyVevf7gx0Kq8u0frn+ML/0+uvqzAl+mStWSC2XeCf1MOjkwadO378s
        f1p77/FyPiWW4oxEQy3mouJEAM3I4pEHAwAA
X-CMS-MailID: 20231206063134epcas5p2b3b9ca0351cd9c1cb169d7a4a3a30b80
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206063134epcas5p2b3b9ca0351cd9c1cb169d7a4a3a30b80
References: <20231206063045.97234-1-aakarsh.jain@samsung.com>
        <CGME20231206063134epcas5p2b3b9ca0351cd9c1cb169d7a4a3a30b80@epcas5p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MFCv12, some section of firmware gets updated at each MFC run.
Hence we need to reload original firmware for each run at the start.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smithatmurthy@gmail.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
index b49159142c53..24dd40ae71ec 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
@@ -51,8 +51,10 @@ int s5p_mfc_load_firmware(struct s5p_mfc_dev *dev)
 	 * into kernel. */
 	mfc_debug_enter();
 
-	if (dev->fw_get_done)
-		return 0;
+	/* Load MFC v12 firmware for each run when MFC runs sequentially */
+	if (!IS_MFCV12(dev))
+		if (dev->fw_get_done)
+			return 0;
 
 	for (i = MFC_FW_MAX_VERSIONS - 1; i >= 0; i--) {
 		if (!dev->variant->fw_name[i])
-- 
2.17.1

