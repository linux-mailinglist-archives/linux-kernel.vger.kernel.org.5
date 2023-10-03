Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94F27B6AA1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjJCNgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjJCNgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:36:21 -0400
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFB3C9;
        Tue,  3 Oct 2023 06:36:17 -0700 (PDT)
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 1B8C9284ECB;
        Tue,  3 Oct 2023 15:36:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
        s=gen1; t=1696340176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xejrogLlnsyj1VlkBVT1SkIE4nImaJi/ldVVHRyYf4=;
        b=SAOwdmRIl90OARnAnro4CgqmhIoRe6zITVVLoUzrBwok6IFEaeZCiAE7AgM0VXbxFP0KbE
        6c0XuyNa+OkA+/j+heqznLfjhhbm1a1jabaSKOuHWTM11t17fJUf1R98Vh16gIrFiqZdhP
        bdK8johAudnoF84QQRZRSNz0bsYnomQ=
Received: from localhost (koleje-wifi-0029.koleje.cuni.cz [78.128.191.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: karelb)
        by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 8FA75441AC5;
        Tue,  3 Oct 2023 15:36:15 +0200 (CEST)
From:   karelb@gimli.ms.mff.cuni.cz
To:     Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Karel Balej <karelb@gimli.ms.mff.cuni.cz>,
        Karel Balej <balejk@matfyz.cz>
Subject: [PATCH v2 2/5] dt-bindings: input/touchscreen: Add compatible for IST3038B
Date:   Tue,  3 Oct 2023 15:34:16 +0200
Message-ID: <20231003133440.4696-3-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003133440.4696-1-karelb@gimli.ms.mff.cuni.cz>
References: <20231003133440.4696-1-karelb@gimli.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>

From: Markuss Broks <markuss.broks@gmail.com>

Imagis IST3038B is a variant (firmware?) of Imagis IST3038 IC,
add the compatible for it to the IST3038C bindings.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
index 0d6b033fd5fb..b5372c4eae56 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -18,6 +18,7 @@ properties:
 
   compatible:
     enum:
+      - imagis,ist3038b
       - imagis,ist3038c
 
   reg:
-- 
2.42.0

