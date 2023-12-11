Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CA780C83C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjLKLmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKLmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:42:16 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00B8D0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:42:19 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231211114217epoutp03eb4e1d6f208a36a81c605d7b89830486~fxDoXIssG0402204022epoutp03Y
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:42:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231211114217epoutp03eb4e1d6f208a36a81c605d7b89830486~fxDoXIssG0402204022epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702294937;
        bh=XoAvqTdk5kaf7nCihnVXE8nDb9SYdgoT9hIxCHdPJ2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oeFs6qrQXMzsZXjvZkuueLXApUclEAT2j5Lk3gr9skbIOCCUiAXKDEgYJ+THWOC+F
         ySAf5izVy+fUBDx2nr/E+4d4Yq2ReD3OLYi5y0/eG1yoKfQ8cEgXoVI8341dt8FpBf
         v/5zTv1uqHhQHH7Z8NxTbLtdnIesf32ABq9+PQ8g=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231211114217epcas2p2ec0065aec6bb6512c4caf7d431bda313~fxDntD-ns1416514165epcas2p2e;
        Mon, 11 Dec 2023 11:42:17 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.69]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Spfx44MFwz4x9Pp; Mon, 11 Dec
        2023 11:42:16 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.26.10022.895F6756; Mon, 11 Dec 2023 20:42:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231211114216epcas2p300bbf4c592d495991c6cc2d96e0b1f85~fxDmqLczW2486024860epcas2p3C;
        Mon, 11 Dec 2023 11:42:16 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231211114216epsmtrp1cb9e7b8590a47fab43111b9f3eab7827~fxDmn2Gsa0416704167epsmtrp1Y;
        Mon, 11 Dec 2023 11:42:16 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-1b-6576f598991f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.D5.08817.795F6756; Mon, 11 Dec 2023 20:42:15 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231211114215epsmtip2ffc263fdc9ff52df6b44a81bd6058682~fxDmUOKKO0860908609epsmtip2g;
        Mon, 11 Dec 2023 11:42:15 +0000 (GMT)
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
Subject: [PATCH v4 2/2] pinctrl: samsung: add exynosautov920 pinctrl
Date:   Mon, 11 Dec 2023 20:41:45 +0900
Message-ID: <20231211114145.106255-3-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211114145.106255-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmqe6Mr2WpBgvXyVk8mLeNzWLN3nNM
        FvOPnGO1aF68ns1iR8MRVot3c2Us9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWd++uYrSY
        cX4fk8WZxb3sFq17j7BbHH7Tzmrxc9c8FotVu4Dqbk+czOgg7LFz1l12j02rOtk87lzbw+ax
        f+4ado/NS+o9+v8aePRtWcXo8XmTXABHVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
        oaWFuZJCXmJuqq2Si0+ArltmDtA7SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC
        8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjCe97WwFfYkVN7/+YGtgPBPUxcjJISFgItE48Spz
        FyMXh5DADkaJeVMa2SGcT4wSHzvaoJxvjBKrFu1jhGn58mITK0RiL6PEk75djBDOR0aJh4e+
        gFWxCWhLfF+/mBXEFhG4zyzxuq0apIhZoJ1JYt63lyxdjBwcwgIuEueaikFqWARUJV7/uc0M
        YvMK2Ekc3/WHBWKbvMTiHcvB4pwC9hInNz5igqgRlDg58wlYDTNQTfPW2WBPSAhc4JDYu+k7
        O0Szi8Tm1gNQtrDEq+NboGwpiZf9bVB2vkTblTNQdo3ExgWXoN60l1h05ic7yJ3MApoS63fp
        g5gSAsoSR25BreWT6Dj8lx0izCvR0SYE0agmcX/qOTYIW0Zi0pGVTBC2h8Su3rsskKCaxChx
        88sBpgmMCrOQfDMLyTezEBYvYGRexSiWWlCcm55abFRgDI/h5PzcTYzg5K3lvoNxxtsPeocY
        mTgYDzFKcDArifDKHClOFeJNSaysSi3Kjy8qzUktPsRoCgzricxSosn5wPyRVxJvaGJpYGJm
        ZmhuZGpgriTOe691boqQQHpiSWp2ampBahFMHxMHp1QDk7fV9mTrS0+ZObRXHndzV3kuvK/1
        x7bYfSGab7L/3T80Szjl8UypheUrcndq51Zkid80CF4vLHRmYbbj9QOfZnc8CrF26XcNf35M
        /46oX2jzhmSrY3eSPGZu3RYZM/Hmpf/yP4oips9uqz6reKDx4TmVya5OKeK7njmFOs58Wlfr
        td/n+K7nepcrNTVdZ16XldR2EDYOd9g78ckmKYb15559OLxw2aI7F4v3+jBqlTJeUzhbPydp
        6SbVsuKil/WeUydcmnggPFbPn8NF43Pcf+/F2d0nNbZNLykTeGUUPrPYfUGnYM03iWNBdun7
        Qv/On6KWoLRh6vKSgim860+Wm//pXh3ds26BfO39iusmK5RYijMSDbWYi4oTATBQFQRnBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJXnf617JUg/mLrCwezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjissmJTUnsyy1SN8ugSvjSW87W0FfYsXNrz/YGhjP
        BHUxcnJICJhIfHmxiRXEFhLYzSgx6X0xRFxGYvmzPjYIW1jifssRoBouoJr3jBKft39iBEmw
        CWhLfF+/GCwhIvCcWeLsn0fMIAlmgX4mieubEroYOTiEBVwkzjWBDWURUJV4/ec2WAmvgJ3E
        8V1/WCAWyEss3rEcLM4pYC9xcuMjJoiD7CTmfdzNClEvKHFy5hMWiPHyEs1bZzNPYBSYhSQ1
        C0lqASPTKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4CjT0trBuGfVB71DjEwcjIcY
        JTiYlUR4ZY4UpwrxpiRWVqUW5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgmy8TB
        KdXAtLXW9EbXsrNzn8Vp/v7V5MLezd7oln0pyvYnZ9s8oz32b5blzD0pd2/BBbbaiMTTRi9n
        WPH8tW1iv7mauT912ob4lSfPbV936dfBKcJGC7ZM+B7YnOQoZ6uV+uBy7IoOltZw86qlETfs
        7shH3vqrwF56OubMDHGPwKqj3564W/rsVdIqfD/t+TfjC+4OT5j6vTwO7Pb7tDCls0JU6pfn
        tC31Zu2qHkt5Skr6Di6b1v/6vF77PL2Ie9PPSL5LqLglKxsyrSr+3R37CbzPBeLYIlt0f7N+
        M/sjt01Z6InAmc0ZXuJCt7KXBM74O/sy//o0vtnGNmsWJhcKppatOXDPiP/tsqD27VMF9AVV
        dBd/VmIpzkg01GIuKk4EAFvf4JshAwAA
