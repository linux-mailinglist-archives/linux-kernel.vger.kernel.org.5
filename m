Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0DF7A4033
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 06:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbjIREv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 00:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239544AbjIREvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 00:51:47 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05FA11C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 21:51:40 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230918045136epoutp03574c10826e8e82aa98c7936a749c49d3~F5REkzKSA2816628166epoutp03D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:51:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230918045136epoutp03574c10826e8e82aa98c7936a749c49d3~F5REkzKSA2816628166epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695012696;
        bh=/m086ylcvUs8tqHsQS1HIUYanaph0yHgdpARIuUHjoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CWr3eZWYIls96bRTa3zvLaIiuUCW5IZIh/bBk25WAgD8xsq3xUHmsGmiISgX7tuPg
         oXYdx5ZZC7l7hTuwKBQuEboajxKP8FqhfV2b+qH42PAw1tDxw3j7MI5DJEEz916avT
         2kiLo1Cm7GQ0egj9/FvMfPBTmlnk/f/b+M4dMkzA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230918045135epcas1p17ddb745a0bf02b783cb3b86e16694307~F5RD91edg0101201012epcas1p1V;
        Mon, 18 Sep 2023 04:51:35 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.134]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Rpsny6Dkjz4x9QF; Mon, 18 Sep
        2023 04:51:34 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.E3.09646.657D7056; Mon, 18 Sep 2023 13:51:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20230918045134epcas1p3263e6d4124a0d37faadb3cb97bf7cd0b~F5RCpY53A0495704957epcas1p3v;
        Mon, 18 Sep 2023 04:51:34 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230918045134epsmtrp12b51a8155bf7a3f266118d900b6e3417~F5RCok4bO1930419304epsmtrp1X;
        Mon, 18 Sep 2023 04:51:34 +0000 (GMT)
