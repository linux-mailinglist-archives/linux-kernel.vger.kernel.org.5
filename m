Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981A37DCA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbjJaJvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbjJaJvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:51:06 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EC913A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:50:36 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231031095022epoutp04faae0d66afaad6d2e76fd604302126b6~TKFNIRZXG2670826708epoutp04E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:50:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231031095022epoutp04faae0d66afaad6d2e76fd604302126b6~TKFNIRZXG2670826708epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698745822;
        bh=6n830WDpB+iIolAE1HEdsY7euSl3MkOP6oEwPsip6Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkEA0gxP6oU+BIclEXyqVPVExfhqDGZ41za5DoLpxmJzW++spSbpv0UdLWLsQVngE
         NW074DuNSKfbb6Btg3wGt/OwIKzLgnrxiFWG0hyCf+dND4dYkuraM3uy0dMCyYHOsD
         16kBnV7jTb/uGxo9OAKOvosbPFkKPw1Wjt5X4g28=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231031095022epcas2p486aa8242f24ea20d89b84cba04cf9429~TKFMl-cbx2735627356epcas2p4B;
        Tue, 31 Oct 2023 09:50:22 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.100]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SKQNs3HM2z4x9Q1; Tue, 31 Oct
        2023 09:50:21 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.8B.18994.DDDC0456; Tue, 31 Oct 2023 18:50:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231031095020epcas2p36f320f3609064b3c906449a2ac517f43~TKFLoKNlk1121511215epcas2p3C;
        Tue, 31 Oct 2023 09:50:20 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231031095020epsmtrp1812f10da9cfc494bd6beece1900cb47b~TKFLnXug82510125101epsmtrp1p;
        Tue, 31 Oct 2023 09:50:20 +0000 (GMT)
X-AuditID: b6c32a4d-9f7ff70000004a32-0d-6540cddd3d93
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.21.08817.CDDC0456; Tue, 31 Oct 2023 18:50:20 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231031095020epsmtip16885486a60d9c4f0de010c5ce61d471e~TKFLMBBSC2332123321epsmtip1e;
        Tue, 31 Oct 2023 09:50:20 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH 08/10] pinctrl: samsung: add exynosautv920 pinctrl
