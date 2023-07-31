Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D19769035
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGaI34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjGaI3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:29:51 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2B5127;
        Mon, 31 Jul 2023 01:29:49 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TZGJ054905;
        Mon, 31 Jul 2023 03:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690792175;
        bh=Cnn6hunqmq7f5Jr25+l7OAAvN0DPDyacQ6yS43vdOIA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZUy90lNtqe34ErMbzIE7UJxD9xDFffqbjZSz3Pw2kJiaGWPdnfAv/aAQufmBEZgq/
         /BVjv3d/8mGRkYcc82WZ07ryZ63d0DcePco5Udvke6EH2oqfA8TFePGQaKu79QvRjG
         VPL8ZRlFYkwj66xrxCVvoFtPgHI5r5pLr5ecG5FY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V8TZEm087078
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 03:29:35 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 03:29:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 03:29:35 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TY3O083974;
        Mon, 31 Jul 2023 03:29:34 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <j-luthra@ti.com>
Subject: [PATCH v8 02/16] media: dt-bindings: Make sure items in data-lanes are unique
Date:   Mon, 31 Jul 2023 13:59:20 +0530
Message-ID: <20230731-upstream_csi-v8-2-fb7d3661c2c9@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=UfBX2IjR7BMRvLrfIY6UfQ6cNhv74+fundjxLXZnoOE=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx2xkMRHlCZr+X1x8TI+E434+bj6RdzsmM8YD4
 E86YzsTy1GJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMdsZAAKCRBD3pH5JJpx
 RdAdD/9hBBvwIg6o7ngR/hLbmpVHPiC2ERWcvLyy3NPacNjGcnpv00rml6TmlxkIDM7UyUjXdKu
 rA/VqIyKUIu/fKqCVBerT2rkJd5mtk2TIQF9QglQhXpu9zdX/t3Yr4SF55YFFeZrSLPO3QVeyMa
 zxVvRYSeF3IBAvXCeHVvKqOqesFXZp+QMTAnp1s+G4E6iY3wbCOikv9VR1RxoC6E55s2LXEulO6
 OI+kzYuOvn5wp0S1cbLhcFPLhgscxHEeq5cU/LCp/LsNviU+VyUhM+ycDr2l2wWxlLud5SiKUcm
 rIVxdoOoG2kVxI+fGInIzERyHpTZSzqF5/NpvjteYdha+Bc14paruc+WY/XlVBiUhRDlIHjIbYA
 yPH3MMMsYaJLL2m0s80lJgQdVsbOUxxNFq0qtBbt7FP6KcOxYufAKUni3NjL6/J2h+EzlQ54Oqt
 68xkY61zBoEZ2+WkU4i00ZKZ2JDSDPrwOn0AwYN06/Vmxx6zj1To/l8kwd9h7eKajwoWgO1pckg
 ePI0rKXY/GqhceXCLY0Ldz6WkBNzkaqpzP0XdP8YA5k4ceIlIGraRozxX9G6bV2dPmkC+z6c2CS
 7FzJ9yEZV/OLt1/lDPw8bXFQKjWJnE5N33ffycG7czkwswv38CfAyEO1Vwi0do5CVrz4ft8BB5h
 I5DUJqHwynvwMmw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

The data-lanes property maps the logical lane numbers to the physical
lane numbers. The position of an entry is the logical lane number and
its value is the physical lane number. Since one physical lane can only
map to one logical lane, no number in the list should repeat. Add the
uniqueItems constraint on the property to enforce this.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v7->v8: No change

 Documentation/devicetree/bindings/media/video-interfaces.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/video-interfaces.yaml b/Documentation/devicetree/bindings/media/video-interfaces.yaml
index a211d49dc2ac..26e3e7d7c67b 100644
--- a/Documentation/devicetree/bindings/media/video-interfaces.yaml
+++ b/Documentation/devicetree/bindings/media/video-interfaces.yaml
@@ -160,6 +160,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     minItems: 1
     maxItems: 8
+    uniqueItems: true
     items:
       # Assume up to 9 physical lane indices
       maximum: 8

-- 
2.41.0
