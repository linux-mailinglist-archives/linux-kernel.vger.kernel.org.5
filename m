Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852F77BB4BE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjJFKEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjJFKEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:04:46 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB828D6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:04:44 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231006100443euoutp02f588510aee9474c9058728aa12f75915~LfJlugl6l0875308753euoutp02S
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:04:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231006100443euoutp02f588510aee9474c9058728aa12f75915~LfJlugl6l0875308753euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696586683;
        bh=z6rhMYaDcJ+uyYL8myW9fdMsYuCjZb7DFvMLTAmA6e8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jlgyu4vqAUIP4TkCGrmRpL0kwh5qhMv+G5ZrCbQBUZhEEz6bZ3WLejKVYD00zfaaD
         daai54SgnWLuTnV6AtCfztm91TizHCgsySKlfBZZ9yFqWDJQRhU3buLD2QV3nwQf6M
         VjkasFDE25bSuPCQ3Py45PUgtEfO52Ru3RYPUoMc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231006100442eucas1p2a02ba81ee3d92d3e18985c785bb5e9ff~LfJli5w9n3217832178eucas1p25;
        Fri,  6 Oct 2023 10:04:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 52.AE.11320.ABBDF156; Fri,  6
        Oct 2023 11:04:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231006100442eucas1p2a51781e74ccd43bbac5c5d0eead6101f~LfJlL5ERC3016730167eucas1p2G;
        Fri,  6 Oct 2023 10:04:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231006100442eusmtrp21195aab04738dbda1231e2376e9d341e~LfJlLZFPR0048400484eusmtrp2B;
        Fri,  6 Oct 2023 10:04:42 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-7f-651fdbba70b2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C5.1D.25043.ABBDF156; Fri,  6
        Oct 2023 11:04:42 +0100 (BST)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231006100441eusmtip2c67b28c7d21971ae06b13a64096f47d7~LfJkrTJyR1180811808eusmtip2n;
        Fri,  6 Oct 2023 10:04:41 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v2 2/2] extcon: max77843: add device-tree compatible string
