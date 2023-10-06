Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61B17BB872
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjJFNB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjJFNBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:01:18 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3B0193
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:00:54 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231006130045euoutp02b44087402b5f8afd881b86d4880bff31~LhjTE6mFe0813008130euoutp02I
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:00:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231006130045euoutp02b44087402b5f8afd881b86d4880bff31~LhjTE6mFe0813008130euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696597245;
        bh=TR7Kzoq1U4uZ7ZoVNJnoUetQhJy9xOmLtt/Kna2DQZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RmUFf4Ke9fhAU4cZ08q3nrPYhg9tw50NwVxJNPFlSPbRCdFLaS2Dq7K8FRSW5CuYS
         9c9i57dHl28N2u0HeFHveM+85JAVFBxw/v64GFLwOfv8SDRiDaySsbOt+FQ1Tw80MI
         93ub3gsSLwDDaRjYRuB2IKVBjaaIKGlVSyQgWAYA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231006130045eucas1p2d432252966f402c4a9ea724a6c0e41e3~LhjStiLqH3165331653eucas1p2s;
        Fri,  6 Oct 2023 13:00:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E4.5A.42423.DF400256; Fri,  6
        Oct 2023 14:00:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231006130044eucas1p17a141ec5aafca3d5af5295049f8b1651~LhjSMgmPy3093330933eucas1p1l;
        Fri,  6 Oct 2023 13:00:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231006130044eusmtrp2974082dca1420afebcc023c76ab2c0ce~LhjSL521h0256802568eusmtrp2-;
        Fri,  6 Oct 2023 13:00:44 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-5c-652004fd144b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D4.2E.10549.CF400256; Fri,  6
        Oct 2023 14:00:44 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231006130043eusmtip29ae9abc412499762caada0cec5375ced~LhjQ-XyNw0538005380eusmtip2V;
        Fri,  6 Oct 2023 13:00:43 +0000 (GMT)
