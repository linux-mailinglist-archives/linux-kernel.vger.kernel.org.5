Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C384B7A4032
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 06:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbjIREvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 00:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239541AbjIREvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 00:51:47 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04C811A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 21:51:40 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230918045136epoutp03330b761ba8ff3bc51c118e841d4204cd~F5REc_eKz2963229632epoutp03P
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:51:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230918045136epoutp03330b761ba8ff3bc51c118e841d4204cd~F5REc_eKz2963229632epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695012696;
        bh=g5oaDh0Uv1CkUcrELplZoNLFxDnPPigO99UnJx9kJDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pyz4GGSsCkBMoWEU3pBhIGsclF4qse+mWIMXcxOYOf/69lNzHEmc7sso5bjZ7O+1V
         K+qDt1TKTsrBEfyUKk2O/CwQviPoqACkm/BnCMOIC+6uLNcFz3UkNq6GnLWt89ynbU
         dlAxRxXjzW3hnJuGmrl12d+ckzOt/tD6T5GS7xMg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230918045135epcas1p1659ed5fa554b51528dcd6557bab97e38~F5RD91N9H0405204052epcas1p11;
        Mon, 18 Sep 2023 04:51:35 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.235]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Rpsny45h1z4x9Pp; Mon, 18 Sep
        2023 04:51:34 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.84.09567.657D7056; Mon, 18 Sep 2023 13:51:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230918045134epcas1p1b80b338b66512a976c3783cd0e51da50~F5RCU3sxW0410204102epcas1p1H;
        Mon, 18 Sep 2023 04:51:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230918045134epsmtrp1cd3b3cde5ec76d00910563cc24961421~F5RCT_gz71969519695epsmtrp1h;
        Mon, 18 Sep 2023 04:51:34 +0000 (GMT)
X-AuditID: b6c32a39-6ffff7000000255f-af-6507d7561ea6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.94.08788.557D7056; Mon, 18 Sep 2023 13:51:33 +0900 (KST)
Received: from mediaserver.. (unknown [10.113.111.131]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230918045133epsmtip1ce5b0b263b40cc2b6612f1be498e1f91~F5RB96QLb1742617426epsmtip1h;
        Mon, 18 Sep 2023 04:51:33 +0000 (GMT)
From:   Kwanghoon Son <k.son@samsung.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 1/3] dt-bindings: reset: Document th1520 reset control
Date:   Mon, 18 Sep 2023 04:51:23 +0000
Message-Id: <20230918045125.4000083-2-k.son@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918045125.4000083-1-k.son@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmrm7YdfZUg3Uz5S22/p7FbrFm7zkm
        i/lHzrFavNjbyGIx6f4EFovmY+vZLPpePGS2uLxrDpvFts8tbBZ3751gsXh5uYfZom0Wv0Xr
        3iPsFi37p7A48Hm8efmSxeNwxxd2j02rOtk87lzbw+axeUm9R/9fA4/3+66yefRtWcXocan5
        OrvH501yAVxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6
        bpk5QPcrKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMC/SKE3OLS/PS9fJSS6wM
        DQyMTIEKE7Izdp/3KXgjUHF9nXUD4xPeLkYODgkBE4l5F1K7GLk4hAR2MEpcO/iDtYuRE8j5
        xCjxeJ87ROIbo8ThZQ+YQRIgDR2fDrNAJPYyShxZuYwdwnnDKPH0+F0mkCo2AXWJJW1rwRIi
        Av8ZJd78aQVLMAvES5y4dg5slLCAp8S/Z8fYQWwWAVWJhWdPgNXwClgA3fEHap28xP6DZ8Fs
        TgFLifO3djJC1AhKnJz5hAViprxE89bZzCDLJAT2cEj8e3oeqtlFYub8DkYIW1ji1fEt7BC2
        lMTL/jYoO1vi6Me9bBB2icT1WYtYIWxjif1LJzOBAolZQFNi/S59iLCixM7fcxkh9vJJvPva
        wwoJR16JjjYhCFNe4lZnOUS1qMSZpx+hhntIzO+bAA24HkaJ/z8OMU1gVJiF5JtZSL6ZhbB4
        ASPzKkax1ILi3PTUYsMCU3j0JufnbmIEJ2Ytyx2M099+0DvEyMTBeIhRgoNZSYR3piFbqhBv
        SmJlVWpRfnxRaU5q8SFGU2BYT2SWEk3OB+aGvJJ4QxNLAxMzI2MTC0MzQyVx3nNve1OEBNIT
        S1KzU1MLUotg+pg4OKUamHSZtDh4z+QH6VhMuxm7NVHgxMJzvh0b1ES8/XrYnu4Uvv5wbmf7
        RsaTs53ixNc6B6yICObm8lHemjtj+mOmpvLzyzg1T1rHXmddJL1eVvac0p0QlV1f4tuWVVgU
        +R1/4DJzrTVb0ObdQizlx5ZNObvmSV6jUWzX07dXQt5s0P/xMOzy3dyJhlwyR24xRwby3/85
        ObAh7lqW1w8NnYeN53RY1U9+n3Z55RILK06m9sxdll/v9DRvsp4bscWmZvm+8wuKT78q3D91
        2zzBPa7dKZFTt1Y29K96NTHMyyE3fNHft8wGcufnfZI6dWpj9Rzh1+sO8jzUtjwffuT2Xw+D
        52b/emq4FpS0MBrvM8h6p6DEUpyRaKjFXFScCAAuO0bTVQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnG7YdfZUg1fuFlt/z2K3WLP3HJPF
        /CPnWC1e7G1ksZh0fwKLRfOx9WwWfS8eMltc3jWHzWLb5xY2i7v3TrBYvLzcw2zRNovfonXv
        EXaLlv1TWBz4PN68fMnicbjjC7vHplWdbB53ru1h89i8pN6j/6+Bx/t9V9k8+rasYvS41Hyd
        3ePzJrkArigum5TUnMyy1CJ9uwSujN3nfQreCFRcX2fdwPiEt4uRk0NCwESi49Nhli5GLg4h
        gd2MEifuHWSCSIhKdFxuZOxi5ACyhSUOHy6GqHnFKHH27yxmkBo2AXWJJW1r2UESIgK9TBIf
        Pi4Ba2YWSJTY8vU1WJGwgKfEv2fH2EFsFgFViYVnT4DV8ApYSFw7+IcZYpm8xP6DZ8FsTgFL
        ifO3djKC2EJANb0fXjFC1AtKnJz5hAVivrxE89bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PbfY
        sMAoL7Vcrzgxt7g0L10vOT93EyM4hrS0djDuWfVB7xAjEwfjIUYJDmYlEd6ZhmypQrwpiZVV
        qUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTBN8Z7PXxPxiPtUnHpF
        wd7iHMXpoh17ApUW/qtwSDpgIfLnqn/e2dBzP8/3X5+9+Ob7U0dSDc13HtmW9f6Na4yyjvXS
        3OS8/AUX7QRbNnTu4GI+9/qQT/LW5Jl77z56xqx8ZLfkgdVVS8KinUWqmP7ERauZBd2JrI2a
        6qchO12hef15Db6ucrMwN84lzAH+636E9xrEXfMr4k//rOqhbKNX/Li6M8j/c6/Uw6zqF3UF
        /xiNv7CdtOfodHTimH+d6dzGlZdWaX87WxyjN8es8Oa1myXPMpN0LgVdnCJYK6zRUdEy/0mD
        0HXDvQUvp755pBwndLUtQ+VYTmLywUNOT4NuqS4wXnLvoMX7E2+vNyqxFGckGmoxFxUnAgBC
        hs+NEAMAAA==
