Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112BB810F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjLMK5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbjLMK5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:57:36 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA55B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:57:41 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231213105740epoutp0335464d5dc62c3203a961656290e03563~gXvPKQzxw3040030400epoutp03a
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:57:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231213105740epoutp0335464d5dc62c3203a961656290e03563~gXvPKQzxw3040030400epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702465060;
        bh=JR8cpn8FtAJ3icCrbeSnO13yrkpEZ+816XdU3CJPlLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=glsDaqdbo4zEQZa0nc0kr9wGnjDwUsgUV197ClEDqaIHv3j+U0Z9F+stnlwZZqhgl
         3L9CAqGIHin/3QfRNTza45CKNJ79CyQOgYDzhz+p8W1YiAfKvo3Se4iptvdvbSBsJa
         Qufgt10zn/pwvHfKMbsovACubqK215Yza39LiH+8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231213105739epcas5p1b5bf4fc4d81a2870282af80ba9ae8193~gXvOQj8vC2628626286epcas5p13;
        Wed, 13 Dec 2023 10:57:39 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Sqsrd3R88z4x9Q1; Wed, 13 Dec
        2023 10:57:37 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.9F.19369.12E89756; Wed, 13 Dec 2023 19:57:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20231213081115epcas5p395d6fd6fdcf7ce8e20c5b0aba400af12~gVd7rXmCZ3024230242epcas5p3N;
        Wed, 13 Dec 2023 08:11:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231213081115epsmtrp2508dc8224e804e5be9a559bf9be7737e~gVd7qSwnS2160121601epsmtrp2s;
        Wed, 13 Dec 2023 08:11:15 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-f8-65798e21d0c4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.4B.08755.22769756; Wed, 13 Dec 2023 17:11:14 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231213081112epsmtip28af1488c9d56ee0ff74c8c9ab563b6c3~gVd5B8RAI1539415394epsmtip2j;
        Wed, 13 Dec 2023 08:11:12 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
        andi@etezian.org, gost.dev@samsung.com, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        ajaykumar.rs@samsung.com, aakarsh.jain@samsung.com,
        linux-fsd@tesla.com
