Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BF1753117
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjGNFUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjGNFUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:20:40 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFC62D40
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:20:31 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230714052026epoutp01090029fdd1fd5f04148f1e4d6b0cf563~xpFZxvnWE2272422724epoutp01a
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:20:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230714052026epoutp01090029fdd1fd5f04148f1e4d6b0cf563~xpFZxvnWE2272422724epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689312026;
        bh=HgQ1MLPChBeRR9u2P73bmaJa95URuggnT6VF1NFZi0Q=;
        h=From:To:Cc:Subject:Date:References:From;
        b=JyPr8RssLY52B0n037ypZPGohz6obYTJFsXoNj9n6VfGhd1m1v5pqbLlf3+scrpdA
         /k8codzMhaqwFGqVfR/rD3LaMnGZvdNvqmtwzfcwhCIv67ucfWtXGlfhYrsUrSMLCx
         Qr2a6jxoJPuDVR8+gfpM8fmOy4SNe7gBuR3HNiGw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230714052026epcas2p1cb17548c6bcdfafe38a129feed128ac8~xpFZZrydn1134511345epcas2p1s;
        Fri, 14 Jul 2023 05:20:26 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4R2KYj4hvcz4x9Q5; Fri, 14 Jul
        2023 05:20:25 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.F5.40133.91BD0B46; Fri, 14 Jul 2023 14:20:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230714052025epcas2p46d5485a277c9f21ace14300dd9d7b4d8~xpFYn5g8-1875118751epcas2p4T;
        Fri, 14 Jul 2023 05:20:25 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230714052025epsmtrp1ec16bc9ee2542943a04b8164b3626db9~xpFYnD_ot0608206082epsmtrp1m;
        Fri, 14 Jul 2023 05:20:25 +0000 (GMT)
X-AuditID: b6c32a46-4edb870000009cc5-cc-64b0db19ec1f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.92.14748.91BD0B46; Fri, 14 Jul 2023 14:20:25 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230714052024epsmtip22a0713a12c6a631e2368ad5af71bed45~xpFYTiwBm1519115191epsmtip2H;
        Fri, 14 Jul 2023 05:20:24 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH] arm64: dts: exynos: add pwm node for exynosautov9-sadk
