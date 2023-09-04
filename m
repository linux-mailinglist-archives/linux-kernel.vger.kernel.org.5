Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB97791C50
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353385AbjIDSF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238746AbjIDSF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:05:28 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A1FF9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:05:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c93638322so366024766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1693850722; x=1694455522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BwZewNI4F+2A2loSj+kf1NfW7/PQMO46viQSdkuX7pk=;
        b=b5cUNv/B1jbsODWiWhqr+r8OfHKZczOKDPMGxg7RDvuklBYmSR9wkoUkRMFTzmJe9U
         v69fGjpPjbehkfzeqr/Frc6LzfBCJSnrmC1uhggRM0TY9MpD2GFw4Ch92g+dTQS2/r4G
         h07+sDtdQ12LrjoBVY0eCSCM+QX2JumCimghA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693850722; x=1694455522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwZewNI4F+2A2loSj+kf1NfW7/PQMO46viQSdkuX7pk=;
        b=T0E4ZdeJlnwQkC6f8eUDpejp8Lo6L7y31R/nTXWwbQEFQhfa5x2EE1MWZoNIesI9+Z
         7ngL9lCzxl9J7XN3teYuvqBnQWX4fquOstOt5bSM46/Z6/Sue/vkgXjuJWjvluKm03Wg
         kxFcB6KYk3NadXeMuFHm5HBWaizpWZIiQ+LEdF+F6Ag2jSjgfWBya6chwPu+5sJu3qWi
         HGEsP9/dAZwmMUg29fBZfKiqLwidjTk4M1y20ABLmh2lz9rMpSZXF9DHKlszqyR4D8LO
         FBi2g/s5bREeaf1sJr9pIfI/hjkcNiRyqkXAiIGxQc+AHOojk2H6pusfdBupFmx56avb
         4Ojg==
X-Gm-Message-State: AOJu0YzQdTxLuQf3H/9/q20wuoEvKWod9WuIYyZBmudpXGhnsfJSfAHV
        JuigsNUblnt+qw9fAAi5q4X/CODjfZj/2KCxMcli4A==
X-Google-Smtp-Source: AGHT+IEYctr6D2EcdpyGOsS9HFSxP/Ij1SiHZ9bQWe2PcRm76C8Xxe7LTR4UZmZqVc4lcVqibvJZ0A==
X-Received: by 2002:a17:907:97d0:b0:9a1:c69c:9388 with SMTP id js16-20020a17090797d000b009a1c69c9388mr13413090ejc.37.1693850722354;
        Mon, 04 Sep 2023 11:05:22 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
        by smtp.gmail.com with ESMTPSA id pw9-20020a17090720a900b0098884f86e41sm6382620ejb.123.2023.09.04.11.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 11:05:21 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH] ARM: dts: stm32: fix SDRAM size on stm32f469-disco
Date:   Mon,  4 Sep 2023 20:05:13 +0200
Message-Id: <20230904180513.923280-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The board is equipped with a 128Mbit SDRAM.
128Mbit = 16 Mbyte = 16,777,216 bytes = 0x1000000.

Fixes: 626e7ea00215 ("ARM: DT: stm32: move dma translation to board files")
Link: https://www.st.com/en/evaluation-tools/32f469idiscovery.html
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/boot/dts/st/stm32f469-disco.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32f469-disco.dts b/arch/arm/boot/dts/st/stm32f469-disco.dts
index cbbd521bf010..f173a5892b7d 100644
--- a/arch/arm/boot/dts/st/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f469-disco.dts
@@ -84,7 +84,7 @@ vdd_dsi: vdd-dsi {
 	};
 
 	soc {
-		dma-ranges = <0xc0000000 0x0 0x10000000>;
+		dma-ranges = <0xc0000000 0x0 0x1000000>;
 	};
 
 	leds {
-- 
2.34.1

