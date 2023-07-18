Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2310757423
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjGRG1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGRG1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:27:39 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F051709
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:27:27 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230718062725epoutp0270315544b648189057aea74a3c27e490~y4lB1BE5f1722217222epoutp02W
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:27:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230718062725epoutp0270315544b648189057aea74a3c27e490~y4lB1BE5f1722217222epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689661645;
        bh=vYQIAYiSqk2C1mX1NBxVZiqE0v3Msi5msNaJNXfmdDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rx2DYkqI8knI76Vqrddh61jluNwO0RDVIoWk4vsITbkXFAAGEWaKkSbWcYP7Z9/el
         8uGSvJ4IQh0GEL0rpgPPsFCh/erNTGdD2w/TLJVyn9KjBiS9SXwdAd5a+XB4DuvU/c
         haz/0lksnp7JIrpOVxIBZx7Te08oXJJA47ykbruw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230718062724epcas2p1b2f2cdddb702defa2f42c1caf10a2f08~y4lBWyg0p0717307173epcas2p1A;
        Tue, 18 Jul 2023 06:27:24 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.99]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4R4ps845Fxz4x9QJ; Tue, 18 Jul
        2023 06:27:24 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.67.32606.CC036B46; Tue, 18 Jul 2023 15:27:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230718062724epcas2p38ce71c6a195738a7bdc3871e6cbcf71c~y4lAsdEon1013710137epcas2p3t;
        Tue, 18 Jul 2023 06:27:24 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230718062724epsmtrp161251800ddcfc4192013b2bcf2ce0307~y4lAreBiR2319023190epsmtrp1i;
        Tue, 18 Jul 2023 06:27:24 +0000 (GMT)
X-AuditID: b6c32a47-9cbff70000007f5e-37-64b630ccccee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.DC.64355.BC036B46; Tue, 18 Jul 2023 15:27:24 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230718062723epsmtip272ad21406fcbc91d01efd7aa03165083~y4lAYnTZN0242102421epsmtip2V;
        Tue, 18 Jul 2023 06:27:23 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v6 2/2] arm64: dts: exynos: add pwm node for
 exynosautov9-sadk
