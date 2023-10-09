Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30067BDD6B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376758AbjJINKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376781AbjJINKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:10:01 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B6793;
        Mon,  9 Oct 2023 06:09:58 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 399D9hMt055512;
        Mon, 9 Oct 2023 08:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696856983;
        bh=Lz2x3xIw/kJkOKbJx/niYJH/N0ewRr5xZQck2iUm7x0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=B7zVxk8H83ezeoHAY3h34LXQOTdmhymSr2IzCbeW+R+Z4/CRGGnzJaA2zAiXTvizL
         iHWwetwRcEKd5TsYNIMUCLBU+lzOER2+CZIpBncTSuKFPTJ/pNgiHmB5nFs9LtVRVB
         Vvtzlunpa3y5b5kZXQmDM2k3OwvbWyuNWbNHjpQY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 399D9hAD076964
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Oct 2023 08:09:43 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 08:09:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 08:09:42 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 399D9gd0055488;
        Mon, 9 Oct 2023 08:09:42 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <j-luthra@ti.com>, <a-bhatia1@ti.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v10 01/13] media: dt-bindings: Make sure items in data-lanes are unique
Date:   Mon, 9 Oct 2023 18:39:27 +0530
Message-ID: <20231009-upstream_csi-v10-1-330aaed24c5d@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
References: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=OCxVyiBNv/iKEBoQi4+IK0XyQm++LE8DE/EIGdFNE6Q=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlI/slBKH+PkDCYAQAJv4U95j33kYS7kF8cIYg6
 bVOJONCs3OJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZSP7JQAKCRBD3pH5JJpx
 RSe3EACMzIvgxPmloW2hDwypwO0Yexi5djPKJq0LRH/Zv+4tycwi3VmARg/n77w+HnFKOXlG0Vo
 6xEPIxMPrJazPQDEuw0y7UOfeIx0OGIxE5nH6ul4x4ZAiofrA5gjJtPPlJ7tC0Of7R49BtomHeS
 V/sC1xqjEe7/j22AAmwmBwIYBDWR2425ahfK2lYgNHZ+PI69rQgXjgWouIBFrIiIrQGF5/9++fN
 3HVJJJSkwZ54WC+hZDWFistPIPWxtf1q8zyHg1wTRgl5tAmv5hQFUlGv22xEiCtQ1biiwP/77jw
 gHBz7yv5/Y3hBS2QsCxhOY+P/TY4ddJruSJYGoODYxZxak89apPCx61iutEtNaEQ+NqOSiPw7iy
 SL7a/VS70w//H/2pVy0kPuSsHkYMvqcB7R7cQc/vwuEPMK/5IW9AlKLbz1yeOuuI85Jdc7GQA1S
 mUfsNdEl6kH5bsDfKX4M5fuFdStA8UQpTY8arTu6Or6+V4xN6tUcHzGwfrTdG7lmPCVU+jreSmO
 9me4lE9eIDyiq6YWo1IuugERZBkS0AB8vqHqB/jF/szrzCBzv37jQ3+AAcEEg8NCtF4LJcj967t
 vFZ9WB8BhqIUJpCMrqhk5U98WI8PvUGU+Wa3+krJ4D9/Rl/54e/4HyGmoEEFFePLgUs/B0YaOGl
 6j+UBfcVteci6/g==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
Tested-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
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
2.42.0
