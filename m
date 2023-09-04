Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2A2791090
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 06:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351677AbjIDE0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 00:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbjIDE0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 00:26:11 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4187103
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 21:26:07 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230904042606epoutp01158e1af6b3f939b7cef43179c36f221c~Bl4zjm-QK2501725017epoutp01n
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 04:26:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230904042606epoutp01158e1af6b3f939b7cef43179c36f221c~Bl4zjm-QK2501725017epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693801566;
        bh=F0Cw2/eIVKvUe9Ad3kDZbvYRFetszRqIT02C8jm0Ihc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vfjfoOzR59kOatlizBYeVUYzM/G7l1Kw/qXf2PZqmi2HiPI6GFkR9DCoB29HvSyTr
         3yqBfe6U6Dm29hva0IpLVw1WBf6OhW5Mu7haxZ0BbL3QthqoITYpWok4bV7x5s/Bne
         xTMU/D/dnijDqD7fBDAARwP4WGLGhbFWQWWY50HI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230904042605epcas1p13e75eb52c8cef4bd57e8e556bdb6d119~Bl4yzpxWN3248132481epcas1p1g;
        Mon,  4 Sep 2023 04:26:05 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.232]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RfFv02xxqz4x9Q1; Mon,  4 Sep
        2023 04:26:04 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.8B.18968.C5C55F46; Mon,  4 Sep 2023 13:26:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230904042603epcas1p47c4e858d65f2618d747bdc214d350cf7~Bl4xbOmDK0894808948epcas1p46;
        Mon,  4 Sep 2023 04:26:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230904042603epsmtrp18accbbeb8bdfa7bc1a73b0833efad0e2~Bl4xaYGUI0102601026epsmtrp14;
        Mon,  4 Sep 2023 04:26:03 +0000 (GMT)
