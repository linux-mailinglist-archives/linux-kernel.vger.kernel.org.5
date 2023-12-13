Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41110810F41
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378422AbjLMLB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378465AbjLMLBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:01:55 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0CEE8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:02:00 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231213110159epoutp02fd8f3e96e325ee5bd56b77203ed3fd9f~gXzAMdhze0677506775epoutp02M
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:01:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231213110159epoutp02fd8f3e96e325ee5bd56b77203ed3fd9f~gXzAMdhze0677506775epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702465319;
        bh=LZVgTWOA7yYp3sqdPTipSEAOFAHSGmyu544A5a7oNAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hLs/edNbmVQA+1gU653vWLLH4aA1S8npxnVSaSxmEeHO5ixbSWqNLjldIif/t+ufY
         6a/fD7hTJ1W0L5iEYUspv4D6lzFGRGFeLfeA5vF7954+uJ+F59Ghd7ZbutNgZ7vb9/
         X+a7/qV4SBzUEI1MBN5VEEXin0xOcxqnqRxFe7jE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231213110158epcas5p37b00b3c0862782e3aa9bc0aec604fa8b~gXy-nWIxR0874808748epcas5p3G;
        Wed, 13 Dec 2023 11:01:58 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Sqsxc5ZG3z4x9Pp; Wed, 13 Dec
        2023 11:01:56 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.95.10009.42F89756; Wed, 13 Dec 2023 20:01:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231213081143epcas5p1a3acbe09ca033b356a19e2acb2d9411f~gVeWUshgv2135121351epcas5p1O;
        Wed, 13 Dec 2023 08:11:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231213081143epsmtrp2c0e11dd3fe1087765e4a4a11ed62e190~gVeWTxp-z2150821508epsmtrp2j;
        Wed, 13 Dec 2023 08:11:43 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-08-65798f244c6f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.E2.08817.F3769756; Wed, 13 Dec 2023 17:11:43 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231213081140epsmtip2f9f8f2364db705d0388396386aeada86~gVeTjDDOS0553305533epsmtip2V;
        Wed, 13 Dec 2023 08:11:40 +0000 (GMT)
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
Subject: [Patch v6 09/10] media: s5p-mfc: Load firmware for each run in
 MFCv12.
