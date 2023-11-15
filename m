Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999CA7EC030
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjKOKAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjKOJ7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:59:42 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C8913D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:59:06 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231115095857epoutp04869c87ee534bb31c160cad0d12f7c550~Xw3-INukT1002810028epoutp04j
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:58:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231115095857epoutp04869c87ee534bb31c160cad0d12f7c550~Xw3-INukT1002810028epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700042337;
        bh=lD63qgcV74VqOUBzue3mA9MfoV8naGExU8sdTwqBMoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vysl66W9ttTMYJYPeYuSuadGJvaWlKi/yA1MnT6Br6ze3maUCAAuQ11I44C+BAfug
         MTbK9e8eO0HnajWPp8duqYXRPjkxCm/n1xBERHEobIXN1/iuFJkhvlyEYEQYXUOu6/
         ZmclVPOIjSAICXgzfj4E2VocFmkJDtGecCLYEPcg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231115095857epcas2p40f37848f01a5050b02f5f368d03e30b0~Xw3_q9vvu0467204672epcas2p4R;
        Wed, 15 Nov 2023 09:58:57 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SVdsr6SyLz4x9Q0; Wed, 15 Nov
        2023 09:58:56 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.0D.09622.06694556; Wed, 15 Nov 2023 18:58:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20231115095856epcas2p1c3ee85750828bec2ee4ab0adeaeaff28~Xw39WF3Vq2129221292epcas2p1U;
        Wed, 15 Nov 2023 09:58:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231115095856epsmtrp1e6d2580f4a6c324e1a3a4ac826e663c5~Xw39VTFAT2856328563epsmtrp1P;
        Wed, 15 Nov 2023 09:58:56 +0000 (GMT)
X-AuditID: b6c32a46-d61ff70000002596-b5-65549660484e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.F6.08755.F5694556; Wed, 15 Nov 2023 18:58:55 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231115095855epsmtip2e39232ae7c56787c7afe8b88fcaa15ae~Xw385tfXx2749427494epsmtip2f;
        Wed, 15 Nov 2023 09:58:55 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v2 10/12] pinctrl: samsung: add exynosautov920 pinctrl