X-CMS-MailID: 20230918045134epcas1p1b80b338b66512a976c3783cd0e51da50
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230918045134epcas1p1b80b338b66512a976c3783cd0e51da50
References: <20230918045125.4000083-1-k.son@samsung.com>
        <CGME20230918045134epcas1p1b80b338b66512a976c3783cd0e51da50@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe th1520 reset device

Signed-off-by: Kwanghoon Son <k.son@samsung.com>
---
 .../bindings/reset/thead,th1520-reset.yaml    | 44 +++++++++++++++++++
 .../dt-bindings/reset/thead,th1520-reset.h    |  9 ++++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
 create mode 100644 include/dt-bindings/reset/thead,th1520-reset.h

diff --git a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
new file mode 100644
index 000000000000..49ea8c6a331f
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/thead,th1520-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD th1520 SoC Reset Controller
+
+maintainers:
+  - Kwanghoon Son <k.son@samsung.com>
+
+properties:
+  compatible:
+    items:
+      - const: thead,th1520-reset
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/thead,th1520-reset.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        reset-controller@ffef014000 {
+            compatible = "thead,th1520-reset", "syscon";
+            reg = <0xff 0xef014000 0x0 0x1000>;
+            #reset-cells = <1>;
+        };
+    };
diff --git a/include/dt-bindings/reset/thead,th1520-reset.h b/include/dt-bindings/reset/thead,th1520-reset.h
new file mode 100644
index 000000000000..ec10751814e5
--- /dev/null
+++ b/include/dt-bindings/reset/thead,th1520-reset.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef DT_BINDING_RESET_TH1520_H
+#define DT_BINDING_RESET_TH1520_H
+
+#define TH1520_RESET_WDT0 0
+#define TH1520_RESET_WDT1 1
+
+#endif
-- 
2.34.1

