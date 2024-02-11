Return-Path: <linux-kernel+bounces-60702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7908508B2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC701C21118
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D7C5A4C5;
	Sun, 11 Feb 2024 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdYKNLZ4"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A259174;
	Sun, 11 Feb 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707648824; cv=none; b=N/EgaEUD9RUER7oTuYZHtr8EXZxmyHJBDU4nAj+6mhsenjwmXxsoEArPinv/1NJlV5YJwiuchdgu3fcFO6qEdQ4gxnE0RP37l6TcDTW5p7C+eL8bSynuBK88GXf5wNrnmoQMBP7i4beqDPC+/iMvNhuJVqHq7eG14ZEoXAzIwpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707648824; c=relaxed/simple;
	bh=aHVHW7Z9Vz8E35efk396ga0J8V70ILA+KvMuR//APMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYy7olzOWDiGLxO2g0S/MWbcS7/PkQcophLfzpimNezbHo/o32YY2rSVlEKYX7xtcyPtghMCEDWLYbvJaLAZI7VAsIk7AuV2M6HCyzXZXlt0+UylOj0VR+tmvw/kyc9Wb/dIduFN1ETia8TmCHNYB+xMxfFFrE4S1cNZsdmtCa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdYKNLZ4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d0ed7cbd76so9094721fa.1;
        Sun, 11 Feb 2024 02:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707648820; x=1708253620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uO+FD++i6lu3R3UMtfKiyAbMLFBWQFc/P76C+86fYSw=;
        b=bdYKNLZ4avyCYV/xWpProgwYZdbxw5QAViXW4qlgrJcAyz4wpIZTyy5YyPuFwyh3os
         1bbli7YLnO4p+r/iWcoQ0ukevMzvQoToRcbRAX3YuiIkUA0VAs8hzyhjbYo8yqMQvE9p
         X8GgPD48h+wcgcUCZmYgBQ4Lztgbd4yhsfi6bDX60fo0Bs+/nWfaM3omSmO0cC3h2JCv
         zKmsvNRfDwg8Y4fl5tW9H124YRBzF6XDN8RHgTmYQkjBN/s/4ewiJ2NITIbbmaDiThNe
         F96NogJ3sWQ9PmeF7PmUd87vTXGdfhskHdxf+Nfkf3A6NSJ1IsucTVxSuUW2rvpbcWwD
         EGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707648820; x=1708253620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uO+FD++i6lu3R3UMtfKiyAbMLFBWQFc/P76C+86fYSw=;
        b=Htz1D2d25RGuS5/i0pNo/OoPVLYBIqqOnkRoHyn3/RJP5N0M7x+ynrEGUcMEhy+Jmg
         53r1sgOEscUMHqHYhapF4WpADrVOwgMe5LVwTLryRos+k1+XJx91gVXCQjfMQzJOgPFa
         oMgDxbF+PUFYAeASqeuII97BxQYBLCBvnxRq7Hu9z2+3fpOTL88YprerNpCTiTvGNRDG
         31IkucgO9/ZnjeBD0sDm/DSRv3y73l4QtgDsJYOIHAuY1nvrsJdG5aXEwC3w8dUMuBjB
         hKJYhE4XdMY19kZRLjvUeXMXZfysryfEGn8afMSRPI6/StvQQxYPdeO1xHu+nWA4van5
         mXjA==
X-Forwarded-Encrypted: i=1; AJvYcCVhlwsqHGGgw+ux74AmuE02aJyz14mZ68SP4ZmgHUFURMhlupwWSm30b0rYYiR4x9XtsBVzRuPXLd2nV6zytaclYS/Qt7aqGMuQSClT7qmhCCrC2e09GheYK+5jJ81nnEMMdRRHAxYMAA==
X-Gm-Message-State: AOJu0Yy5WptuvBrlItGn9USSve9s2Vt1q0vGZpQl4mtTUMcmDP24wCtr
	ze5HzkQ5PX1X1XO61e2hKDJXTNRU/tgEG9rH1/B2tTgSElehbPtZ
