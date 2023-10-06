Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F16C7BB4B9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjJFKDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjJFKDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:03:37 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873239F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:03:35 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231006100331euoutp028bc936c182d7c3bc38760ad6860704f0~LfIjYeir10621906219euoutp02T
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:03:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231006100331euoutp028bc936c182d7c3bc38760ad6860704f0~LfIjYeir10621906219euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696586611;
        bh=26Lv+is9OakJ4x7WmOArKP1bVEUcRhQ+PNABYJruimA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MNX202t/lPaJW2/nRGgKMAZbdaY2kTNdnJi1snu9xYQ/9qnLqS9brwm1pktJnHeMw
         MdSalX71m+rdbATVhTwkvuj2OvMIMlvIneCOSHgCsPbydr47v7Mp+C3tfV6LXboy+Y
         rimoXwAj8FGfoU3zkDie7ghrN0f0rpkBpcuODB14=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231006100331eucas1p299bd17717fc99cb7d1a396ccabb5bb79~LfIjDikqN2220722207eucas1p2H;
        Fri,  6 Oct 2023 10:03:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 75.D3.42423.37BDF156; Fri,  6
        Oct 2023 11:03:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231006100330eucas1p2c874f582336ed1de4dc1cd759c452ce2~LfIikuRin2220722207eucas1p2G;
        Fri,  6 Oct 2023 10:03:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231006100330eusmtrp10bd268b7432e420a68f9d8518074625c~LfIikKXZb2314123141eusmtrp1c;
        Fri,  6 Oct 2023 10:03:30 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-20-651fdb73496a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 45.10.10549.27BDF156; Fri,  6
        Oct 2023 11:03:30 +0100 (BST)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231006100330eusmtip2f3873f0c5b193a98db11e42c48717521~LfIiMf0Rj0569705697eusmtip2W;
        Fri,  6 Oct 2023 10:03:30 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] Input: max77693-haptic - add device-tree compatible
 strings
Date:   Fri,  6 Oct 2023 12:03:20 +0200
Message-Id: <20231006100320.2908210-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduznOd3i2/KpBv0TxSwOL3rBaLH39VZ2
        i5ufvrFaXN41h81i7ZG77A6sHjtn3WX3uHNtD5tH35ZVjB6fN8kFsERx2aSk5mSWpRbp2yVw
        ZVz+P5Gx4IxAxdLuQ8wNjB18XYycHBICJhI7/1xl7GLk4hASWMEo8fz1FSYI5wujxNsVPawQ
        zmdGiUNnP7HBtMy68BmqZTmjxMRVkxnhWvae28sIUsUmYCjR9bYLrENEwFZix4rpYHOZBaYx
        Six+fZIdJCEsECjx6vMHJhCbRUBV4untH2A2r4C9RFvDQhaIdfIS+w+eZYaIC0qcnPkELM4M
        FG/eOpsZZKiEQCeHxLG191khGlwkpp09DnWrsMSr41vYIWwZidOTe1ggGtoZJRb8vs8E4Uxg
        lGh4fosRospa4s65X0DdHEArNCXW79KHCDtKdBzawAISlhDgk7jxVhDiCD6JSdumM0OEeSU6
        2oQgqtUkZh1fB7f24IVLzBC2h0RDK8g5HMDQipV41cs0gVFhFpLPZiH5bBbCCQsYmVcxiqeW
        FuempxYb5qWW6xUn5haX5qXrJefnbmIEJpTT/45/2sE499VHvUOMTByMhxglOJiVRHjTG2RS
        hXhTEiurUovy44tKc1KLDzFKc7AoifOqpsinCgmkJ5akZqemFqQWwWSZODilGphaFpunmH5O
        eHLszoV1DzsrQzdKhOxbvuu7eYlbspekqHeF2dy1D161Bcw6yrV8QfJR/ZmBAYXfHs80fG6U
        5dx5/H1e/QEn7r2d2cprvhipLw1Ni+Wq9Vb8v90oUF7k/zJu8f5LMdVR5bPEtnNrqCQ73xWM
        +uu35cakx7Y3Jk7okFH9zGFiZ5D1uyFA+1JeXeqHN7Hbn34RUP3fcOui9Xk1Q510HuHYkFl+
        6d0NS4MP1c6JvZMVbP9K7fz3rGfdV6/flNw8+bXX85Bg+/Dt+rv3rrvjw7WoupbP55fXpX3n
        TaY9VpgsuerY+hvs9gsfcMxfOL97bXlW5ct3WsE/GlLttz1ZFrzsIV9CQyTXlHAlluKMREMt
        5qLiRACQMApJlwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVy+t/xe7pFt+VTDd52m1ocXvSC0WLv663s
        Fjc/fWO1uLxrDpvF2iN32R1YPXbOusvucefaHjaPvi2rGD0+b5ILYInSsynKLy1JVcjILy6x
        VYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7j8fyJjwRmBiqXdh5gbGDv4
        uhg5OSQETCRmXfjM2MXIxSEksJRRYt/lJcwQCRmJk9MaWCFsYYk/17rYIIo+MUrcPzCbHSTB
        JmAo0fUWJMHJISJgL3H4zRoWkCJmgWmMEnNX/GMCSQgL+EusfzyfEcRmEVCVeHr7B1icF6ih
        rWEhC8QGeYn9B88yQ8QFJU7OfAIWZwaKN2+dzTyBkW8WktQsJKkFjEyrGEVSS4tz03OLDfWK
        E3OLS/PS9ZLzczcxAgN527Gfm3cwznv1Ue8QIxMH4yFGCQ5mJRHe9AaZVCHelMTKqtSi/Pii
        0pzU4kOMpkD3TWSWEk3OB8ZSXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFM
        HxMHp1QDk9vu0tzi3q9nDU5c2tmu2zMvkDvpaXKbfrRe+bOyu5/u8M7iePn11BKGN0oci44o
        GTrwmvffF7m6z6a5x/rIihdVYik53GJPjvTvuH51ltm9z7VZzFZWCjuMTyv87WHhX/Z5wpWI
        /z9fF8kHZmqVXUlNc+5yXro0nstBJeJAvKFtfu9U2e1pfx+x3Crs76ictTBU0k5Kw8Oh1Ub+
        m9adrLnLomp/tbtfuV/3wmUtpyuz5TZvrwCvCkPP86zzZ6yTb+Y4+t/Oak/Tr5A8WdNj2ctl
        XtsEFFXM0UoqOysn7KjT4d3vrCn3ZG70jgufA1fP/npZwOvHq/lT513fbPZQO6duz9YfPlX7
        2FlmROUosRRnJBpqMRcVJwIAIFBl5O0CAAA=
