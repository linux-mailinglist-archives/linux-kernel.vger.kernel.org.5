Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5650F7B6AA9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjJCNgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjJCNgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:36:47 -0400
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767D2E5;
        Tue,  3 Oct 2023 06:36:43 -0700 (PDT)
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 1C441284EB5;
        Tue,  3 Oct 2023 15:36:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
        s=gen1; t=1696340202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=broKVa+juBbW34y8eQgur3LUcnJmsuFbRBQr02rIzvk=;
        b=jFqts3VssuXMwipR90dbrh+n1MVPucm6nYIP4Sl4799i4sHCdldDBuzhb7+jeaoJYQ6hLU
        EEF/QdBS6LIS98K5phjCzxDvI31S9zWZtSFOjiv/rmrofbiFuvCKz2ZOsgW5a+/dhLVXfh
        KZUXGr33RZLj0qlIG8sWOPcVUt3UBBQ=
Received: from localhost (koleje-wifi-0029.koleje.cuni.cz [78.128.191.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: karelb)
        by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id A5DCD441AC5;
        Tue,  3 Oct 2023 15:36:41 +0200 (CEST)
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
Subject: [PATCH v2 4/5] dt-bindings: input/touchscreen: imagis: add compatible for IST3032C
Date:   Tue,  3 Oct 2023 15:34:18 +0200
Message-ID: <20231003133440.4696-5-karelb@gimli.ms.mff.cuni.cz>
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

From: Karel Balej <balejk@matfyz.cz>

Document possible usage of the Imagis driver with the IST3032C
touchscreen.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
index b5372c4eae56..2af71cbcc97d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -18,6 +18,7 @@ properties:
 
   compatible:
     enum:
+      - imagis,ist3032c
       - imagis,ist3038b
       - imagis,ist3038c
 
-- 
2.42.0

