Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320027BA198
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbjJEOqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238985AbjJEOlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:41:31 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DC785F3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:16:11 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231005114824euoutp028f74bffa776572d343ed5eb7afa92645~LM61TSJfj2243822438euoutp028
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:48:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231005114824euoutp028f74bffa776572d343ed5eb7afa92645~LM61TSJfj2243822438euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696506504;
        bh=K0V3kKyiwioyVGjMGi18lGgN46kvGuxop3Lkg0la2P4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tZSQZwrmlYxbn7pM3sAZiPs3fBMJj246a/8U313T1Oie8s2uDGQdc7nS2famFYMfA
         5JjjQJrhoj4E0IEJwvBo6Bf4CyL+KB2v3rK/dQ7/LK/7n5DG9tHS2CIipG/GiwnFVU
         bi7vHgqg0z1yMXzYqdDgzdJCiN6GyAK2X84liCoA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231005114823eucas1p1debb8a190c079839ebdd65f135cd07e3~LM61ICxH32689026890eucas1p1G;
        Thu,  5 Oct 2023 11:48:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 47.85.42423.782AE156; Thu,  5
        Oct 2023 12:48:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231005114823eucas1p2db2015fae87787ca776ad987f2fe6f5d~LM60zr3c02300223002eucas1p24;
        Thu,  5 Oct 2023 11:48:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231005114823eusmtrp10da3f848dd26e1c58cf13060472f7755~LM60zCfMo2664026640eusmtrp1C;
        Thu,  5 Oct 2023 11:48:23 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-ab-651ea2873832
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3C.CC.10549.782AE156; Thu,  5
        Oct 2023 12:48:23 +0100 (BST)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231005114823eusmtip13660e942bc309057656955b195d06761~LM60c6aVi1331813318eusmtip17;
        Thu,  5 Oct 2023 11:48:23 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] Input: max77693-haptic - add device-tree compatible strings