Date:   Tue, 31 Oct 2023 18:47:50 +0900
Message-ID: <20231031094852.118677-9-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031094852.118677-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxjPube9vZh0uRbYThqyNZdsS92gLc8DCoNplqrbIJrMPQM37Q10
        lNvaFoRNHI7xzHjL0PLaeIRBzNDyGBYQAghjGxWn6xxScdPgBHUMt4IGdC2tm//9vu/7fef7
        /b5zDomLfiXEpIYzsQaO0dLEFl7fmDQiyDEdx8rHrP7oWmMfgU4O2TDUNG7jo7yWLgL1547z
        0d2GADS01CtAx9bbMWS5buej7qZ1gC5a6wnkcHQCdPz8WQz92FIqQPlD4wI0druQj+5bG3mo
        0+riXamsBnG+yjNmh0Bp6SwmlHP2QUI53HBSoOxu/URZviFXlvV0AuU9y7OJ5LtpO1JZRs0a
        JCyn0qk1XEoMvXd/0s6k8Ai5IkgRhSJpCcekszH0rtcTg17TaF12aEkmo81wpRIZo5GWxe4w
        6DJMrCRVZzTF0KxerdVH6oONTLoxg0sJ5lhTtEIuDwl3EZPTUo8v3QN6uxlkPTjNywXnj4IS
        4ENCKgxOLPRiJWALKaIGAawZfeQNVgCcrvoe9wROADvqVwSPW0p7WnmewhCA9up6gSf4C0DH
        TwOEm0VQL8HVrha+G/tRf+Ow9veP3SScKsRgo/MWz13wpV6F3d+ub5J41POwddruypOkkIqF
        U1OhnmnPwcHmVcyNfahX4JnPP90ULqS2wqkTNzaPwV2cvN66TamQmiHhZPuS190uWNJ3hfBg
        X7g42eO1IIa3ygu8OA0W1no0QCoLXjhV5+WHQvNCIXDrwSkp7LLK3BBSgXB81jv2KVg0tiHw
        pIWwqEDkaXwBztfYvIcEwKrxDsyDlTB37RLfs6oqAOeHJ4gKIDE/4cb8hBvz/4O/BHgnELN6
        Y3oKqwrRK4I49tB/16zSpVvA5hvf9kY/WOraCB4FGAlGASRx2k84Fh7HioRqJvsj1qBLMmRo
        WeMoCHetuxIX+6t0rk/CmZIUYVHysIgIRWRIuDySfkZ4Nb9BLaJSGBObxrJ61vC4DyN9xLlY
        x2/t8MjbNRV34vMOtmJnL84vOx7kDJdexu4Saw//5EJWnk4esbTHvjhguXxj8mX63KWWiT+u
        Hpqdbb752ZsJi7mq0a9i9gbsObe9b75NYPhBKv3i61NG6oB49uHhhXcSJL11Kucdqd/MtbcG
        7XmaE8Xp1bFTVNvcLztFltOxPwcW8dRYdPDyQCP3yHKgwhCdPLJ7+74S3DaCAq3Z94+Ssv7W
        6X3HhmTaoNCF79b6bdnkgo25DhTrU2WBmpmyQW3l6gWD7b0jW/01mbJU6e3mD0HTXGTOcpbT
        6VjErVROLRHP7f9gz+7MgqjiOck3+ZZ/Eg6HtRXG16H3y28G5wwfxGieMZVRbMMNRuZf/wAH
        KmwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnO6dsw6pBke/mVk8mLeNzWLN3nNM
        FvOPnGO1aF68ns1iR8MRVot3c2Us9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWd++uYrSY
        cX4fk8WZxb3sFq17j7BbHH7Tzmrxc9c8FotVu4Dqbk+czOgg7LFz1l12j02rOtk87lzbw+ax
        f+4ado/NS+o9+v8aePRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfGjNefGQuuzWKs+LWRpYHx
        fCNjFyMnh4SAiUTvliUsXYxcHEICuxkl+j7vhErISCx/1scGYQtL3G85wgpR9J5R4lzjMbAE
        m4C2xPf1i8ESIgK/mCV2T7gL1s0s0M8kcX1TAogtLOAksXn7H1YQm0VAVWLJ2WtA6zg4eAXs
        JE6eNIZYIC+xZ9F3JhCbU8BeYmdPE9gYIaCSixtugsV5BQQlTs58wgIxXl6ieets5gmMArOQ
        pGYhSS1gZFrFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcaVpaOxj3rPqgd4iRiYPx
        EKMEB7OSCO9hU4dUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzfXvemCAmkJ5akZqemFqQWwWSZ
        ODilGpgyg+vTfiudaL5dd+jriuYeLfv3krkhK05tXen69+M1o9oCC5c1VzZuVQq5OuH+mfR7
        qckPzCP9JlnmbvvTxlQkviWq9vNh9lvq1in7umZUHcwW+W+le/j3lCNvTrW7nmPZcFaZkbPs
        ddI700ONwUL33zhxP3YTMd/TZP48yorXtO1FRKOC9EzhP1F3/rnlXnXdUuz55miiIot2wCYO
        Z58nT+RmOk6TdZyq7J3eXKG27Xp+RaO50ZcHrHFVyXy9j54pKa3wvVHveEDnvvQ74UfiVmEN
        6svNDHo7um49OXf+gdayA/+yeKbN/5+lItGV0KjnDPSUs8RWkdctK2u2MeU31k8sVxQuuHC7
        iMlfiaU4I9FQi7moOBEAbSemhCMDAAA=
X-CMS-MailID: 20231031095020epcas2p36f320f3609064b3c906449a2ac517f43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031095020epcas2p36f320f3609064b3c906449a2ac517f43
References: <20231031094852.118677-1-jaewon02.kim@samsung.com>
        <CGME20231031095020epcas2p36f320f3609064b3c906449a2ac517f43@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ExynosAutov920 GPIO has a different register structure.
In the existing Exynos series, EINT control register enumerated after
a specific offset (e.g EXYNOS_GPIO_ECON_OFFSET).
However, in ExynosAutov920 SoC, the register that controls EINT belongs
to each GPIO group, and each GPIO group has 0x1000 align.

This is a structure to protect the GPIO group with S2MPU in VM environment,
and will only be applied in ExynosAuto series SoCs.

