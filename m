Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1117EBCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 05:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbjKOEfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 23:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKOEfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 23:35:23 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E4BD8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 20:35:19 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-28019b66ad5so122443a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 20:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700022919; x=1700627719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKE2Z3rIdCP16EvnaCbTQcF6cETDsiXZjgYQFVaGzsY=;
        b=PA7ze/vLK/n0DCl+piO4LVDdXt4uQIgscs9vqxrC0mMHoFGfAdrWaKPWsAzmdWUX/D
         WzPTAMy311JyYZUJjQj2S86klcV3Fcp0B1HENsz9CZAXTmb1033zvrvGhGJRdLo3HhlC
         U/EUuncoQiJu/dhrqw4UW7zkEXD3PvpoVLwf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700022919; x=1700627719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKE2Z3rIdCP16EvnaCbTQcF6cETDsiXZjgYQFVaGzsY=;
        b=r+EsxbPxXXu5fn2xpngoNK0btfphMp2O4iKgon5noiBAWeysdID0l3aZJ9E7oYIaS6
         zaH3wregW+Loyqpq2qpzEkE5igDQJxwtHc1B5HxUfzDQXWQIqe0XL0edvuNFQWZGoEyi
         C2+4fI/w6mWOwC8+dsBDp6GKiJygeL7EeRQtG+g81qDaoGqy9kFt/LoFD3/+izccd1FH
         nppDEIKrlkregRGQMi5F0lQe8coPCS7PZeLOaRNNXd198HIajto/AY4QvATCOGCwgkmb
         VIw5gcSy7TJDTEx8QGOA59SwcjhPw9nIMvfWx9jEwPQBhh8qv9+QYmr4JbQpnN4DeKpE
         l+ng==
X-Gm-Message-State: AOJu0YyweleWDB0OcWrAb9qPztK/DSik5qF7Xru33SeBGXiUvdv6lq7X
        dBNPSYBoF5/bXfZBbv1P3gt2JQ==
X-Google-Smtp-Source: AGHT+IHPWARszrcyKURojq7sjdFRg5WZJqBWm7TVHsyJF6yVoEHDN9wnAQBKnHHZ3jWQAFQoYBIT5Q==
X-Received: by 2002:a17:90b:1c0c:b0:27f:fce3:2266 with SMTP id oc12-20020a17090b1c0c00b0027ffce32266mr11651424pjb.24.1700022918786;
        Tue, 14 Nov 2023 20:35:18 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:b51f:fb1c:5e29:cfc8])
        by smtp.gmail.com with ESMTPSA id gp16-20020a17090adf1000b00280cd4fbd83sm7879425pjb.55.2023.11.14.20.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 20:35:18 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2] arm64: dts: mt8173: Add G2Touch touchscreen node
Date:   Wed, 15 Nov 2023 12:35:01 +0800
Message-ID: <20231115043511.2670477-1-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo Ideapad C330 Chromebook (MTK) uses G2Touch touchscreen as a
second source component.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---

Changes in v2:
- Remove the label for the node

 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
index bdcd35cecad9..8836ac3c4233 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
@@ -29,6 +29,14 @@ touchscreen3: touchscreen@20 {
 		interrupt-parent = <&pio>;
 		interrupts = <88 IRQ_TYPE_LEVEL_LOW>;
 	};
+
+	touchscreen@40 {
+		compatible = "hid-over-i2c";
+		reg = <0x40>;
+		hid-descr-addr = <0x0001>;
+		interrupt-parent = <&pio>;
+		interrupts = <88 IRQ_TYPE_LEVEL_LOW>;
+	};
 };
 
 &i2c4 {
-- 
2.43.0.rc0.421.g78406f8d94-goog

