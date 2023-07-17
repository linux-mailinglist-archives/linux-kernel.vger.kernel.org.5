Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAC3755BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGQGir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGQGil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:38:41 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA6311C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:38:40 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230717063838epoutp031a9e30f25675d511cf200fbf6ce3afdd~ylFijfD8J2127521275epoutp03T
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:38:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230717063838epoutp031a9e30f25675d511cf200fbf6ce3afdd~ylFijfD8J2127521275epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689575918;
        bh=7IlN+/vOFpy/kZO8jlCQ1rWIEH+D8SX1OhK9NB37YCk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=X0zpziFk2gwcHXZHdcfH64MdFNpkvMeFvr6Ic9KEQLxI10Y7w9MtfboxTh0fRJXZ0
         bCbKwmCFNwlHbw+2S/itKoUsSKDS8r4ieIdIwZE4n4CycxocBhs1eu4JucCUuEf1Eb
         Utd/Q6GSiCphnoLqkb+6mZ945K5tqdHEZzHqRLmw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230717063837epcas2p37b528d9a3d00d4a148c41b90d4917c9e~ylFh779rH1900219002epcas2p3U;
        Mon, 17 Jul 2023 06:38:37 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4R4C8Y4XWPz4x9Q1; Mon, 17 Jul
        2023 06:38:37 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.4D.49913.DE1E4B46; Mon, 17 Jul 2023 15:38:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230717063837epcas2p3780fbf0f8c12ca070aa296766d0eb5e8~ylFhEBG441900219002epcas2p3P;
        Mon, 17 Jul 2023 06:38:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230717063837epsmtrp10579e02b2b7977c549a5225cf3a1414c~ylFhDBuos1682716827epsmtrp1B;
        Mon, 17 Jul 2023 06:38:36 +0000 (GMT)
X-AuditID: b6c32a45-5cfff7000000c2f9-93-64b4e1ed0f2c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.60.34491.CE1E4B46; Mon, 17 Jul 2023 15:38:36 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230717063836epsmtip2d0ed344014d8d5ae2e73c3633f2a756b~ylFgx2w2U2665326653epsmtip2J;
        Mon, 17 Jul 2023 06:38:36 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v3] arm64: dts: exynos: add pwm node for exynosautov9-sadk
