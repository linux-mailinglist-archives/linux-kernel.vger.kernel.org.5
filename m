Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44A17DCA21
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbjJaJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236053AbjJaJvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:51:09 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCC71BE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:50:40 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231031095023epoutp01346061bfd3f5d005df565f2b39d0c668~TKFNvrMWB1096410964epoutp01X
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:50:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231031095023epoutp01346061bfd3f5d005df565f2b39d0c668~TKFNvrMWB1096410964epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698745823;
        bh=t5IrulBEYs/pAFYmxibKmCqgtb1DKb9WLtc5ml9R97Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azirv0p+v+R4SHX1eWSvf14YMSjWKT42IBbOTVJz/UuEKBiHIbAJsQa9qGLcoxVNe
         3NlWKiDBkt/XaBpxZ2W86yHgQtr1wK36DOClR8C098jcfUcH9Ho6jcL4Wh2t9OFD0z
         plq+/W7sg/veK06hy6QVsXP0WWtOkxEPw3sdtSxQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231031095022epcas2p32b0faa9af82c5f2ea617f8e135b7c3e7~TKFNWJYht0127001270epcas2p3K;
        Tue, 31 Oct 2023 09:50:22 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SKQNt29TGz4x9Pt; Tue, 31 Oct
        2023 09:50:22 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.1E.10022.EDDC0456; Tue, 31 Oct 2023 18:50:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231031095021epcas2p343514064dc0da3fff87e4b8a24d895fd~TKFMSIeNY0127001270epcas2p3G;
        Tue, 31 Oct 2023 09:50:21 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231031095021epsmtrp24e846dd33a0bb2a6729563a9dd777dcc~TKFMRTggq1473914739epsmtrp2M;
        Tue, 31 Oct 2023 09:50:21 +0000 (GMT)
X-AuditID: b6c32a47-9a3ff70000002726-34-6540cdde65f7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.42.07368.DDDC0456; Tue, 31 Oct 2023 18:50:21 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231031095021epsmtip13a8fcaf2ab6663eeb538bf106d2d2005~TKFLz3D4h2273922739epsmtip1q;
        Tue, 31 Oct 2023 09:50:21 +0000 (GMT)
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
Subject: [PATCH 10/10] arm64: dts: exynos: add minimal support for
 exynosautov920 sadk board
Date:   Tue, 31 Oct 2023 18:47:52 +0900
Message-ID: <20231031094852.118677-11-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031094852.118677-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKJsWRmVeSWpSXmKPExsWy7bCmqe69sw6pBtOeclg8mLeNzWLN3nNM
        FvOPnGO1aF68ns1iR8MRVot3c2Us9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWd++uYrSY
        cX4fk8WZxb3sFq17j7BbHH7Tzmrxc9c8FotVu4Dqbk+czOgg7LFz1l12j02rOtk87lzbw+ax
        f+4ado/NS+o9+v8aePRtWcXo8XmTXABHVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
        oaWFuZJCXmJuqq2Si0+ArltmDtA7SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC
        8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjDfvmxkLbopXvOx4ytbAOF+4i5GTQ0LARGLmt08s
        XYxcHEICOxglrn2YxwrhfGKUmH/0KlTmG6NEw6Ed7DAtjU+72CESexkltm7vZ4RwPjJKrJ/e
        xwJSxSagLfF9/WJWEFtE4AuzxPRH1SBFzALtTBLzvr0EKxIWiJPY9HwKG4jNIqAqMW/jXyYQ
        m1fAXuLagmZmiHXyEnsWfQeLcwLFd/Y0MULUCEqcnPkEbA4zUE3z1tnMIAskBK5wSOy4uYEN
        otlF4tjEbkYIW1ji1fEtUD9ISXx+txeqJluiffofVgi7QuLihtlQcWOJWc/agXo5gBZoSqzf
        pQ9iSggoSxy5BbWWT6Lj8F92iDCvREebEESjmsT9qeeghshITDqykgnC9pDobbzEBAmrSYwS
        M842MU5gVJiF5JtZSL6ZhbB4ASPzKkax1ILi3PTUYqMCY3gUJ+fnbmIEp28t9x2MM95+0DvE
        yMTBeIhRgoNZSYT3sKlDqhBvSmJlVWpRfnxRaU5q8SFGU2BYT2SWEk3OB2aQvJJ4QxNLAxMz
        M0NzI1MDcyVx3nutc1OEBNITS1KzU1MLUotg+pg4OKUamOZlL/cq7HnT2t3CvqJ+T2jC43d/
        p0/P5RIPjG1LCPr7vPFLVnDL6ekdldXlR/fFrRIxe6cZuz3UxzxezMXkPeur078vKLGHMTz6
        9v387hmmGm0GWWI8MdWqFw7sv/Pd7xbzwStq+xaJN3zcyhm74aLilwlGG9bM2BLrO/MUw2vd
        DSecys7LbJl2Pskge9961903dauzFI+lrmlfPkFiWbSDz8y77w8utZoQXMb5MKdEpPyRaezB
        afp/+Yzr6hStXz3bJslks8N28YpvTX+2KN4x/2cdO+vOJmvX0LtT5l9ktuHunrj/3lVT57Z5
        18M3aBgx7PIUTfVleP4wfte3BW9FFtStNNU5efh+lnX20k1KLMUZiYZazEXFiQCb4RbDaAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTvfuWYdUg1vP5C0ezNvGZrFm7zkm
        i/lHzrFaNC9ez2axo+EIq8W7uTIWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLu3dXMVrM
        OL+PyeLM4l52i9a9R9gtDr9pZ7X4uWsei8WqXUB1tydOZnQQ9tg56y67x6ZVnWwed67tYfPY
        P3cNu8fmJfUe/X8NPPq2rGL0+LxJLoAjissmJTUnsyy1SN8ugSvjzftmxoKb4hUvO56yNTDO
        F+5i5OSQEDCRaHzaxd7FyMUhJLCbUWLdvOWsEAkZieXP+tggbGGJ+y1HWCGK3jNK3LrTwQSS
        YBPQlvi+fjFYQkTgF7PE7gl3GUESzAL9TBLXNyV0MXJwCAvESDy5bg0SZhFQlZi38S9YL6+A
        vcS1Bc3MEAvkJfYs+g4W5wSK7+xpAhsjJGAncXHDTah6QYmTM5+wQIyXl2jeOpt5AqPALCSp
        WUhSCxiZVjFKphYU56bnJhsWGOallusVJ+YWl+al6yXn525iBMeZlsYOxnvz/+kdYmTiYDzE
        KMHBrCTCe9jUIVWINyWxsiq1KD++qDQntfgQozQHi5I4r+GM2SlCAumJJanZqakFqUUwWSYO
        TqkGptOiK7y/rX/DyBZf5eWyVUnx37ZLFdHmWxk+rvGJlhDm3/H1cSav3U/Dk0+2f9Yvu/VK
        a6aIfn6IZDXHvTSdiw8NNTfKKbQzfejkKtRg3hcYfyZhU8nzQ9qXV06aeL1348vFoUmvLGKu
        3Yub6XzgUXJfUrn3sULW46vrn2+rtp+gvL3qxh6lpdMYogMmfQvTTWlbFPX4Hm/lvrRZt08W
        qTzZmXNrfaO3gc+k9w07GU48aNm/6/Lh26sd9uderW6df/zSvUj508wXHcustroarFx49pH/
        jNX3LXcwzmXqS3zRfV3H4uOlsGWM6V3lalpPd3XcY6yJ/cSzl1e59VNGocGN+Ag510tJ6Xf8
        tizJSFdiKc5INNRiLipOBADEScfPIgMAAA==