Date:   Fri, 14 Jul 2023 14:15:21 +0900
Message-Id: <20230714051521.22720-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7bCmqa7k7Q0pBk/bFC0ezNvGZnF5v7bF
        mr3nmCzmHznHarGj4QirRd+Lh8wWmx5fY7W4vGsOm8WM8/uYLFr3HmF34PLYtKqTzePOtT1s
        HpuX1Hv0bVnF6PF5k1wAa1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5i
        bqqtkotPgK5bZg7QTUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAvMCveLE3OLS
        vHS9vNQSK0MDAyNToMKE7Iyzv3+wFezgrni+7QlzA+Nhzi5GTg4JAROJJZsbmboYuTiEBHYw
        SvzevoodJCEk8IlR4t06YYjEN0aJg/8WMMF0rPj3jhEisZdR4ti/KewQzkdGie1/JrOAVLEJ
        aEt8X7+YFSQhIrCGUWL1p80sIA6zwE1Gid3HrgE5HBzCAu4Smw86gzSwCKhKPLj5lxnE5hWw
        lZjQ9JURYp28xOoNB5gh7EPsEocemoC0Sgi4SEw/yQcRFpZ4dXwLO4QtJfGyvw3KzpZon/6H
        FcKukLi4YTYbhG0sMetZOyPIGGYBTYn1u/QhJipLHLkFdj2zAJ9Ex+G/7BBhXomONiGIRjWJ
        +1PPQQ2RkZh0ZCU0SDwkHvc9ZYSEW6zE9r7DjBMYZWchzF/AyLiKUSy1oDg3PbXYqMAIHkXJ
        +bmbGMGJTMttB+OUtx/0DjEycTAeYpTgYFYS4VXZti5FiDclsbIqtSg/vqg0J7X4EKMpMLAm
        MkuJJucDU2leSbyhiaWBiZmZobmRqYG5kjjvvda5KUIC6YklqdmpqQWpRTB9TBycUg1MXuUz
        zhQLWelov3608rN1317Ne9OmtfwPmZS27O3XdUG7g+reLF6jmjHJu2XtpRzbTGvB1nVPz5/Z
        d6I1eZ2gft3l9ftWtabUZE3yOtZovbY48YyU6sYzipz1MryXOx4Kf5smUffA7c2kaevu9vpX
        mPG7PUp6qPQ/+Olea6NHe6N2BNTOdbFZNSf5vrH1Wg33g58ZV97ZrR+1ya67945j2FG7v86v
        97BucL9Q7zurRKYtW0LaffP9zoNsIvbXPNyVP2z/4XDW0eDh2SuvDnu7KoVMelOsER9fM2Xb
        +ePikYHHdx91tlpU5iduvPRM83GVac8Yb/k2TE3lV3T6I3X0isjC1c5rpmxekVvw/Hi8shJL
        cUaioRZzUXEiAC5opjHtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42LZdlhJXlfy9oYUg9v3mC0ezNvGZnF5v7bF
        mr3nmCzmHznHarGj4QirRd+Lh8wWmx5fY7W4vGsOm8WM8/uYLFr3HmF34PLYtKqTzePOtT1s
        HpuX1Hv0bVnF6PF5k1wAaxSXTUpqTmZZapG+XQJXxtnfP9gKdnBXPN/2hLmB8TBnFyMnh4SA
        icSKf+8YQWwhgd2MEmv7jCDiMhLLn/WxQdjCEvdbjrB2MXIB1bxnlPj/dgEzSIJNQFvi+/rF
        YAkRgXWMEi3fXjKCOMwC9xkl9my9C+RwcAgLuEtsPugM0sAioCrx4OZfsGZeAVuJCU1fGSE2
        yEus3nCAeQIjzwJGhlWMkqkFxbnpucmGBYZ5qeV6xYm5xaV56XrJ+bmbGMEBpqWxg/He/H96
        hxiZOBgPMUpwMCuJ8KpsW5cixJuSWFmVWpQfX1Sak1p8iFGag0VJnNdwxuwUIYH0xJLU7NTU
        gtQimCwTB6dUA5P0E3XJtUZ65z+qXBLZ+oSx0UfU/lFvwv0p6Swid+T+Z7Wp90UZWWs6LMsz
        /OA8efuBn4p8yRLbSmVaFvydaSp32KqURX2G9YNttsI37fq8n5ZKZLqu+OEnZLTm8eqNfzRj
        Xwb++lm1keORhZqddX5qxN48nevCzx10p63otJI8rsqXXf9TIcVZV33JsciDfx/J3t3Z52N4
        w82Oz7Zt5tVPF43uvux9mP64yVvDv2FtrN2OCkux/8yXI79LXltexBjzOkSw2nCl49PL3h6M
        T1wV7nVKqDztWGlcKuxdpr0n/8nC5d0nXh/aUFSuf3DC2+Ne8+ZcYGGb/dVsfmeh1YL8fbtM
        azuTdp7N3/akTomlOCPRUIu5qDgRAPCfAVyfAgAA
X-CMS-MailID: 20230714052025epcas2p46d5485a277c9f21ace14300dd9d7b4d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230714052025epcas2p46d5485a277c9f21ace14300dd9d7b4d8
References: <CGME20230714052025epcas2p46d5485a277c9f21ace14300dd9d7b4d8@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
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
index d3c5cdeff47f..e8860b03fe89 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
@@ -1560,6 +1560,15 @@
 			samsung,syscon-phandle = <&pmu_system_controller>;
 			samsung,cluster-index = <1>;
 		};
+
+		pwm: pwm@103f0000 {
+			compatible = "samsung,exynos4210-pwm";
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