Date:   Tue, 18 Jul 2023 15:22:00 +0900
Message-Id: <20230718062200.79306-3-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230718062200.79306-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmue4Zg20pBotfy1s8mLeNzWLN3nNM
        FvOPnGO12NFwhNWi78VDZotNj6+xWlzeNYfN4u7dVYwWM87vY7Jo3XuE3eLnrnksFrcnTmZ0
        4PHYOesuu8emVZ1sHneu7WHz2Lyk3qP/r4FH35ZVjB6fN8kFsEdl22SkJqakFimk5iXnp2Tm
        pdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA3amkUJaYUwoUCkgsLlbSt7Mpyi8t
        SVXIyC8usVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM64MHUWe8Ff7orGmxfZGxi/
        cnYxcnJICJhINCxqY+pi5OIQEtjBKDFhaxcLhPOJUeL3/p3MIFVgzv57aV2MHGAdj48lQdTs
        ZJQ4tO0uM4TzkVFi5oTljCANbALaEt/XL2YFsUUEFjJJPLtfBlLELHCaUWLtrScsIAlhgQCJ
        IzufsYPYLAKqEhOPt4PZvAK2ElPnnmeHuE9eYvWGA2BXcArYSazefRnsVgmBn+wS2z8tYoUo
        cpHYvX8rE4QtLPHq+BaoZimJl/1tUHa2RPv0P1D1FRIXN8xmg7CNJWY9a2cEeY1ZQFNi/S59
        iC+VJY7cAjuTWYBPouPwX3aIMK9ER5sQRKOaxP2p56CGyEhMOrIS6gAPiQd926AhOpFR4nnP
        R+YJjHKzEBYsYGRcxSiWWlCcm55abFRgDI+w5PzcTYzgZKjlvoNxxtsPeocYmTgYDzFKcDAr
        ifB+X7UpRYg3JbGyKrUoP76oNCe1+BCjKTDsJjJLiSbnA9NxXkm8oYmlgYmZmaG5kamBuZI4
        773WuSlCAumJJanZqakFqUUwfUwcnFINTKYfnjvazjp0YrnwAz7vRz23vxdJ+vGpS1V9jGSf
        8kgvt9uB0/74TvfVW0WVeNpnXlF4cGIe886mRxx6E02EF38USvIpFz1UxdQm3rp75YJvav0r
        Zj61FL06+6WfygETyT9/HrU6FNl2aJ+++/DZVF61wuPdt++l3244uksryu3dWafXluc2RO1X
        PHi6jS9C9c+6m6qbDs96O2uFS53yi+9ND6bccWiYerqqkeWH9byqJyV9hjNNbO8XeFxdNcG1
        Q/TUq/W271+eYbmW+LIpRmvX90WZqXl+ErJvCh3mT7sTH7nr0vv3Wx/c9uh+9aUy6nbWyiZn
        qZf519VunlEzP+4lOXsG8yeu/DsOiVJ7piQpsRRnJBpqMRcVJwIAURxhMQ8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSvO4Zg20pBs2LmS0ezNvGZrFm7zkm
        i/lHzrFa7Gg4wmrR9+Ihs8Wmx9dYLS7vmsNmcffuKkaLGef3MVm07j3CbvFz1zwWi9sTJzM6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79H/18Cjb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4Mi5M
        ncVe8Je7ovHmRfYGxq+cXYwcHBICJhKPjyV1MXJyCAlsZ5T4cIERxJYQkJFY/qyPDcIWlrjf
        coS1i5ELqOY9o8TzsztZQRJsAtoS39cvBkuICCxmknjT/RDMYRa4yChx4s8VdpAqYQE/ickv
        zzOD2CwCqhITj7eDxXkFbCWmzj3PDrFCXmL1hgNgNZwCdhKrd19mgjjJVmLFvXlMExj5FjAy
        rGIUTS0ozk3PTS4w1CtOzC0uzUvXS87P3cQIDlitoB2My9b/1TvEyMTBeIhRgoNZSYT3+6pN
        KUK8KYmVValF+fFFpTmpxYcYpTlYlMR5lXM6U4QE0hNLUrNTUwtSi2CyTBycUg1ME4+yhB/S
        Zn0cMz3k2NOAuo6Koz6/UraqLPh5xSyAqePCHi2Obd1ph1Z1/kkp+RLcLVTD0vu1oXnPyXKx
        Xb95Hbb6v0nb47iQ62YwxzOW5TPvux5vlDzYM9tHL8bE6f3pTU9jHz1OqL9+eWfmldCoq5Nu
        bXO+mngjf9mRyW/4tjJ1BlXf3jvj7KYXjptMTtmrRr0L227TovKWo7HF7YPhq4iZaUWnBS8X
        7lV5vP6v8f0/U0Vr9lj9n560q1cwu5ub7fXGapHa2on9j7IefY6Z45lyKVDD+OT8x6e5q34q
        +p/nvqeiUK1k9Do/dfFh83yeFW8E5IyD/vLcare9eu2AX5WrwYPVJpmJN9NqOm6aK7EUZyQa
        ajEXFScCAEl17C/HAgAA
X-CMS-MailID: 20230718062724epcas2p38ce71c6a195738a7bdc3871e6cbcf71c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230718062724epcas2p38ce71c6a195738a7bdc3871e6cbcf71c
References: <20230718062200.79306-1-jaewon02.kim@samsung.com>
        <CGME20230718062724epcas2p38ce71c6a195738a7bdc3871e6cbcf71c@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts |  6 ++++++
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi     | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
index 101f51bf565a..bc1815f6ada2 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
+++ b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
@@ -49,6 +49,12 @@
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
index d3c5cdeff47f..16669b0443fa 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
@@ -1560,6 +1560,17 @@
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
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.17.1