X-CMS-MailID: 20231031095021epcas2p343514064dc0da3fff87e4b8a24d895fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031095021epcas2p343514064dc0da3fff87e4b8a24d895fd
References: <20231031094852.118677-1-jaewon02.kim@samsung.com>
        <CGME20231031095021epcas2p343514064dc0da3fff87e4b8a24d895fd@epcas2p3.samsung.com>
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

ExynosAutov920 SADK is ExynosAutov920 SoC based SADK(Samsung Automotive
Development Kit) board. It has 16GB(8GB + 8GB) LPDDR5 RAM and 256GB
(128GB + 128GB) UFS.

This is minimal support board device-tree.
 * Serial console
 * GPIO Key
 * PWM FAN

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 arch/arm64/boot/dts/exynos/Makefile           |  3 +-
 .../boot/dts/exynos/exynosautov920-sadk.dts   | 88 +++++++++++++++++++
 2 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts

diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/exynos/Makefile
index 6e4ba69268e5..da06e1a9456c 100644
--- a/arch/arm64/boot/dts/exynos/Makefile
+++ b/arch/arm64/boot/dts/exynos/Makefile
@@ -5,4 +5,5 @@ dtb-$(CONFIG_ARCH_EXYNOS) += \
 	exynos7-espresso.dtb		\
 	exynos7885-jackpotlte.dtb	\
 	exynos850-e850-96.dtb		\
-	exynosautov9-sadk.dtb
+	exynosautov9-sadk.dtb		\
+	exynosautov920-sadk.dtb
diff --git a/arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts b/arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts
new file mode 100644
index 000000000000..e250b5594b58
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung's ExynosAutov920 SADK board device tree source
+ *
+ * Copyright (c) 2023 Samsung Electronics Co., Ltd.
+ *
+ */
+
+/dts-v1/;
+#include "exynosautov920.dtsi"
+#include "exynos-pinctrl.h"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Samsung ExynosAutov920 SADK board";
+	compatible = "samsung,exynosautov920-sadk", "samsung,exynosautov920";
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &serial_0;
+	};
+
+	chosen {
+		stdout-path = &serial_0;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x70000000>,
+		      <0x8 0x80000000 0x1 0xfba00000>,
+		      <0xa 0x00000000 0x2 0x00000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&key_wakeup &key_back>;
+
+		key-wakeup {
+			label = "KEY_WAKEUP";
+			linux,code = <KEY_WAKEUP>;
+			gpios = <&gpa0 0 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+
+		key-back {
+			label = "KEY_BACK";
+			linux,code = <KEY_BACK>;
+			gpios = <&gpp6 3 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&pinctrl_alive {
+	key_wakeup: key-wakeup-pins {
+		samsung,pins = "gpa0-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+	};
+};
+
+&pinctrl_peric1 {
+	key_back: key-back-pins {
+		samsung,pins = "gpp6-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+	};
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_tout0>;
+	status = "okay";
+};
+
+&serial_0 {
+	status = "okay";
+};
+
+&usi_0 {
+	samsung,clkreq-on; /* needed for UART mode */
+	status = "okay";
+};
+
+&xtcxo {
+	clock-frequency = <38400000>;
+};
-- 
2.42.0

