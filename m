Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C917D39AF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjJWOlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjJWOku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:40:50 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438B110EF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:44 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7789577b53fso215175385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698072043; x=1698676843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZz9i6ImFQmqM4y5QrZ6koA95MCCt5tnF575J5PorR0=;
        b=NU0b+bx5lgPdDwvG6dMkWhCIboFFP0r/V6ZAxZeu/GdcsDiY3j9tWg+GcXfT77Y2ck
         K/T6wSsur7lWaq03vM9DHkLS2Aj8jA6bfrD8jgo+sxvehqqASATp7wGuamI30xHgZ0XF
         6rjM8/WH3xVpRWe0fttf5SJjuVZ9NFS3Cms3Vj8GAdowtj/vHPhTeMkHXQMv0VuWLjo3
         NmIxneiCm6Li0t8ttGiGC0zkNDSFC2gsLG98JZVTRzqs+OoypW7rrt4IMKeT+aBJvYsX
         HxiHODIpcg5j3+YRl824hLwior+ei+imdsP4Ai2wXpk42qNHOgc1oQEDWK/gel5iJ8cj
         FSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072043; x=1698676843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZz9i6ImFQmqM4y5QrZ6koA95MCCt5tnF575J5PorR0=;
        b=qmW7O92OBo3GXLIz36Gxfxfjfa7k9JCUAORY8IHfAQMS2wL4qwoB/Qk8bhVrIjcPTv
         Xue2KVo5YtOfWwCP02xE9U9MaaDqVhlUVBkT/ZnZqWSBA7uIoKqIHpjD5hs/55UWyXk9
         XnaC5a7Io0ydWPSrr3VxfhNTDSsMz3RAe1n6iPaOYZ6tEx794jzNnxh2ePqvLzoWIrLl
         OBr+qfj6QtG2g92d4SDDArLTEHfsvY7rwQ51ECMshgOc4hBm5HvDlZJVT5mXYyx5DDWX
         Z/vAIcq7+H8aKHOfHCS/UAH1cCXZIbMiKZT8cakS6OKoZ9MTM6xx01w9+DGdHKvR1hqL
         H86Q==
X-Gm-Message-State: AOJu0YxUKCMpzuf4pxGJNLVobfyJeq2ejX/GRS5ZkIHWXS/mCTsaS8oZ
        jwIeGQj5rcVDusYSQy2bpeJRBA==
X-Google-Smtp-Source: AGHT+IHbPwl6Xj7okP15FlZMJetuD29qDDNSXkimIr93x9jaXLYk5EpuaT+glnhtgHxMvP6epra6AA==
X-Received: by 2002:a05:620a:4308:b0:778:8fee:e863 with SMTP id u8-20020a05620a430800b007788feee863mr10472895qko.75.1698072043216;
        Mon, 23 Oct 2023 07:40:43 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f1-20020a05620a408100b007789a3499casm2725020qko.115.2023.10.23.07.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:40:42 -0700 (PDT)
From:   amergnat@baylibre.com
Date:   Mon, 23 Oct 2023 16:40:07 +0200
Subject: [PATCH 07/18] dt-bindings: display: mediatek: dpi: add binding for
 MT8365
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v1-7-5c860ed5c33b@baylibre.com>
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
In-Reply-To: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=jKTgLJ7tZRm38ANNnWtNI/u763F2Jj1UVc7V+THD25Q=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlNoXPxIX1QNuRobZW6u5aV9tmmhhr5yqPuC817lI4
 62W3Xv6JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZTaFzwAKCRArRkmdfjHURQE3D/
 9gh0ybUwT+mSx5ZgcOKs8AfJtTZow7les4rs5WdR/ORkQzY6kXCEPQHJGwSm0pR6fHVeLntm2PWxpi
 78A3aSvnwtOhVtVJoriEEqc3VPTXLDGdncGNzxQgHjIaJf/qf0g3vXhMbQvnMcTGQKq0P7ofP70yRS
 yp3iq2ADrr+onPPVI9x5OqNqqrgou/rGorFRI3j6YUcUVuRk0eTZw2mvQPpRvhPou7cvlatR+mcOQd
 berg1tg3/mYPJutWXRz5ap4f1oflMYsg3i9spOCvvx7hjuYxBpU1hHWorYsM9gg0IcXml/oWyQKiQM
 17TD0yEEYJ/kIkt+1+FITaxqJIiV1yZC2y7/mWDR9lnavla8+8MVs7z/ISJu+CDzxrBIQyiBnSQ9Dd
 nEexfUsenm4xIu0EvfZMG1E3iAHqfb84Y4Pm8Ot7gLwQ0Ng2dN5kKXmT5Y0RgVOoRgtNmNyJmJiJ0Z
 SL6XNuTP80brDNxMxods4dmBecGPUVrhSMLc+2jle6uyNYeODCCeLeCW9AqK4oBI+BgchKhuIOoHCl
 +ER5rAlg0xyfWbsj1xq00CDmneG0+on57XQ++jBfGnGN6Ia/00PiXrCamZVX8HYu5PLJa1oS/DykiZ
 RsA4SIdFr0mQ+fJ9a1qydzvN8kxnhcf4lPkehbldTFcp7ns0U5UFtjtzHABQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

DPI for MT8365 is compatible with MT8192 but requires an additional
clock. Modify the documentation to requires this clock only on MT8365 SoCs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../bindings/display/mediatek/mediatek,dpi.yaml       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index e126486e8eac..c86527c33acf 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -27,6 +27,7 @@ properties:
           - mediatek,mt8188-dp-intf
           - mediatek,mt8192-dpi
           - mediatek,mt8195-dp-intf
+          - mediatek,mt8365-dpi
       - items:
           - enum:
               - mediatek,mt6795-dpi
@@ -39,16 +40,20 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 3
     items:
       - description: Pixel Clock
       - description: Engine Clock
       - description: DPI PLL
+      - description: DPI Clock
 
   clock-names:
+    minItems: 3
     items:
       - const: pixel
       - const: engine
       - const: pll
+      - const: dpi
 
   pinctrl-0: true
   pinctrl-1: true
@@ -77,6 +82,20 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8365-dpi
+
+    then:
+      properties:
+        clocks:
+          minItems: 4
+        clock-names:
+          minItems: 4
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>

-- 
2.25.1

