Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8C1809D96
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573350AbjLHHvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573342AbjLHHu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:50:27 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E101173D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:50:31 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231208075022epoutp02df8883623f2bf42ea8f1721f91321333~ey9Rcu2cp2045920459epoutp02S
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:50:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231208075022epoutp02df8883623f2bf42ea8f1721f91321333~ey9Rcu2cp2045920459epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702021822;
        bh=tDx7+j5DykI148IvsokWJUA3ERR2qHhvO15Vvo+brS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qx41GLFpCix6yG6WToUPIbRxheV62itvLf4+9xgoGCv27APHgcNzsvimgFxz6FC6L
         N12c/wW72xotEdqSK84t14P8VU71UxREi/qXqS8iV8oSk9FaVD+q8sGWRHoY/BpxaI
         I7bauuH0eRkDmxiWis0hxezZm5MbzqpWvW/EXID8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231208075021epcas2p3a079d1a5512c90ba6e2d2a98a9002f2b~ey9Q5Ug5P0598705987epcas2p3n;
        Fri,  8 Dec 2023 07:50:21 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Smjwr6vH2z4x9Q1; Fri,  8 Dec
        2023 07:50:20 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.D3.10006.CBAC2756; Fri,  8 Dec 2023 16:50:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231208075020epcas2p414c85e03d18327665eeff54082314b56~ey9P6bxPo0754707547epcas2p48;
        Fri,  8 Dec 2023 07:50:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231208075020epsmtrp1a874498b4d1f8fb3e2635c9b45b4a7c1~ey9P36vit0202202022epsmtrp11;
        Fri,  8 Dec 2023 07:50:20 +0000 (GMT)
X-AuditID: b6c32a45-3ebfd70000002716-7c-6572cabca78e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.C4.08755.CBAC2756; Fri,  8 Dec 2023 16:50:20 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231208075020epsmtip24c69b3412c34bfffa92e5bd6c348fd89~ey9PmcHxA1333813338epsmtip2Z;
        Fri,  8 Dec 2023 07:50:20 +0000 (GMT)
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
Subject: [PATCH v3 4/4] pinctrl: samsung: add exynosautov920 pinctrl
Date:   Fri,  8 Dec 2023 16:45:27 +0900
Message-ID: <20231208074527.50840-5-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208074527.50840-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbdRTH8+ttby8QyKUw91u7sdrFGSBASyi9kLEtguYmg4UpMWZO8Ao3
        hVHaprc1G2oECTBAnh1sLa+yYiYNG1mhS4dUkVZFgqCDDWXjYcQpLyMsbsrGYuntdP99f+d8
        vr9zzu+BIYIpVIgVqPW0Tk2pJGgg97o7kogZGtPR0ukmObHYcR0lel0THKLTM8Ejyqx9KOEs
        8fCIP9r3Eq5VB584//gyh7D/cptH9Hc+BsTUYBtKzM3ZAHFx8nMOMW6t5RPlLg+fcK9V8oh/
        Bju4hG3Qy91pNIKjYeQN8xyftNuqUPLu7SGU/KK9l0/2d39I1m9LyboBGyDv2yMysZOFh/Jp
        Ko/WiWl1riavQK1MkRx7LSc1R54olcXIkgiFRKymiugUSVp6ZswrBSrvOBLxu5TK4A1lUgwj
        iTt8SKcx6GlxvobRp0hobZ5Kq9DGMlQRY1ArY9W0PlkmlcbLveDbhfnDGys87cdvnrHcaOaW
        gKmMahCAQTwBrj4y8qtBICbAnQC6v5pB2cUmgLWTHyHs4gGALabfeE8tTdeaeGzCBaBj4aqf
        2gDwZtV5zg6F4tHwYZ/V5wjHFxC4WvHeDoTglRzY8WCZu5MIw9PgZFsZsqO5+Avwlu2uLx6M
        p8DtlicoW24/tDov+5gA/DC01DoRlgmF35qWfDziZcocrQjLj2PQ6jjC6jTYuHaVw+owuPLN
        AJ/VQrhcX+HXGlgxPe7X78NrlpuA1Ueg+dGAdwDMu38k7BuM25EQPwA9s/6qIfCce5vPhoPh
        uQoBazwIF5on/M3vhU2eHn8DJBy7M+RrUoA3Alh+T9UAxOZnZjE/M4v5/7oWgNjAc7SWKVLS
        TLxW9t8F52qK7MD3uqNedgLj+p+xI4CDgREAMUQSHqya1NCC4DzqbDGt0+ToDCqaGQFy70k3
        IsJduRrv91Drc2QJSdKExESZIl4uVUh2B8+Xt+cJcCWlpwtpWkvrnvo4WICwhBO1tZiV7Om8
        gmd1IwFryz2iU9np+w4e6+0ZNZSj87rwU/V7AnPiQu2iH9ZfPT3pUIXZRgPt/Z9EL5yMWO4L
        kUdWCvGf58XjennWcND9lT2/ZxebGraMjaWbH6SNbJS6m5SLhoWO5Ldc2SI9N1VZfUDYbA5J
        r1vkt176einoR8tEze6HxghHRtdo/fAbx6+8pPhefvZvIAx/3iXiBoTWbF4ofXFWsX4C636i
        vvX6X2hmRujMdybC5DaUhH0a/xkTlTS//ydp++nQrtmxC9G/HqVrjtcFdc0023chdV+SVdSJ
        aaeoLvFMQ+uQE23bmukSJW7uK8q41PJOavG9pWHpImmUcJl8ShaF6BjqX/8r/IxmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvO6eU0WpBqvOCFs8mLeNzWLN3nNM
        FvOPnGO1aF68ns1iR8MRVot3c2Us9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWd++uYrSY
        cX4fk8WZxb3sFq17j7BbHH7Tzmrxc9c8FotVu4Dqbk+czOgg7LFz1l12j02rOtk87lzbw+ax
        f+4ado/NS+o9+v8aePRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfGgY+vWAt6oisW7JzK0sB4
        2beLkZNDQsBEYtLGSaxdjFwcQgK7GSX6Zs5mhUjISCx/1scGYQtL3G85AlX0nlHi96GPzCAJ
        NgFtie/rF4MlRASeM0uc/fMILMEs0M8kcX1TAogtLOAicX5OM1icRUBV4uqqOywgNq+ArcTf
        af+gNshLLN6xHKyGU8BOYkHvDjBbCKhmzdYOdoh6QYmTM5+wQMyXl2jeOpt5AqPALCSpWUhS
        CxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEealuYOxu2rPugdYmTiYDzEKMHB
        rCTCm3M+P1WINyWxsiq1KD++qDQntfgQozQHi5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QD
        k9HVZJnOeVrzfWIL0oVeNR/jnX73z2WWuEyuC8yZ7J/SdwVE3I6QuqE9WbVk+mPmW7ZeCdOa
        j6aEMWn/CGNynGy/p4OheinH/U5RTu2KN3eXs02RE7Fwa1hrqCBYtj4pt0xW3qfnZDm3r4hJ
        rmVA482QhIl3yl9xXFDdMKftgsGxl+Vnk5SDKnJyzsW7ptQW/byZ+fXWqXmV7/k4Tv1RWPnk
        7JFtvjfbNV78WBPzs0FOsf1QttuljZxvcjXzz306mVgSzLLKsv6z36Mdv9c7SV1RyJS+uenF
        wtzpv+LLDN2eM/8wZcvJP51n+5hjjyjX7y9LleI6vzE3lzI32jNEbEgI5nIK9YtRf7mJa7IS
        S3FGoqEWc1FxIgCYdcqgIwMAAA==
