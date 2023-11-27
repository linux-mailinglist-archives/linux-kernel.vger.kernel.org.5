Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F073D7F9CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjK0Jei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjK0Jeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:34:36 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B821E12F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:34:42 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a0029289b1bso544269966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701077681; x=1701682481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r/cLEfEYsDlJ66whBNkZuZq4CWHWfN+jms36PvtVtn0=;
        b=idD3yoCrxbb9nntr0AWzXClUrz5UkOzUrGMasZjR9s8T9MByMbF4oxGFL7qEs7/Tj0
         TivjHTH1Sy7zUtcb91eYCmCGdSDWXsKYAh2n/5g2xFXGfIWbM/EhduokfhR/tq0fzxQv
         RXRf1TfcXYUxzKC3MllyORN5chx3WOvi3OQ4oDisGTRzc0QjoJ8fTs0XtBYYHhWwmkTX
         GAC/c8jlce3QkBqJf6PD1mUhQjhYJ8iVCBodI/auin81uYhpzEJxmtLCWWyytJCvD/19
         XGEEGeKHTrOAgWeIAo/6qnAMsczv83abO2V5VPHfEIrmdYilJh9UtPk9XKe/B8L+exXf
         On9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701077681; x=1701682481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/cLEfEYsDlJ66whBNkZuZq4CWHWfN+jms36PvtVtn0=;
        b=w+LmFTqfa2ZF2B43ub9rtVmbDg7n8n5JGb4gWu86LcVHlsAjnpG44te8PemKfRL4I6
         h7B9j2WkR81VJdZU75Jp06rksopbEvCW88Qiqux+JK6s2E+L/jg8h3nbaaa8gmRbIZPs
         Sck+amG3+a6WhxBYnsgjclyRC7fvWYAfXNvLcWVPDaIFY3tinyXGChXTLGbxVJPgTAx3
         s1c5qT4hWvshDPHFu4xV7RZotouSqZEVGPMwCHP4K4om2ykoozQnXznXQxJuxUWHzV7N
         A1uywkADJbCL3v8JfTkCwKSTA23BZqxdru/Y5BTXrAuHEDGioq5xWovc7ST3ITcUpd/u
         pK9w==
X-Gm-Message-State: AOJu0YwBJT0MQtTscPIE36uEmsakYRo7b8/ga99mDKb+8BvSMR68iTNi
        t0uh4ISRikbXpSgywYI8dFkVIw==
X-Google-Smtp-Source: AGHT+IGnhYWsRzafsu4ynClwI2g+4BUzmbE3Md5LZwds9K60AiVBQlMrDOPX5/2ErDeanuSExoJjdw==
X-Received: by 2002:a17:906:693:b0:9fc:9b28:7ff7 with SMTP id u19-20020a170906069300b009fc9b287ff7mr8766198ejb.60.1701077681201;
        Mon, 27 Nov 2023 01:34:41 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id j8-20020a1709062a0800b00a0185ccedcasm5506518eje.223.2023.11.27.01.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:34:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] ARM: dts: sti: minor whitespace cleanup around '='
Date:   Mon, 27 Nov 2023 10:34:38 +0100
Message-Id: <20231127093438.20512-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Split previous commit touching entire 'st' directory.
---
 arch/arm/boot/dts/st/stih407-pinctrl.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/st/stih407-pinctrl.dtsi b/arch/arm/boot/dts/st/stih407-pinctrl.dtsi
index 7815669fe813..dcb821f567fa 100644
--- a/arch/arm/boot/dts/st/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stih407-pinctrl.dtsi
@@ -462,14 +462,14 @@ pio19: pio@9209000 {
 			serial0 {
 				pinctrl_serial0: serial0-0 {
 					st,pins {
-						tx =  <&pio17 0 ALT1 OUT>;
-						rx =  <&pio17 1 ALT1 IN>;
+						tx = <&pio17 0 ALT1 OUT>;
+						rx = <&pio17 1 ALT1 IN>;
 					};
 				};
 				pinctrl_serial0_hw_flowctrl: serial0-0_hw_flowctrl {
 					st,pins {
-						tx =  <&pio17 0 ALT1 OUT>;
-						rx =  <&pio17 1 ALT1 IN>;
+						tx = <&pio17 0 ALT1 OUT>;
+						rx = <&pio17 1 ALT1 IN>;
 						cts = <&pio17 2 ALT1 IN>;
 						rts = <&pio17 3 ALT1 OUT>;
 					};
-- 
2.34.1

