Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF997537BB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbjGNKPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbjGNKPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:15:12 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6296735AF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:14:41 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230714101436epoutp0124e02f32845e5b8fdfd95a6fbeea90c3~xtGPhWvn-0708507085epoutp01i
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:14:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230714101436epoutp0124e02f32845e5b8fdfd95a6fbeea90c3~xtGPhWvn-0708507085epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689329676;
        bh=5y2wn7eKoq4joqL9pyavaB3xiLHVTS+gBfYcdENKvTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VqrB9gqbHHcf3LkWzZyhlAm2kTNaZRXgGrlQRAutv3XuqBN0d/A+bazr1FlIz80D6
         83o2RLlUGzKM/v0zOnGh81JAGOprWo0cSsbrDwVlCl2YsoR0eTdbKkFHYHLXDpS70z
         UIYG5F7Nwk5sgBZ1bMp7UnCs7LrfiQkgeCK71rfk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230714101435epcas2p4f21db32a8183f267bd6ec493900ceaa9~xtGOn9q882145921459epcas2p4o;
        Fri, 14 Jul 2023 10:14:35 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.89]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4R2S570P47z4x9Q2; Fri, 14 Jul
        2023 10:14:35 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.42.40133.A0021B46; Fri, 14 Jul 2023 19:14:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230714101434epcas2p1d52a733cf3d9c5d0d8f2c26ef1a85a00~xtGNkhLfQ0423904239epcas2p1K;
        Fri, 14 Jul 2023 10:14:34 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230714101434epsmtrp28cef28463dd16bf95d5fac3370f4805a~xtGNjsV0p0309603096epsmtrp2T;
        Fri, 14 Jul 2023 10:14:34 +0000 (GMT)
X-AuditID: b6c32a46-6fdfa70000009cc5-02-64b1200ad4f5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.E9.64355.A0021B46; Fri, 14 Jul 2023 19:14:34 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230714101433epsmtip10142344b7fe968c201268d93546300fa~xtGNWtkqX2241322413epsmtip19;
        Fri, 14 Jul 2023 10:14:33 +0000 (GMT)
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
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v2 3/3] arm64: dts: exynos: add pwm node for
 exynosautov9-sadk
