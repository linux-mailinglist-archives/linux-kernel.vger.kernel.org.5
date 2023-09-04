Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F91791094
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 06:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351769AbjIDE0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 00:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbjIDE0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 00:26:13 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E90F119
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 21:26:09 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230904042606epoutp02018e8e4506a25c854cf19fcd75927941~Bl4zyt9Jl2289722897epoutp02l
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 04:26:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230904042606epoutp02018e8e4506a25c854cf19fcd75927941~Bl4zyt9Jl2289722897epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693801566;
        bh=EmA/HppB7J/yQWez+lyoU/J/IHa85Q6RP2Aw+/GrjrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5Rd8ytJWN4JqVO7t5jA942u4NttnNuhhR6QS5ZkzQr0EFoqJrzKIPLwJVEjw3Hef
         ZQzijLh+zOodle+I3b8ajoZo7W02yzs+oKxrgv5V9SvbcH2JyeZ83jkXnt7x7paHoQ
         ECl34EP2W2E432GtFtZl2VOKuXMLwYbqCtJdYaHQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230904042605epcas1p42009aecd349ac3adcac19567db2ba727~Bl4zSP8Sc0894808948epcas1p4P;
        Mon,  4 Sep 2023 04:26:05 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.235]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RfFv00xqMz4x9QB; Mon,  4 Sep
        2023 04:26:04 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.34.09646.C5C55F46; Mon,  4 Sep 2023 13:26:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230904042603epcas1p11db03427cc5f434578d29dd51bc3ae85~Bl4xKuFAF2685926859epcas1p1u;
        Mon,  4 Sep 2023 04:26:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230904042603epsmtrp2204ad9e96cccac2277800d5fcdfe183f~Bl4xJ2Nyc0179101791epsmtrp2H;
        Mon,  4 Sep 2023 04:26:03 +0000 (GMT)