Date:   Fri,  6 Oct 2023 12:04:34 +0200
Message-Id: <20231006100434.2908243-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006100434.2908243-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djPc7q7bsunGnyYY2Rx/ctzVou9r7ey
        W1zeNYfNYu2Ru+wWtxtXsDmwety5tofNo2/LKkaPz5vkApijuGxSUnMyy1KL9O0SuDKOb/3K
        WjCJs2La0hbmBsZb7F2MnBwSAiYSTcvfsnUxcnEICaxglFj1ppURJCEk8IVRYsH7GojEZ0aJ
        /Zv6WGE6rvz5xgyRWM4osef3TXYIB6hj4o6pYHPZBAwlut52sYHYIgIKEpt7n7GCFDEL7GCU
        uDnlPFMXIweHsIC3xLtFSSA1LAKqEg37DoPV8wrYS0x73A51n7zE/oNnmUFsTgEHiWe/17NA
        1AhKnJz5BMxmBqpp3job7CIJgbkcEv3/7jBBNLtIfGm5wgJhC0u8Or4FaqiMxP+d85kgGtqB
        /vx9H8qZwCjR8PwWI0SVtcSdc7/YQC5lFtCUWL9LHyLsKHH2831WkLCEAJ/EjbeCEEfwSUza
        Np0ZIswr0dEmBFGtJjHr+Dq4tQcvXGKGsD0k/lzZzDaBUXEWkndmIXlnFsLeBYzMqxjFU0uL
        c9NTi43yUsv1ihNzi0vz0vWS83M3MQKTyOl/x7/sYFz+6qPeIUYmDsZDjBIczEoivOkNMqlC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1KzU1MLUotgskwcnFINTByPNH4ee5pz
        bfqFMsMzRt0mH/qPtKxonT9/44KIo2/rX3/I/bLP71CSg32VatiusNVab/f+c93B+pInQeWc
        7btchcMFEWvOnZzaxMkmNW3tE3vFidfubTJapz5124cP/bt35cq7cXBZ3e/8cJCb68M8l477
        v7i6rVcw3p8vce9HmCZ7D8emc/+YQt9Pq+576vW0MGf1Mmm57PYzj2XkWX7JBq4VvW884QrT
        jWbOvlA+8x8H3Leu+DB3s2evjdXU162spaoM3DXp9mf1koKvhed0mnz/eTC8ulnvUn/ajIov
        f+7tVNZ+8sTA+e7H6s5txftLqrtfTd2yM2tD2KLZR81Orol98DBqQeQaqaL3VWJKLMUZiYZa
        zEXFiQBJmzqIkQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsVy+t/xe7q7bsunGtzpFrG4/uU5q8Xe11vZ
        LS7vmsNmsfbIXXaL240r2BxYPe5c28Pm0bdlFaPH501yAcxRejZF+aUlqQoZ+cUltkrRhhZG
        eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnHt35lLZjEWTFtaQtzA+Mt9i5GTg4J
        AROJK3++MXcxcnEICSxllJh6ahcbREJG4uS0BlYIW1jiz7UuNoiiT4wSLxbeBetmEzCU6Hrb
        BdYgIqAgsbn3GStIEbPALkaJd3PmMXUxcnAIC3hLvFuUBFLDIqAq0bDvMFg9r4C9xLTH7VBX
        yEvsP3iWGcTmFHCQePZ7PQtIqxBQTdtXZohyQYmTM5+wgNjMQOXNW2czT2AUmIUkNQtJagEj
        0ypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAUN927OeWHYwrX33UO8TIxMF4iFGCg1lJhDe9
        QSZViDclsbIqtSg/vqg0J7X4EKMp0NkTmaVEk/OB0ZZXEm9oZmBqaGJmaWBqaWasJM7rWdCR
        KCSQnliSmp2aWpBaBNPHxMEp1cC0NlY65ZTX8ibNfZd1d/dLnUltWn/7XunlCRK/E1Y6z13b
        /mnrkq1TwqaYX7QNPKzUW9TDnbW3usj8qkXS3d1y+1MKm4ynPHO28fdcnCwh5fjhaun63iXu
        DWuMuh5599frJ0w6qyFZKZH2eMLpiF83eE5vN/k001lqS6HorUVqTF3pN6Sr67zN43gz3QpP
        20q2feh3zb/ytXXK4+9Vuts/2Xx7mPIz9GWQyKpb72a26h0ve7PmuefNkzecGFxa500RPJxU
        dmeuVQVvfk9BuaVBJG/uYa6404tWnalfF3Te16qhQ+XD+b+Xons1SuL/PWm+b+l66t6sCQtn
        JaVw7Ofdzt6oHbjmaPisbcxXfvcpsRRnJBpqMRcVJwIAEeN5IP4CAAA=
X-CMS-MailID: 20231006100442eucas1p2a51781e74ccd43bbac5c5d0eead6101f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231006100442eucas1p2a51781e74ccd43bbac5c5d0eead6101f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231006100442eucas1p2a51781e74ccd43bbac5c5d0eead6101f
References: <20231006100434.2908243-1-m.szyprowski@samsung.com>
        <CGME20231006100442eucas1p2a51781e74ccd43bbac5c5d0eead6101f@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the needed device-tree compatible string to the MAX77843 extcon
driver, so it can be automatically loaded when compiled as a kernel
module and given device-tree contains separate 'muic' node under the main
MAX77843 PMIC node.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/extcon/extcon-max77843.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index 1bc0426ce3f1..acb11a54f875 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -946,9 +946,16 @@ static const struct platform_device_id max77843_muic_id[] = {
 };
 MODULE_DEVICE_TABLE(platform, max77843_muic_id);
 
+static const struct of_device_id of_max77843_muic_dt_match[] = {
+	{ .compatible = "maxim,max77843-muic", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, of_max77843_muic_dt_match);
+
 static struct platform_driver max77843_muic_driver = {
 	.driver		= {
 		.name		= "max77843-muic",
+		.of_match_table = of_max77843_muic_dt_match,
 	},
 	.probe		= max77843_muic_probe,
 	.remove		= max77843_muic_remove,
-- 
2.34.1

