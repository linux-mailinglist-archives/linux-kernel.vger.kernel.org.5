Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63657BA31D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjJEPv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjJEPu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:50:57 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2405C61AA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:21:12 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231005104339euoutp021ae2c98d298b15fb81c675fcf55f7325~LMCTxpBmw1423214232euoutp029
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:43:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231005104339euoutp021ae2c98d298b15fb81c675fcf55f7325~LMCTxpBmw1423214232euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696502619;
        bh=nvSmLyOZjKFnQBujJEdDEwOW1UtEfOPirawuT+66nv4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=A4QzKonKDJZzckNIll//BIBWaK86cZHmSPIUIo8uC2Yd+1NR4isimL9aNd2PNTkR4
         4uXayVa31n4nPD195XvzzmVFEOMw7bHPF0w8q9ehDaF6tUjDMi3gTkTT1LFPlU2nwh
         YBeQIxUe7caVO2A05q8fjhGwi69W6U0UozpOs8vw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231005104339eucas1p1797d91f45a471e3c9065f03027fe78c1~LMCTjJEQD0347503475eucas1p1B;
        Thu,  5 Oct 2023 10:43:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 64.41.37758.B539E156; Thu,  5
        Oct 2023 11:43:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231005104339eucas1p17e2b8f2886bbd529c207e68e8de18b01~LMCTEUtSn1444214442eucas1p1n;
        Thu,  5 Oct 2023 10:43:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231005104339eusmtrp2e9490269826a1e9b8401bf2ab91abced~LMCTDzJ2a1952219522eusmtrp27;
        Thu,  5 Oct 2023 10:43:39 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-a7-651e935bd109
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2B.EE.25043.B539E156; Thu,  5
        Oct 2023 11:43:39 +0100 (BST)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231005104338eusmtip11ce947ed9ee180be70a0e549be447e49~LMCSuLWuH1257912579eusmtip1X;
        Thu,  5 Oct 2023 10:43:38 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 1/2] extcon: max77693: add device-tree compatible string
Date:   Thu,  5 Oct 2023 12:43:25 +0200
Message-Id: <20231005104327.981101-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djPc7rRk+VSDXbvUrC4/uU5q8Xe11vZ
        LS7vmsNmsfbIXXaL240r2BxYPe5c28Pm0bdlFaPH501yAcxRXDYpqTmZZalF+nYJXBmX7kxg
        LWjjqlh1ZhVLA+N2ji5GTg4JAROJiU86GLsYuTiEBFYwSky+tZoVwvnCKPGofz8ThPOZUeL9
        +QNMMC0Tzl5hgUgsZ5S4cHU7Qsv5M7fYQKrYBAwlut52gdkiAgoSm3ufgRUxC+xglLg55TzY
        KGEBD4lrpx+zg9gsAqoS3/bOBiri4OAVsJN4/0saYpu8xP6DZ5lBbF4BQYmTM5+wgNjMQPHm
        rbOZQWZKCHRySJz8tpoFosFF4su7k+wQtrDEq+NboGwZif875zNBNLQzSiz4fR/KmcAo0fD8
        FiNElbXEnXO/2ECuYBbQlFi/Sx/ElBBwlGicpQJh8knceCsIcQOfxKRt05khwrwSHW1CEDPU
        JGYdXwe39eCFS8wQtofEy9M/wa4UEoiVOLi2hXkCo8IsJJ/NQvLZLIQTFjAyr2IUTy0tzk1P
        LTbOSy3XK07MLS7NS9dLzs/dxAhMIqf/Hf+6g3HFq496hxiZOBgPMUpwMCuJ8KY3yKQK8aYk
        VlalFuXHF5XmpBYfYpTmYFES59W2PZksJJCeWJKanZpakFoEk2Xi4JRqYHJ8su9czItp94SF
        tSWjLzY8zlrBaBp5i7Nmbk3UAq9PN/UjVvyt3P1lZZmbOd+a9P7IrKXnPj1y/Lp2K8v8RzLX
        Aw7yZj/JONlm+E3etZXpgfmPt/Ivs42XXTnlZ7X+pqSCTHJKW+r/Isu9p5c5+en3Vfi+d7q4
        O/jUxaDFzt8E2sNfBsr9eNqlw733Mstj1oWbozWFV91Uerwnm6lI6855lguBmq5ppp+myBlJ
        Z/YXBd6YPnd28AxPr0uty9vC10tMb5FVC+5bp7cxVbv1weRL+p++MWrw9t378vvbt3We0w9O
        /nyJ67+cgvnc0s1R1QviTq2fVunbG1DcsJrlc2q7kz3npJeTf+yP+8/ebKTEUpyRaKjFXFSc
        CAB3YpFAkQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsVy+t/xu7rRk+VSDW5sZ7a4/uU5q8Xe11vZ
        LS7vmsNmsfbIXXaL240r2BxYPe5c28Pm0bdlFaPH501yAcxRejZF+aUlqQoZ+cUltkrRhhZG
        eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmX7kxgLWjjqlh1ZhVLA+N2ji5GTg4J
        AROJCWevsHQxcnEICSxllFhzq48NIiEjcXJaAyuELSzx51oXG0TRJ0aJ338nMYMk2AQMJbre
        doE1iAgoSGzufcYKUsQssItR4t2ceUwgCWEBD4lrpx+zg9gsAqoS3/bOBiri4OAVsJN4/0sa
        YoG8xP6DZ8Fm8goISpyc+YQFxGYGijdvnc08gZFvFpLULCSpBYxMqxhFUkuLc9Nzi430ihNz
        i0vz0vWS83M3MQKDd9uxn1t2MK589VHvECMTB+MhRgkOZiUR3vQGmVQh3pTEyqrUovz4otKc
        1OJDjKZA501klhJNzgfGT15JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8T
        B6dUA5PX1zkek92mXMtwCjj2xTLC5UJM+4f3PYevdAj73HtTJiI2yySo5h3njYAja/8e6Cld
        ZLRbzlQgOmP3vAk6WudWvYusdrv6VoFZeVqr7FX2G9curfF6lfvyYPDPD77fNdLPcdj+C7j/
        qMTQnXOdtt3bn7arZ8h8slnK0O6hVtEjxrisg/+MdLylqZjWZ1UD8XZTed+EOxsUWr4Z3to8
        J+pjJ7vHj+j9mz62Pjv0Qq76QxPfCu9qRybNoCvSEmc6Q3wzn3E263UVLDmwIjbC/klD0D3h
        l3+bTKWCjnvF3nqxWtd2xi/Xb+aFLy0TdOdf02uv+S2+7lbdbbllh1a5y63rnFQolJm1c8FZ
        kQenPiixFGckGmoxFxUnAgD5ZBvV5wIAAA==
X-CMS-MailID: 20231005104339eucas1p17e2b8f2886bbd529c207e68e8de18b01
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231005104339eucas1p17e2b8f2886bbd529c207e68e8de18b01
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231005104339eucas1p17e2b8f2886bbd529c207e68e8de18b01
References: <CGME20231005104339eucas1p17e2b8f2886bbd529c207e68e8de18b01@eucas1p1.samsung.com>
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
 drivers/extcon/extcon-max77693.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index 1f1d9ab0c5c7..5fb9c413a23b 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -1258,6 +1258,12 @@ static int max77693_muic_probe(struct platform_device *pdev)
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
-- 
2.34.1

