Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB417BA11E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbjJEOr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238678AbjJEOns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:43:48 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E285FD0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:21:12 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231005104340euoutp023f1a4987ce326703d26c55dfeaeb8138~LMCUEAldD1583815838euoutp02E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:43:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231005104340euoutp023f1a4987ce326703d26c55dfeaeb8138~LMCUEAldD1583815838euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696502620;
        bh=8wEAKXOwQhYmIssQzSnkvAgvOVQgNm4lz48XDZ7ufcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uKiHUcHpCSgchxQ6HOeWjDidotaEAdTeCHsz7e52stdoI8VnYbuu0EBrheN0Si9Y7
         2ORvTh/opflBjHyWf4+qf5sS2gnM9GUpc+ZZoRmZcF7mFa6n6VQXgQopkduS2/6RZs
         pWMguiR66CE4ehF/odZlMGLI5nop5vBG2c34+yr0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231005104339eucas1p108080269626f3ee3056114cbe12a947c~LMCTxjoTC1459814598eucas1p1d;
        Thu,  5 Oct 2023 10:43:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 68.87.42423.B539E156; Thu,  5
        Oct 2023 11:43:39 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231005104339eucas1p147e85630eec0ec4b476a21ed2cd3650d~LMCTen-hd0765607656eucas1p16;
        Thu,  5 Oct 2023 10:43:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231005104339eusmtrp1e8f0a0291bf2ee5a86b479b6869e51ee~LMCTdAg5V2008320083eusmtrp1l;
        Thu,  5 Oct 2023 10:43:39 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-f8-651e935b49cb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B7.12.10549.B539E156; Thu,  5
        Oct 2023 11:43:39 +0100 (BST)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231005104339eusmtip150522e1f70365d612ed92e9819dc1ba4~LMCTDLvTu1355713557eusmtip1K;
        Thu,  5 Oct 2023 10:43:39 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 2/2] extcon: max77843: add device-tree compatible string
Date:   Thu,  5 Oct 2023 12:43:26 +0200
Message-Id: <20231005104327.981101-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005104327.981101-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWy7djP87rRk+VSDd49N7C4/uU5q8Xe11vZ
        LS7vmsNmsfbIXXaL240r2BxYPe5c28Pm0bdlFaPH501yAcxRXDYpqTmZZalF+nYJXBmvppgX
        TOGoWLM9t4HxC1sXIyeHhICJxOV/j9m7GLk4hARWMEqsu7uXFcL5wihx/+EkqMxnRokt/34y
        djFygLXcWKIOEV/OKLGmfQsLXMePKX+YQeayCRhKdL3tAtshIqAgsbn3GdhYZoEdjBI3p5xn
        AkkIC3hI7Jk3GayBRUBVYsehLWBxXgE7ic3/XzFCHCgvsf/gWWaQzZwC9hLbtwZDlAhKnJz5
        hAXEZgYqad46mxmifC6HRG87L8ShLhIfv1RBhIUlXh3fwg5hy0icntwDdrOEQDujxILf95kg
        nAmMEg3Pb0HttZa4c+4XG8ggZgFNifW79CHCjhL3/m9lgpjPJ3HjrSDECXwSk7ZNZ4YI80p0
        tAlBVKtJzDq+Dm7twQuXoEo8JNYtZ5/AqDgLyS+zkPwyC2HtAkbmVYziqaXFuempxYZ5qeV6
        xYm5xaV56XrJ+bmbGIGp4/S/4592MM599VHvECMTB+MhRgkOZiUR3vQGmVQh3pTEyqrUovz4
        otKc1OJDjNIcLErivNq2J5OFBNITS1KzU1MLUotgskwcnFINTPJb12VwtO7JMvUQ71M5XCd6
        JVwi/kbJknePny07/j7l355D/U8DPmWamvh+uholsPSVxUvWF74GLadtwyxnd3Q0361MN1cx
        3tN1bfby3Eu8RxPKbvZblfAaM/59zHVhnuil2ROvC5++1fhgZ7ucw+2/Z1sYJxvqx1bayU7R
        UeBfKsUqoVTJrVG26VhBplS26RU158kH1A+VbUjbJ69qwdf9KOXd/RyrXRLfvzW+21ra/9P7
        72uXiwdnyhqKevrf7VD82nw9g7+pPCQsaQF7VenZbaWbvT42x/0pPME25f+stf5+d3Zr5Ck5
        LPk9+ffDZ3MaWCz/6OruO71zG1N/0nG7pzKt666/NZ39l/9LtRJLcUaioRZzUXEiAGeR1VmM
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t/xu7rRk+VSDbqapC2uf3nOarH39VZ2
        i8u75rBZrD1yl93iduMKNgdWjzvX9rB59G1ZxejxeZNcAHOUnk1RfmlJqkJGfnGJrVK0oYWR
        nqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsarKeYFUzgq1mzPbWD8wtbFyMEhIWAi
        cWOJehcjF4eQwFJGiZlXTrB3MXICxWUkTk5rYIWwhSX+XOtigyj6xCixYNkcFpAEm4ChRNdb
        kAQnh4iAgsTm3mesIEXMArsYJd7NmccEkhAW8JDYM28yM4jNIqAqsePQFrA4r4CdxOb/rxgh
        NshL7D94lhnkIk4Be4ntW4NBwkJAJW9bW6DKBSVOznwCtpcZqLx562zmCYwCs5CkZiFJLWBk
        WsUoklpanJueW2yoV5yYW1yal66XnJ+7iREY5tuO/dy8g3Heq496hxiZOBgPMUpwMCuJ8KY3
        yKQK8aYkVlalFuXHF5XmpBYfYjQFOnsis5Rocj4w0vJK4g3NDEwNTcwsDUwtzYyVxHk9CzoS
        hQTSE0tSs1NTC1KLYPqYODilGpg6fZ/N+3vWqDedaYf4giPiN5c5VF8UPJ3moNTwZ3nMpAb7
        iVu0djyRn5eUFOKzXuk02+mngRsm/G677Jd3chOb4i/DSw1e/RwHN75k2rVI6M0kN6XoQ1/j
        ZHg6hcQLowXFOiO+NJ9UPsf45/7sKrmV0zy7dHbua157/NyBtCWPfRTdzv5c2hftHFo9Q6Zo
        3nWRzVtO1xgIbdoYq+aj4TojyM4xgv3V+efRr+7E2Cmd9eM2kp+V5FL5YbbunifKC9nFrK8o
        WhUcqP+1ZZrnm1PCr9tUp12N7dgukreuJXEH0ySX2vzid7dduFc/NOxeW6Hz9J5VSN/ViYUV
        NpGv5Nkf6881fmhRsP9eyQFO7RglluKMREMt5qLiRACzBBb0/AIAAA==
X-CMS-MailID: 20231005104339eucas1p147e85630eec0ec4b476a21ed2cd3650d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231005104339eucas1p147e85630eec0ec4b476a21ed2cd3650d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231005104339eucas1p147e85630eec0ec4b476a21ed2cd3650d
References: <20231005104327.981101-1-m.szyprowski@samsung.com>
        <CGME20231005104339eucas1p147e85630eec0ec4b476a21ed2cd3650d@eucas1p1.samsung.com>
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

Add the needed device-tree compatible string to the MAX77843 extcon
driver, so it can be automatically loaded when compiled as a kernel
module and given device-tree contains separate 'muic' node under the main
MAX77843 PMIC node.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/extcon/extcon-max77843.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index 1bc0426ce3f1..e04ebdda886a 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -946,6 +946,12 @@ static const struct platform_device_id max77843_muic_id[] = {
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
-- 
2.34.1