X-AuditID: b6c32a37-b23ff700000025ae-75-64f55c5caae6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.CA.08788.B5C55F46; Mon,  4 Sep 2023 13:26:03 +0900 (KST)
Received: from mediaserver.. (unknown [10.113.111.131]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230904042603epsmtip1056d8fd3d3a415dd11d44d31a2404de2~Bl4w8R5wG1614716147epsmtip14;
        Mon,  4 Sep 2023 04:26:03 +0000 (GMT)
From:   Kwanghoon Son <k.son@samsung.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [RFC PATCH 1/3] dt-bindings: reset: Document th1520 reset control
Date:   Mon,  4 Sep 2023 04:25:57 +0000
Message-Id: <20230904042559.2322997-2-k.son@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904042559.2322997-1-k.son@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmnm5MzNcUg9tvmS22/p7FbrFm7zkm
        i/lHzrFavNjbyGIx6f4EFovmY+vZLPpePGS2uLxrDpvFts8tbBZ3751gsXh5uYfZom0Wv0Xr
        3iPsFi37p7A48Hm8efmSxeNwxxd2j02rOtk87lzbw+axeUm9R/9fA4/3+66yefRtWcXocan5
        OrvH501yAVxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6
        bpk5QPcrKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMC/SKE3OLS/PS9fJSS6wM
        DQyMTIEKE7Iz+vYuZSzYxF2xbuYLxgbGpZxdjJwcEgImEu1f+5i7GLk4hAR2MErsunqWCcL5
        xCix8MNcKOcbo0TjvWvsMC1LpzSC2UICexklDm1Ogyh6wyhx/t13FpAEm4C6xJK2tewgCRGB
        /4wSb/60MoEkmAXiJU5cOwe0kINDWMBLYurfSBCTRUBV4uO7SJAKXgELifWPtrJA7JKX2H/w
        LDOIzSlgKfHh4UFGiBpBiZMzn7BATJSXaN46G+wFCYEDHBI3dp1mA5kpIeAi0bVBAmKOsMSr
        41ug7peS+PxuLxuEnS1x9COMXSJxfdYiVgjbWGL/0slMIGOYBTQl1u/ShwgrSuz8PZcRYi2f
        xLuvPawQm3glOtqEIEx5iVud5RDVohJnnn6EGu4h0TDrIRskoHoYJW4vbGKewKgwC8kzs5A8
        Mwth8QJG5lWMYqkFxbnpqcWGBcbw6E3Oz93ECE7MWuY7GKe9/aB3iJGJg/EQowQHs5IIr5z2
        pxQh3pTEyqrUovz4otKc1OJDjKbAkJ7ILCWanA/MDXkl8YYmlgYmZkbGJhaGZoZK4ry3nvWm
        CAmkJ5akZqemFqQWwfQxcXBKNTC5cd/l+tmoKz5NtbTl+/yCZ286bTl413P67Fx8513RlOuR
        l92mq7ssaJv8+HbQtdWdEmKds3TEajgjrz2v5L0QsPD/zgWfjL5x3fBMvzX33dczUnnZr3db
        H9/qoBqbJmAokfL3KrNWtnbJwUef063Xc+xIvbT9mt3lt1ZWDCv/afvt6Uszvxy63rXz8pWT
        UmZNZUwP/N4YRZQ/26jwteat1C+mX/5NnGY6xcfv3Lh+YPqUKVFC+yZEnl593Fn3bk6ZXJLs
        oc1WSy/MWFVTvdtJzOHtwt6+fe+5WlWdJ82sfqt7ftm8qee5uqT25Jo59bzZYPE6cNYNi4XW
        zpLMQVGyku63ps+7yuoaWLykbv0FJZbijERDLeai4kQAuQF0OVUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnG50zNcUg/2tqhZbf89it1iz9xyT
        xfwj51gtXuxtZLGYdH8Ci0XzsfVsFn0vHjJbXN41h81i2+cWNou7906wWLy83MNs0TaL36J1
        7xF2i5b9U1gc+DzevHzJ4nG44wu7x6ZVnWwed67tYfPYvKTeo/+vgcf7fVfZPPq2rGL0uNR8
        nd3j8ya5AK4oLpuU1JzMstQifbsEroy+vUsZCzZxV6yb+YKxgXEpZxcjJ4eEgInE0imN7F2M
        XBxCArsZJT7O3sAOkRCV6LjcyNjFyAFkC0scPlwMUfOKUeLdx21gNWwC6hJL2taCNYsI9DJJ
        fPi4hAkkwSyQKLHl62tmkGZhAS+JqX8jQUwWAVWJj+8iQSp4BSwk1j/aygKxSl5i/8GzzCA2
        p4ClxIeHBxlBbCGgmg2/XrFA1AtKnJz5hAViurxE89bZzBMYBWYhSc1CklrAyLSKUTK1oDg3
        PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4irS0djDuWfVB7xAjEwfjIUYJDmYlEV457U8pQrwp
        iZVVqUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTAVTJqcpR1w8b6i
        2WfHL1N7thyftb9K+5j67Val8+Z2f3TC91RvXcT3/ZaYJSfbnXWcbufvS/c2LF/RtqWPeRXT
        xiKGGiGnCg4eAam9azd8+/e0/q/5fakr8n2/wkMnBdb3Tt16qkq/jF3Hx+pddK0/s9hcg903
        r6RPuBR3qqN/wZnz+7iKs5juvn1VWyEfHG72z/Hrx29cqa9OdnoYGS7SuZhb/8T1qnVZ5f+U
        s4vuTVpWpaa5hu2Y1qH0Jb+/vOQ+JSFzSke4pnvT5Gnqbw3qOqwMZh+yXxE0s+DEepb/oh4K
        kwL+XTWfmn5yS+SzwtOVunMX7Z768pazY46ClgmPYYFy4prwghs8N//HZAkosRRnJBpqMRcV
        JwIAljeyCREDAAA=
X-CMS-MailID: 20230904042603epcas1p11db03427cc5f434578d29dd51bc3ae85
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230904042603epcas1p11db03427cc5f434578d29dd51bc3ae85
References: <20230904042559.2322997-1-k.son@samsung.com>
        <CGME20230904042603epcas1p11db03427cc5f434578d29dd51bc3ae85@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe th1520 reset driver

Signed-off-by: Kwanghoon Son <k.son@samsung.com>
---
 .../bindings/reset/thead,th1520-reset.yaml    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
new file mode 100644
index 000000000000..a56d77af464a
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
@@ -0,0 +1,39 @@
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
+    - items:
+        - const: thead,th1520-reset
+        - const: syscon
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
+    #include <dt-bindings/reset/th1520-reset.h>
+
+    reset-controller@ffef014000 {
+        compatible = "thead,th1520-reset", "syscon";
+        reg = <0xff 0xef014000 0x0 0x1000>;
+        #reset-cells = <1>;
+    };
-- 
2.34.1

