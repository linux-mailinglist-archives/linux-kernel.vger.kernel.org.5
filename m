Return-Path: <linux-kernel+bounces-53084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9677584A07A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D68C28276E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF77945953;
	Mon,  5 Feb 2024 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQSwM3P0"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159BC4594D;
	Mon,  5 Feb 2024 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153640; cv=none; b=sbfu21P7ZmVL2wxu4j7ZgiPnvNvdSsV1lLPD1c3kcZiF5fRNAI7rfhyZcty+Q0/+8F9rdvLMiPGsGuVVmSu9ZBH8n1JCADUTMVt061oQLMrJRhmUONiKpsuiRtTsBNUKEJp5BRIzrBd3nuxQ7DXmSelp6OS6ysprzaogz9+rZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153640; c=relaxed/simple;
	bh=LAeHhmBz1VNDE6V0cPKKRwembrMNzST8rAV8CdBI2G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e32IPUTgqZD/2Ms7QmQii/ukElCeIPY8WQm6n+IiSTjlSbI51mGMHhjB4d8UdzSDFEjkvZSBZnjRvkCRCsSJYfQhZmdK4Fg/d1n6+ZLElciiOzWTMaJnMwbwyr1s4R32wEauhpESIo5haDskVyyTAWhRcmTFCCb3i8zNFL916FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQSwM3P0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d9b2400910so7227795ad.0;
        Mon, 05 Feb 2024 09:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707153637; x=1707758437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hS6dIuUOs6IlT69yW9IpIjBL1L09bQr38oFgBY2DWIM=;
        b=ZQSwM3P01qsTiryaEMNd6A1EQoEASZVN8pjfrVNbTkVLA5w6BzFARXtxlrw0gtQwMQ
         B5SpIH1W00nOa/XUJmbokmMtFibrWKF8Gda9c9TihNxofY98Ai0eRrmyiS8YXxlBJeZb
         GruN8Uu5fjdMpDzKmokvqH1v7pcFNwYKS7Ntrx8R7esFkunumC2Gnq2jU8QUFhtTuih4
         09uVXMishD0r1QOhW4+SDZHyzFqb8xGUg5Zd6mzQRiiPzwZvWDchze/8B12rXhTGrHXD
         Q1Lca9AJs0CnAcmPjF1nE9wTNXzs3CD6W+PLs+XVhhJAl8an2xt8jKxHGHF1US4JHcru
         12yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153637; x=1707758437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hS6dIuUOs6IlT69yW9IpIjBL1L09bQr38oFgBY2DWIM=;
        b=nHoCips4DQbqoqk4s3/Zq7mMG5wsopjMu4p5ySRlE4DwQQLvmizgMzJIEvQyQ9pmAC
         QjZGDAgENTKYPBizCoqo5/A3escCnlgdzkC/LC2oz1ll3DQeFLvu55LagvM6HmDzxZvt
         gwB9sbQjRTDXJAHeMRXxy7W2JUoYbGsfWHUvz5baage3gM3WpcDTrd1bIlx61835URVs
         IpAx5NPbiahckFdKbezQmLFyo+vQLTyd+t63qadeOeimGolQeYW5woM11Ad+7uRexmZM
         4h5ZlohC7xG5nOV0cxmz32eujjmRCNJKlQdsRj0OPSQ7+NnVgFcgrDbDi+dj8ONYX31N
         G+Sg==
X-Gm-Message-State: AOJu0Yz2XdVRL8XsgLPGuJivQ5CfiMJN+KQH5flbGQFPhSJGC+hhAozu
	Nq4jXPphuQ4EwdS1QU/GrIbkijDlVeijGbqqjTYDPIdKZ6GcdoQl