X-CMS-MailID: 20231211114216epcas2p300bbf4c592d495991c6cc2d96e0b1f85
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231211114216epcas2p300bbf4c592d495991c6cc2d96e0b1f85
References: <20231211114145.106255-1-jaewon02.kim@samsung.com>
        <CGME20231211114216epcas2p300bbf4c592d495991c6cc2d96e0b1f85@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl data for ExynosAutov920 SoC.
It has a newly applied pinctrl register layer for ExynosAuto series.

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
 drivers/pinctrl/samsung/pinctrl-exynos.c      |  23 ++-
 drivers/pinctrl/samsung/pinctrl-exynos.h      |  25 ++++
 drivers/pinctrl/samsung/pinctrl-samsung.c     |   2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |   1 +
 5 files changed, 190 insertions(+), 1 deletion(-)

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
index 77f747e629f7..934426d61a6f 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -267,7 +267,10 @@ static irqreturn_t exynos_eint_gpio_irq(int irq, void *data)
 	unsigned int svc, group, pin;
 	int ret;
 
-	svc = readl(bank->eint_base + EXYNOS_SVC_OFFSET);
+	if (bank->eint_con_offset)
+		svc = readl(bank->eint_base + EXYNOSAUTO_SVC_OFFSET);
+	else
+		svc = readl(bank->eint_base + EXYNOS_SVC_OFFSET);
 	group = EXYNOS_SVC_GROUP(svc);
 	pin = svc & EXYNOS_SVC_NUM_MASK;
 
@@ -476,6 +479,22 @@ static const struct exynos_irq_chip exynos7_wkup_irq_chip __initconst = {
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
@@ -488,6 +507,8 @@ static const struct of_device_id exynos_wkup_irq_ids[] = {
 			.data = &exynos7_wkup_irq_chip },
 	{ .compatible = "samsung,exynosautov9-wakeup-eint",
 			.data = &exynos7_wkup_irq_chip },
+	{ .compatible = "samsung,exynosautov920-wakeup-eint",
+			.data = &exynosautov920_wkup_irq_chip },
 	{ }
 };
 
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index 3ac52c2cf998..305cb1d31de4 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -31,6 +31,7 @@
 #define EXYNOS7_WKUP_EMASK_OFFSET	0x900
 #define EXYNOS7_WKUP_EPEND_OFFSET	0xA00
 #define EXYNOS_SVC_OFFSET		0xB08
+#define EXYNOSAUTO_SVC_OFFSET		0xF008
 
 /* helpers to access interrupt service register */
 #define EXYNOS_SVC_GROUP_SHIFT		3
@@ -140,6 +141,30 @@
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
index 362e99566919..47fb72fad8eb 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1322,6 +1322,8 @@ static const struct of_device_id samsung_pinctrl_dt_match[] = {
 		.data = &exynos850_of_data },
 	{ .compatible = "samsung,exynosautov9-pinctrl",
 		.data = &exynosautov9_of_data },
+	{ .compatible = "samsung,exynosautov920-pinctrl",
+		.data = &exynosautov920_of_data },
 	{ .compatible = "tesla,fsd-pinctrl",
 		.data = &fsd_of_data },
 #endif
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

