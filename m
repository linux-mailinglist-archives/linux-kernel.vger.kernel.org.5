Return-Path: <linux-kernel+bounces-3770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 068888170C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC791F210AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22141D13D;
	Mon, 18 Dec 2023 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VXtv+iR+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710671D141
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a236456fee1so67932466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 05:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702907142; x=1703511942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eKhb1wuaASLimxbRARfMv02XJ8Pn6jccWBoKn7oICEU=;
        b=VXtv+iR+1rhIM5lKiKV7A5Ht/Ro0bFSmXMOKNm5SJENTv9rT1PJFM2BoRPoxFv3z2C
         8DDTDspIBmvvPG0VU1A9ZXrcmduYOqXGsCUeycQ5G7lAHu+5Q/SDQ+ZYgoAysqWffGOi
         Rm5W5ltnW0StsBEosBycqS/Nzy8yeRReCip08pNx4eiwFnz9qT/y1lxTMlICxDBqr8zP
         Z72Ytg6p3VyO+RQvXdyBxf7DMmcuEzfJJfzllLS1POj+B3Mxjs8m4a70hDIs2Wy7YlGV
         y6XzSf/jMtczDOixmPMPIQvlHQG0LvFvp3DXciVQ7D7qmIkov1/6Zkz9py1Gd6RM/71D
         Yr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702907142; x=1703511942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKhb1wuaASLimxbRARfMv02XJ8Pn6jccWBoKn7oICEU=;
        b=CEnFRi4T2MtJgizwnwPEEEftmfRzVqOS77VZpW/auunzV6JZJa/KTbzUlyTmsyv41I
         Xn/vQ/nn0ZEflBhLhOuV1GX6l3QGKSB5W5o4F6d8sJ+Kys//KsNTnMeUPkUf2EttMSNP
         JFuboR8yWFEWuAWvlLGjSeLi256QQlhp5otyX8EeZlhoiCAmecNDwIKVenpBWttzyZ17
         /trtLqTwNGxyjESPZj8TzhnogzFNdLjWppaIhmj1WsF/ADQgtIg/nExcJL14+hGqszaq
         MMU+fbBMoYqYiGp/9S9fMzjVxknmjJ8pAhXhGGuaiwJ6p4cgsjt5CYjY8uCeSv3fs379
         NgBw==
X-Gm-Message-State: AOJu0YzdVZGLTUju3EkcFhS7PZyUcbneuks/ysYW0XYyscBk5jqhP1Wd
	6cklQTJ2/fzG/TXE5VyEdSPD3A==
X-Google-Smtp-Source: AGHT+IFs7wt3ToRlnwY7EWDI6F7umGuxxvB8rQGh/rKbHCiv45OnY0HarLfW0BWd14nFz1qBMlhM9Q==
X-Received: by 2002:a17:907:d1b:b0:a23:614d:37c7 with SMTP id gn27-20020a1709070d1b00b00a23614d37c7mr587185ejc.141.1702907142528;
        Mon, 18 Dec 2023 05:45:42 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id lm11-20020a17090718cb00b00a1db76f99c8sm14345334ejc.93.2023.12.18.05.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 05:45:42 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arm@kernel.org,
	soc@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lennert Buytenhek <kernel@wantstofly.org>,
	Steve Sakoman <sakoman@gmail.com>,
	"Mark F . Brown" <mark.brown314@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Florian Fainelli <florian@openwrt.org>,
	Simtec Linux Team <linux@simtec.co.uk>
Subject: [PATCH] ARM: MAINTAINERS: drop empty entries for removed boards
Date: Mon, 18 Dec 2023 14:45:32 +0100
Message-Id: <20231218134532.50599-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Drop empty and redundant maintainer entries for boards which were
removed to fix `scripts/get_maintainer.pl --self-test=sections` errors
like:

  ./MAINTAINERS:2021: warning: section without file pattern	ARM/CIRRUS LOGIC EDB9315A MACHINE SUPPORT

Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Steve Sakoman <sakoman@gmail.com>
Cc: Mark F. Brown <mark.brown314@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Florian Fainelli <florian@openwrt.org>
Cc: Simtec Linux Team <linux@simtec.co.uk>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d26c5311fb1..cdf1575dc851 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2018,11 +2018,6 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Odd Fixes
 N:	clps711x
 
