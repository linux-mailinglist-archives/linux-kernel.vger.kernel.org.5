Return-Path: <linux-kernel+bounces-13897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B5D821465
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 17:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91FF1F2171A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 16:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9419DC2DF;
	Mon,  1 Jan 2024 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="d/Bg4KOq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247418BEA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d60ad5f0bso47095455e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 08:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704125771; x=1704730571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mPDNXnb7QOonc0RYCjpM23Kv+HuP4dW7ug+KwP2qeg=;
        b=d/Bg4KOqoIMgXhftN3xPRmPuTg40x5Fa1VQi75eBxC8g+EG2FD2hCoMuGBIbyffCl1
         6sfn5MDKyfh+cGvZ122aN+nlmjJnrTMHYmuviTL+VsiJvB5MxwOArbWf10GQMy9840O8
         kwP1bc+FVxz4xZuAcTNa4RD9q45y1qLhVMIX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704125771; x=1704730571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mPDNXnb7QOonc0RYCjpM23Kv+HuP4dW7ug+KwP2qeg=;
        b=Zfehj2FBIpG+T1acYVkIHo9Vtp+c+eYNaNJ2ouIlQQSohvouhJw5JSi/Nfod97xPvx
         aVfb7r9O7UA3/ymnyVVugP79t08x1fVlvsYYgy33Zlh6Vd3UbaGD69XlWWr0JEFj+xvP
         d58Dk1LzyZ3u9OTp3Vrk1xIQnHpDPkKJT9NCv8jrdLvADZBoKJeDJvKZ0xYUt3hmNdAB
         0Fe8yuK6jZcNYcHbim3Vi+HpRVaauFifvtJaxKDKWhL3nDYiASZP/anuNaOsjmH/KKLi
         pxL/MS5GFw0k3PelCYsIytLgIZUlTjVPAyySn3lyz+ePJ0bnscA6qm7VOf8bHkZOtEBJ
         kOMA==
X-Gm-Message-State: AOJu0Yw6cxkiP+DZE95pqS7/GwLyH2XQdlOdNIUSuj+bina/Kv1VjXMM
	sZEtrmVQdlrRVW2G3ZwBMabmPNwk9yADaw34JT54UI5bLI4=
X-Google-Smtp-Source: AGHT+IHSl15tLxHpi+RcLJUqhRUzwJaEGI0rE3xh/JUkXzKq/LKEw48Va5v6dhV2hR+u+VqwAjeyVQ==
X-Received: by 2002:a05:600c:3494:b0:40d:8a2a:220b with SMTP id a20-20020a05600c349400b0040d8a2a220bmr575593wmq.171.1704125771193;
        Mon, 01 Jan 2024 08:16:11 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-48-44-179.retail.telecomitalia.it. [82.48.44.179])
        by smtp.gmail.com with ESMTPSA id ep16-20020a1709069b5000b00a27d5e9b3ebsm1897857ejc.105.2024.01.01.08.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 08:16:10 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 3/8] ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f769-disco
Date: Mon,  1 Jan 2024 17:15:46 +0100
Message-ID: <20240101161601.2232247-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240101161601.2232247-1-dario.binacchi@amarulasolutions.com>
References: <20240101161601.2232247-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the schematics of document UM2033, the power supply for the micro SD
card is the same 3v3 voltage that is used to power other devices on the
board. By generalizing the name of the voltage regulator, it can be
referenced by other nodes in the device tree without creating
misunderstandings.

This patch is preparatory for future developments.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/arm/boot/dts/st/stm32f769-disco.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32f769-disco.dts b/arch/arm/boot/dts/st/stm32f769-disco.dts
index 5d12ae25b327..8632bd866272 100644
--- a/arch/arm/boot/dts/st/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f769-disco.dts
@@ -92,9 +92,9 @@ usbotg_hs_phy: usb-phy {
 		clock-names = "main_clk";
 	};
 
-	mmc_vcard: mmc_vcard {
+	vcc_3v3: vcc_3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "mmc_vcard";
+		regulator-name = "vcc_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
@@ -128,7 +128,7 @@ &rtc {
 
 &sdio2 {
 	status = "okay";
-	vmmc-supply = <&mmc_vcard>;
+	vmmc-supply = <&vcc_3v3>;
 	cd-gpios = <&gpioi 15 GPIO_ACTIVE_LOW>;
 	broken-cd;
 	pinctrl-names = "default", "opendrain", "sleep";
-- 
2.43.0