From:   Mateusz Majewski <m.majewski2@samsung.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mateusz Majewski <m.majewski2@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 4/4] pinctrl: samsung: do not offset pinctrl numberspaces
Date:   Fri,  6 Oct 2023 14:55:57 +0200
Message-ID: <20231006125557.212681-5-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231006125557.212681-1-m.majewski2@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7p/WRRSDRZcELd4MG8bm8Xe11vZ
        Lab8Wc5ksenxNVaLzfP/MFpc3jWHzWLG+X1MFhOPTWa2WHvkLrvF4TftrBardv1hdOD22Dnr
        LrvHnWt72Dw2L6n36NuyitHj8ya5ANYoLpuU1JzMstQifbsErozOO3UFPYoVJx59ZmxgfCTd
        xcjJISFgIvHm3gNGEFtIYAWjxOnJkl2MXED2F0aJiQdWMkI4nxkl5vxtZoTp2LHjBhtEYjmj
        xK6PF5khnFYmidfvlrGAVLEJGEg8eLOMHSQhItDOKNFz6xbYLGaBfUwSkzdeZAWpEhbwlJjy
        exJQgoODRUBV4tLfWpAwr4CtxOnt35kh1slL7Fn0nQnE5hSwk2h6/p0FokZQ4uTMJ2A2M1BN
        89bZYFdICFzhkHiz7Q5Us4vExa4zbBC2sMSr41vYIWwZif875zNB2PkSMza/ZwG5QUKgQuLu
        QS8I01ri4xlmEJNZQFNi/S59iGJHif+br7FBVPBJ3HgrCHEAn8SkbdOZIcK8Eh1tQhDVqhLH
        90yCOkVa4knLbSaIEg+JOfe8JjAqzkLyySwkn8xCWLuAkXkVo3hqaXFuemqxYV5quV5xYm5x
        aV66XnJ+7iZGYCI6/e/4px2Mc1991DvEyMTBeIhRgoNZSYQ3vUEmVYg3JbGyKrUoP76oNCe1
        +BCjNAeLkjivaop8qpBAemJJanZqakFqEUyWiYNTqoFJvar80orL63x4X/x0bHQwEwmQ2RYz
        e6tK3Kc5Xpktrw4de3yiNKGk54OUJFfoIf7CBXJdZgH/Z63XfCHI63t/Yt+x/+GNurPzzrDJ
        3HFb6LrQd7mWPmfr9r4NInF+UR0Kll0MPc/38L9gOeLteWqGKUPj8sede1vvaIRmmgfUqxw8
        uvPLLNZjUZwh13bkWja9PKPrLubyytvz2Pyc93lFqvGrpy1QsPH5eNdh+Z27x2ZHN4h+z+9+
        8G9PJOu31+4ybOtWdlq29s7evNvMa/bp9vru3yYnpl0q613n/e7om5USNmlhv2sMMt3Lw+XK
        269k2grMrBCR8ZfLLXQoFN2m/Pbrzc7aRc/qtaOPRiuxFGckGmoxFxUnAgCWXhk/swMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsVy+t/xe7p/WBRSDTZeMLJ4MG8bm8Xe11vZ
        Lab8Wc5ksenxNVaLzfP/MFpc3jWHzWLG+X1MFhOPTWa2WHvkLrvF4TftrBardv1hdOD22Dnr
        LrvHnWt72Dw2L6n36NuyitHj8ya5ANYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2Pz
        WCsjUyV9O5uU1JzMstQifbsEvYzOO3UFPYoVJx59ZmxgfCTdxcjJISFgIrFjxw02EFtIYCmj
        xIMN5hBxaYnDX6awQ9jCEn+udQHVcAHVNDNJrF53gwkkwSZgIPHgzTKwIhGBbkaJbxO5QIqY
        BQ4wSSyZdRBsqrCAp8SU35MYuxg5OFgEVCUu/a0FCfMK2Eqc3v6dGWKBvMSeRd/BZnIK2Ek0
        Pf/OAnGQrcShHXuYIOoFJU7OfAIWZwaqb946m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+oV
        J+YWl+al6yXn525iBMbNtmM/N+9gnPfqo94hRiYOxkOMEhzMSiK86Q0yqUK8KYmVValF+fFF
        pTmpxYcYTYHOnsgsJZqcD4zcvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKY
        PiYOTqkGJiahbxaLe7h2CT7S52lf1/TogMOXdxr2J/pemp+PNGbSL+F7P/H/bQO3Iu2U01Ys
        si0Ct9KjKwx91HfMaGCcv9+jZMfiE888l1/6JX+g9NF7tcc+H04t1csOlF9z23KdzZ8nQT1L
        Pya9T/0fdru8rjm7uyPu/avqNlv/+W6tt7wK/gedPHPqWXqTj/3LJS29Xf6Mmcf+2r00rnd4
        oe/0+6ZvZMqi+cVPv2/XCg7efGnbhv1lVmaWfcVxqQt6z0+XLWPqFnWY/uKyVEBz+46IA0tY
        uTzUri0uXD3lqO7/fdPbSq/va2GsnuPvc6j1JsPxjSdzGiu228xj7mG4z66/TjnkldCTOKWl
        gVIbWyvvK7EUZyQaajEXFScCADMqoCUkAwAA
X-CMS-MailID: 20231006130044eucas1p17a141ec5aafca3d5af5295049f8b1651
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231006130044eucas1p17a141ec5aafca3d5af5295049f8b1651
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231006130044eucas1p17a141ec5aafca3d5af5295049f8b1651
References: <20231006125557.212681-1-m.majewski2@samsung.com>
        <CGME20231006130044eucas1p17a141ec5aafca3d5af5295049f8b1651@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Past versions of this driver have manually calculated base values for
both the pinctrl numberspace and the global GPIO numberspace, giving
both the same values. This was necessary for the global GPIO
numberspace, since its values need to be unique system-wide. However, it
was not necessary for the pinctrl numberspace, since its values only
need to be unique for a single instance of the pinctrl device. It was
just convenient to use the same values for both spaces.

