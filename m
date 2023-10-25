Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCCA7D68AB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbjJYKe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbjJYKeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:34:19 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66255184
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:34:16 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231025103414epoutp03273f5a6ea987ea331618208083d77e84~RUzzBJnPR0486104861epoutp03R
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:34:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231025103414epoutp03273f5a6ea987ea331618208083d77e84~RUzzBJnPR0486104861epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698230054;
        bh=D2reVD+QHDa0MjOnXlQgoQji2aELDgUBzkVwFfOgrw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DIdFodnx8pLR+z+gT1Vgu7Zw25p2UVmrMty+OjJjaxIRRLPJ3pbgMzmJzLrEtgroc
         luHTCe5hswc6JveZuF3nnJa6iwxW8LyDSHHID4i5s3Lod5W50hH+IgM0MzjzZfBUaX
         fJ/f95gL4gHSZnZu1qTqZEZdDYiQkSQWPfMuqAJk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231025103413epcas5p4a7fe0049aba2a04bac3130071b3aed5e~RUzyKLHPX2195921959epcas5p4T;
        Wed, 25 Oct 2023 10:34:13 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SFlfD13YCz4x9Py; Wed, 25 Oct
        2023 10:34:12 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.4C.19369.32FE8356; Wed, 25 Oct 2023 19:34:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231025102233epcas5p16b716d5b650bbc5af0d759ea4f58f44d~RUpmCUVnA1254412544epcas5p17;
        Wed, 25 Oct 2023 10:22:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231025102233epsmtrp2e0ef9741073b883c40b3cf1374794c78~RUpmBAXeV0922409224epsmtrp2y;
        Wed, 25 Oct 2023 10:22:33 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-30-6538ef2386a8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.C2.08755.96CE8356; Wed, 25 Oct 2023 19:22:33 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231025102230epsmtip1f77b2f0330f442e6ddfa936ff0829a43~RUpi6oJMu0491604916epsmtip1H;
        Wed, 25 Oct 2023 10:22:30 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        linux-samsung-soc@vger.kernel.org, andi@etezian.org,
        gost.dev@samsung.com, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        ajaykumar.rs@samsung.com, aakarsh.jain@samsung.com,
        linux-fsd@tesla.com
