Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B60D7727E4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjHGOfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbjHGOfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:35:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE80E10E3;
        Mon,  7 Aug 2023 07:35:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-986d8332f50so628616266b.0;
        Mon, 07 Aug 2023 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691418932; x=1692023732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ha6FI2rVxbfPVkhF/ZknZxX9q1C2VljgFJVBNarUleo=;
        b=Z3LvtDp4zP8VkyIlt0D/cF+eA5Bl9AT+QeI/m/ZZteXaPqeHZFq0OkV1glWPgDsZTE
         mjtb3bmoqbygcexNngQqiuZVRC5yB4ROtd1tR2wSG/LTTu4fXIPoWRg3kbgm5iM51vpq
         YhE/MRsCR6K0SuxNjZFpL2drPflHGDKj5nSQlrZ3l/gMZhz67K2269tP9iyyDUucnXdw
         vLBepkg/M8xt9khLcbtZ3EUU3y+tQKmkEkZjF+KwyCsvEcf86WqQi2gxunTVoxubERHu
         SJU7ihM+Km2unWvvOvexi/JrkPk2sZYku4rVz7SFtef61GQrt5OBJknVQc99bcLSiJWe
         KEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691418932; x=1692023732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ha6FI2rVxbfPVkhF/ZknZxX9q1C2VljgFJVBNarUleo=;
        b=S4XzbSf4blG2zuqC6o///+Vbe3l9otYHdbV0ORpQ9AG/k4fDpP9uswfebP1/s4U0hJ
         j9GY42RNd2N0i3ScEuLrLLxiKF98zVF+zSj+KSasfqFLhowK545OYqiLVskA3iRqwIiJ
         vxd4XvxJWO9xJjI9+eaWVepRIIK3KuDqAnpMxAhp2tdipBgfIp+yCSvjmexxsuPCYEP3
         2G55zHw2W112yBvnsW1wOXMo9kWdy9hAllcrbRg3Zx1MIbohgFkKg9YK7vY+JXBPXhAd
         M8gQBKG+w3ECjHjDkbFXr+J9OXjBHarY5c48c/jo/DZ/eJ9N29xrFd+ozythhSykpSnf
         mX+Q==
X-Gm-Message-State: AOJu0YzyK8xbYSktT1HHWCbS7osRu8015WttmDAXAOHw8G/LU1ilZ4Wj
        /sPW9139bOkTRGc7I4gP0ek=
X-Google-Smtp-Source: AGHT+IGZtGya0s5IHu2LCfaHpasZEmG+74SNEfbKrRDRkKBBWkQxhuFnQequ3Lj0qk7pzQtKV3Up7Q==
X-Received: by 2002:a17:906:3295:b0:992:a85d:278b with SMTP id 21-20020a170906329500b00992a85d278bmr7524417ejw.59.1691418932420;
        Mon, 07 Aug 2023 07:35:32 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906504300b0099329b3ab67sm5323292ejk.71.2023.08.07.07.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:35:32 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] ARM: dts: tegra: Drop unit-address from parallel RGB output port
Date:   Mon,  7 Aug 2023 17:35:11 +0300
Message-Id: <20230807143515.7882-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807143515.7882-1-clamor95@gmail.com>
References: <20230807143515.7882-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Schwalm <maxim.schwalm@gmail.com>

Fix the following W=1 build warning:
"Warning (unit_address_vs_reg): /host1x@50000000/dc@54200000/rgb/port@0:
 node has a unit name, but no reg or ranges property"

Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra20-acer-a500-picasso.dts  | 2 +-
 arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts         | 2 +-
 arch/arm/boot/dts/nvidia/tegra30-asus-lvds-display.dtsi | 2 +-
 arch/arm/boot/dts/nvidia/tegra30-asus-tf700t.dts        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nvidia/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/nvidia/tegra20-acer-a500-picasso.dts
index 486fd244291e..a619ea83ed3b 100644
--- a/arch/arm/boot/dts/nvidia/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/nvidia/tegra20-acer-a500-picasso.dts
@@ -65,7 +65,7 @@ dc@54200000 {
 			rgb {
 				status = "okay";
 
-				port@0 {
+				port {
 					lcd_output: endpoint {
 						remote-endpoint = <&lvds_encoder_input>;
 						bus-width = <18>;
diff --git a/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts b/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
index a3757b7daeda..e118809dc6d9 100644
--- a/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts
@@ -66,7 +66,7 @@ dc@54200000 {
 			rgb {
 				status = "okay";
 
-				port@0 {
+				port {
 					lcd_output: endpoint {
 						remote-endpoint = <&lvds_encoder_input>;
 						bus-width = <18>;
diff --git a/arch/arm/boot/dts/nvidia/tegra30-asus-lvds-display.dtsi b/arch/arm/boot/dts/nvidia/tegra30-asus-lvds-display.dtsi
index bae09d82594d..680edff0f26f 100644
--- a/arch/arm/boot/dts/nvidia/tegra30-asus-lvds-display.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra30-asus-lvds-display.dtsi
@@ -10,7 +10,7 @@ lcd: dc@54200000 {
 			rgb {
 				status = "okay";
 
-				port@0 {
+				port {
 					dpi_output: endpoint {
 						remote-endpoint = <&bridge_input>;
 						bus-width = <24>;
diff --git a/arch/arm/boot/dts/nvidia/tegra30-asus-tf700t.dts b/arch/arm/boot/dts/nvidia/tegra30-asus-tf700t.dts
index efde7dad718a..9c480fde2e76 100644
--- a/arch/arm/boot/dts/nvidia/tegra30-asus-tf700t.dts
+++ b/arch/arm/boot/dts/nvidia/tegra30-asus-tf700t.dts
@@ -15,7 +15,7 @@ lcd: dc@54200000 {
 			rgb {
 				status = "okay";
 
-				port@0 {
+				port {
 					dpi_output: endpoint {
 						remote-endpoint = <&bridge_input>;
 						bus-width = <24>;
-- 
2.39.2