Date:   Wed, 15 Nov 2023 18:56:06 +0900
Message-ID: <20231115095609.39883-11-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115095609.39883-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRmVeSWpSXmKPExsWy7bCmuW7CtJBUgxOzjCwezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX
        0NLCXEkhLzE31VbJxSdA1y0zB+gdJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6B
        eYFecWJucWleul5eaomVoYGBkSlQYUJ2xurnz9gLFsxlrPjzfi1TA+ONZsYuRk4OCQETiVnL
        njN1MXJxCAnsYJR4NnEtG4TziVHi+eTLrBDON0aJ069PsMC0rGmaANWyl1FiZdNRqJaPjBLz
        z25iBaliE9CW+L5+MZgtInCfWeJ1WzVIEbNAO5PEvG8vwUYJC7hJ3Jj6ig3EZhFQlVh9eztY
        A6+AncSns0uYINbJS+xZ9B3I5uDgBIq3nteCKBGUODnzCdgYZqCS5q2zmUHmSwjc4JC4vfgK
        1HcuEnMPz4SaIyzx6vgWdghbSuJlfxuUnS3RPv0PK4RdIXFxw2w2CNtYYtazdkaQvcwCmhLr
        d+mDmBICyhJHbkGt5ZPoOPyXHSLMK9HRJgTRqCZxf+o5qCEyEpOOrIQ6wEOiefJ0aFBNBIbu
        vU0sExgVZiH5ZhaSb2YhLF7AyLyKUSy1oDg3PbXYqMAIHsfJ+bmbGMEJXMttB+OUtx/0DjEy
        cTAeYpTgYFYS4TWXC0kV4k1JrKxKLcqPLyrNSS0+xGgKDOqJzFKiyfnAHJJXEm9oYmlgYmZm
        aG5kamCuJM57r3VuipBAemJJanZqakFqEUwfEwenVANTasbzXQ88czQn25Z9nWN2N6XliMau
        5KV3G0wmP1K0dxV7OVuDt/9nl/2U5dYLe2un2E9errNKZ6YVp8HNS3PmZrblzLNO4NrC8tGJ
        /eUtmTXzF22YLn8s7kjmmYl2+Z7K+rN03VXZ7i3flpz88tzdteHvTlfbSa64s/ovz54a75p3
        GU8z1+18lm9ccHjGjPCCR4VWRYVp25NEPyu/SZm5rPSEtH7BrJtrOze0NHJqn6+OmKMaoCmu
        P0n/6/9fxwSfpUd0uf9c2HW96YpkxNmMr3+iA40SnfccTFxvOL1VeP/Jj2aRkkkH4+7O2Hig
        u29d4rPr+yNvGG28oN59V53hhKf1dM+duzQXWE4wcAw3VWIpzkg01GIuKk4EAH2T+E5pBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvG78tJBUg95zphYP5m1js1iz9xyT
        xfwj51gtmhevZ7PY0XCE1eLdXBmLva+3sltM+bOcyWLT42usFpvn/2G0uLxrDpvF3burGC1m
        nN/HZHFmcS+7ReveI+wWh9+0s1r83DWPxWLVLqC62xMnMzoIe+ycdZfdY9OqTjaPO9f2sHns
        n7uG3WPzknqP/r8GHn1bVjF6fN4kF8ARxWWTkpqTWZZapG+XwJWx+vkz9oIFcxkr/rxfy9TA
        eKOZsYuRk0NCwERiTdMEpi5GLg4hgd2MEh1vW9khEjISy5/1sUHYwhL3W46wQhS9Z5Q43zOZ
        FSTBJqAt8X39YrCEiMBzZomzfx4xgySYBfqZJK5vSgCxhQXcJG5MfQU2iUVAVWL17e1gzbwC
        dhKfzi5hgtggL7Fn0Xcgm4ODEyjeel4LJCwkYCvRuvsHM0S5oMTJmU9YIMbLSzRvnc08gVFg
        FpLULCSpBYxMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgmNNS3MH4/ZVH/QOMTJx
        MB5ilOBgVhLhNZcLSRXiTUmsrEotyo8vKs1JLT7EKM3BoiTOK/6iN0VIID2xJDU7NbUgtQgm
        y8TBKdXAlD4rwLN908rEkxtf3sxx3P1dLvr9rk+MOcefOuXNUS0qXqv1y+Lqm9iGH8wzV522
        /TCzXz9X1n/te5sDd6a94RBWXHWu9F6dgs2WZ7YLdVczfuPbVX/bZIVWyCcxgRmPOjVu508I
        rXm0Q0hCK6jSMyjGuWTmouUPlIvP3JvRri89p9dmwq9p20q0hSqefUhn5HaYb7LsSue1MHZu
        W+Z5mQ+b9Zb9muq5bEKI26Ikw3Nbbpr/X/encenczVFXdJmFv/X0Xlyl4nn93XLZvT6lVxY4
        n5++I+h65ER7RrayOXdC/TdUapdOY2PNjTbK/WG7QeKj1+9d/re6yjdmLd3Gs2jxgfyM85f+
        vokOtlqsvUOJpTgj0VCLuag4EQB+a0dqJAMAAA==
X-CMS-MailID: 20231115095856epcas2p1c3ee85750828bec2ee4ab0adeaeaff28
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231115095856epcas2p1c3ee85750828bec2ee4ab0adeaeaff28
References: <20231115095609.39883-1-jaewon02.kim@samsung.com>
        <CGME20231115095856epcas2p1c3ee85750828bec2ee4ab0adeaeaff28@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 140 ++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.c      | 102 ++++++++++++-
 drivers/pinctrl/samsung/pinctrl-exynos.h      |  27 ++++
 drivers/pinctrl/samsung/pinctrl-samsung.c     |   5 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |  13 ++
 5 files changed, 280 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