X-Google-Smtp-Source: AGHT+IHfeJGfD6S5ADXFrljt6jbddz9qVjW3/0nsFBVwOu/NPnAfiZcxzuyjoHLont1QS/afVvVHYw==
X-Received: by 2002:a2e:a0c5:0:b0:2d0:41d1:8124 with SMTP id f5-20020a2ea0c5000000b002d041d18124mr2687733ljm.1.1707648820227;
        Sun, 11 Feb 2024 02:53:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXq0bUGyM2L2ZMhPe3QpzgYa2IAkwmyOEM121qoFdMoe+SQp89/Lo1WfqGa3sgNYrtjmEojn5mz2kpuhustodB5Gp3JOTfyUfGcemSebzkqRrsrzReLXngmSqImWSCUdcrPz/07+oV80iYqDNefI0e+zcVybbPZbySaATJnRYzx+rM5sIpXUZoCcks5pf8Rb+GjC2d8ooGmLJKNGsr+GPaP1VxQgrr3JOYPVa/Eu1lAAmzUgZRr9XtNzadND3dP5LW0jke9n0sxDBdslvXAz1mFEHuv33a5akuoYGsUrm/DKxPYQf8uCtbcjHS6H0yb0g2W3bkFwhO+Sft9I0NbhvDwdfBhJGdGWolmywbcSpGmxjOqxtf8akVzUX1c17J9X1gZUKmKMp7cUChndpLB7bp8ki78slLaIKa2++EOs7zSiPAcnzNjVm4xmwTBaD57deNaCh8YnOJznTwImzoD1QNFKN28/ZKTrAC9Duni6hL+VBG0L2lXZQ==
Received: from localhost.localdomain ([2a05:3580:f312:6c01:1b8f:2a1b:d18:1951])
        by smtp.gmail.com with ESMTPSA id y5-20020a2e95c5000000b002cd34872be7sm893799ljh.25.2024.02.11.02.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 02:53:39 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Alexey Klimov <alexey.klimov@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] arm64: dts: allwinner: a64: Add thermal trip points for GPU
Date: Sun, 11 Feb 2024 13:53:26 +0300
Message-ID: <20240211105326.506049-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Klimov <alexey.klimov@linaro.org>

Without trip points for GPU, the following errors are printed in the
dmesg log and the sun8i-thermal driver fails to load:

thermal_sys: Failed to find 'trips' node
thermal_sys: Failed to find trip points for thermal-sensor id=1
sun8i-thermal: probe of 1c25000.thermal-sensor failed with error -22

When thermal zones are defined, trip points definitions are mandatory.
Trip values for the GPU are assumed to be the same values as the CPU
ones. The available specs do not provide any hints about thermal regimes
for the GPU and it seems GPU is implemented on the same die as the CPU.

'make dtbs_check' complains about problem in dts for 18 A64-based boards
supported by the kernel:

sun50i-a64-pine64.dtb: thermal-zones: gpu0-thermal: 'trips' is a required property
	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
sun50i-a64-pine64.dtb: thermal-zones: gpu1-thermal: 'trips' is a required property
	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#

Tested on Pine a64+ and PinePhone 1.2.

Cc: Samuel Holland <samuel@sholland.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
Tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 57ac18738c99..c25da7229e42 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -244,6 +244,29 @@ gpu0_thermal: gpu0-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 1>;
+
+			trips {
+				gpu0_alert0: gpu0_alert0 {
+					/* milliCelsius */
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu0_alert1: gpu0_alert1 {
+					/* milliCelsius */
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				gpu0_crit: gpu0_crit {
+					/* milliCelsius */
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 
 		gpu1_thermal: gpu1-thermal {
@@ -251,6 +274,29 @@ gpu1_thermal: gpu1-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&ths 2>;
+
+			trips {
+				gpu1_alert0: gpu1_alert0 {
+					/* milliCelsius */
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu1_alert1: gpu1_alert1 {
+					/* milliCelsius */
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				gpu1_crit: gpu1_crit {
+					/* milliCelsius */
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
 		};
 	};
 
-- 
2.43.0