Subject: [Patch v6 01/10] dt-bindings: media: s5p-mfc: Add mfcv12 variant
Date:   Wed, 13 Dec 2023 13:40:56 +0530
Message-Id: <20231213081105.25817-2-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213081105.25817-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmhq5iX2Wqwe5jIhZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        ePgq3OLyrjlsFj0btrJazDi/j8li7ZG77BbLNv1hsli09Qu7ReveI+wOIh7Xl3xi9li85yWT
        x6ZVnWwed67tYfPYvKTeo2/LKkaPf01z2T0+b5LzOPX1M3sAZ1S2TUZqYkpqkUJqXnJ+SmZe
        uq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QZ0oKZYk5pUChgMTiYiV9O5ui/NKS
        VIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Iz+l1IFR7grtt94wtTA+IK9
        i5GTQ0LARGLe9+3MXYxcHEICexgl9nw/xwThfGKUOPxyPSuE841RYsGPc2wwLfuvv4Sq2sso
        0dL8mBEkISTQyiSxb1JIFyMHB5uArsTZ7TkgYRGBRkaJxx0lIPXMArOYJZrn/2cBSQgLeErM
        /DSLCcRmEVCV+LH0D9gcXgFbiVU/7zFCLJOXWL3hADOIzSlgJ/GuaT8jyCAJgSMcEofWr4Mq
        cpG4d3sBK4QtLPHq+Bao56QkPr/bC3V1ssTjRS+ZIewcifV7prBA2PYSB67MYQE5mllAU2L9
        Ln2IsKzE1FPrwG5jFuCT6P39hAkiziuxYx6MrSYx584PqLUyEodXL4U6x0Ni6uwp0JCbCAyg
        D/OYJjDKzUJYsYCRcRWjVGpBcW56arJpgaFuXmo5PNaS83M3MYJTr1bADsbVG/7qHWJk4mA8
        xCjBwawkwntyR3mqEG9KYmVValF+fFFpTmrxIUZTYAhOZJYSTc4HJv+8knhDE0sDEzMzMxNL
        YzNDJXHe161zU4QE0hNLUrNTUwtSi2D6mDg4pRqYFnIy5Xxc0Fg34U6+4zOuUrVG+yc3/D9d
        EBJTW/P5Yuv2298ahHYEHtizdOWkRrFrZ+a5+CgtmujWLCMj79Gsv3PHnNfzDnx8c6tm6gw5
        854907+/ClCdt9h51aLTBwuni0179f/4epefomI8P4tj8+6WCWnu5p+07L2t0cUrEdvFE7a0
        Z7jpbVz69vatzWV5t9qvaSxsqu+blNUefiP6+splTu+vdvinf70QmTrjsGWP1QXpBYkhHApi
        9R99Da8I8z/ltXqqtf4M+//jRpNlNW10Ds3oMWzZw5JUJdFyekf/et/Lh0TUiyuWehls4Z62
        PLIuz+GhzE0XiVyPxUmPYi+9DdBzjJtbPTn0/0P+CiWW4oxEQy3mouJEANuLV+dGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvK5SemWqwYZLFhZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        ePgq3OLyrjlsFj0btrJazDi/j8li7ZG77BbLNv1hsli09Qu7ReveI+wOIh7Xl3xi9li85yWT
        x6ZVnWwed67tYfPYvKTeo2/LKkaPf01z2T0+b5LzOPX1M3sAZxSXTUpqTmZZapG+XQJXRv9L
        qYIj3BXbbzxhamB8wd7FyMkhIWAisf/6S6YuRi4OIYHdjBKfWpYxQyRkJP63HYMqEpZY+e85
        mC0k0MwkcWJWShcjBwebgK7E2e05IL0iAq2MEtdXdoINYhZYxyzR0XQDrEFYwFNi5qdZTCA2
        i4CqxI+lfxhBbF4BW4lVP+8xQiyQl1i94QDYYk4BO4l3TfsZIZbZSizffZt5AiPfAkaGVYyS
        qQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwbGhpbmDcfuqD3qHGJk4GA8xSnAwK4nwntxR
        nirEm5JYWZValB9fVJqTWnyIUZqDRUmcV/xFb4qQQHpiSWp2ampBahFMlomDU6qB6WjyRguG
        20rnm9ZJ3viap/WkT+bECqkih9/zJ9zp4NZlcmItvx9g3bwji3ur5bO012mbft5wrbecfmeC
        EF/bXXfZHcVunjn7e2f8ckjUexmwxHvuY45Vixh22/Hf6zivof6fQ+zw+8crTvqsLZ4osP64
        zkdRhr384i/FjBf8v1N59b16p9yribs3OGXxmvhcN7XcHb+Wd1fovIqDHvHPxLoEGNOiag6v
        tg/fWDGxbULi39ofGbEBkWahB9d6Ve1IP/x7p3+CoOpyn5JLPicysrcefGXlvKbA46qZ/Rzx
        Iwez46qaFyy6Nkf3hm7kxx2n1GqszkRmO1xlb7c6XTyLOVWOe//+x+G92d9qdGr8lFiKMxIN
        tZiLihMB0UB0efwCAAA=
X-CMS-MailID: 20231213081115epcas5p395d6fd6fdcf7ce8e20c5b0aba400af12
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213081115epcas5p395d6fd6fdcf7ce8e20c5b0aba400af12
References: <20231213081105.25817-1-aakarsh.jain@samsung.com>
        <CGME20231213081115epcas5p395d6fd6fdcf7ce8e20c5b0aba400af12@epcas5p3.samsung.com>
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

Add Tesla FSD MFC(MFC v12) compatible.

Cc: linux-fsd@tesla.com
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/media/samsung,s5p-mfc.yaml        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
index 084b44582a43..d66e51547482 100644
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
@@ -165,6 +166,23 @@ allOf:
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
+        iommus:
+          maxItems: 2
+        iommus-names: false
+
 examples:
   - |
     #include <dt-bindings/clock/exynos4.h>
-- 
2.17.1