index cb965cf93705..cf86722a70a3 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -796,3 +796,143 @@ const struct samsung_pinctrl_of_match_data fsd_of_data __initconst = {
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
+static const struct samsung_retention_data exynosautov920_retention_data __initconst = {
+	.regs	 = NULL,
+	.nr_regs = 0,
+	.value	 = 0,
+	.refcnt	 = &exynos_shared_retention_refcnt,
+	.init	 = exynos_retention_init,
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
+		.retention_data	= &exynosautov920_retention_data,
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
index 6b58ec84e34b..b1bf44ee09db 100644
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
@@ -221,6 +230,22 @@ static const struct exynos_irq_chip exynos_gpio_irq_chip __initconst = {
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
+	.eint_con = 0,
+	.eint_mask = 0,
+	.eint_pend = 0,
+	/* eint_wake_mask_value not used */
+};
+
 static int exynos_eint_irq_map(struct irq_domain *h, unsigned int virq,
 					irq_hw_number_t hw)
 {
@@ -247,7 +272,10 @@ static irqreturn_t exynos_eint_gpio_irq(int irq, void *data)
 	unsigned int svc, group, pin;
 	int ret;
 
-	svc = readl(bank->eint_base + EXYNOS_SVC_OFFSET);
+	if (bank->combine)
+		svc = readl(bank->eint_base + EXYNOSAUTOV920_SVC_OFFSET);
+	else
+		svc = readl(bank->eint_base + EXYNOS_SVC_OFFSET);
 	group = EXYNOS_SVC_GROUP(svc);
 	pin = svc & EXYNOS_SVC_NUM_MASK;
 
@@ -297,8 +325,12 @@ __init int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
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
@@ -456,6 +488,22 @@ static const struct exynos_irq_chip exynos7_wkup_irq_chip __initconst = {
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
@@ -468,6 +516,8 @@ static const struct of_device_id exynos_wkup_irq_ids[] = {
 			.data = &exynos7_wkup_irq_chip },
 	{ .compatible = "samsung,exynosautov9-wakeup-eint",
 			.data = &exynos7_wkup_irq_chip },
+	{ .compatible = "samsung,exynosautov920-wakeup-eint",
+			.data = &exynosautov920_wkup_irq_chip },
 	{ }
 };
 
@@ -655,6 +705,20 @@ static void exynos_pinctrl_suspend_bank(
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
@@ -662,8 +726,12 @@ void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
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
@@ -704,14 +772,34 @@ static void exynos_pinctrl_resume_bank(
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
index 3ac52c2cf998..210952c7a5aa 100644
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
index 79babbb39ced..adf2d0cff438 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1106,6 +1106,9 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 		bank->eint_type = bdata->eint_type;
 		bank->eint_mask = bdata->eint_mask;
 		bank->eint_offset = bdata->eint_offset;
+		bank->mask_offset = bdata->mask_offset;
+		bank->pend_offset = bdata->pend_offset;
+		bank->combine = bdata->combine;
 		bank->name = bdata->name;
 
 		raw_spin_lock_init(&bank->slock);
@@ -1321,6 +1324,8 @@ static const struct of_device_id samsung_pinctrl_dt_match[] = {
 		.data = &exynosautov9_of_data },
 	{ .compatible = "tesla,fsd-pinctrl",
 		.data = &fsd_of_data },
+	{ .compatible = "samsung,exynosautov920-pinctrl",
+		.data = &exynosautov920_of_data },
 #endif
 #ifdef CONFIG_PINCTRL_S3C64XX
 	{ .compatible = "samsung,s3c64xx-pinctrl",
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 9b3db50adef3..cbb78178651b 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -122,6 +122,9 @@ struct samsung_pin_bank_type {
  * @eint_type: type of the external interrupt supported by the bank.
  * @eint_mask: bit mask of pins which support EINT function.
  * @eint_offset: SoC-specific EINT register or interrupt offset of bank.
+ * @mask_offset: SoC-specific EINT mask register offset of bank.
+ * @pend_offset: SoC-specific EINT pend register offset of bank.
+ * @combine: EINT register is adjacent to the GPIO control register.
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
+ * @combine: EINT register is adjacent to the GPIO control register.
  * @name: name to be prefixed for each pin in this pin bank.
  * @id: id of the bank, propagated to the pin range.
  * @pin_base: starting pin number of the bank.
@@ -170,6 +179,9 @@ struct samsung_pin_bank {
 	enum eint_type	eint_type;
 	u32		eint_mask;
 	u32		eint_offset;
+	u32		mask_offset;
+	u32		pend_offset;
+	bool		combine;
 	const char	*name;
 	u32		id;
 
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