-ARM/CIRRUS LOGIC EDB9315A MACHINE SUPPORT
-M:	Lennert Buytenhek <kernel@wantstofly.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-
 ARM/CIRRUS LOGIC EP93XX ARM ARCHITECTURE
 M:	Hartley Sweeten <hsweeten@visionengravers.com>
 M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
@@ -2171,11 +2166,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
 F:	arch/arm/boot/dts/nxp/vf/
 F:	arch/arm/mach-imx/*vf610*
 
-ARM/GUMSTIX MACHINE SUPPORT
-M:	Steve Sakoman <sakoman@gmail.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-
 ARM/HISILICON SOC SUPPORT
 M:	Wei Xu <xuwei5@hisilicon.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -2254,11 +2244,6 @@ F:	Documentation/devicetree/bindings/arm/intel,keembay.yaml
 F:	arch/arm64/boot/dts/intel/keembay-evm.dts
 F:	arch/arm64/boot/dts/intel/keembay-soc.dtsi
 
-ARM/INTEL XSC3 (MANZANO) ARM CORE
-M:	Lennert Buytenhek <kernel@wantstofly.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-
 ARM/LG1K ARCHITECTURE
 M:	Chanho Min <chanho.min@lge.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -2840,11 +2825,6 @@ F:	arch/arm/boot/dts/synaptics/
 F:	arch/arm/mach-berlin/
 F:	arch/arm64/boot/dts/synaptics/
 
-ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
-M:	Lennert Buytenhek <kernel@wantstofly.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-
 ARM/TEGRA HDMI CEC SUBSYSTEM SUPPORT
 M:	Hans Verkuil <hverkuil-cisco@xs4all.nl>
 L:	linux-tegra@vger.kernel.org
@@ -2861,11 +2841,6 @@ L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 F:	arch/arm64/boot/dts/tesla/
 
-ARM/TETON BGA MACHINE SUPPORT
-M:	"Mark F. Brown" <mark.brown314@gmail.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-
 ARM/TEXAS INSTRUMENT AEMIF/EMIF DRIVERS
 M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-kernel@vger.kernel.org
@@ -17674,14 +17649,6 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-pxa.c
 
-PXA MMCI DRIVER
-S:	Orphan
-
-PXA RTC DRIVER
-M:	Robert Jarzmik <robert.jarzmik@free.fr>
-L:	linux-rtc@vger.kernel.org
-S:	Maintained
-
 PXA2xx/PXA3xx SUPPORT
 M:	Daniel Mack <daniel@zonque.org>
 M:	Haojian Zhuang <haojian.zhuang@gmail.com>
@@ -18320,10 +18287,6 @@ F:	drivers/media/i2c/max9271.c
 F:	drivers/media/i2c/max9271.h
 F:	drivers/media/i2c/rdacm21.c
 
-RDC R-321X SoC
-M:	Florian Fainelli <florian@openwrt.org>
-S:	Maintained
-
 RDC R6040 FAST ETHERNET DRIVER
 M:	Florian Fainelli <f.fainelli@gmail.com>
 L:	netdev@vger.kernel.org
@@ -19930,11 +19893,6 @@ F:	Documentation/devicetree/bindings/display/simple-framebuffer.yaml
 F:	drivers/video/fbdev/simplefb.c
 F:	include/linux/platform_data/simplefb.h
 
-SIMTEC EB110ATX (Chalice CATS)
-M:	Simtec Linux Team <linux@simtec.co.uk>
-S:	Supported
-W:	http://www.simtec.co.uk/products/EB110ATX/
-
 SIOX
 M:	Thorsten Scherer <t.scherer@eckelmann.de>
 M:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
-- 
2.34.1


