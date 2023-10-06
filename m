Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0ED7BB4BD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjJFKEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjJFKEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:04:45 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D90FD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:04:43 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231006100442euoutp021a7e2483c9dc2fe83c8f10b321980f10~LfJlPekKv0875308753euoutp02R
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:04:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231006100442euoutp021a7e2483c9dc2fe83c8f10b321980f10~LfJlPekKv0875308753euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696586682;
        bh=4W5tFkuucJCypa0L7HcUy55hL2J5Gro3wnBCsUs/EI0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=SomvssLtXcs4Ml7sGmKyFDQZ9y6FuOHKG1OmSFqtYMnxRZBmgtAuXkvKzLuPISlJw
         YuEAFsvNLgNJRruNeNa3EGif1zhstO97upiB/fiG1qRmKnn3Cfed4AUeaDzwNOftvj
         QjCtU3G0aiceLToEVLhWL+ynSEnbV6jUOSMTSis0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231006100442eucas1p197f84e055b7299d728d6a26342dcc6ac~LfJlAmQem1497814978eucas1p1D;
        Fri,  6 Oct 2023 10:04:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 92.14.42423.ABBDF156; Fri,  6
        Oct 2023 11:04:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231006100441eucas1p1642aee6baa9713864274aa254f4b5116~LfJksjNqy2534125341eucas1p1H;
        Fri,  6 Oct 2023 10:04:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231006100441eusmtrp2908adc16bc04b7e433845ab4d4728f8e~LfJkr_cgf3224832248eusmtrp2i;
        Fri,  6 Oct 2023 10:04:41 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-16-651fdbba5f17
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 35.1D.25043.9BBDF156; Fri,  6
        Oct 2023 11:04:41 +0100 (BST)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231006100441eusmtip298471e42ee4c8642c8f322b94a4a6213~LfJkSsOhK1124111241eusmtip21;
        Fri,  6 Oct 2023 10:04:41 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v2 1/2] extcon: max77693: add device-tree compatible string
