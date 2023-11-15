Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B027ED616
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjKOVeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKOVeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:34:13 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD35B8;
        Wed, 15 Nov 2023 13:34:09 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-407da05f05aso623445e9.3;
        Wed, 15 Nov 2023 13:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700084047; x=1700688847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TJq9RwRehs4D7WXODBH5ujBwSEz9WoRdCdezm7e5LdI=;
        b=CI9VI4IX3/Y7I7kovV2zUqXNJa7zrS9O2ZU0Zu3iOPwhAYXGleOFG57/vnop2rtg3E
         WPegyPypcT2GGfNh31wJeRvG5mgU1xmMPsFes2esgJIbpV4Ih452p20BTvt7WMW1ZqkE
         RIXiPjyO1ZofbzttGLS+H0xDsptZXcIMPNQKkde69CMMI/h+MFeSCJwaAfsDBzJy8bWO
         D2q7P0ml/gaSrzW/hb+3bT2U7peqFeqMkTLJ/p1zZg15k4TBwZvuzJMvcrLwlNr7kPx1
         icA36TKRRGYjdfwtLhE89DxvG/F9WnBaKvFipGREOAojyXUI78yEYu8hHud8wOCMDGZ+
         hhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700084047; x=1700688847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJq9RwRehs4D7WXODBH5ujBwSEz9WoRdCdezm7e5LdI=;
        b=dk+7TKPBqQQkaG0/vNEL1Hq8tvmaSLM/k89Y5HaNoKNrtC1H6S2Pg/mo6Yzo8RY3Nl
         2uhNqGr7BwlnpFxuxPUWurupd5Xt2B7Hg/2QNSoXoN/vzUyyGWwn4XiurBTcaORdkw1Y
         5+ISXXJdGx4d5hQpckB5GQsCngIk1gXrk1V5O4vBIuPXlyXfyqdKlWBx4xokjj84fBx7
         TPBkLo2OWmh/ChsOX6W0UMjLNL5875RHZAvkELkU/Rms+bTOyvDczU+LU6KMiQWJbMIX
         GQBpZQl8xcQ8FxrGORaWZRHaGzmVBhCJukASY6+YLV2cB+avP2izf/W6Leq/RHCchf9Q
         z+mw==
X-Gm-Message-State: AOJu0Yze7JAsYJbzDllCncDoMNqUmU/QyHWF51NDIYdh7ttylaGfZnIZ
        qqlsQ5yf/f0Tl8aJpcYl7LQ=
X-Google-Smtp-Source: AGHT+IHb3SyTdwLXt/HE/cynHBAK02Y53Amu6UoXjOtymiJSVwp87yE+gVeFZi19CMpgtwP80m5dNg==
X-Received: by 2002:a05:600c:4f8d:b0:40a:6235:e82d with SMTP id n13-20020a05600c4f8d00b0040a6235e82dmr2265604wmq.15.1700084047522;
        Wed, 15 Nov 2023 13:34:07 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:e8e:4851:e049:93fd])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c2a5000b00405391f485fsm914104wme.41.2023.11.15.13.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:34:07 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] ASoC: dt-bindings: renesas,rz-ssi: Document RZ/Five SoC
Date:   Wed, 15 Nov 2023 21:33:58 +0000
Message-Id: <20231115213358.33400-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The SSI block on the RZ/Five SoC is identical to one found on the RZ/G2UL
SoC. "renesas,r9a07g043-ssi" compatible string will be used on the RZ/Five
SoC so to make this clear and to keep this file consistent, update the
comment to include RZ/Five SoC.

No driver changes are required as generic compatible string
"renesas,rz-ssi" will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
index 3b5ae45eee4a..8b9695f5decc 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -16,7 +16,7 @@ properties:
   compatible:
     items:
       - enum:
-          - renesas,r9a07g043-ssi  # RZ/G2UL
+          - renesas,r9a07g043-ssi  # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-ssi  # RZ/G2{L,LC}
           - renesas,r9a07g054-ssi  # RZ/V2L
       - const: renesas,rz-ssi
-- 
2.34.1

