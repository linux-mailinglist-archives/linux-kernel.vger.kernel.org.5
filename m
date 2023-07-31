Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79BF769042
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjGaIbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjGaIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:30:59 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3752310F4;
        Mon, 31 Jul 2023 01:30:04 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TbxK128697;
        Mon, 31 Jul 2023 03:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690792177;
        bh=VxN1eO0EV5FCfzTt4Xq/2iHHu69kw7ABwjJVLqhU40w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Qk1R8jLTN9Z0dDAP/S9TqC3gzkc9tMB5xPxhk8CEufDzPbqxN065iZwiNATsrJyq7
         5c77fFvh3tFrdTYfjoXAwTz4HvZwdCOSg71UKDaIHGKvjezSzG8SIzj4f5WoH4Uctd
         VH8AbWkhS0IkLlxiOFZZ3rEs7/TdBEHvR0L+9kQw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V8TauB106672
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 03:29:36 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 03:29:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 03:29:36 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TZYi016471;
        Mon, 31 Jul 2023 03:29:36 -0500
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
Subject: [PATCH v8 03/16] media: dt-bindings: cadence-csi2rx: Add TI compatible string
Date:   Mon, 31 Jul 2023 13:59:21 +0530
Message-ID: <20230731-upstream_csi-v8-3-fb7d3661c2c9@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=F2ilYjTbzu9dX3pV5QoTtxm/nD9f4ZdliFaZ8sBuNag=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx2xlQ9tJFOhA36teU6odWfRkRMu46aQtrwf/b
 VP/D0xAm2OJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMdsZQAKCRBD3pH5JJpx
 RSuZD/9k0s4G/RncGnncZVaFiIYPd/1titdsezD5eWanjqqpCXObBOehjaxVNfPlH/MXXV+/NQA
 AiR4M2iTVsTA/XlvMilVl4Abc8kptZ+otasu8SEioxM8Kv4SqOTdQAj+GnCU+AUv/WwyKuCA6pp
 aEJM9d+yhpl3lBrRMpeXLoPEF94zKdnwmzWg4euHJei0Vb5r3pzYzz6g8VnY7/tUkH5GxONSTRk
 IC7BJbXyxKYduo++6REn1lH0DUA+VUrQ9bVTyHDCUVjx/iTXPO25i7mMpBjB/Fzov1xWA+a+Zaf
 FZEr4fmHJitOO5w16c3+Lso8VFVQa9YpSVY0U+uqUTEi0wZJSBppMZlBhunn7e2cCV4mVdSmDFD
 Y1/9T0GwKZ9n06Zw6900rkczgRUfUhlj13FWS51bgRWG63a1vmAO8ivtjSOxkZrUM9TOO6GKBpl
 P599cjZpTt4Qv8wilDnpvaHsm4d9KmgJwoOIrsgtBTzl8jr/iwl1oV88ARdB2Yguo5YrS/3P/FQ
 h3QMNmYGmebBTaaGVs9U/kYcJ3CPvwxmmSahg5ABSkcA+5zKH3tbd5CVNSkszBzN/LpoLUXgXNe
 5KgGUbCnOAUlJekMPGRHL+5fNiQ618Gr/xYm4BIYGUEAwwDhNbMa/JMLeQk+d0qGFTD46uyTKJI
 1b1hUyFdtFjofSg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a SoC-specific compatible string for TI's integration of this IP in
J7 and AM62 line of SoCs.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
New in v8

 Documentation/devicetree/bindings/media/cdns,csi2rx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
index 30a335b10762..2008a47c0580 100644
--- a/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
+++ b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
@@ -18,6 +18,7 @@ properties:
     items:
       - enum:
           - starfive,jh7110-csi2rx
+          - ti,j721e-csi2rx
       - const: cdns,csi2rx
 
   reg:

-- 
2.41.0