Date:   Fri,  6 Oct 2023 12:04:33 +0200
Message-Id: <20231006100434.2908243-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRj1d+/dvFtMrlfTHyZOTCOjtJHhwNCyskF/FEEIgtXI6zXapm6Z
        NRFn0sPZYg0fuMyUlppl1nLSfFSTctlSK9F8TcseK8VeipRG5nbV/O985zuHcz74cJScx/zw
        Y7ITlFwmlgSxuVhj+++uTU1DfGpzr44nfDPtYAlbJ0zuwp6mMraw7ondXTiUW8PezhIN97Ww
        RZcaaoFoyhiwH03gbkuiJMdOUvLw6CPclPqBLyDtI/fUnzo9qgJnOGrAwSERAX+ce8VSAy5O
        EjUAVhXrATNMA9ibewZjhikAG62fWUuWubtTKLOoBtBu68CWLeZeG3Cq2IQAqifVbCf2JgLh
        fc0nVwhKPABwoLAbUQMc9yL2wt/2RKcGI0Jg8W074sQ8IgaWXa9CmTQ+fGTpRBneE3aUfsCc
        GF3g80xXXC0gkYtDfacKMIZd8GlDF8JgLzhubXBnsD+cN19DGMN5ACvmRhcHLYAqx+CiOwoO
        d82yne1QIhTWN4Uz9A5ovnnRVRoSHrB/0pMp4QF1jSUoQ/PghXMko14H9dY7y7GWl68XbxHB
        /huTLp4kEuGd8mpMCwL1K07TrzhN/79DBUBrgS+VoZDSlEIgozLDFGKpIkNGhx1NlRrBwo/Y
        /lp/PgBXx3+EtQEEB20A4miQN49W+VMkL0l8WknJUw/LMySUog2swbEgX15IEp8iCVp8gjpO
        UWmUfGmL4Bw/FVK0S353RGc7FdDFOz5E2nduKQiOmziU0LfmecWryusaovbFi+h8tfaert9m
        5c/ocudrY1Nm/Av5P2M3GtIl0mBPJaUZNXc/Mwy7RUrr6ot4a997I9/K+VmruAqBj9BY1edj
        jr/cMqZpdyus/PDe5Baq0o+15h00ZOf8BT0GRxRyRBk6W7QtUuanBTQ9+kkwPbyP1hjn4kUG
        1CrwImjL1sDSgSxl242aeN/L31Pf8aMivj2UjDd9J7MPkOmc/K/5vfeSPTwymy3vmtePlL7N
        KQkwGp4FFzTfMj12JLcLY/ssmrNe1dK8gT3W9LjVIT27T6/mZHKirb6Dg79igjBFiliwAZUr
        xP8ArL2emZIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsVy+t/xe7o7b8unGvyYYW5x/ctzVou9r7ey
        W1zeNYfNYu2Ru+wWtxtXsDmwety5tofNo2/LKkaPz5vkApij9GyK8ktLUhUy8otLbJWiDS2M
        9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLW33zJWPCUq+LP2lnMDYxNnF2MnBwS
        AiYSvzd8Zu5i5OIQEljKKPFl5U0miISMxMlpDawQtrDEn2tdbBBFnxglDr7dBpZgEzCU6HoL
        kuDkEBFQkNjc+4wVpIhZYBejxLs584AmcXAIC3hL/LwbC1LDIqAqMW3NXbAFvAL2EnMWL2OG
        WCAvsf/gWWaIuKDEyZlPWEBsZqB489bZzBMY+WYhSc1CklrAyLSKUSS1tDg3PbfYSK84Mbe4
        NC9dLzk/dxMjMHi3Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuFNb5BJFeJNSaysSi3Kjy8qzUkt
        PsRoCnTfRGYp0eR8YPzklcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFw
        SjUwmXa/TDnZYmk9hWGx4bb7lzdktHZaLitPkCkoqJzy5DZr3zIrdnVX0alZXqnRWX+i9b58
        EuibqHff2MpprrNiZeOW4LwIxS9Kc8wWdwWfXfXU46vG1YhlZufYr7zrbf2lnsqjrr7TsdnP
        WHgSx5y2pb16FvYxX44dSnooz3CtcZfL/M9ST064lpcWSGVLsNvduPgl/Zi0r8/Xyzzs7k+V
        rIon2Bszer3kYlxbeybhjua2ik8e8ceDRM0cDD20FT+b1DhcZ+zMrNMSruyXK73C8vDUi9yT
        xnvEL75bYt6k8u4m050WDZkLh3grrvExr/kgqvJFxXGX0K13rQdPMPbnqheuOejp0JAnb9Tx
        RomlOCPRUIu5qDgRANpY2nDnAgAA
X-CMS-MailID: 20231006100441eucas1p1642aee6baa9713864274aa254f4b5116
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231006100441eucas1p1642aee6baa9713864274aa254f4b5116
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231006100441eucas1p1642aee6baa9713864274aa254f4b5116
References: <CGME20231006100441eucas1p1642aee6baa9713864274aa254f4b5116@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 57f706bf7307 ("ARM: dts: samsung: exynos4412-midas: add USB
connector and USB OTG") added a 'muic' node to the MAX77693 PMIC
definition in various device-tree files. Since that commit, the newly
created MFD cell gained its own of_node and compatible string. This
changed its modalias, what in turn broke automated loading of the driver
module, because the new modalias is based on the of_node compatible
string, not the platform device name.

Fix this by adding the needed device-tree compatible string.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/extcon/extcon-max77693.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index 1f1d9ab0c5c7..2c567e0b7b7f 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -1258,9 +1258,16 @@ static int max77693_muic_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct of_device_id of_max77693_muic_dt_match[] = {
+	{ .compatible = "maxim,max77693-muic", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, of_max77693_muic_dt_match);
+
 static struct platform_driver max77693_muic_driver = {
 	.driver		= {
 		.name	= DEV_NAME,
+		.of_match_table = of_max77693_muic_dt_match,
 	},
 	.probe		= max77693_muic_probe,
 };
-- 
2.34.1

