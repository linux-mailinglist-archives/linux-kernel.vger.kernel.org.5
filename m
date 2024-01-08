Return-Path: <linux-kernel+bounces-20077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E39C827909
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29138B22F3A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D3455E6D;
	Mon,  8 Jan 2024 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dFl0xiqT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43DC55C14
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-557f4fd1278so111592a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 12:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1704744986; x=1705349786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mPDNXnb7QOonc0RYCjpM23Kv+HuP4dW7ug+KwP2qeg=;
        b=dFl0xiqTIoP0+gAHr8tWcEcWltqmPv3i7MhYW9nZdsDpraOPvFHXLHZqkgAhQgj9Dr
         DnPglBhHGy5xkziNlqo3EaFVsNgLz15tKeVDLGq0mlmBlavBm6Q1WKgoWArRLYy9+ETL
         NMo7CLg5DwnvseaBO62/t6gNriieAfdYS30vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704744986; x=1705349786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mPDNXnb7QOonc0RYCjpM23Kv+HuP4dW7ug+KwP2qeg=;
        b=pOxxXebFHAPnI2UiQsLiTUYfYmyRj5q39sb/td1Tx9sfEnHGCwZ+/Mgks0CjknWGZN
         5DC0hWq8MHHMyIFbnWCKpH/9x81S9KNIFKsMpE0MgjoQV++cJ/Zgq4Zuz6R9b4/dOAvf
         bKImrvJvWirkOxBAHkrVaoSRX4YA2lb7jXQB1MPNBTetGuM63cl8YqbXTsLizlmLxnm/
         APV5ePfy+HCNO/8nN+hYnR1N2p4o8sHOehIWIRgTFes3OZDiPiyx/t5HYxwDniWuoRvd
         8Rked0kBIuahM4SNxKph6+HXce75msZNLxNUXrSnUgkhMKDuKTBv5JlY+BCS6Gv0ll9m
         Dh9A==
X-Gm-Message-State: AOJu0Yxc11sIqGyg9NBX6qkKO8HfP9737A6f4PCKmvUbRBmXhcix7LWe
	7f9ihkgNd4PvhClkhMTD1QN5KL+vKTRu/jVLGKEuz+68+mw=
X-Google-Smtp-Source: AGHT+IHaaI1NSukORL4e4ZmL8fcZPEpDIgOEx1JCxKvw+wV6NYJajXGzcYKLAKRo8vBhmJzZt/w4Hg==
X-Received: by 2002:a50:d481:0:b0:553:faf6:4c8d with SMTP id s1-20020a50d481000000b00553faf64c8dmr2556328edi.35.1704744985694;
        Mon, 08 Jan 2024 12:16:25 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-2-38-81.retail.telecomitalia.it. [87.2.38.81])
        by smtp.gmail.com with ESMTPSA id by26-20020a0564021b1a00b00555fd008741sm173699edb.95.2024.01.08.12.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:16:25 -0800 (PST)
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
Subject: [PATCH v5 3/8] ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f769-disco
Date: Mon,  8 Jan 2024 21:15:48 +0100
Message-ID: <20240108201618.2798649-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108201618.2798649-1-dario.binacchi@amarulasolutions.com>
References: <20240108201618.2798649-1-dario.binacchi@amarulasolutions.com>
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