Date:   Fri, 14 Jul 2023 19:09:29 +0900
Message-Id: <20230714100929.94563-4-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230714100929.94563-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmuS6XwsYUg50zrC0ezNvGZnF5v7bF
        mr3nmCzmHznHarGj4QirRd+Lh8wWmx5fY7W4vGsOm8Xdu6sYLWac38dk0br3CLvFz13zWCxu
        T5zM6MDrsXPWXXaPTas62TzuXNvD5rF5Sb1H/18Dj74tqxg9Pm+SC2CPyrbJSE1MSS1SSM1L
        zk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpVSaEsMacUKBSQWFyspG9n
        U5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdsbXjL2vBLu6K67/e
        MjcwHuXsYuTkkBAwkWj4dZqxi5GLQ0hgB6PEvZ9noZxPjBIT2kEynBDO565smI6vL7cyQRTt
        ZJS49vErG4TzkVFiyYP3rCBVbALaEt/XLwazRQQWMkk8u18GYjMLfGOUmPyHB8QWFgiQ6N7V
        C1TDwcEioCrx9lANSJhXwFZi9dvtrBDL5CVWbzjADGJzCthJPPu3CWyXhMBfdonNy78yQxS5
        SOzZeIUJwhaWeHV8CzuELSXx+d1eNgg7W6J9+h+ooRUSFzfMhoobS8x61s4IcgOzgKbE+l36
        IKaEgLLEkVssEBfzSXQc/ssOEeaV6GgTgmhUk7g/9RzUEBmJSUdWQh3gIXHh70FoiExklLh4
        uYFxAqPcLIQFCxgZVzGKpRYU56anFhsVGMHjKzk/dxMjOCVque1gnPL2g94hRiYOxkOMEhzM
        SiK8KtvWpQjxpiRWVqUW5ccXleakFh9iNAUG3URmKdHkfGBSziuJNzSxNDAxMzM0NzI1MFcS
        573XOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgcnLyYY34dE95u05CU+ep7Sla5eL7tgvtcX89OSN
        ++rjXz8RNyxL4rT1Zlj77UxNhtlaw8d7tj2PXP8iIPugzPUZole4bm3cOF37l7mR/pHL2coq
        zx3c84OKJ/XrftrrERAesPSaiqX1N0mODQG/hZhmxO1W3TttTeErvZVXX975qshhfC71N8OX
        d4Z8lVo71p956Z4Tw1sT6PxLM0WnMnXpPMEFq5p9Fr/d4i0u/tz38I5FofveLXPyTJyziK3g
        5nsp79PHf+St8XHafs7FZU3DT597F87Pqmc1fu++T3qDUrvXmrI3fMnzTzOaK3XEK/+dZt/8
        5KHV/o/hp1QOzXu93bfWQaB0a0h9weQI7mQlluKMREMt5qLiRACny5uGEgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWy7bCSnC6XwsYUg5vr2SwezNvGZnF5v7bF
        mr3nmCzmHznHarGj4QirRd+Lh8wWmx5fY7W4vGsOm8Xdu6sYLWac38dk0br3CLvFz13zWCxu
        T5zM6MDrsXPWXXaPTas62TzuXNvD5rF5Sb1H/18Dj74tqxg9Pm+SC2CP4rJJSc3JLEst0rdL
        4MrY2vGXtWAXd8X1X2+ZGxiPcnYxcnJICJhIfH25lQnEFhLYziixr0cDIi4jsfxZHxuELSxx
        v+UIaxcjF1DNe0aJ46/PMoIk2AS0Jb6vXwyWEBFYzCTxpvshmMMs8IdRor9pBStIlbCAn8TM
        xo3sXYwcHCwCqhJvD9WAhHkFbCVWv93OCrFBXmL1hgPMIDangJ3Es3+b2CAuspX48PgH0wRG
        vgWMDKsYRVMLinPTc5MLDPWKE3OLS/PS9ZLzczcxggNXK2gH47L1f/UOMTJxMB5ilOBgVhLh
        Vdm2LkWINyWxsiq1KD++qDQntfgQozQHi5I4r3JOZ4qQQHpiSWp2ampBahFMlomDU6qBaWeu
        7FOtt80820tvH1djWXMj8Lpksl0W49TMmxUtJ+/m8ji98g0uX//qK9fmHGV7oy8H+RpFBThC
        /v702znxZctPTe1nmrNar7yrWbMhbdmzCfM8o1+c+xC7kmWlyz/vO7fl1/Cv373j1ZkEpS83
        3s5Z3JFy2zlsye4yvdsMbfGhxZ/X5c486dNdUp2eetMjN/aBb9Sso4/efK1pflgx6f2Pnk8n
        GV2+82fv8P/OKv55AV9keUey3rJFZ9PuZqSonE1fzBJau2tSjcyvmtmBfcq7T06O4ZjygXfy
        99hTUmZ6FZy7xDncqhwe/ur93bd3DqfdYuXTurcfXuWWEss59ap/e6eP6pZkaeU98xxjKpVY
        ijMSDbWYi4oTAehOQf3LAgAA
X-CMS-MailID: 20230714101434epcas2p1d52a733cf3d9c5d0d8f2c26ef1a85a00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230714101434epcas2p1d52a733cf3d9c5d0d8f2c26ef1a85a00
References: <20230714100929.94563-1-jaewon02.kim@samsung.com>
        <CGME20230714101434epcas2p1d52a733cf3d9c5d0d8f2c26ef1a85a00@epcas2p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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
 arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts | 6 ++++++
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi     | 9 +++++++++
 2 files changed, 15 insertions(+)

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
index d3c5cdeff47f..672af47c79c1 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
@@ -1560,6 +1560,15 @@
 			samsung,syscon-phandle = <&pmu_system_controller>;
 			samsung,cluster-index = <1>;
 		};
+
+		pwm: pwm@103f0000 {
+			compatible = "samsung,exynosautov9-pwm";
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

