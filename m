Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21EB763677
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjGZMig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjGZMif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:38:35 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918EE1FC4;
        Wed, 26 Jul 2023 05:38:34 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-78372625badso341661839f.3;
        Wed, 26 Jul 2023 05:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690375113; x=1690979913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aGT7UlmjRXi6PUL4RsiT1fEnt9Uyup46lUIlm5jld/A=;
        b=gmMIekJSCAonC+Qw//FFTRq7li7414wah68hHNew0b++tLNPFKd+HQv/iQ1uv7502i
         3/HLZ92/rBEUB3KhNk3FkV9OdKgb05us6gb9uEHbj25k2mWQ7iumpmyUPHydvhaATQ1v
         K+uoufTUCYjqBQibmZctZk3Y0EzsTipnfpUxryMvsuC8iVNNE3RO2y9P9SQVkwNWh5bA
         DroTfEFRR+hhCS1mqfHdWqyG8axiDHOJeGVpQjQfazqe7WbstNRRVQNbcVPXPYeCy/Ez
         5mFD9MHW0npsmfgPpAlTjtR1wtnKC8PQYJ0kHquzVEvjxdUoYq+qn8Y+n9s3hsJRe/4a
         DdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690375113; x=1690979913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGT7UlmjRXi6PUL4RsiT1fEnt9Uyup46lUIlm5jld/A=;
        b=DHEHt3obdRUI0P4IxZnhmCFgIaFEiIO9T2qP4Ol40j8z9GUpY84TnN3WKG8097jqrm
         21+0KAydZgwFCJS7NYWlbrquU7MIZcxyxSR99Tuq9TldpObIbwofBzCLk2RqICSNC4Up
         vsJIpvnLEeFme7MlLunL3QERaMYaRe4NPtfdmt+E6t6aVqF3n2nK+9ToHWqroq2PV+K6
         JjY/bo4sz7xE+IQaKYcBsS6NphDuHXV3RVxnYhl+NUm7N6b/Nquww3B8mrK2/9bNxXhE
         zGwaiyvNEhS1Pi/05sIKaAVkfQvKmAGsGHQh9ojsQ3tIt6KVGlE9Ypmz2rhve2W4f1ku
         vttg==
X-Gm-Message-State: ABy/qLati9lyoGituXorbDFsTB2IWhM7/U17kH0wAmyWJWocUO6kzz4I
        8eFjku9CO11T62+4RRDBQx2jnOEvZGb2CQ==
X-Google-Smtp-Source: APBJJlG8Sr6PqOsWuM4C6cxct4nY9BAxq1iwf3FqwlGHmzatUWFPM3HwEphQpoEOJ4CTUCV7nbQoWg==
X-Received: by 2002:a05:6602:420c:b0:786:2878:9593 with SMTP id cb12-20020a056602420c00b0078628789593mr1975128iob.0.1690375113466;
        Wed, 26 Jul 2023 05:38:33 -0700 (PDT)
Received: from james-x399.localdomain (71-33-156-134.hlrn.qwest.net. [71.33.156.134])
        by smtp.gmail.com with ESMTPSA id cg7-20020a0566381bc700b0042baffe832fsm4352025jab.101.2023.07.26.05.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:38:32 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM with Custom Board
Date:   Wed, 26 Jul 2023 06:37:39 -0600
Message-Id: <20230726123747.4097755-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Variscite i.MX6Q VAR-SOM-MX6 SoM with Custom Board.

Cc: Pierluigi Passaro <pierluigi.p@variscite.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 2510eaa8906d..76bb098605e7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -385,6 +385,12 @@ properties:
           - const: toradex,apalis_imx6q
           - const: fsl,imx6q
 
+      - description: i.MX6Q Variscite VAR-SOM-MX6 Boards
+        items:
+          - const: variscite,mx6customboard
+          - const: variscite,var-som-imx6q
+          - const: fsl,imx6q
+
       - description: TQ-Systems TQMa6Q SoM (variant A) on MBa6x
         items:
           - const: tq,imx6q-mba6x-a
-- 
2.34.1

