Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E147BDD85
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376858AbjJINKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376780AbjJINKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:10:04 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952FABA;
        Mon,  9 Oct 2023 06:10:02 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 399D9iBd043923;
        Mon, 9 Oct 2023 08:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696856984;
        bh=BgxjJaKkhypgGTDotppIbabHhDLsyOxiD/tKF7b/5FI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZqW54PP/AxS+p73SATwC9HUEgdTUUhWoBKhYUyzEjt12mijfuSVAdPB3iUNe6pIct
         18E9IVDZ1EN3lek2sgg4TIT7sBAkRsWvXI7Yy7yeWXcddxfK2SMqQTktp7rVl7mSx7
         qkO46RFBtOUdxPLsuSVCO+vBHuHZEJJW0SknWbbM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 399D9i7R076972
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Oct 2023 08:09:44 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 08:09:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 08:09:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 399D9hPS117909;
        Mon, 9 Oct 2023 08:09:44 -0500
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
Subject: [PATCH v10 02/13] media: dt-bindings: cadence-csi2rx: Add TI compatible string
Date:   Mon, 9 Oct 2023 18:39:28 +0530
Message-ID: <20231009-upstream_csi-v10-2-330aaed24c5d@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
References: <20231009-upstream_csi-v10-0-330aaed24c5d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=970; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=yrzgWB6pzGmHW+FN3ZDQrdA1db60oGi+PIM018sEEvc=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlI/smnhGLhA7u9h02i3/0Kd8QycjSAZBnEvf7V
 PPfSv3v3s+JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZSP7JgAKCRBD3pH5JJpx
 Rb5vD/9cHjnkUGH6ekQ9asA/a8pWobsNyak08z5s0JHR1M/dAGkWrqTvrQpK0o7tKRbPfUu/tkZ
 uZnCk1KMH+cy/K6kQXlJi6+QO8oFkdjsSPrXpo9/zXFpdwPKjzR4n+pPxHPxpAe5v7aGw/RMMlM
 M2RHMeejKY0UOwfFe8OSy3/GW/tqRKRz4KAfJwAJxA2QoOuBlXlxjovgpbGLCoZ8gPRM4SxAJDo
 BjRE6XHYo6PTdm6XL/YqXDuGUIUWZcDTeGZebV1To++Mr3BBdlPbnA80KGm+nW+3ps76XBqk38L
 hlAEMdgpGwVLh0Q7zSGUk2Ph2ghqM3LJnS096+sjjsTUIzAgcWCBBmmUhjc4c1l/HPYpMWBFOnU
 TZg31qnFf3tcX07pGKVl36xPPrX7iAcBINDpITyHjMiywVn4ZfOaoxzJ//99ZnAuNFqExcZ8vqv
 +UG4LdlaA3jWKr/LnTkcBkYVUOOjUTa91T5bRdOwk1b0pzN9IHyVvwpq1f+GdW+nttLhKCclJxv
 uIHmbEx7K5TZqlsABoALdPb2ymZhYdI90LY5YWSykFUb+oP8tx56I9fnnvqaDuvt1BSLJHU/Kca
 JPf5VXC+JJSq+mHTQMOWMUs4KHOswEiHPtDVLArh8jCz5vjfTHU2D+mVFFNQAvyFrJKFRfnRigj
 EhCIzy3U5aQEzTA==
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

Add a SoC-specific compatible string for TI's integration of this IP in
J7 and AM62 line of SoCs.

Tested-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
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
2.42.0