X-AuditID: b6c32a37-b23ff700000025ae-c0-6507d756dc3c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.65.18916.657D7056; Mon, 18 Sep 2023 13:51:34 +0900 (KST)
Received: from mediaserver.. (unknown [10.113.111.131]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230918045134epsmtip14278f579639705e41854fbb2cb3b367d~F5RCTA6TB1476614766epsmtip1g;
        Mon, 18 Sep 2023 04:51:34 +0000 (GMT)
From:   Kwanghoon Son <k.son@samsung.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 3/3] riscv: dts: Add th1520 reset device tree
Date:   Mon, 18 Sep 2023 04:51:25 +0000
Message-Id: <20230918045125.4000083-4-k.son@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918045125.4000083-1-k.son@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmgW7YdfZUg8W/DC22/p7FbrFm7zkm
        i/lHzrFavNjbyGIx6f4EFovmY+vZLPpePGS2uLxrDpvFts8tbBZ3751gsXh5uYfZom0Wv0Xr
        3iPsFi37p7A48Hm8efmSxeNwxxd2j02rOtk87lzbw+axeUm9R/9fA4/3+66yefRtWcXocan5
        OrvH501yAVxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6
        bpk5QPcrKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMC/SKE3OLS/PS9fJSS6wM
        DQyMTIEKE7IzTq3cwFbwlq1i4sz9bA2M51i7GDk5JARMJA7++MkMYgsJ7GCU+P04pYuRC8j+
        xCixbP0fdjhnzap1LDAdG+YfhkrsZJS48fMvlPOGUeLcrh/sIFVsAuoSS9rWgiVEBP4zSrz5
        08oEkmAWiJc4ce0c2EJhAQeJvbsmgo1lEVCVWDl3Blgzr4CFxP4HJxgh1slL7D94FqyeU8BS
        4vytnYwQNYISJ2c+YYGYKS/RvHU2M8gyCYEdHBK/10EskxBwkTh67A+ULSzx6vgWdghbSuJl
        fxuUnS1x9ONeNgi7ROL6rEXQkDGW2L90MlAvB9ACTYn1u/QhwooSO3/PZYTYyyfx7msPK0iJ
        hACvREebEIQpL3GrsxyiWlTizNOPUMM9JB69/AINqx5GiVefFzJPYFSYheSbWUi+mYWweAEj
        8ypGsdSC4tz01GLDAmN4DCfn525iBKdnLfMdjNPeftA7xMjEwXiIUYKDWUmEd6YhW6oQb0pi
        ZVVqUX58UWlOavEhRlNgWE9klhJNzgdmiLySeEMTSwMTMyNjEwtDM0Mlcd5bz3pThATSE0tS
        s1NTC1KLYPqYODilGphqVps02AX+686K1E5mWMsW9Mg9zLtQj6mEb+ItIQb7RwH91V+kVerY
        Gqvi4ld5X5233HjPjP6gWU6Gj05ualU6MvONi45U8Iuj+R4nFytG3T9688MepV8XdSxqGBZZ
        mpz/FyxnvmpNS9/0Vqmp2xZluznPlS3JsC24u8eNS7xHQYYh2730ndHa2/fun8sW+30tdv23
        R+u6F0Qd+dTs/2OnQWC8GVdCkZvLIi+nuUrVax/sFHzHsHrmJMdTbO8+f9hTOn3HGZFbWWv9
        E/5ON5028+umo+zK6jHRJ1eekll4+eHnX1+/PTRNvlwQ+E5J2IdPZcE/6TPPTYLMPmu2uWXM
        WsR97+CqqO/xH7fUHvFUYinOSDTUYi4qTgQAcGokuFgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnG7YdfZUg3s7RS22/p7FbrFm7zkm
        i/lHzrFavNjbyGIx6f4EFovmY+vZLPpePGS2uLxrDpvFts8tbBZ3751gsXh5uYfZom0Wv0Xr
        3iPsFi37p7A48Hm8efmSxeNwxxd2j02rOtk87lzbw+axeUm9R/9fA4/3+66yefRtWcXocan5
        OrvH501yAVxRXDYpqTmZZalF+nYJXBmnVm5gK3jLVjFx5n62BsZzrF2MnBwSAiYSG+YfZu9i
        5OIQEtjOKHFn20QWiISoRMflRsYuRg4gW1ji8OFiiJpXjBL7zjWyg9SwCahLLGlbC9YsItDL
        JPHh4xImkASzQKLElq+vmUFsYQEHib27IIayCKhKrJw7A6yZV8BCYv+DE4wQy+Ql9h88C1bP
        KWApcf7WTrC4EFBN74dXjBD1ghInZz5hgZgvL9G8dTbzBEaBWUhSs5CkFjAyrWIUTS0ozk3P
        TS4w1CtOzC0uzUvXS87P3cQIjiCtoB2My9b/1TvEyMTBeIhRgoNZSYR3piFbqhBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXFe5ZzOFCGB9MSS1OzU1ILUIpgsEwenVAMTg+ymWT0Pev3W/VCba1Tf
        kXtRNPPkHp98K4alvyYJZNvwbJyxOcRA2XHbtYtqFpsFBEU2VAq6eM+zmG4u6t0sc2VVbdZG
        9z0M76uO/IituFrp82ORR0z327dR1w+kds/a9shyvooCQ5Htvktcwot/TosQeDxZWdfS1d/u
        /2W3wuf8SsGtu3nzlnCfu5WVzD/ZplQxc/PvT32izYqn81bXz3izXsYr67Dk4m7Vwxmb56V9
        8FzL6+d6uDh6zcGZF2dtav17ZcL37eeZGBJ71ncdVd5bzK0p+P9o0bP2rAABrT+NKx4vNTyT
        fGhn7+vK3ICfLrkzsm47T8k36mtsM74g373cUFzaWPxFsNcaxhNKLMUZiYZazEXFiQDB2bDl
        DwMAAA==
X-CMS-MailID: 20230918045134epcas1p3263e6d4124a0d37faadb3cb97bf7cd0b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230918045134epcas1p3263e6d4124a0d37faadb3cb97bf7cd0b
References: <20230918045125.4000083-1-k.son@samsung.com>
        <CGME20230918045134epcas1p3263e6d4124a0d37faadb3cb97bf7cd0b@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset device tree for th1520 SoC

Signed-off-by: Kwanghoon Son <k.son@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index ce708183b6f6..210f234839c3 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/reset/thead,th1520-reset.h>
 
 / {
 	compatible = "thead,th1520";
@@ -418,5 +419,11 @@ portf: gpio-controller@0 {
 				interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
+
+		rst: reset-controller@ffef014000 {
+			compatible = "thead,th1520-reset", "syscon";
+			reg = <0xff 0xef014000 0x0 0x1000>;
+			#reset-cells = <1>;
+		};
 	};
 };
-- 
2.34.1