Example)
-------------------------------------------------
| original		| ExynosAutov920	|
|-----------------------------------------------|
| 0x0	GPIO_CON	| 0x0	GPIO_CON	|
| 0x4	GPIO_DAT	| 0x4	GPIO_DAT	|
| 0x8	GPIO_PUD	| 0x8	GPIO_PUD	|
| 0xc	GPIO_DRV	| 0xc	GPIO_DRV	|
| 0x700	EINT_CON	| 0x18	EINT_CON	|
| 0x800	EINT_FLTCON	| 0x1c	EINT_FLTCON0	|
| 0x900	EINT_MASK	| 0x20	EINT_FLTCON1	|
| 0xa00	EINT_PEND	| 0x24	EINT_MASK	|
|			| 0x28	EINT_PEND	|
-------------------------------------------------

Pinctrl data for ExynosAutoV920 SoC.
 - GPA0,GPA1 (10): External wake up interrupt
 - GPQ0 (2): SPMI (PMIC I/F)
 - GPB0,GPB1,GPB2,GPB3,GPB4,GPB5,GPB6 (47): I2S Audio
 - GPH0,GPH1,GPH2,GPH3,GPH4,GPH5,GPH6,GPH8 (49): PCIE, UFS, Ethernet
 - GPG0,GPG1,GPG2,GPG3,GPG4,GPG5 (29): General purpose
 - GPP0,GPP1,GPP2,GPP3,GPP4,GPP5,GPP6,GPP7,GPP8,GPP9,GPP10 (77): USI

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 131 ++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.c      |  99 ++++++++++++-
 drivers/pinctrl/samsung/pinctrl-exynos.h      |  27 ++++
 drivers/pinctrl/samsung/pinctrl-samsung.c     |   5 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |  13 ++
 5 files changed, 268 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
index cb965cf93705..8551b85c3e6f 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -796,3 +796,134 @@ const struct samsung_pinctrl_of_match_data fsd_of_data __initconst = {
 	.ctrl		= fsd_pin_ctrl,
 	.num_ctrl	= ARRAY_SIZE(fsd_pin_ctrl),
 };
