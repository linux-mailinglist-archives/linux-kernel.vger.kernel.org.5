Return-Path: <linux-kernel+bounces-12973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 523B881FDD7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A811F2358D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD17779C2;
	Fri, 29 Dec 2023 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HETnAPdD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039068F51;
	Fri, 29 Dec 2023 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dc07ce2a30so1055332a34.0;
        Thu, 28 Dec 2023 23:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703835935; x=1704440735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raM42T0EIL2NcFESOuJEj10hSihrJvgpKQH+cdOXtTI=;
        b=HETnAPdD/HilQP/nDTHprZRI5XLfXARlU9rECZySe2j1eTJoNs1TGIQO2qEUXvqiwj
         G13eqFgxaJdp2MBQYBKQcoZzTH+qv3gT+nz1CWO50Rt8oJ1XTFoFmW8ChFUL9gvRydw5
         W8YHylfWOXbUQNmAiALgShpqk/TgaImrGNBvZLn/rv8rBSDYd/WDPz6+Kop9pZ7OWmRz
         4cY+9eEDhQcVecvFt0+qxSXLIH+fqGL8T1br3RegImZkBA+6U6yCPdsPdpvqLwcui1FC
         xnkrwt3MYeZF8mKGKMUATgsYK7ffO9gNOZN3StyfuQi8IJzxZOBVXPn2dll7UZX5zmFN
         Jeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703835935; x=1704440735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raM42T0EIL2NcFESOuJEj10hSihrJvgpKQH+cdOXtTI=;
        b=xLA4v3iFHzEfSlDtqn9P3cfoZRnrImhHuf+JIdBmVLgcnWZlRU3fl/ETKOhotTGU5Q
         AFy++db3sfQ/D0qapn8qKnnfcw0I/4UPp05BWJEFZ+dq1h2z41/zkh2oeMU/m5sBRedj
         kkBiu4EiZdXy0NXJma3zynN6QY/f6dQgLqO2Bg5ubaGSa7t6pupwGtzKxYcYXCB74twy
         M1XIvtg+cKcM77FfJx/Um0Mc3OIrRFgsST8YAf/wsoZKxx3Tx8a46BwKYN9pfPjO+tnj
         zAe8LXWxJpMr3OKz/BwICFmOkvS5lvbL6+dIvHJ7bB2WJYwER2U5rBAiT4AX1o+ELEY8
         QfuA==
X-Gm-Message-State: AOJu0YxIpseCTtwKw/npQ9+7Ufs9uT2b31PXOqPpaShBb5nUVljkEunw
	yi8ea6+oDMSiw4mWXsfhecc=
X-Google-Smtp-Source: AGHT+IHVacEjDYDHAf1Is5qnuiqwZwRsVxajivxiR3T1XLsZA5D4sijpp84TGkK8RWO6nbh5MDsz7w==
X-Received: by 2002:a9d:6e8b:0:b0:6db:af74:dacb with SMTP id a11-20020a9d6e8b000000b006dbaf74dacbmr7602885otr.67.1703835935085;
        Thu, 28 Dec 2023 23:45:35 -0800 (PST)
Received: from localhost.localdomain ([1.200.140.173])
        by smtp.gmail.com with ESMTPSA id s188-20020a6377c5000000b005c683937cc5sm10305186pgc.44.2023.12.28.23.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 23:45:34 -0800 (PST)
From: jim.t90615@gmail.com
X-Google-Original-From: JJLIU0@nuvoton.com
To: JJLIU0@nuvoton.com,
	KWLIU@nuvoton.com,
	jim.t90615@gmail.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: [PATCH v10 2/3] arm: dts: nuvoton: npcm: Add sgpio feature
Date: Fri, 29 Dec 2023 15:45:07 +0800
Message-Id: <20231229074508.2709093-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231229074508.2709093-1-JJLIU0@nuvoton.com>
References: <20231229074508.2709093-1-JJLIU0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Liu <jim.t90615@gmail.com>

Add the SGPIO controller to the NPCM7xx devicetree

Signed-off-by: Jim Liu <jim.t90615@gmail.com>
---
Changes for v10:
   - no changed
Changes for v9:
   - no changed
---
 .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index 868454ae6bde..df91517a4842 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
@@ -372,6 +372,30 @@ &fanin12_pins &fanin13_pins
 				status = "disabled";
 			};
 
+			gpio8: gpio@101000 {
+				compatible = "nuvoton,npcm750-sgpio";
+				reg = <0x101000 0x200>;
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				nuvoton,input-ngpios = <64>;
+				nuvoton,output-ngpios = <64>;
+				status = "disabled";
+			};
+
+			gpio9: gpio@102000 {
+				compatible = "nuvoton,npcm750-sgpio";
+				reg = <0x102000 0x200>;
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				nuvoton,input-ngpios = <64>;
+				nuvoton,output-ngpios = <64>;
+				status = "disabled";
+			};
+
 			i2c0: i2c@80000 {
 				reg = <0x80000 0x1000>;
 				compatible = "nuvoton,npcm750-i2c";
-- 
2.25.1


