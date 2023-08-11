Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6E4778C5A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbjHKKsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjHKKsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:48:18 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F5CE4C;
        Fri, 11 Aug 2023 03:48:17 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlhSb078815;
        Fri, 11 Aug 2023 05:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691750863;
        bh=Zhkh9i8A8/o8YrE7uFwwlWTRheuCv4OgXpNk/4C4Sgs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UMubTtbe1SfTQraIqemE9gYbZs+jEHJKyZfGFvRb9Xf9lPEb9PtRB1IGeFNHE7JwL
         P6O6J52G3AhzfJwzbhGQaaCkKdlfbl6+0C46E6dqsMrcmuKArFlxb9ggKe0yfucjPH
         7iinipoRzGWx/KpLgJTP1MnizM+upjHK1VgFMU1s=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BAlhKw041868
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 05:47:43 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 05:47:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 05:47:42 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BAlg4g008181;
        Fri, 11 Aug 2023 05:47:42 -0500
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
Subject: [PATCH v9 02/13] media: dt-bindings: cadence-csi2rx: Add TI compatible string
Date:   Fri, 11 Aug 2023 16:17:24 +0530
Message-ID: <20230811-upstream_csi-v9-2-8943f7a68a81@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=847; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=eA1yYw44f16RsWMs2uAnsTw6L+xpAUPkHRwYoS7eUqc=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk1g71orbGMxlp88wqb4PgrVsIqHilRXEwyVEWM
 dEwq65VoS6JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZNYO9QAKCRBD3pH5JJpx
 RQ+oD/9FfCkSLPnd7tkCAqMlzhvE3L/Gkhn8b6ViAgqZmnIfZmCYkzx3Koal7UGOTL/ud4Shd3w
 XolqkQLC5LhbT/U3SdP/LLLU4Qu1/TbzrGdeLIh6atPpYprPfuxP5EhcwTP8qT9HEAh2jYY8jVO
 3Xq1QjK5b6YLcP/no42qiFwU/89RGgBbFzLPYoW2kXMn39QPxQi0hicBIim/UTI871mZRaU/ebg
 14/8hnm+1qPxGybO6rtIQeVSTMjnw9uCJ1PUa2qVA01w8Sh094NWTYuvm805lH9XdsfjL/LZvsn
 I1XBDduShtTeZmAoOPsZhzOlt7DzicipddSxhO/ajLVddIQEcXYcMGoX9fT5rj956TGPV9+Kvbt
 2eMztn15pyGsRGNXXIFNykUXKC69gJLFtTs+0cK6cuw4y7cPoT6az5S5OfxXSdxXOvvfF2tZWqp
 /DlkMmnRhU4AKrOgGHk5DFewe2FY7hJRTYgXpgTKLEU/PvwLp0UdBDgCEUnPQAHQvN8wPPjLmZ2
 EeMQb/lbdbvUHNSqb7y+u77XKdLarpyBBbnyQxnjElAipt91BF1fpwSfh4FKq8H35hLHXGKQkoA
 4UUM6VKkAq4+hOf7SbQ0YBoJQgafB/mD1b0HFAngNE5SQTyp9chKZI8DrhbsMyy9V2f3MBFS/Cm
 o5ghNkN3MZVlzaA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a SoC-specific compatible string for TI's integration of this IP in
J7 and AM62 line of SoCs.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
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
2.41.0
