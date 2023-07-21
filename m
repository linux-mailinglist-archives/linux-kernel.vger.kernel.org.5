Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE3775BDCD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjGUFju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGUFjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:39:47 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272301BC1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 22:39:45 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-56372a369d3so751184a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 22:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1689917984; x=1690522784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MET1FtsHEOQSbfBm9BNtYvB0Q268yaadYjHQUlEH8ew=;
        b=rC8YrmePH9OhK6bW8pKMi8wPd5o4X85CUBjfQ064A0pBxm4il19yyhoB95JnpechbJ
         S/2pHJfFJU1/KmaJnY8boi/gAdqJz71xx2Pmiec9SEH4UrF71z+pctasdpxBM5Jvtjsk
         9cmJS2goGsvTSOoyEQDWC4ow+eQGy2m2KDYUaUH2FkibXnhYKdFAWbbcmnUXDVpfwTt2
         +dKkbKjO4OqXrMpt2OCNevlBQ565oJsstTonckAPrH29AudHcVs0je5qudw76WCiqE0P
         DGQ5PgjYyKsMeyAomhJsSFPMfvHhR2xI3otpcN6mLYnKa5l+Tuv/hsPUSiCUGH6P9MUI
         s9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689917984; x=1690522784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MET1FtsHEOQSbfBm9BNtYvB0Q268yaadYjHQUlEH8ew=;
        b=aNq3ZshndJbyY2h18xngrLNhMQ6XkTGpFIccSJLiCJaHc3HzPHPEg8lvCZlCBAtjkW
         6HwKKiYYeoYG265AT+8t7VDH78WySQ5OqNMPS+uC03Xm54osHZgyPC25HzpPrEtV6Qo9
         VTtYLyOVJhmmD36/CCjjH1vEOlLxwoTSyw8r1h4fEnLS7R/68DmbCZCndYeINmp8IX5f
         q99FjaGnGi9DS0Q/kE1lani0BzQQg3sRd6o5Zm9H4yl1CfLU8+OplSh6Gk1V912yDdfD
         qgkBpxNX3xHjGZlViPpuQ6KpN/XVeyY/NtOcj07dDEIhs9r6rrRlxGI+CQcF40Deiwsv
         jiPw==
X-Gm-Message-State: ABy/qLZM+gNi8SSLn24FUMhfPbww01m9yIRy5AMSpbyNT+m3X7yD0vZR
        ZJfBh1X8ZUe+HF/0xOGOJj77wQ==
X-Google-Smtp-Source: APBJJlGT0YJwrdWz/rSHkii66QghHlD0aHdPrXJ236lAMeGLNoUIb+iZTRE0SUMVKzkLuh34MCWwVw==
X-Received: by 2002:a05:6a21:33a7:b0:12f:c61e:7cac with SMTP id yy39-20020a056a2133a700b0012fc61e7cacmr947830pzb.31.1689917984627;
        Thu, 20 Jul 2023 22:39:44 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id s26-20020a63a31a000000b0055c178a8df1sm2157857pge.94.2023.07.20.22.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 22:39:44 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, cristian.birsan@microchip.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH] ARM: dts: at91: remove duplicated entries
Date:   Fri, 21 Jul 2023 08:39:18 +0300
Message-Id: <20230721053918.33944-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM14,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated DTC_FLAGS_<board> := -@ entries which intends to enable
the building of device tree overlays.
Commit 724ba6751532 ("ARM: dts: Move .dts files to vendor sub-directories")
added those entries at the beginning of file w/o removing the already
available entries spread though file.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 arch/arm/boot/dts/microchip/Makefile | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/Makefile b/arch/arm/boot/dts/microchip/Makefile
index 0f5193d05a31..31e03747cdf4 100644
--- a/arch/arm/boot/dts/microchip/Makefile
+++ b/arch/arm/boot/dts/microchip/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+# Enables support for device-tree overlays
 DTC_FLAGS_at91-sam9x60_curiosity := -@
 DTC_FLAGS_at91-sam9x60ek := -@
 DTC_FLAGS_at91-sama5d27_som1_ek := -@
@@ -54,21 +55,9 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 	at91sam9g35ek.dtb \
 	at91sam9x25ek.dtb \
 	at91sam9x35ek.dtb
-# Enables support for device-tree overlays
-DTC_FLAGS_at91-sam9x60_curiosity := -@
-DTC_FLAGS_at91-sam9x60ek := -@
 dtb-$(CONFIG_SOC_SAM9X60) += \
 	at91-sam9x60_curiosity.dtb \
 	at91-sam9x60ek.dtb
-# Enables support for device-tree overlays
-DTC_FLAGS_at91-sama5d27_som1_ek := -@
-DTC_FLAGS_at91-sama5d27_wlsom1_ek := -@
-DTC_FLAGS_at91-sama5d2_icp := -@
-DTC_FLAGS_at91-sama5d2_ptc_ek := -@
-DTC_FLAGS_at91-sama5d2_xplained := -@
-DTC_FLAGS_at91-sama5d3_eds := -@
-DTC_FLAGS_at91-sama5d3_xplained := -@
-DTC_FLAGS_at91-sama5d4_xplained := -@
 dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-kizbox2-2.dtb \
 	at91-kizbox3-hs.dtb \
@@ -95,8 +84,6 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-sama5d4_xplained.dtb \
 	at91-sama5d4ek.dtb \
 	at91-vinco.dtb
-# Enables support for device-tree overlays
-DTC_FLAGS_at91-sama7g5ek := -@
 dtb-$(CONFIG_SOC_SAMA7G5) += \
 	at91-sama7g5ek.dtb
 
-- 
2.39.2

