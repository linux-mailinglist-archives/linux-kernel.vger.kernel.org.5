Return-Path: <linux-kernel+bounces-91539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BA2871359
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBDBCB240A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684818654;
	Tue,  5 Mar 2024 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rnizyw7p"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8712D17C9E;
	Tue,  5 Mar 2024 02:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604317; cv=none; b=rfA8cVLiCzE1qSLwpe6AwzW8y16m1hHId+XU+C2vqBTB35k3Mqzp+Q2jx8/oG5KnW3fwGGW1HkI4Bn4lk6AeLjnIuIAhYxSGybsD8nsPL923IFVmtvWVjbuJ7JvjqqQ2xW+4P0+mqv47v0kMzQY4gX1Kv35rmpQT6BNMBpGNZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604317; c=relaxed/simple;
	bh=mQfMQLmAIBV2TnuZl3ZY6h75I3PfxUcRIRutX3ur6xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XJnAeet6sN0UzEhLy1ANulSrrvzW2I9f1NuUo2fD9Ducb+Kgn1brULFRIfNk2A8zpzfd3iQnzXONsB9YtD+abuiZsWIMdOQy63ko9Q0djQu1zoCn4F4QIlsuK2At/a0wMrIRo+8wDwWExdDh3NeSzPNZt8CO033jPKHreWWw/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rnizyw7p; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bb5fda069bso334889539f.0;
        Mon, 04 Mar 2024 18:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709604314; x=1710209114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dJuCH373LezeptXjAUVUX17sgHTpn3EnPm8FEMA/ybs=;
        b=Rnizyw7pEsitMnzu/BLBKD/snZarhe4ApKFK1e/jSUAaEBxXtqHBRIaxKjedv0/jwJ
         zIKPk1pexeEp8wBtmeH4y4c42nQEjcXckTb64ZLvWr4pBeNYYNGBDOdQgo35e/Bbz9et
         5YzywQ1kEPbegEtIpkz90ZDl9s1T4YyotEHpn46T1uMztjBz0WUQToX6uRFRkxqbCcKX
         fcnNbhzunXaWWI/R8zZ+/bMLwhsLECXTUs/kJItU2/KhbnSPOyAb5Cf/I1XsYRzbAOOj
         AMOzJKHI8Sg5W54COEoldumDpa0z7YC3n66ObQDRevjVo9nE7XQ4s250ot/tXR0/5IZU
         N2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709604314; x=1710209114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJuCH373LezeptXjAUVUX17sgHTpn3EnPm8FEMA/ybs=;
        b=sVZUsp++U6c+N6SeSZdkwM6CzU6YQJ9SQebf6P/tnXwSjBdLq5UARbDpZyowkbQ/ek
         KAj0+DztHDDrT14TVy9CQjz/bFKftN5CmDE2HxHqcALc8fyMbo7Ivbil1C5I66V5xFIY
         mL39z/Ygc8w9JIO3tDkdrDBIpQ72ub11ORj3AVfppX4wieSxzo9a4VjYiTkU6mBVXFPD
         1XRXXHfukhfWsKbnzoL/gihptKPlG2aTn15n6HAea9qy9qNjOj4mzNd/a6aqXZtJHqVz
         FdF4vHRKOidaOqCd1goN++lYKbgolVEtfhAzrbMUDRTrrizIH+x7T02TeVizWoILSEaL
         1ozQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrS343ncmU1iX/imXH93EPxqfGfskWgvKPr53JTME4+d1nAz1KjHr3m7Alh8A51DSd+egwIoURjv4zGcg9Sl6kbMdFAtrjd2boSOqGY/bZKJGvvTHIY3yD52iXbD2a+x5C6GuUrhHK6A==
X-Gm-Message-State: AOJu0YwiMfXLL68E4axWtqMUzT2JJmTFj1/yg1n/0Xv8RVjOwSZQSLOV
	XG7P//FMzMknNcHk/twD42Gg6svC3fyRyFBeLH5neFnKGZfhRSgS
X-Google-Smtp-Source: AGHT+IEAIhjfu9DwkDH1PlpTwYvXtDbjW4w0IaT9LIlexPIlg93AQjn3hVh6QqttEk1LXdSnSY9ZkQ==
X-Received: by 2002:a5d:9502:0:b0:7c8:5ab2:6313 with SMTP id d2-20020a5d9502000000b007c85ab26313mr3171143iom.8.1709604314546;
        Mon, 04 Mar 2024 18:05:14 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:5872:22b6:b680:a683])
        by smtp.gmail.com with ESMTPSA id g16-20020a056638061000b0047483de6cd5sm2590708jar.112.2024.03.04.18.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 18:05:14 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp-beacon-kit: Fix errors found from CHECK_DTBS
Date: Mon,  4 Mar 2024 20:05:08 -0600
Message-ID: <20240305020508.6379-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The adv7535 has some extra reg-name which can be removed since
the defaults that are used when these are not assigned work
just fine.  Removing them and adding some required regulators
make the errors detected from CHECK_DTBS go away.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
Requires: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240305004859.201085-2-aford173@gmail.com/

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index fba8fd04398d..b1cd0f0b9c13 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -302,12 +302,19 @@ pca6416_3: gpio@20 {
 
 	adv_bridge: hdmi@3d {
 		compatible = "adi,adv7535";
-		reg = <0x3d>, <0x3c>, <0x3e>, <0x3f>;
-		reg-names = "main", "cec", "edid", "packet";
+		reg = <0x3d>;
+		reg-names = "main";
 		interrupt-parent = <&gpio4>;
 		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
 		adi,dsi-lanes = <4>;
 		#sound-dai-cells = <0>;
+		avdd-supply = <&buck5>;
+		dvdd-supply = <&buck5>;
+		pvdd-supply = <&buck5>;
+		a2vdd-supply = <&buck5>;
+		v1p2-supply = <&buck5>;
+		v3p3-supply = <&buck4>;
+
 
 		ports {
 			#address-cells = <1>;
-- 
2.43.0