Subject: [Patch v4 01/11] dt-bindings: media: s5p-mfc: Add mfcv12 variant
Date:   Wed, 25 Oct 2023 15:52:06 +0530
Message-Id: <20231025102216.50480-2-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025102216.50480-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0zTVxTHvb/frw8I3X4rLt41k5E6zMC1ttp2F8IzOP0RSGQjuuGIXQO/
        AaG0XR8gY5uMrW46fLAMGQgFAWeE8lh5aigryMZgTB4i4oRVgUUoRJ0Isoe6lpbtv8+593xz
        vufce9g4d5TJY6er9LRWpVDymd5E2+XAIMGWe4gW/XgtFP3eUcJAtnvdBLplamOi6tU7GLJX
        LxGop7mVhczWKxg632djoIreKwzU3j1NoBu2ixgaKZki0Im52ziyzIwz0G3HW+jqpTImKmhq
        ZaBvhrowVN87xULnro9g6FvLPxiqan3IQkZrLytyE2U2mQF1veYBTl0snWJR1Z3zGGWpPcqk
        Jsc7mVRzzWHK+MNfBHWipRZQT/LLWdSSxY8aWF5ixfscyAhNoxUptNafViWrU9JVqWH82AR5
        tFwqE4kF4mD0Gt9fpcikw/i74uIFu9OVzr75/lkKpcF5FK/Q6fjbw0O1aoOe9k9T6/RhfFqT
        otRINEKdIlNnUKUKVbQ+RCwS7ZA6E9/NSDPlLWOaEe9DRY/KmXngJOsY8GJDUgIbHDPYMeDN
        5pKdADa3/uYJHgBomW0j3MEKgNccf+LrkvYiO3BfWAG8MFnAdAdGDDa3dTn1bDaTFMBf2pUu
        wUbyEwBnvtC7GCcdOBysi3KxLxkDb/40t+aDIANgqbkBczGHDINFE8WYu9hLsK7JtlbYiwyH
        lSv5LFctSN5nw6dnTUx30i440WX2NOQLHX0tHubBpbtWT04ynKma93SghI2dXxNujoC2sTLC
        5RknA2Hjpe3u482waMDtByefgcf/nvX44cAO0zpvhWWTqww3vwgv150DbqbgnNXoGVAhgPn2
        X7FTwK/0/xKVANQCHq3RZabSyVKNWKCis/97tmR1pgWsfe6g+A5Q1/RY2AMwNugBkI3zN3IS
        4xDN5aQocj6gtWq51qCkdT1A6pxgIc57Plnt3A6VXi6WBIskMplMErxTJuZv4iwYy1O4ZKpC
        T2fQtIbWruswthcvDyPfnl042fMoSnPQoB0jDAzT1OlPB25MjJ8SDX2XsG9HhCNKHUgVNy69
        0f8O79kXfIxn7Ed9tmXfHZbrYyWvcj8M+b6KX1gw8PnD1aSIJFPsm+lX6cTMnMgA7+zpuNP2
        bO1B3XzIFnOurMTI4Ub/XCEc9tswWrPSfx9EMoc/vnVzmbc/tiEr3Ey23JEELQyNPi3v2zAX
        njQ4Zz/Mbew9v61fWI8vVmx+JeOsfPyzI7bnwIXdifv8pjW5OL2/qy76o+7csddTK1aPzyb4
        hgTlBAx+tSfYx0fafkia8/IBvDa8Pmbn1i+LHy8eye163+FcXsbi3ur3srP+ED6xCnL1CZUx
        ZWN8QpemEAfhWp3iX+yGFhNlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJTjfzjUWqwa+dShZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYvnxA6wW84+cY7XYfvARi8XNAzuZLC7OvMti
        0ffiIbPFpsfXWC0evgq3uLxrDptFz4atrBYzzu9jslh75C67xdLrF5kslm36w2SxaOsXdovW
        vUfYHcQ91sxbw+hxfcknZo+ds+6yeyze85LJY9OqTjaPO9f2sHlsXlLv0Xr0F4tH35ZVjB7/
        muaye3zeJOdx6utn9gCeKC6blNSczLLUIn27BK6MeQ1fmQouclVM/T6XrYGxn72LkZNDQsBE
        YvvU+4xdjFwcQgK7GSX6f31ig0jISPxvOwZVJCyx8t9zdoiiZiaJzdN2AzkcHGwCuhJnt+eA
        xEUEWhklrq/sZAJxmAWaWCQOt84B6xYW8JS4feIFmM0ioCoxa806JhCbV8BWYuqN6UwQG+Ql
        Vm84wAxicwrYSSz41gRWLwRUc//+D8YJjHwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXr
        JefnbmIEx5aW5g7G7as+6B1iZOJgPMQowcGsJMIb6WORKsSbklhZlVqUH19UmpNafIhRmoNF
        SZxX/EVvipBAemJJanZqakFqEUyWiYNTqoFpf1Bz3HL5pr5zahsSPdy107eLlB/fePib9E2+
        +3LCoXeUp//IvmEq/+FEt13+Ot7fE/s/HBfJbj204c7bIw92L+qc/lW1kPHlxd1p3Ibrmou3
        NR+Pi9WfPVn1RPSbg3ZrUjzD/ndtYkl7K/VeOX4Tu0/v4lKp6mO80U+je7/PZmT09d8hqPSW
        02i5Na/lU4MQ+WKVz9+Wvzg4ea1K1P7z/j3++xNLeZa+3vji8ZwdW4/de1Ytsm+32QnvnNR1
        j/amf3u0ulrixL8PL5q17rXETvxnU+u9t98ubnO08rQDt2au+rJQLLPjmuLk08oTBH58nqF8
        PL7xVvzDwzrqPMsZIjcI+rVd/VtUsX9/zfU/3EosxRmJhlrMRcWJAHN9TWAcAwAA
X-CMS-MailID: 20231025102233epcas5p16b716d5b650bbc5af0d759ea4f58f44d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025102233epcas5p16b716d5b650bbc5af0d759ea4f58f44d
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
        <CGME20231025102233epcas5p16b716d5b650bbc5af0d759ea4f58f44d@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Tesla FSD MFC(MFC v12) compatible.

Cc: linux-fsd@tesla.com
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../bindings/media/samsung,s5p-mfc.yaml          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
index 084b44582a43..c30eb309f670 100644
--- a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
+++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
@@ -24,6 +24,7 @@ properties:
           - samsung,mfc-v7                # Exynos5420
           - samsung,mfc-v8                # Exynos5800
           - samsung,mfc-v10               # Exynos7880
+          - tesla,fsd-mfc                 # Tesla FSD
       - items:
           - enum:
               - samsung,exynos3250-mfc    # Exynos3250
@@ -165,6 +166,21 @@ allOf:
           minItems: 1
           maxItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - tesla,fsd-mfc
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: mfc
+        iommus: false
+
 examples:
   - |
     #include <dt-bindings/clock/exynos4.h>
-- 
2.17.1