X-AuditID: b6c32a4c-34c49a8000004a18-e3-64f55c5cf3a8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.1A.08742.B5C55F46; Mon,  4 Sep 2023 13:26:03 +0900 (KST)
Received: from mediaserver.. (unknown [10.113.111.131]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230904042603epsmtip10f0955ba6b9506551bf7511184e42159~Bl4xNs_XB1398813988epsmtip1i;
        Mon,  4 Sep 2023 04:26:03 +0000 (GMT)
From:   Kwanghoon Son <k.son@samsung.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [RFC PATCH 3/3] riscv: dts: Add th1520 reset device tree
Date:   Mon,  4 Sep 2023 04:25:59 +0000
Message-Id: <20230904042559.2322997-4-k.son@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904042559.2322997-1-k.son@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmvm5MzNcUg1t/RSy2/p7FbrFm7zkm
        i/lHzrFavNjbyGIx6f4EFovmY+vZLPpePGS2uLxrDpvFts8tbBZ3751gsXh5uYfZom0Wv0Xr
        3iPsFi37p7A48Hm8efmSxeNwxxd2j02rOtk87lzbw+axeUm9R/9fA4/3+66yefRtWcXocan5
        OrvH501yAVxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6
        bpk5QPcrKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMC/SKE3OLS/PS9fJSS6wM
        DQyMTIEKE7IzXv/fxFjwmKvi2ck9LA2M3zm6GDk5JARMJG42v2ftYuTiEBLYwyix594UJgjn
        E6PEyssHGSGcb4wSHd9+MMK09M59zQ6R2MsoMfv4V6j+N4wS257/YAapYhNQl1jSthasSkTg
        P6PEmz+tTCAJZoF4iRPXzoEVCQs4Sqx4/YIVxGYRUJVoXLINqIaDg1fAQuLoJWOIbfIS+w+e
        BSvnFLCU+PDwINgVvAKCEidnPmGBGCkv0bx1NjPILgmBPRwSu78dZoNodpFoafjKCmELS7w6
        voUdwpaSeNnfBmVnSxz9uBeqvkTi+qxFUPXGEvuXTga7h1lAU2L9Ln2IsKLEzt9zGSH28km8
        +9rDClIiIcAr0dEmBGHKS9zqLIeoFpU48/Qj1HAPiU+T26Hh1sMosfblVKYJjAqzkHwzC8k3
        sxAWL2BkXsUolVpQnJuemmxYYKibl1oOj+Xk/NxNjOA0reWzg/H7+r96hxiZOBgPMUpwMCuJ
        8Mppf0oR4k1JrKxKLcqPLyrNSS0+xGgKDO6JzFKiyfnATJFXEm9oYmlgYmZkbGJhaGaoJM4b
        86k9RUggPbEkNTs1tSC1CKaPiYNTqoFp2mcxzuOHTfLLd//fyuZbrXp9fht7bJ7G9QcXJ/4y
        C7+dZnm6cCdP7t+l2j92TlB6XaIt4zMh8HFlPX+QCKf+pA+3hC8E8Mef3menUhx+wnu269Gs
        hpS6A+1c02pOyjtdEdp0K8ji2YuDcUcPrfEorJ5xQ7EpjOHLzwdVLoePb47f2bvw5v2bzrOq
        bLfxBjhHq/IkBius3z77Z7L7gWOHrTUmqfGkzi1d0F10l4knRFXt3MW7cW0erLMi9/8MUgjq
        0F79yGd6CePs94IR6asKfu679+XEyVCjh0sNHr0NVp97PsF5+g1O5q/SPUyR6/r/s/048uPZ
        LLlvb9qUTJSMuH5MXXzev3AeR8mxkmkJSizFGYmGWsxFxYkAvZLQQFwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnG50zNcUg7YDZhZbf89it1iz9xyT
        xfwj51gtXuxtZLGYdH8Ci0XzsfVsFn0vHjJbXN41h81i2+cWNou7906wWLy83MNs0TaL36J1
        7xF2i5b9U1gc+DzevHzJ4nG44wu7x6ZVnWwed67tYfPYvKTeo/+vgcf7fVfZPPq2rGL0uNR8
        nd3j8ya5AK4oLpuU1JzMstQifbsErozX/zcxFjzmqnh2cg9LA+N3ji5GTg4JAROJ3rmv2UFs
        IYHdjBKzz1ZCxEUlOi43MnYxcgDZwhKHDxdDlLxilFi4LQHEZhNQl1jSthaolYtDRKCXSeLD
        xyVMIAlmgUSJLV9fM4PYwgKOEitev2AFsVkEVCUal2xjApnJK2AhcfSSMcQqeYn9B8+ClXMK
        WEp8eHiQEWKXhcSGX69YQGxeAUGJkzOfsECMl5do3jqbeQKjwCwkqVlIUgsYmVYxSqYWFOem
        5xYbFhjmpZbrFSfmFpfmpesl5+duYgTHkJbmDsbtqz7oHWJk4mA8xCjBwawkwiun/SlFiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOK/4i94UIYH0xJLU7NTUgtQimCwTB6dUA5PPG6Ooc7G2L0Vq
        WW23+Mw0LbvS1NVY6HuD1+nZvwWiZ6erTZHMDDKUs7qbIBddlL9Bm/d8oIbO1JJVaRkMX9+s
        u+SsUn5QfmXKPFnuKS0vd/eqlf3Mn3bTLMQxp1nGtdcvWtWcR4ntbFWi2JU39Wsr8+fPluI6
        4r+t23e3gsEtJ79//xsO2344vTRV+Cv7Hrs9R9V+GtrqCMqdzt6nrL9toe2CmPK8E2Ki/PMf
        RuxMVDG4nL+14HPh72iezefKDuwtV1ASWuUtXFKnMi2qbD7z1q7W3PqDLvprvtz/cGbC6SmH
        5131/PH+kqvayX33g8K2H9E7lBUsbyK47LrH/dBjXovD1q3a/ptddJGMhxJLcUaioRZzUXEi
        ACRhl6sQAwAA
X-CMS-MailID: 20230904042603epcas1p47c4e858d65f2618d747bdc214d350cf7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230904042603epcas1p47c4e858d65f2618d747bdc214d350cf7
References: <20230904042559.2322997-1-k.son@samsung.com>
        <CGME20230904042603epcas1p47c4e858d65f2618d747bdc214d350cf7@epcas1p4.samsung.com>
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
 arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi | 4 ++++
 arch/riscv/boot/dts/thead/th1520.dtsi                  | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index a802ab110429..b689cc049ad8 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -36,3 +36,7 @@ &uart_sclk {
 &dmac0 {
 	status = "okay";
 };
+
+&rst {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index ce708183b6f6..1cacfa386d19 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/reset/th1520-reset.h>
 
 / {
 	compatible = "thead,th1520";
@@ -418,5 +419,12 @@ portf: gpio-controller@0 {
 				interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
+
+		rst: reset-controller@ffef014000 {
+			compatible = "thead,th1520-reset", "syscon";
+			reg = <0xff 0xef014000 0x0 0x1000>;
+			#reset-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1

