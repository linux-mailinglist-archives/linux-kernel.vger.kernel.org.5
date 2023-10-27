Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D407D8DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 06:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbjJ0EEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 00:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJ0EEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 00:04:45 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697A41B1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 21:04:39 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231027040436epoutp036ff16c1cf16778692f34b2f9eb88a508~R2yK33YB22646426464epoutp03L
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:04:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231027040436epoutp036ff16c1cf16778692f34b2f9eb88a508~R2yK33YB22646426464epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698379476;
        bh=aDX3zvnF+fRtt5wIIVHBTyTD3vLT080LHTbz65XT1Hc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ELExcS9kUHEexepsudknt3e2GIUragsTV5tkSAWuJRgpPb218+46ko1dvB2z5gDQI
         JxECBvMe30WGOCqm8qCBaXi2cv6/AJHHojInOlGdK+EeihW1Wh56Ed2YFFTCWlrIk+
         hTmTt2p0Qo5nMunHaCnT5YO10+yS+9yitnswIxy4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231027040436epcas2p21a9ffa6dd46196e8db82257a03be207a~R2yKaJONG2314623146epcas2p2k;
        Fri, 27 Oct 2023 04:04:36 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SGpvl47vbz4x9Pw; Fri, 27 Oct
        2023 04:04:35 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.AE.09607.3D63B356; Fri, 27 Oct 2023 13:04:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231027040435epcas2p4628f9c61d4622ed4c4b62edc4486e2d1~R2yJh_DeH2938529385epcas2p42;
        Fri, 27 Oct 2023 04:04:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231027040435epsmtrp1efeba21c502e7fcaf50475eb8181fdbc~R2yJhSHlA1246512465epsmtrp1G;
        Fri, 27 Oct 2023 04:04:35 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-d0-653b36d332e2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.05.08817.3D63B356; Fri, 27 Oct 2023 13:04:35 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231027040434epsmtip2db0ce62e5ab00afe11de7e8ba50a993f~R2yJT084Z1325513255epsmtip2V;
        Fri, 27 Oct 2023 04:04:34 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH] arm64: dts: exynos: add gpio-key node for exynosautov9-sadk