X-Google-Smtp-Source: AGHT+IEr9WVh5tHKvU1HS2CVHP43BD/DeXPf5QOiaZJtxwQUCZ6uXzC4m2BBtTurEjLkD42+OzPOUg==
X-Received: by 2002:a17:903:1c2:b0:1d9:4143:5fe1 with SMTP id e2-20020a17090301c200b001d941435fe1mr493718plh.0.1707153637320;
        Mon, 05 Feb 2024 09:20:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXHjBVTNLFu0eYUL+Q+ORdz2rkEuW7AN4pMU/cmyWkcXb4xYBO+XdsypuclxP93NF30wnEhXUaxlpy5FGlZPE5w0cyhpE8f7SxllsREgXg9jgBdWA8aEyFEBtblK86wDEDaIHkzEaWDu6gLO3WM2gOWfbSA5hvsR5CGP/ExrOOmHy7kx7C/Aa6FQr6Ys9GF44yeg92uDc6IvrYGfBN53Cq+XC4SNDPuHm703BAUpv8dm3IJhzDkrtJ+Ie4mmIjq6mnQPQNN7wTGgvTyEzNWPiTZd+5D/cEVWYS7S+N7aljoeMjIkA+m80v79/YYhvAG1YWAA/jkPEMRRqeXubTPiKKITN9e/ekjV16ttM4uQtj+jv3FO2f9fTveftjiobMorBmc8JfVZQWsIUD2U1JUgNybxUUuwZhfHokUgToJnRreFFuDUEfJ1siGzIORSY4MXISg9fph
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id iy15-20020a170903130f00b001d8f3c7fb96sm107518plb.166.2024.02.05.09.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:20:36 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv1 4/5] arm64: dts: amlogic: Add cache information to the Amlogic S922X SoC
Date: Mon,  5 Feb 2024 22:49:22 +0530
Message-ID: <20240205171930.968-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205171930.968-1-linux.amoon@gmail.com>
References: <20240205171930.968-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per S922X datasheet add missing cache information to the Amlogic
S922X SoC.

- Each Cortex-A53 core has 32 KB of instruction cache and
	32 KB of L1 data cache available.
- Each Cortex-A73 core has 64 KB of L1 instruction cache and
	64 KB of L1 data cache available.
- The little (A53) cluster has 512 KB of unified L2 cache available.
- The big (A73) cluster has 1 MB of unified L2 cache available.

To improve system performance.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
[0] https://dn.odroid.com/S922X/ODROID-N2/Datasheet/S922X_Public_Datasheet_V0.2.pdf
[1] https://en.wikipedia.org/wiki/ARM_Cortex-A73
[2] https://en.wikipedia.org/wiki/ARM_Cortex-A53
---
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 62 ++++++++++++++++++---
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
index 86e6ceb31d5e..624c6fd763ac 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
@@ -49,7 +49,13 @@ cpu0: cpu@0 {
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <592>;
-			next-level-cache = <&l2>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2_cache_l>;
 			#cooling-cells = <2>;
 		};
 
@@ -59,7 +65,13 @@ cpu1: cpu@1 {
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <592>;
-			next-level-cache = <&l2>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
+			next-level-cache = <&l2_cache_l>;
 			#cooling-cells = <2>;
 		};
 
@@ -69,7 +81,13 @@ cpu100: cpu@100 {
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			next-level-cache = <&l2>;
+			d-cache-line-size = <64>;
+			d-cache-size = <0x10000>;
+			d-cache-sets = <64>;
+			i-cache-line-size = <64>;
+			i-cache-size = <0x10000>;
+			i-cache-sets = <64>;
+			next-level-cache = <&l2_cache_b>;
 			#cooling-cells = <2>;
 		};
 
@@ -79,7 +97,13 @@ cpu101: cpu@101 {
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			next-level-cache = <&l2>;
+			d-cache-line-size = <64>;
+			d-cache-size = <0x10000>;
+			d-cache-sets = <64>;
+			i-cache-line-size = <64>;
+			i-cache-size = <0x10000>;
+			i-cache-sets = <64>;
+			next-level-cache = <&l2_cache_b>;
 			#cooling-cells = <2>;
 		};
 
@@ -89,7 +113,13 @@ cpu102: cpu@102 {
 			reg = <0x0 0x102>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			next-level-cache = <&l2>;
+			d-cache-line-size = <64>;
+			d-cache-size = <0x10000>;
+			d-cache-sets = <64>;
+			i-cache-line-size = <64>;
+			i-cache-size = <0x10000>;
+			i-cache-sets = <64>;
+			next-level-cache = <&l2_cache_b>;
 			#cooling-cells = <2>;
 		};
 
@@ -99,14 +129,32 @@ cpu103: cpu@103 {
 			reg = <0x0 0x103>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			next-level-cache = <&l2>;
+			d-cache-line-size = <64>;
+			d-cache-size = <0x10000>;
+			d-cache-sets = <64>;
+			i-cache-line-size = <64>;
+			i-cache-size = <0x10000>;
+			i-cache-sets = <64>;
+			next-level-cache = <&l2_cache_b>;
 			#cooling-cells = <2>;
 		};
 
-		l2: l2-cache0 {
+		l2_cache_l: l2-cache-cluster0 {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+		};
+
+		l2_cache_b: l2-cache-cluster1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 };
-- 
2.43.0


