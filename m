Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9727EB41C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjKNPte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjKNPtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:49:23 -0500
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B132172C;
        Tue, 14 Nov 2023 07:49:16 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so8915011a12.0;
        Tue, 14 Nov 2023 07:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976954; x=1700581754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bC0gh5GtET+GY1POn83wCGMR6SSUdpI6TGA9ZU4YvM=;
        b=GVupiTHviyl7vEUphbr5I2TK8Rs1nURtxoUssbARItdl4CU5PROA+SLTb4Zp3D021b
         QCRJKkWMrWV7Wx+U/FgSSIUo/onv7vnZxXmmxWEJjMLKDteAKKtsO4T+JZhlQqHM4UTK
         8NHeeuu2UevEGlcUL3e85JaEAhOXBRwB9APVXmUcLU2qcIOJ3HTovRJRuWIfuFOMnA9m
         Enj6oaROnliG663o5dZ/TO3kL+lKi+ocGKuxwtzOqZra69poz88cqEuLJYb45A57uKbv
         2wODTaPslxqMpemOTVVuuzMlisndPFbVjRekucZULZQpA0+ra0+vk2dRbmsH7/cqa7zT
         BkNQ==
X-Gm-Message-State: AOJu0Yw1oLTJWQMRpYUSR7hGvZ8nH5Le0bIWYjUrq99kmhW+9M7+W+kE
        tEtBmAR8KVf/s/vOsholozk=
X-Google-Smtp-Source: AGHT+IENt1pIK+n+wp8H+la5uVQPNjn4/lEW7n+Ls2HMUqOuHCwh3SZzMgv4ZZ05LH+OzNrW4jjdfA==
X-Received: by 2002:aa7:d889:0:b0:543:5741:c9cd with SMTP id u9-20020aa7d889000000b005435741c9cdmr6861999edq.34.1699976954369;
        Tue, 14 Nov 2023 07:49:14 -0800 (PST)
Received: from ramallet.home (cst-prg-38-127.cust.vodafone.cz. [46.135.38.127])
        by smtp.gmail.com with ESMTPSA id v22-20020aa7d816000000b00533e915923asm5211770edq.49.2023.11.14.07.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:49:13 -0800 (PST)
From:   Tomeu Vizoso <tomeu@tomeuvizoso.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Tomeu Vizoso <tomeu@tomeuvizoso.net>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: amlogic: meson-g12-common: Set the rates of the clocks for the NPU
Date:   Tue, 14 Nov 2023 16:48:43 +0100
Message-ID: <20231114154843.1262225-1-tomeu@tomeuvizoso.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106092202.11127-1-tomeu@tomeuvizoso.net>
References: <20231106092202.11127-1-tomeu@tomeuvizoso.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise they are left at 24MHz and the NPU runs very slowly.

Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Suggested-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

---

v2: Fix subject (Jerome Brunet)
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index ff68b911b729..9d5eab6595d0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2502,6 +2502,9 @@ npu: npu@ff100000 {
 		clocks = <&clkc CLKID_NNA_CORE_CLK>,
 			 <&clkc CLKID_NNA_AXI_CLK>;
 		clock-names = "core", "bus";
+		assigned-clocks = <&clkc CLKID_NNA_CORE_CLK>,
+				  <&clkc CLKID_NNA_AXI_CLK>;
+		assigned-clock-rates = <800000000>, <800000000>;
 		resets = <&reset RESET_NNA>;
 		status = "disabled";
 	};
-- 
2.41.0