Date:   Fri, 27 Oct 2023 13:03:37 +0900
Message-ID: <20231027040338.63088-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTQveymXWqwfEfchYP5m1js1iz9xyT
        xfwj51gtdjQcYbXoe/GQ2WLT42usFpd3zWGzmHF+H5NF694j7A6cHptWdbJ53Lm2h81j85J6
        j74tqxg9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
        8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeX
        WmJlaGBgZApUmJCdsXxTE1vBbqGKi2cOsDQwNvJ3MXJwSAiYSKzaXNjFyMUhJLCDUeLVg142
        COcTo8S3ec2MEM43RonLM/cxdTFygnUc3dzIDJHYyyjx6O0VqJaPjBK3JtwHq2IT0Jb4vn4x
        K0hCRGANo8TqT5tZQBxmgQ2MEsf2v2AFqRIW8JH4uX4CE8glLAKqEkdm24KEeQVsJa507GGB
        WCcvsWfRdyaIuKDEyZlPwOLMQPHmrbPBzpAQuMUu8eHEV6gGF4m+JT3sELawxKvjW6BsKYmX
        /W1QdrZE+/Q/rBB2hcTFDbPZIGxjiVnP2hlB7mEW0JRYv0sfEkjKEkduQa3lk+g4/JcdIswr
        0dEmBNGoJnF/6jmoITISk46shAaWh8SNeefBFgkJxErM2PSAeQKj/Cwkz8xC8swshL0LGJlX
        MYqlFhTnpqcWGxWYwCM1OT93EyM4SWp57GCc/faD3iFGJg7GQ4wSHMxKIryRPhapQrwpiZVV
        qUX58UWlOanFhxhNgaE7kVlKNDkfmKbzSuINTSwNTMzMDM2NTA3MlcR577XOTRESSE8sSc1O
        TS1ILYLpY+LglGpgCvG793O9dOpbTa4K7qt7D1xmn2r1QsJZYkU5p+VjvpMrHlyUfRNRcDP8
        6aHDDVs9u5kkFrFnC7QFpiQeMllX2b392uvWPPMjfj8TLFx7Khs1lql0bU5+pfNVl8dxjuKU
        nWcv/dt5quL3J5WUPo42p99LV9jZSJ2Mz859O0Ou/8DjzByGlKdb3+4P0xPYXhCs8saiNcX9
        /6u58a2/KnOnHpMX/ifpkVWkcSpyb+SDzjtm9oK2AYnpgYF8X16VcOQ7qGb3nTo199GC/EOa
        UsvncmsHNfaYHrrRPOFeYvTmK/1b5x/WNPe7+vLjulnKBTu+6u2c+9fPy26Jv+vHn9Zvrsze
        YHq6wOCh8VH/PPYTSizFGYmGWsxFxYkA70z/ChsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSvO5lM+tUg72TWC0ezNvGZrFm7zkm
        i/lHzrFa7Gg4wmrR9+Ihs8Wmx9dYLS7vmsNmMeP8PiaL1r1H2B04PTat6mTzuHNtD5vH5iX1
        Hn1bVjF6fN4kF8AaxWWTkpqTWZZapG+XwJWxfFMTW8FuoYqLZw6wNDA28ncxcnJICJhIHN3c
        yNzFyMUhJLCbUaLv0nk2iISMxPJnfVC2sMT9liOsEEXvGSX2bj7LDpJgE9CW+L5+MVhCRGAd
        o0TLt5eMIA6zwBZGiYvHn4G1Cwv4SPxcP4Gpi5GDg0VAVeLIbFuQMK+ArcSVjj0sEBvkJfYs
        +s4EEReUODnzCVicGSjevHU28wRGvllIUrOQpBYwMq1ilEwtKM5Nzy02LDDKSy3XK07MLS7N
        S9dLzs/dxAgOXS2tHYx7Vn3QO8TIxMF4iFGCg1lJhDfSxyJViDclsbIqtSg/vqg0J7X4EKM0
        B4uSOO+3170pQgLpiSWp2ampBalFMFkmDk6pBqZ+MQ4mq+BdiQXTmtyd2R21C5++Cd259POh
        11MKnxf1ih5o5FubprJlzpeVy80Zb3C9Eak6y3bg/9QNRydd2GT1tkxfnP9Z/x/v9duUepY8
        Yzrw2tguRt/T5dg0fcbXLa07hK41q/KcCyhK+rdQUzX/ziJbhdNt+78unSLrVHO8bqUnc9uU
        7u3ym6z8FZotn7RpNl57UPpMsO21hI/eMuWnrc4xLVu25X2rCuMQ95e+oO3Kvrr0UkjFsoSJ
        UwqlaqsTOdae3+fA9Hf/Rwv+m6cX3fltFHpNZ9vN69ndATl9y6Z26BnVRV465xtW8N8nwPN9
        N3PqVZtjAbnv1lzsfFJ0WtpLyiBqH/eamlOsf5VYijMSDbWYi4oTAYB5BJvMAgAA
X-CMS-MailID: 20231027040435epcas2p4628f9c61d4622ed4c4b62edc4486e2d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231027040435epcas2p4628f9c61d4622ed4c4b62edc4486e2d1
References: <CGME20231027040435epcas2p4628f9c61d4622ed4c4b62edc4486e2d1@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ExynosAutov9 SADK board has 3 keys to test external GPIO interrupt.
To support this, add 3 gpio-key(Wakeup, Volume Down, Volume Up) node.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 .../boot/dts/exynos/exynosautov9-sadk.dts     | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
index bc1815f6ada2..de2c1de51a76 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
+++ b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
@@ -9,6 +9,7 @@
 /dts-v1/;
 #include "exynosautov9.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Samsung ExynosAuto v9 SADK board";
@@ -32,6 +33,31 @@ memory@80000000 {
 		      <0xa 0x00000000 0x2 0x00000000>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&key_wakeup &key_volup &key_voldown>;
+
+		key-wakeup {
+			label = "Wakeup";
+			linux,code = <KEY_WAKEUP>;
+			gpios = <&gpa0 0 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			gpios = <&gpg2 0 GPIO_ACTIVE_LOW>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&gpg1 5 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	ufs_0_fixed_vcc_reg: regulator-0 {
 		compatible = "regulator-fixed";
 		regulator-name = "ufs-vcc";
@@ -49,6 +75,31 @@ ufs_1_fixed_vcc_reg: regulator-1 {
 	};
 };
 
+&pinctrl_alive {
+	key_wakeup: key-wakeup-pins {
+		samsung,pins = "gpa0-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+};
+
+&pinctrl_peric1 {
+	key_voldown: key-voldown-pins {
+		samsung,pins = "gpg2-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+
+	key_volup: key-volup-pins {
+		samsung,pins = "gpg1-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
+	};
+};
+
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm_tout3>;
-- 
2.42.0

