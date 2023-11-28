Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC317FC933
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376271AbjK1WNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346561AbjK1WNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:13:13 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6331BE;
        Tue, 28 Nov 2023 14:13:20 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-58d3c5126e9so2477499eaf.1;
        Tue, 28 Nov 2023 14:13:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701209599; x=1701814399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76mP+x+bYO6jX4WukwyAY+fmiKt3MRVCF+jR8taIB6c=;
        b=pq1CazXO1TwvBLO4RzhAo3YONJ81RLa/olOzdogkMD8x7osYxjfabAAu2T8HaZHFPQ
         ZXy7zUGVu6ezIvQYbF/gTeNNey3Tjrr8fYEWr1WcDqz2B4E4EnBJ+nOtZ7JJMEhl2Ygm
         VTKQLDiE+8wcF0oPqZVARpV25oO0dvzUASVSR5eNHyQaAVQ8maMqJMO44IySUbb/Tr01
         F82TfC8ipB0mdrYYO/dQhqUFjUVTTmcny16jyLoAEv0CNjfwogC6wa/GDc5TJ5mBgs+V
         r7VCGC76C2ll12XZcoRysNd5c6InGkfq24XrIj5e1aGFgLJuaovH+wa6bqqwY1RucjyE
         f7Cw==
X-Gm-Message-State: AOJu0Yx7DtxQpKqNmk1zOIosK4itBSgPur5koe3u0CN9kYv8ZgxxUCt1
        Vvb1bXzy5jpaEisma/5x3Q==
X-Google-Smtp-Source: AGHT+IHLa/L1r6e7R0OzqIz2an7oAGmbLiFuC1QyvPdBbgI2xiaK1h3cuyi5/8Y7OB+uf8eAxVWIFA==
X-Received: by 2002:a05:6820:626:b0:58d:74f2:bb4f with SMTP id e38-20020a056820062600b0058d74f2bb4fmr10557302oow.1.1701209599248;
        Tue, 28 Nov 2023 14:13:19 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e64-20020a4a5543000000b0058d8b0c4bbdsm835334oob.32.2023.11.28.14.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 14:13:18 -0800 (PST)
Received: (nullmailer pid 4078954 invoked by uid 1000);
        Tue, 28 Nov 2023 22:13:17 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Turn on undocumented compatible checks
Date:   Tue, 28 Nov 2023 16:10:08 -0600
Message-ID: <20231128221008.4050638-2-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The undocumented compatibles in the examples are down to just a few
left. Turn on the warning by default. The increased visibility should
get the remaining warnings fixed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
After the last batch of fixes I've sent out, there's 6 warnings 
remaining:

 ['socionext,milbeaut-usio-uart']
 ['sprd,sc9863a-glbregs', 'syscon', 'simple-mfd']
 ['brcm,bcm2711-avs-monitor', 'syscon', 'simple-mfd']
 ['fsl,imx6q-anatop', 'syscon', 'simple-mfd']
 ['hisilicon,hi3798cv200-combphy']
 ['qca,ar9331-switch']

 Documentation/devicetree/bindings/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 3e886194b043..3e3e49d8a733 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -61,9 +61,6 @@ override DTC_FLAGS := \
 	-Wno-unique_unit_address \
 	-Wunique_unit_address_if_enabled
 
-# Disable undocumented compatible checks until warning free
-override DT_CHECKER_FLAGS ?=
-
 $(obj)/processed-schema.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version FORCE
 	$(call if_changed_rule,chkdt)
 
-- 
2.42.0

