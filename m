Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B497CA129
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjJPICY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjJPICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:02:20 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE86B4;
        Mon, 16 Oct 2023 01:02:17 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so40271935e9.3;
        Mon, 16 Oct 2023 01:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697443336; x=1698048136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vxzdd7hvG1LZGKkqhTZumSilwKU2j2TuY6Cx8E9gJo=;
        b=ev/jab1eV1cbharyKMsaQwtfcgPVcwWewxeEX1djIYlMrQg+qFfKoHNKKloMihZsmr
         0njoBA62xbbWFnbyHb6HgYa8gy2RAWFUWoWv0SsAn2TquSY8AlSxCNbQ2FltMPCu3JG3
         OSJ+hUlbsZrl1U4QrgKsjnQrwJHhEAqJWQAYihMpx/ULN80nE141qX0ZK8257g/w0gfp
         aIQiSjbKk363DAa+DfhGLl8zBnz4K7UrpKl9W0Bw45D5u++FbuFnM4S+H+yifwHKdBKQ
         2sDCLijCJqAUc1CYtiXaeNlw/CpuFwcfz7GJiRYRVsGuqL6Et+WYTDp2Xwi5fgvbTMM2
         wNqQ==
X-Gm-Message-State: AOJu0Ywl3TgvvKOtv+m0geYgXBChfgTBnvtdBRw42NubL6HURgNxav5r
        oR2eKwK3k1euUkOFvIXITlENQyKyvMsCORZS
X-Google-Smtp-Source: AGHT+IEnAQcfulAK8tSKm3mqtTHbvdCU+3ufmoudypoqa9HGPqbCXKZR1ZkkXFpExKpIiIPsRBFBng==
X-Received: by 2002:a7b:c40a:0:b0:406:61c6:30b8 with SMTP id k10-20020a7bc40a000000b0040661c630b8mr28046368wmi.22.1697443335642;
        Mon, 16 Oct 2023 01:02:15 -0700 (PDT)
Received: from cizrna.home (cst-prg-37-192.cust.vodafone.cz. [46.135.37.192])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c419600b00407460234f9sm6395535wmh.21.2023.10.16.01.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 01:02:15 -0700 (PDT)
From:   Tomeu Vizoso <tomeu@tomeuvizoso.net>
To:     linux-kernel@vger.kernel.org
Cc:     Da Xue <da@libre.computer>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: VIM3: Set the rates of the clocks for the NPU
Date:   Mon, 16 Oct 2023 10:02:03 +0200
Message-ID: <20231016080205.41982-1-tomeu@tomeuvizoso.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise they are left at 24MHz and the NPU runs very slowly.

Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Suggested-by: Lucas Stach <l.stach@pengutronix.de>
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