+
+/* pin banks of exynosautov920 pin-controller 0 (ALIVE) */
+static struct samsung_pin_bank_data exynosautov920_pin_banks0[] = {
+	EXYNOSV920_PIN_BANK_EINTW(8, 0x0000, "gpa0", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTW(2, 0x1000, "gpa1", 0x18, 0x20, 0x24),
+	EXYNOS850_PIN_BANK_EINTN(2, 0x2000, "gpq0"),
+};
+
+/* pin banks of exynosautov920 pin-controller 1 (AUD) */
+static struct samsung_pin_bank_data exynosautov920_pin_banks1[] = {
+	EXYNOSV920_PIN_BANK_EINTG(7, 0x0000, "gpb0", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(6, 0x1000, "gpb1", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(8, 0x2000, "gpb2", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(8, 0x3000, "gpb3", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(8, 0x4000, "gpb4", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(5, 0x5000, "gpb5", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(5, 0x6000, "gpb6", 0x18, 0x24, 0x28),
+};
+
+/* pin banks of exynosautov920 pin-controller 2 (HSI0) */
+static struct samsung_pin_bank_data exynosautov920_pin_banks2[] = {
+	EXYNOSV920_PIN_BANK_EINTG(6, 0x0000, "gph0", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(2, 0x1000, "gph1", 0x18, 0x20, 0x24),
+};
+
+/* pin banks of exynosautov920 pin-controller 3 (HSI1) */
+static struct samsung_pin_bank_data exynosautov920_pin_banks3[] = {
+	EXYNOSV920_PIN_BANK_EINTG(7, 0x000, "gph8", 0x18, 0x24, 0x28),
+};
+
+/* pin banks of exynosautov920 pin-controller 4 (HSI2) */
+static struct samsung_pin_bank_data exynosautov920_pin_banks4[] = {
+	EXYNOSV920_PIN_BANK_EINTG(8, 0x0000, "gph3", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(7, 0x1000, "gph4", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(8, 0x2000, "gph5", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(7, 0x3000, "gph6", 0x18, 0x24, 0x28),
+};
+
+/* pin banks of exynosautov920 pin-controller 5 (HSI2UFS) */
+static struct samsung_pin_bank_data exynosautov920_pin_banks5[] = {
+	EXYNOSV920_PIN_BANK_EINTG(4, 0x000, "gph2", 0x18, 0x20, 0x24),
+};
+
+/* pin banks of exynosautov920 pin-controller 6 (PERIC0) */
+static struct samsung_pin_bank_data exynosautov920_pin_banks6[] = {
+	EXYNOSV920_PIN_BANK_EINTG(8, 0x0000, "gpp0", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(8, 0x1000, "gpp1", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(8, 0x2000, "gpp2", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(5, 0x3000, "gpg0", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(8, 0x4000, "gpp3", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(4, 0x5000, "gpp4", 0x18, 0x20, 0x24),
+	EXYNOSV920_PIN_BANK_EINTG(4, 0x6000, "gpg2", 0x18, 0x20, 0x24),
+	EXYNOSV920_PIN_BANK_EINTG(4, 0x7000, "gpg5", 0x18, 0x20, 0x24),
+	EXYNOSV920_PIN_BANK_EINTG(3, 0x8000, "gpg3", 0x18, 0x20, 0x24),
+	EXYNOSV920_PIN_BANK_EINTG(5, 0x9000, "gpg4", 0x18, 0x24, 0x28),
+};
+
+/* pin banks of exynosautov920 pin-controller 7 (PERIC1) */
+static struct samsung_pin_bank_data exynosautov920_pin_banks7[] = {
+	EXYNOSV920_PIN_BANK_EINTG(8, 0x0000, "gpp5",  0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(5, 0x1000, "gpp6",  0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(4, 0x2000, "gpp10", 0x18, 0x20, 0x24),
+	EXYNOSV920_PIN_BANK_EINTG(8, 0x3000, "gpp7",  0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(4, 0x4000, "gpp8",  0x18, 0x20, 0x24),
+	EXYNOSV920_PIN_BANK_EINTG(4, 0x5000, "gpp11", 0x18, 0x20, 0x24),
+	EXYNOSV920_PIN_BANK_EINTG(4, 0x6000, "gpp9",  0x18, 0x20, 0x24),
+	EXYNOSV920_PIN_BANK_EINTG(4, 0x7000, "gpp12", 0x18, 0x20, 0x24),
+	EXYNOSV920_PIN_BANK_EINTG(8, 0x8000, "gpg1",  0x18, 0x24, 0x28),
+};
+
+const struct samsung_pin_ctrl exynosautov920_pin_ctrl[] = {
+	{
+		/* pin-controller instance 0 ALIVE data */
+		.pin_banks	= exynosautov920_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks0),
+		.eint_wkup_init	= exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 1 AUD data */
+		.pin_banks	= exynosautov920_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks1),
+	}, {
+		/* pin-controller instance 2 HSI0 data */
+		.pin_banks	= exynosautov920_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks2),
+		.eint_gpio_init	= exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 2 HSI1 data */
+		.pin_banks	= exynosautov920_pin_banks3,
+		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks3),
+		.eint_gpio_init	= exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 2 HSI2 data */
+		.pin_banks	= exynosautov920_pin_banks4,
+		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks4),
+		.eint_gpio_init	= exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 2 HSI2UFS data */
+		.pin_banks	= exynosautov920_pin_banks5,
+		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks5),
+		.eint_gpio_init	= exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 2 PERIC0 data */
+		.pin_banks	= exynosautov920_pin_banks6,
+		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks6),
+		.eint_gpio_init	= exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 2 PERIC1 data */
+		.pin_banks	= exynosautov920_pin_banks7,
+		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks7),
+		.eint_gpio_init	= exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	},
+};
+
+const struct samsung_pinctrl_of_match_data exynosautov920_of_data __initconst = {
+	.ctrl		= exynosautov920_pin_ctrl,
+	.num_ctrl	= ARRAY_SIZE(exynosautov920_pin_ctrl),
+};
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index a8212fc126bf..c50ddbc6bfd4 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -56,6 +56,9 @@ static void exynos_irq_mask(struct irq_data *irqd)
 	unsigned int mask;
 	unsigned long flags;
 
+	if (bank->combine)
+		reg_mask = bank->mask_offset;
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	mask = readl(bank->eint_base + reg_mask);
@@ -72,6 +75,9 @@ static void exynos_irq_ack(struct irq_data *irqd)
 	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
 	unsigned long reg_pend = our_chip->eint_pend + bank->eint_offset;
 
+	if (bank->combine)
+		reg_pend = bank->pend_offset;
+
 	writel(1 << irqd->hwirq, bank->eint_base + reg_pend);
 }
 
@@ -95,6 +101,9 @@ static void exynos_irq_unmask(struct irq_data *irqd)
 	if (irqd_get_trigger_type(irqd) & IRQ_TYPE_LEVEL_MASK)
 		exynos_irq_ack(irqd);
 
+	if (bank->combine)
+		reg_mask = bank->mask_offset;
+
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	mask = readl(bank->eint_base + reg_mask);
@@ -221,6 +230,19 @@ static const struct exynos_irq_chip exynos_gpio_irq_chip __initconst = {
 	/* eint_wake_mask_value not used */
 };
 
+static const struct exynos_irq_chip exynosautov920_gpio_irq_chip __initconst = {
+	.chip = {
+		.name = "exynosautov920_gpio_irq_chip",
+		.irq_unmask = exynos_irq_unmask,
+		.irq_mask = exynos_irq_mask,
+		.irq_ack = exynos_irq_ack,
+		.irq_set_type = exynos_irq_set_type,
+		.irq_request_resources = exynos_irq_request_resources,
+		.irq_release_resources = exynos_irq_release_resources,
+	},
+	/* eint_wake_mask_value not used */
+};
+
 static int exynos_eint_irq_map(struct irq_domain *h, unsigned int virq,
 					irq_hw_number_t hw)
 {
@@ -247,7 +269,10 @@ static irqreturn_t exynos_eint_gpio_irq(int irq, void *data)
 	unsigned int svc, group, pin;
 	int ret;
 
-	svc = readl(bank->eint_base + EXYNOS_SVC_OFFSET);
+	if (bank->combine)
+		svc = readl(bank->eint_base + EXYNOSAUTOV920_SVC_OFFSET);
+	else
+		svc = readl(bank->eint_base + EXYNOS_SVC_OFFSET);
 	group = EXYNOS_SVC_GROUP(svc);
 	pin = svc & EXYNOS_SVC_NUM_MASK;
 
@@ -297,8 +322,12 @@ __init int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
 		if (bank->eint_type != EINT_TYPE_GPIO)
 			continue;
 
-		bank->irq_chip = devm_kmemdup(dev, &exynos_gpio_irq_chip,
-					   sizeof(*bank->irq_chip), GFP_KERNEL);
+		if (bank->combine)
+			bank->irq_chip = devm_kmemdup(dev, &exynosautov920_gpio_irq_chip,
+						   sizeof(*bank->irq_chip), GFP_KERNEL);
+		else
+			bank->irq_chip = devm_kmemdup(dev, &exynos_gpio_irq_chip,
+						   sizeof(*bank->irq_chip), GFP_KERNEL);
 		if (!bank->irq_chip) {
 			ret = -ENOMEM;
 			goto err_domains;
@@ -456,6 +485,22 @@ static const struct exynos_irq_chip exynos7_wkup_irq_chip __initconst = {
 	.set_eint_wakeup_mask = exynos_pinctrl_set_eint_wakeup_mask,
 };
 
+static const struct exynos_irq_chip exynosautov920_wkup_irq_chip __initconst = {
+	.chip = {
+		.name = "exynosautov920_wkup_irq_chip",
+		.irq_unmask = exynos_irq_unmask,
+		.irq_mask = exynos_irq_mask,
+		.irq_ack = exynos_irq_ack,
+		.irq_set_type = exynos_irq_set_type,
+		.irq_set_wake = exynos_wkup_irq_set_wake,
+		.irq_request_resources = exynos_irq_request_resources,
+		.irq_release_resources = exynos_irq_release_resources,
+	},
+	.eint_wake_mask_value = &eint_wake_mask_value,
+	.eint_wake_mask_reg = EXYNOS5433_EINT_WAKEUP_MASK,
+	.set_eint_wakeup_mask = exynos_pinctrl_set_eint_wakeup_mask,
+};
+
 /* list of external wakeup controllers supported */
 static const struct of_device_id exynos_wkup_irq_ids[] = {
 	{ .compatible = "samsung,s5pv210-wakeup-eint",
@@ -468,6 +513,8 @@ static const struct of_device_id exynos_wkup_irq_ids[] = {
 			.data = &exynos7_wkup_irq_chip },
 	{ .compatible = "samsung,exynosautov9-wakeup-eint",
 			.data = &exynos7_wkup_irq_chip },
+	{ .compatible = "samsung,exynosautov920-wakeup-eint",
+			.data = &exynosautov920_wkup_irq_chip },
 	{ }
 };
 
@@ -655,6 +702,20 @@ static void exynos_pinctrl_suspend_bank(
 	pr_debug("%s: save    mask %#010x\n", bank->name, save->eint_mask);
 }
 
+static void exynosautov920_pinctrl_suspend_bank(
+				struct samsung_pinctrl_drv_data *drvdata,
+				struct samsung_pin_bank *bank)
+{
+	struct exynos_eint_gpio_save *save = bank->soc_priv;
+	void __iomem *regs = bank->eint_base;
+
+	save->eint_con = readl(regs + bank->eint_offset);
+	save->eint_mask = readl(regs + bank->mask_offset);
+
+	pr_debug("%s: save     con %#010x\n", bank->name, save->eint_con);
+	pr_debug("%s: save    mask %#010x\n", bank->name, save->eint_mask);
+}
+
 void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
 {
 	struct samsung_pin_bank *bank = drvdata->pin_banks;
@@ -662,8 +723,12 @@ void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
 	int i;
 
 	for (i = 0; i < drvdata->nr_banks; ++i, ++bank) {
-		if (bank->eint_type == EINT_TYPE_GPIO)
-			exynos_pinctrl_suspend_bank(drvdata, bank);
+		if (bank->eint_type == EINT_TYPE_GPIO) {
+			if (bank->combine)
+				exynosautov920_pinctrl_suspend_bank(drvdata, bank);
+			else
+				exynos_pinctrl_suspend_bank(drvdata, bank);
+		}
 		else if (bank->eint_type == EINT_TYPE_WKUP) {
 			if (!irq_chip) {
 				irq_chip = bank->irq_chip;
@@ -704,14 +769,34 @@ static void exynos_pinctrl_resume_bank(
 						+ bank->eint_offset);
 }
 
+static void exynosautov920_pinctrl_resume_bank(
+				struct samsung_pinctrl_drv_data *drvdata,
+				struct samsung_pin_bank *bank)
+{
+	struct exynos_eint_gpio_save *save = bank->soc_priv;
+	void __iomem *regs = bank->eint_base;
+
+	pr_debug("%s:     con %#010x => %#010x\n", bank->name,
+			readl(regs + bank->eint_offset), save->eint_con);
+	pr_debug("%s:    mask %#010x => %#010x\n", bank->name,
+			readl(regs + bank->mask_offset), save->eint_mask);
+
+	writel(save->eint_con, regs + bank->eint_offset);
+	writel(save->eint_mask, regs + bank->mask_offset);
+}
+
 void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 {
 	struct samsung_pin_bank *bank = drvdata->pin_banks;
 	int i;
 
 	for (i = 0; i < drvdata->nr_banks; ++i, ++bank)
-		if (bank->eint_type == EINT_TYPE_GPIO)
-			exynos_pinctrl_resume_bank(drvdata, bank);
+		if (bank->eint_type == EINT_TYPE_GPIO) {
+			if (bank->combine)
+				exynosautov920_pinctrl_resume_bank(drvdata, bank);
+			else
+				exynos_pinctrl_resume_bank(drvdata, bank);
+		}
 }
 
 static void exynos_retention_enable(struct samsung_pinctrl_drv_data *drvdata)
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index 7bd6d82c9f36..212225a3ed3b 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -31,6 +31,7 @@
 #define EXYNOS7_WKUP_EMASK_OFFSET	0x900
 #define EXYNOS7_WKUP_EPEND_OFFSET	0xA00
 #define EXYNOS_SVC_OFFSET		0xB08
+#define EXYNOSAUTOV920_SVC_OFFSET	0xF008
 
 /* helpers to access interrupt service register */
 #define EXYNOS_SVC_GROUP_SHIFT		3
@@ -140,6 +141,32 @@
 		.name		= id				\
 	}
 
+#define EXYNOSV920_PIN_BANK_EINTG(pins, reg, id, offs, mask_offs, pend_offs)	\
+	{							\
+		.type		= &exynos850_bank_type_off,	\
+		.pctl_offset	= reg,				\
+		.nr_pins	= pins,				\
+		.eint_type	= EINT_TYPE_GPIO,		\
+		.eint_offset	= (reg + offs),			\
+		.mask_offset	= (reg + mask_offs),		\
+		.pend_offset	= (reg + pend_offs),		\
+		.combine	= true,				\
+		.name		= id				\
+	}
+
+#define EXYNOSV920_PIN_BANK_EINTW(pins, reg, id, offs, mask_offs, pend_offs)	\
+	{							\
+		.type		= &exynos850_bank_type_alive,	\
+		.pctl_offset	= reg,				\
+		.nr_pins	= pins,				\
+		.eint_type	= EINT_TYPE_WKUP,		\
+		.eint_offset	= (reg + offs),			\
+		.mask_offset	= (reg + mask_offs),		\
+		.pend_offset	= (reg + pend_offs),		\
+		.combine	= true,				\
+		.name		= id				\
+	}
+
 /**
  * struct exynos_weint_data: irq specific data for all the wakeup interrupts
  * generated by the external wakeup interrupt controller.
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index e54847040b4a..4066a1e1aff7 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1105,6 +1105,9 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 		bank->eint_type = bdata->eint_type;
 		bank->eint_mask = bdata->eint_mask;
 		bank->eint_offset = bdata->eint_offset;
+		bank->mask_offset = bdata->mask_offset;
+		bank->pend_offset = bdata->pend_offset;
+		bank->combine = bdata->combine;
 		bank->name = bdata->name;
 
 		raw_spin_lock_init(&bank->slock);
@@ -1319,6 +1322,8 @@ static const struct of_device_id samsung_pinctrl_dt_match[] = {
 		.data = &exynosautov9_of_data },
 	{ .compatible = "tesla,fsd-pinctrl",
 		.data = &fsd_of_data },
+	{ .compatible = "samsung,exynosautov920-pinctrl",
+		.data = &exynosautov920_of_data },
 #endif
 #ifdef CONFIG_PINCTRL_S3C64XX
 	{ .compatible = "samsung,s3c64xx-pinctrl",
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 9af93e3d8d9f..8151583d4a88 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -122,6 +122,9 @@ struct samsung_pin_bank_type {
  * @eint_type: type of the external interrupt supported by the bank.
  * @eint_mask: bit mask of pins which support EINT function.
  * @eint_offset: SoC-specific EINT register or interrupt offset of bank.
+ * @mask_offset: SoC-specific EINT mask register offset of bank.
+ * @pend_offset: SoC-specific EINT pend register offset of bank.
+ * @combine: EINT register is combined to the GPIO control register.
  * @name: name to be prefixed for each pin in this pin bank.
  */
 struct samsung_pin_bank_data {
@@ -133,6 +136,9 @@ struct samsung_pin_bank_data {
 	enum eint_type	eint_type;
 	u32		eint_mask;
 	u32		eint_offset;
+	u32		mask_offset;
+	u32		pend_offset;
+	bool		combine;
 	const char	*name;
 };
 
@@ -147,6 +153,9 @@ struct samsung_pin_bank_data {
  * @eint_type: type of the external interrupt supported by the bank.
  * @eint_mask: bit mask of pins which support EINT function.
  * @eint_offset: SoC-specific EINT register or interrupt offset of bank.
+ * @mask_offset: SoC-specific EINT mask register offset of bank.
+ * @pend_offset: SoC-specific EINT pend register offset of bank.
+ * @combine: EINT register is combined to the GPIO control register.
  * @name: name to be prefixed for each pin in this pin bank.
  * @pin_base: starting pin number of the bank.
  * @soc_priv: per-bank private data for SoC-specific code.
@@ -169,6 +178,9 @@ struct samsung_pin_bank {
 	enum eint_type	eint_type;
 	u32		eint_mask;
 	u32		eint_offset;
+	u32		mask_offset;
+	u32		pend_offset;
+	bool		combine;
 	const char	*name;
 
 	u32		pin_base;
@@ -350,6 +362,7 @@ extern const struct samsung_pinctrl_of_match_data exynos7_of_data;
 extern const struct samsung_pinctrl_of_match_data exynos7885_of_data;
 extern const struct samsung_pinctrl_of_match_data exynos850_of_data;
 extern const struct samsung_pinctrl_of_match_data exynosautov9_of_data;
+extern const struct samsung_pinctrl_of_match_data exynosautov920_of_data;
 extern const struct samsung_pinctrl_of_match_data fsd_of_data;
 extern const struct samsung_pinctrl_of_match_data s3c64xx_of_data;
 extern const struct samsung_pinctrl_of_match_data s3c2412_of_data;
-- 
2.42.0

