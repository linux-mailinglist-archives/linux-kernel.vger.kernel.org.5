Return-Path: <linux-kernel+bounces-88357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A1186E06F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C18E1F22B96
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FD66BFC4;
	Fri,  1 Mar 2024 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cffAmzlw"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7916995C;
	Fri,  1 Mar 2024 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292918; cv=none; b=gb3/pW64fnkTpXN4W6mJ420pltobS0UHfKaWrxTdrY8bLPJWT5La+HBE952/l44d42/9irCeiURt/NF+U3kxjC+Wh4Ns+uREfhUh2LfcMr2vYckXcYZrYeQzLRuzZ8GAyWiBxzyt6IO7BVDFiSkcYTlcUe5gQ3/9gMdJkeIoWgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292918; c=relaxed/simple;
	bh=8ACh0WaXC/d3smqhFcqHXaO1dAIcR5R+liOdl58ylc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKIVaoaB/RmyfQjo/LWDKaOncOMs95VhSWrUJL+59/8eXrrQTORj6MkfxlGNvKnqDG9hz8ZJkdIAH95XmnPJrnFqnPLSh9/Nm5UpUxUj0MvgW4IHhIjHNx0sR28INJDWR2dZc7tCnoMEH+DsXmAnF5CAIkhRdrQL44XO05CrX3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cffAmzlw; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so312008166b.2;
        Fri, 01 Mar 2024 03:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709292915; x=1709897715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czM8DBayHVyqm7eWnmJUx8XTvSwkYnsGOgEg/DJr9R4=;
        b=cffAmzlwJipWWEk4mvFBnoovk1CrLhVZMN04cjq0VrUcqXV/Tb0kOXU1uFu3eX4vO7
         EMvk5z82chvE6Z2og1/FqjrMv3/NP8DhAxxCLPRHi0XMf4aiWtiiLYL0Kczay/czaEB7
         1TNwsCeUgO6ktQK5OcwxBa0BtpOZPZrcGpISyUD3kpB19jaXmmaaKmX5aG4d37U91Y5/
         IBL9f+/cIMXHGFhzmRyURsU/oeztjUBZj1G2sU3P34Th36wEqnrL2MlRJBw7cXO3p904
         54MWgqFFvqALu30FNjYoCFlwPDlT5IApRr0m0f7neZLGWCbQQNvgoxAULdbaiiBtriwA
         +5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292915; x=1709897715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czM8DBayHVyqm7eWnmJUx8XTvSwkYnsGOgEg/DJr9R4=;
        b=bg+o9KNZdEOqKAvHnTayZTncFe9tAd8/04yYMu591WVEvH4qO1ApogV5hlBdbBHqVK
         8miJzYaL0YJpZibJzpSn4GJKqwfgQA9R1LvtE2zhSY8OgZO0FB/iU6VLGWOe0CsRHVRb
         roh7PBl2EN/5kLbYu1LpLBglUcfzx3myqjgNI0KTwM3C6M58xRgXCQSy5IIkihIRl4V9
         YWcDrHdW8t/rCJNk8AJZRWoF2+73gb2EwROrnlw9YyrSdaSPBDpMGxh86QMD0DTDa/Fx
         DUz2p86R+CJdF4xXgkloU26K1atO5+coOZHrWddT3jR54jJ9UoN/g6XLdQ8snye1zoOD
         WAkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtRtGTrZal0qBx95yg7vq7RRNSbCnAKKshYS05muoszjgYbV//kV/UUFEogl4oO3HQrphAV+XUe+zzQUV8ftA3iJz7ItPjXjLoMJ9b
X-Gm-Message-State: AOJu0YzbMl765qlTMo6xkb5RZadQtviXuw4KYZynwXtfmNwYpR3wYmcL
	XRiGr/OKu3tXiw7vGqivcXx31mAIMUHW8YC6QS2gQVlgSgvJmExf
X-Google-Smtp-Source: AGHT+IH+/9e4RSmsSeOscUfNHVqMBJcw/1QGsSy+l6pIBhMbP5jqUqbpEIzG0EOtFN44mEcEe34NMQ==
X-Received: by 2002:a17:906:11ce:b0:a44:1fcf:9b9c with SMTP id o14-20020a17090611ce00b00a441fcf9b9cmr1045704eja.51.1709292915494;
        Fri, 01 Mar 2024 03:35:15 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3f5c39bf2asm1618457ejc.0.2024.03.01.03.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:35:15 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/4] arm64: dts: mediatek: mt7622: fix clock controllers
Date: Fri,  1 Mar 2024 12:35:03 +0100
Message-Id: <20240301113506.22944-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240301113506.22944-1-zajec5@gmail.com>
References: <20240301113506.22944-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

1. Drop unneeded "syscon"s (bindings were updated recently)
2. Use "clock-controller" in nodenames
3. Add missing "#clock-cells"

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 27 +++++++++++-------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 3ee9266fa8e9..283fdf7d2d8b 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -283,16 +283,14 @@ thermal_calibration: calib@198 {
 		};
 	};
 
-	apmixedsys: apmixedsys@10209000 {
-		compatible = "mediatek,mt7622-apmixedsys",
-			     "syscon";
+	apmixedsys: clock-controller@10209000 {
+		compatible = "mediatek,mt7622-apmixedsys";
 		reg = <0 0x10209000 0 0x1000>;
 		#clock-cells = <1>;
 	};
 
-	topckgen: topckgen@10210000 {
-		compatible = "mediatek,mt7622-topckgen",
-			     "syscon";
+	topckgen: clock-controller@10210000 {
+		compatible = "mediatek,mt7622-topckgen";
 		reg = <0 0x10210000 0 0x1000>;
 		#clock-cells = <1>;
 	};
@@ -734,9 +732,8 @@ wmac: wmac@18000000 {
 		power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
 	};
 
-	ssusbsys: ssusbsys@1a000000 {
-		compatible = "mediatek,mt7622-ssusbsys",
-			     "syscon";
+	ssusbsys: clock-controller@1a000000 {
+		compatible = "mediatek,mt7622-ssusbsys";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
@@ -793,9 +790,8 @@ u2port1: usb-phy@1a0c5000 {
 		};
 	};
 
-	pciesys: pciesys@1a100800 {
-		compatible = "mediatek,mt7622-pciesys",
-			     "syscon";
+	pciesys: clock-controller@1a100800 {
+		compatible = "mediatek,mt7622-pciesys";
 		reg = <0 0x1a100800 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
@@ -921,12 +917,13 @@ sata_port: sata-phy@1a243000 {
 		};
 	};
 
-	hifsys: syscon@1af00000 {
-		compatible = "mediatek,mt7622-hifsys", "syscon";
+	hifsys: clock-controller@1af00000 {
+		compatible = "mediatek,mt7622-hifsys";
 		reg = <0 0x1af00000 0 0x70>;
+		#clock-cells = <1>;
 	};
 
-	ethsys: syscon@1b000000 {
+	ethsys: clock-controller@1b000000 {
 		compatible = "mediatek,mt7622-ethsys",
 			     "syscon";
 		reg = <0 0x1b000000 0 0x1000>;
-- 
2.35.3