Date:   Wed, 13 Dec 2023 13:41:04 +0530
Message-Id: <20231213081105.25817-10-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213081105.25817-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xbVRTHc9/r63sQWV4Y0yubk3Q6MhKgnaW7GNhcLO45B2FOg6KRFfpS
        atvX+l5hgtEBs5PhGBA3A8iPhV9B2Abr+FUGk0KBDB045cd0gCAwB5hOYW5k4mJLQf/7nHO+
        35xzz72Xwn07xP6UljOzPKfSS8TeopaeXYHBz+WlsdLx0iA011ZEoK57dhGaKmsRo8qV3zD0
        S+WyCHVfaSbRhc5BDJU7Bgn0U5cNQzeLJkTozN1pHFlnRgk0vRCHfmwvEaPTjc0EKhy6hqGL
        jgkS1VhXMVTRfJ9Elk4HiT7NrCJe2sKMVS3hjK14gmQqO+Yxxlp3SsyMj3aImStVx5kzTXWA
        eZxVSjLL1u3MwF/LZKx3vC4imVWpWT6A5ZKMai2niZS8diTh5YQwhVQWLAtHeyQBnMrARkqU
        h2KDX9HqXWeUBKSq9CmuVKxKECSheyN4Y4qZDUg2CuZICWtS601yU4igMggpnCaEY80vyqTS
        3WEu4VFd8pzlOmayen+Yd1uZAUaoHOBFQVoOv81vJnKAN+VLXwWwbKABeIIlAB+VjOKe4AGA
        9tU+8YalwFlLegqdABZeXVkPLBjsHTkpygEUJaaD4Y1WvdvgR2cCOJNtdmtwuh+H5/OLRO7C
        ZvowrOksJt0sop+HZZZswu31offCO7ZYT7NnYX1jF+5mL1famfXN2niQHqZg5q17Io9ICadH
        vsM9vBku9DeRHvaHy87O9amT4EzF/LpGDxs6zq5798Gu4ZK1mXF6F2xoD/Wkn4HnBi5hbsbp
        TTD371nMk/eBbWUbvBOWjK8QHt4Ge+qrgYcZOHlhen0nBQA6Bi9j+WB78f8tzgNQB55mTYJB
        wwphpt0ce+y/S0syGqxg7RkHHWwD01N/hHQDjALdAFK4xM/netsx1tdHrUpLZ3ljAp+iZ4Vu
        EObaXwHuvyXJ6PoHnDlBJg+XyhUKhTz8BYVM8pTPoqVU7UtrVGZWx7Imlt/wYZSXfwaWKRxJ
        fM9253VC2zK1lKrLn298p1qe++vngdnvVxc/thFPjveZbW0Xk4a+ivIjUHue/Li9t3c17oSS
        r+eH+84+oXXCB7KWwRpF7e2hxfG7uiilIaQofiRaOxljtFPlr56o/Sjzh53pzMSNmaruW5P9
        C879HW/3RCgfbTsdU58eHa9wnos6NLvCpS5mbbrfwGRsjSlPa+V//+zLhgMf6ELph2Mafuwt
        bxO3Q1kltswpPnn4desbWacSv5A7DuxT7vAd6GkaOhhob18W1NTlrZcSs1dmh3Kh1LGn7p/s
        QnPFfsufolz2TS1nY20n3z18c4lsjI77+Gfsml0+2zfR/P1RjUQkJKtkQTgvqP4FmHmwK08E
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvK59emWqwa97ChZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        ePgq3OLyrjlsFj0btrJazDi/j8li7ZG77BbLNv1hsli09Qu7ReveI+wWLY1LWB1EPa4v+cTs
        sXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j36tqxi9PjXNJfd4/MmOY9TXz+zB3BFcdmkpOZk
        lqUW6dslcGU8bT3JVLCJq6L/tksD41WOLkZODgkBE4mJ71awdzFycQgJ7GaUaDw/lw0iISPx
        v+0YO4QtLLHy33OoomYmib07/jB2MXJwsAnoSpzdngMSFxFoZZS4vrKTCcRhFrjNLLFpwkOw
        bmEBf4mpLfdZQWwWAVWJea0drCDNvAJ2Es92BkAskJdYveEAM4jNCRR+17SfEcQWErCVWL77
        NvMERr4FjAyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC40VLawfjnlUf9A4xMnEw
        HmKU4GBWEuE9uaM8VYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvt9e9KUIC6YklqdmpqQWpRTBZ
        Jg5OqQamTpXlU26uvjRdtyvLc6+Cln+8TW79J2+7g3ck7q7gCdw84ZDNw/sCsSE3T0tkKr1u
        y9ywyMOUa1an3IHL96+lzz9l0PP/87IPzKeuxU/4q6++PXGOR8qLHdUHfvxdfsXm1HGLT36Z
        bg3Prt1eLLr/w5F/OvMZwn9fSzj87U33xsCfP+bb64XNr3VYnzchPf9dEkv5TJf0ZV8/9i8R
        aDsm4WJ4x6Z87d1ZG1JqOTO0hDzDdxfMPDmdQ7F4wVUNczkBL7a53SbHLuuxSUjsY92kvGbN
        Ke/ZDApnPy78YCuTvOLCIrPVnrP4J2ypjwiMO7Sy/d+ujVb8OiWSTSsD2tK6gyNkXx86EKmT
        HZWpKhu8VImlOCPRUIu5qDgRAIFHRxAGAwAA
X-CMS-MailID: 20231213081143epcas5p1a3acbe09ca033b356a19e2acb2d9411f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213081143epcas5p1a3acbe09ca033b356a19e2acb2d9411f
References: <20231213081105.25817-1-aakarsh.jain@samsung.com>
        <CGME20231213081143epcas5p1a3acbe09ca033b356a19e2acb2d9411f@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
index b49159142c53..503487f34a80 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
@@ -51,8 +51,14 @@ int s5p_mfc_load_firmware(struct s5p_mfc_dev *dev)
 	 * into kernel. */
 	mfc_debug_enter();
 
-	if (dev->fw_get_done)
-		return 0;
+	/* In case of MFC v12, RET_SYS_INIT response from hardware fails due to
+	 * incorrect firmware transfer and therefore it is not able to initialize
+	 * the hardware. This causes failed response for SYS_INIT command when
+	 * MFC runs for second time. So, load the MFC v12 firmware for each run.
+	 */
+	if (!IS_MFCV12(dev))
+		if (dev->fw_get_done)
+			return 0;
 
 	for (i = MFC_FW_MAX_VERSIONS - 1; i >= 0; i--) {
 		if (!dev->variant->fw_name[i])
-- 
2.17.1