Date:   Thu,  5 Oct 2023 13:48:16 +0200
Message-Id: <20231005114816.1101953-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduzned32RXKpBgf+mVscXvSC0WLv663s
        Fjc/fWO1uLxrDpvF2iN32R1YPXbOusvucefaHjaPvi2rGD0+b5ILYInisklJzcksSy3St0vg
        yrg+oY+94A1Hxez1y1gaGI+xdzFyckgImEgsv/WDuYuRi0NIYAWjxOkZjxghnC+MEuvaz7BC
        OJ8ZJf4ffwLXMnHlSSaIxHJGia4ZX5jgWjr/LQarYhMwlOh628UGYosI2ErsWDEdrIhZYBqj
        xOLXJ8GKhAV8JL5Ov8QEYrMIqErc7brBCmLzCthL/D1+gw1inbzE/oNnmSHighInZz5hAbGZ
        geLNW2eDXS4h0Mkh8ebgDqgGF4nOJScZIWxhiVfHt0DdLSNxenIPC0RDO6PEgt/3mSCcCYwS
        Dc9vQXVYS9w59wtoEgfQCk2J9bv0IcKOEoeefGMECUsI8EnceCsIcQSfxKRt05khwrwSHW1C
        ENVqErOOr4Nbe/DCJWYI20Oi8/EEsDOFBGIllp2fwzaBUWEWktdmIXltFsINCxiZVzGKp5YW
        56anFhvmpZbrFSfmFpfmpesl5+duYgSmlNP/jn/awTj31Ue9Q4xMHIyHGCU4mJVEeNMbZFKF
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1MAUkPJs6u/8r
        s5bhJA7T5oUWSpI6+3N4/1jObqqa2pHQ9oun5WPU94XaB69ysfq/fsa1+6AaH+9Xz7yFaxgW
        lHtM2PN86Y+D/9hf2J2qamiKnvMjTDt0j1O1mvwt9SLtl+F5ft7Cf7SZ5gsv4ljXl+F+SpqB
        rbFi8e/Ogr/KGtVrcg5YrJ/wnLc16wnX2r8efsLXFwpJFQikJaa+mPlKOdw9zM2R2Zx9+i/m
        tvsrvXNNVEsYrmUfZN854y7HnRk5or4nfvMeYN80xdnyu6HYHdmjHm3B4e+jTn0R/Gpy+Xjf
        ua45TRZO7uKLmV+vPpbPGf4o9rJEyttslZL4x6Vnppn8q02vunJGMq312rUnSizFGYmGWsxF
        xYkAUHKrCZgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVy+t/xu7rti+RSDc5uVLI4vOgFo8Xe11vZ
        LW5++sZqcXnXHDaLtUfusjuweuycdZfd4861PWwefVtWMXp83iQXwBKlZ1OUX1qSqpCRX1xi
        qxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3F9Qh97wRuOitnrl7E0MB5j
        72Lk5JAQMJGYuPIkUxcjF4eQwFJGiQWP90IlZCROTmtghbCFJf5c62KDKPrEKPHh3GGwBJuA
        oUTXW5AEJ4eIgL3E4TdrWECKmAWmMUrMXfGPCSQhLOAj8XX6JTCbRUBV4m7XDbBmXqCGv8dv
        sEFskJfYf/AsM0RcUOLkzCcsIDYzULx562zmCYx8s5CkZiFJLWBkWsUoklpanJueW2yoV5yY
        W1yal66XnJ+7iREYyNuO/dy8g3Heq496hxiZOBgPMUpwMCuJ8KY3yKQK8aYkVlalFuXHF5Xm
        pBYfYjQFum8is5Rocj4wlvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqY
        ODilGpg6jdWMcwsOpVVY5fzZYH5gypHFuz8e0OPw37hcV7iTN/2q82R2VZ1l0RPm593ru7Zk
        /QfGvZs3778unVa5b/uqhaYRkc3x67W7p0+76L51b5HlQs55M571tEmcm6ZomLzwrlnJlA8+
        QnX/XO7Pb1mmtCaj7uvqlVdiF9Z0uE1uTxdaxyv+Y3btgXmhAZU+xg1mrZqWDZLm4p2LzzdN
        eXv+nBE/W1MSW+4Kg2W2mxlnHZvMU71kYXrv6uonL/ZkaSzzsWHVcD1gMEfOWu/tudevoh4+
        rGQ/tC14dWyupmTl1sNW8Szzig+8TffIMzH1Pzr324TwO080vjuueOCrvihmFZ/R/AKLnADL
        nqnpTw4qsRRnJBpqMRcVJwIAJYNP+u0CAAA=
X-CMS-MailID: 20231005114823eucas1p2db2015fae87787ca776ad987f2fe6f5d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231005114823eucas1p2db2015fae87787ca776ad987f2fe6f5d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231005114823eucas1p2db2015fae87787ca776ad987f2fe6f5d
References: <CGME20231005114823eucas1p2db2015fae87787ca776ad987f2fe6f5d@eucas1p2.samsung.com>
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

Add the needed device-tree compatible strings to the MAX77693 haptic
driver, so it can be automatically loaded when compiled as a kernel
module and given device-tree contains separate (i.e. 'motor-driver')
node under the main PMIC node.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/input/misc/max77693-haptic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 80f4416ffe2f..2a6e713b32f4 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -412,6 +412,13 @@ static const struct platform_device_id max77693_haptic_id[] = {
 };
 MODULE_DEVICE_TABLE(platform, max77693_haptic_id);
 
+static const struct of_device_id of_max77693_haptic_dt_match[] = {
+	{ .compatible = "maxim,max77693-haptic", },
+	{ .compatible = "maxim,max77843-haptic", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, of_max77693_haptic_dt_match);
+
 static struct platform_driver max77693_haptic_driver = {
 	.driver		= {
 		.name	= "max77693-haptic",
-- 
2.34.1