X-CMS-MailID: 20231208075020epcas2p414c85e03d18327665eeff54082314b56
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231208075020epcas2p414c85e03d18327665eeff54082314b56
References: <20231208074527.50840-1-jaewon02.kim@samsung.com>
        <CGME20231208075020epcas2p414c85e03d18327665eeff54082314b56@epcas2p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl data for ExynosAutov920 SoC.

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
 drivers/pinctrl/samsung/pinctrl-exynos.c      |  18 +++
 drivers/pinctrl/samsung/pinctrl-exynos.h      |  24 +++
 drivers/pinctrl/samsung/pinctrl-samsung.c     |   2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |   1 +
 5 files changed, 185 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
index cb965cf93705..a998c296dd05 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -796,3 +796,143 @@ const struct samsung_pinctrl_of_match_data fsd_of_data __initconst = {
 	.ctrl		= fsd_pin_ctrl,
 	.num_ctrl	= ARRAY_SIZE(fsd_pin_ctrl),
 };
+
+/* pin banks of exynosautov920 pin-controller 0 (ALIVE) */
+static const struct samsung_pin_bank_data exynosautov920_pin_banks0[] = {
+	EXYNOSV920_PIN_BANK_EINTW(8, 0x0000, "gpa0", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTW(2, 0x1000, "gpa1", 0x18, 0x20, 0x24),
+	EXYNOS850_PIN_BANK_EINTN(2, 0x2000, "gpq0"),
+};
+
+/* pin banks of exynosautov920 pin-controller 1 (AUD) */
+static const struct samsung_pin_bank_data exynosautov920_pin_banks1[] = {
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
+static const struct samsung_pin_bank_data exynosautov920_pin_banks2[] = {
+	EXYNOSV920_PIN_BANK_EINTG(6, 0x0000, "gph0", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(2, 0x1000, "gph1", 0x18, 0x20, 0x24),
+};
+
+/* pin banks of exynosautov920 pin-controller 3 (HSI1) */
+static const struct samsung_pin_bank_data exynosautov920_pin_banks3[] = {
+	EXYNOSV920_PIN_BANK_EINTG(7, 0x000, "gph8", 0x18, 0x24, 0x28),
+};
+
+/* pin banks of exynosautov920 pin-controller 4 (HSI2) */
+static const struct samsung_pin_bank_data exynosautov920_pin_banks4[] = {
+	EXYNOSV920_PIN_BANK_EINTG(8, 0x0000, "gph3", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(7, 0x1000, "gph4", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(8, 0x2000, "gph5", 0x18, 0x24, 0x28),
+	EXYNOSV920_PIN_BANK_EINTG(7, 0x3000, "gph6", 0x18, 0x24, 0x28),
+};
+
+/* pin banks of exynosautov920 pin-controller 5 (HSI2UFS) */
+static const struct samsung_pin_bank_data exynosautov920_pin_banks5[] = {
+	EXYNOSV920_PIN_BANK_EINTG(4, 0x000, "gph2", 0x18, 0x20, 0x24),
+};
+
+/* pin banks of exynosautov920 pin-controller 6 (PERIC0) */
+static const struct samsung_pin_bank_data exynosautov920_pin_banks6[] = {
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
+static const struct samsung_pin_bank_data exynosautov920_pin_banks7[] = {
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
+static const struct samsung_pin_ctrl exynosautov920_pin_ctrl[] = {
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
+		/* pin-controller instance 3 HSI1 data */
+		.pin_banks	= exynosautov920_pin_banks3,
+		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks3),
+		.eint_gpio_init	= exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 4 HSI2 data */
+		.pin_banks	= exynosautov920_pin_banks4,
+		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks4),
+		.eint_gpio_init	= exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 5 HSI2UFS data */
+		.pin_banks	= exynosautov920_pin_banks5,
+		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks5),
+		.eint_gpio_init	= exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 6 PERIC0 data */
+		.pin_banks	= exynosautov920_pin_banks6,
+		.nr_banks	= ARRAY_SIZE(exynosautov920_pin_banks6),
+		.eint_gpio_init	= exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 7 PERIC1 data */
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
index f798f64b1122..593633d09aa2 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -487,6 +487,22 @@ static const struct exynos_irq_chip exynos7_wkup_irq_chip __initconst = {
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
@@ -499,6 +515,8 @@ static const struct of_device_id exynos_wkup_irq_ids[] = {
 			.data = &exynos7_wkup_irq_chip },
 	{ .compatible = "samsung,exynosautov9-wakeup-eint",
 			.data = &exynos7_wkup_irq_chip },
+	{ .compatible = "samsung,exynosautov920-wakeup-eint",
+			.data = &exynosautov920_wkup_irq_chip },
 	{ }
 };
 
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index 5049c170e958..305cb1d31de4 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -141,6 +141,30 @@
 		.name		= id				\
 	}
 
+#define EXYNOSV920_PIN_BANK_EINTG(pins, reg, id, con_offs, mask_offs, pend_offs)	\
+	{							\
+		.type			= &exynos850_bank_type_off,	\
+		.pctl_offset		= reg,				\
+		.nr_pins		= pins,				\
+		.eint_type		= EINT_TYPE_GPIO,		\
+		.eint_con_offset	= con_offs,			\
+		.eint_mask_offset	= mask_offs,			\
+		.eint_pend_offset	= pend_offs,			\
+		.name			= id				\
+	}
+
+#define EXYNOSV920_PIN_BANK_EINTW(pins, reg, id, con_offs, mask_offs, pend_offs)	\
+	{							\
+		.type			= &exynos850_bank_type_alive,	\
+		.pctl_offset		= reg,				\
+		.nr_pins		= pins,				\
+		.eint_type		= EINT_TYPE_WKUP,		\
+		.eint_con_offset	= con_offs,			\
+		.eint_mask_offset	= mask_offs,			\
+		.eint_pend_offset	= pend_offs,			\
+		.name			= id				\
+	}
+
 /**
  * struct exynos_weint_data: irq specific data for all the wakeup interrupts
  * generated by the external wakeup interrupt controller.
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 362e99566919..800a2f0a026a 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1324,6 +1324,8 @@ static const struct of_device_id samsung_pinctrl_dt_match[] = {
 		.data = &exynosautov9_of_data },
 	{ .compatible = "tesla,fsd-pinctrl",
 		.data = &fsd_of_data },
+	{ .compatible = "samsung,exynosautov920-pinctrl",
+		.data = &exynosautov920_of_data },
 #endif
 #ifdef CONFIG_PINCTRL_S3C64XX
 	{ .compatible = "samsung,s3c64xx-pinctrl",
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
index 789358bcd9c5..987086fa0d1d 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.h
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
@@ -362,6 +362,7 @@ extern const struct samsung_pinctrl_of_match_data exynos7_of_data;
 extern const struct samsung_pinctrl_of_match_data exynos7885_of_data;
 extern const struct samsung_pinctrl_of_match_data exynos850_of_data;
 extern const struct samsung_pinctrl_of_match_data exynosautov9_of_data;
+extern const struct samsung_pinctrl_of_match_data exynosautov920_of_data;
 extern const struct samsung_pinctrl_of_match_data fsd_of_data;
 extern const struct samsung_pinctrl_of_match_data s3c64xx_of_data;
 extern const struct samsung_pinctrl_of_match_data s3c2412_of_data;
-- 
2.43.0