Right now those calculations are only used for the pinctrl numberspace,
since GPIO numberspace bases are selected by the GPIO subsystem.
Therefore, those calculations are unnecessary.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 15 ++++-----------
 drivers/pinctrl/samsung/pinctrl-samsung.h |  2 --
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 952aeeebb679..79babbb39ced 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -45,8 +45,6 @@ static struct pin_config {
 	{ "samsung,pin-val", PINCFG_TYPE_DAT },
 };
 
-static unsigned int pin_base;
-
 static int samsung_get_group_count(struct pinctrl_dev *pctldev)
 {
 	struct samsung_pinctrl_drv_data *pmx = pinctrl_dev_get_drvdata(pctldev);
@@ -389,8 +387,7 @@ static void samsung_pinmux_setup(struct pinctrl_dev *pctldev, unsigned selector,
 	func = &drvdata->pmx_functions[selector];
 	grp = &drvdata->pin_groups[group];
 
-	pin_to_reg_bank(drvdata, grp->pins[0] - drvdata->pin_base,
-			&reg, &pin_offset, &bank);
+	pin_to_reg_bank(drvdata, grp->pins[0], &reg, &pin_offset, &bank);
 	type = bank->type;
 	mask = (1 << type->fld_width[PINCFG_TYPE_FUNC]) - 1;
 	shift = pin_offset * type->fld_width[PINCFG_TYPE_FUNC];
@@ -441,8 +438,7 @@ static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
 	unsigned long flags;
 
 	drvdata = pinctrl_dev_get_drvdata(pctldev);
-	pin_to_reg_bank(drvdata, pin - drvdata->pin_base, &reg_base,
-					&pin_offset, &bank);
+	pin_to_reg_bank(drvdata, pin, &reg_base, &pin_offset, &bank);
 	type = bank->type;
 
 	if (cfg_type >= PINCFG_TYPE_NUM || !type->fld_width[cfg_type])
@@ -671,7 +667,7 @@ static int samsung_add_pin_ranges(struct gpio_chip *gc)
 
 	bank->grange.name = bank->name;
 	bank->grange.id = bank->id;
-	bank->grange.pin_base = bank->drvdata->pin_base + bank->pin_base;
+	bank->grange.pin_base = bank->pin_base;
 	bank->grange.base = gc->base;
 	bank->grange.npins = bank->nr_pins;
 	bank->grange.gc = &bank->gpio_chip;
@@ -891,7 +887,7 @@ static int samsung_pinctrl_register(struct platform_device *pdev,
 
 	/* dynamically populate the pin number and pin name for pindesc */
 	for (pin = 0, pdesc = pindesc; pin < ctrldesc->npins; pin++, pdesc++)
-		pdesc->number = pin + drvdata->pin_base;
+		pdesc->number = pin;
 
 	/*
 	 * allocate space for storing the dynamically generated names for all
@@ -1129,9 +1125,6 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 
 	samsung_banks_node_get(&pdev->dev, d);
 
-	d->pin_base = pin_base;
-	pin_base += d->nr_pins;
-
 	return ctrl;
 }
 
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 173db20f70d3..9b3db50adef3 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -269,7 +269,6 @@ struct samsung_pin_ctrl {
  * @nr_groups: number of such pin groups.
  * @pmx_functions: list of pin functions available to the driver.
  * @nr_function: number of such pin functions.
- * @pin_base: starting system wide pin number.
  * @nr_pins: number of pins supported by the controller.
  * @retention_ctrl: retention control runtime data.
  * @suspend: platform specific suspend callback, executed during pin controller
@@ -293,7 +292,6 @@ struct samsung_pinctrl_drv_data {
 
 	struct samsung_pin_bank		*pin_banks;
 	unsigned int			nr_banks;
-	unsigned int			pin_base;
 	unsigned int			nr_pins;
 
 	struct samsung_retention_ctrl	*retention_ctrl;
-- 
2.42.0