Date:   Mon, 17 Jul 2023 15:33:19 +0900
Message-Id: <20230717063319.19974-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7bCmhe7bh1tSDBY8UrJ4MG8bm8WaveeY
        LOYfOcdqsaPhCKtF34uHzBabHl9jtbi8aw6bxYzz+5gsWvceYXfg9Ni0qpPN4861PWwem5fU
        e/RtWcXo8XmTXABrVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
        i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL28
        1BIrQwMDI1OgwoTsjMe33jEXXOepWHHsC2MD4y6uLkZODgkBE4mp/56zdjFycQgJ7GCUOLh9
        GiNIQkjgE6NE53weiMQ3RonGlftYYDr61nUyQyT2MkqsnP6TBcL5yChxrmEnWDubgLbE9/WL
        weaKCKxhlFj9aTNYFbPABkaJY/tfsIJUCQt4Sdw/9pUdxGYRUJW4uekWWDevgK3E6U0v2CD2
        yUus3nCAGcLexy7xeW8ohO0i8fVyC1RcWOLV8S3sELaUxMv+Nig7W6J9+h9WCLtC4uKG2VAz
        jSVmPWsH2sUBdJCmxPpd+iCmhICyxJFbYF8yC/BJdBz+yw4R5pXoaBOCaFSTuD/1HNQQGYlJ
        R1YyQdgeEn19p6EhFytx9+Jj1gmMsrMQ5i9gZFzFKJZaUJybnlpsVGAIj6Tk/NxNjOAkpuW6
        g3Hy2w96hxiZOBgPMUpwMCuJ8H5ftSlFiDclsbIqtSg/vqg0J7X4EKMpMLQmMkuJJucD02he
        SbyhiaWBiZmZobmRqYG5kjjvvda5KUIC6YklqdmpqQWpRTB9TBycUg1MNe2OHw58+d5S6OW/
        qv8cY1/WKS0x1tUrPzK/1zwf9ijQ+/Ck2qcCcs2F2xzW9Zs982Q9oRyw+GFz8xSdnKj2iwZS
        WkKdqyMEz7yYMGXR401dT9fqyRy66fyoZunTu1lMRhG/17auXXKqpTBWtX15lvLcvJ3z6t7P
        mfQ7qY+zZf2cEM5pi6aw/SxXqfh9KjAm+gfXq4g7h+sP/OU+xXhlclF95h/2yTW/MupPy1sf
        m7E6lqXthMvnqU6y07q/FgRXsPRXOki5tkc2nzlgfv1Q8ZXnvQ5cx02rgyfNVWUrMvWPeGk8
        W/TN0Rmr7C+KvFt33cLt3VbrBP9jEQ0z1/VsbwmsUKrmt413FL0oXCOoxFKckWioxVxUnAgA
        YIAfFusDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupiluLIzCtJLcpLzFFi42LZdlhJXvfNwy0pBk13TCwezNvGZrFm7zkm
        i/lHzrFa7Gg4wmrR9+Ihs8Wmx9dYLS7vmsNmMeP8PiaL1r1H2B04PTat6mTzuHNtD5vH5iX1
        Hn1bVjF6fN4kF8AaxWWTkpqTWZZapG+XwJXx+NY75oLrPBUrjn1hbGDcxdXFyMkhIWAi0beu
        k7mLkYtDSGA3o8T15ctYIRIyEsuf9bFB2MIS91uOsEIUvWeUmH9yGQtIgk1AW+L7+sVgCRGB
        dYwSLd9eMoI4zAJbGCUuHn8G1i4s4CVx/9hXdhCbRUBV4uamW4wgNq+ArcTpTS+gVshLrN5w
        gHkCI88CRoZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjBwaWluYNx+6oPeocYmTgY
        DzFKcDArifB+X7UpRYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv+IveFCGB9MSS1OzU1ILUIpgs
        EwenVAOTRJmhZrAo82Hd96vmNjnkK4TdPLn4Enu2XUteXF6fobr8uTNal691Ciw785Tz1Gcm
        l6Wf/03cN1dz3fcVhrH15oy8+fs/ZH3Y27+FfaJfWKx6QWO1qcDmkoRyds7jx0v9bjul+Ldk
        Hdx7O3dNq8ijfZ/cDEv+mi65p/h408QmKQnBNJXbf7MM1hntfBk8xfmvDPelW7MeCtefPLzl
        xPfJXdIB2tJ+WzJnFV6f0iocn1PsdfDAQp8Ph9eKnSia+13oZIfd9xu7fRxuen3vaLySbbRJ
        86dG8czyiwouIos+V4RJKPYWH+0qs+381ddu83V+am3E8pgjllUr9B+W14lsf35svhyfnkhz
        3KffGcxKLMUZiYZazEXFiQDIcj6nnQIAAA==
X-CMS-MailID: 20230717063837epcas2p3780fbf0f8c12ca070aa296766d0eb5e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230717063837epcas2p3780fbf0f8c12ca070aa296766d0eb5e8
References: <CGME20230717063837epcas2p3780fbf0f8c12ca070aa296766d0eb5e8@epcas2p3.samsung.com>
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

Add pwm node to support fan on exynosautov9-sadk board.
PWM channel 3 of ExynosAutov9 is connected to fan for SoC cooling
in SADK board.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
Changes in v3:
 - removed adding compatible to driver.

Changes in v2:
 - add compatible string to driver.
---
 arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts |  6 ++++++
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi     | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
index 898c2fc345ed..e717bb1cad81 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
+++ b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
@@ -50,6 +50,12 @@
 	};
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_tout3>;
+	status = "okay";
+};
+
 &serial_0 {
 	pinctrl-0 = <&uart0_bus_dual>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
index d3c5cdeff47f..3b906f4db907 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
@@ -1560,6 +1560,16 @@
 			samsung,syscon-phandle = <&pmu_system_controller>;
 			samsung,cluster-index = <1>;
 		};
+
+		pwm: pwm@103f0000 {
+			compatible = "samsung,exynosautov9-pwm",
+				     "samsung,exynos4210-pwm";
+			reg = <0x103f0000 0x100>;
+			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
+			#pwm-cells = <3>;
+			clocks = <&xtcxo>;
+			clock-names = "timers";
+		};
 	};
 };
 
-- 
2.17.1