X-CMS-MailID: 20231006100330eucas1p2c874f582336ed1de4dc1cd759c452ce2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231006100330eucas1p2c874f582336ed1de4dc1cd759c452ce2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231006100330eucas1p2c874f582336ed1de4dc1cd759c452ce2
References: <CGME20231006100330eucas1p2c874f582336ed1de4dc1cd759c452ce2@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the needed device-tree compatible strings to the MAX77693 haptic
driver, so it can be automatically loaded when compiled as a kernel
module and given device-tree contains separate (i.e. 'motor-driver') node
under the main PMIC node. When device is instantiated from device-tree,
the driver data cannot be read via platform_get_device_id(), so get
device type from the parent MFD device instead, what works for both
cases.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/input/misc/max77693-haptic.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 80f4416ffe2f..0e646f1b257b 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -307,7 +307,7 @@ static int max77693_haptic_probe(struct platform_device *pdev)
 	haptic->suspend_state = false;
 
 	/* Variant-specific init */
-	haptic->dev_type = platform_get_device_id(pdev)->driver_data;
+	haptic->dev_type = max77693->type;
 	switch (haptic->dev_type) {
 	case TYPE_MAX77693:
 		haptic->regmap_haptic = max77693->regmap_haptic;
@@ -406,16 +406,24 @@ static DEFINE_SIMPLE_DEV_PM_OPS(max77693_haptic_pm_ops,
 				max77693_haptic_resume);
 
 static const struct platform_device_id max77693_haptic_id[] = {
-	{ "max77693-haptic", TYPE_MAX77693 },
-	{ "max77843-haptic", TYPE_MAX77843 },
+	{ "max77693-haptic", },
+	{ "max77843-haptic", },
 	{},
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
 		.pm	= pm_sleep_ptr(&max77693_haptic_pm_ops),
+		.of_match_table = of_max77693_haptic_dt_match,
 	},
 	.probe		= max77693_haptic_probe,
 	.id_table	= max77693_haptic_id,
-- 
2.34.1

