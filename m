Return-Path: <linux-kernel+bounces-5699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A18B818E48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F912865FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2581B3174A;
	Tue, 19 Dec 2023 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/BWVkxk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18687286A6;
	Tue, 19 Dec 2023 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67f296ecb2dso26167726d6.0;
        Tue, 19 Dec 2023 09:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703007506; x=1703612306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7o02eCOkYV+S238EYknUAxPRBxnSpRC9xTw4EPIh2A=;
        b=F/BWVkxk06nuQQgZA+hPF6w2wKtiwUyUcxNPltjVim9AmFm+7R5y0v32Vgbmjq4o6F
         2GWwHpQdJgeZBE8ZjJ++rI3cIfRDNHH5QI/M89c/KPZ8MJlEutwPT1IbC1CGqZkRFlOn
         /xG0vHZ4Td4IHoPSMX0a9845BH+kx8FtsQ+Xj+As/BmLWDIM+Hdt9uMdyXzsqMJiHYDm
         oGpK4gN/yystQd18Vivue7Bm2S3mg5slARkkYolDXsAfb4/8DlTQqNX8mvYApd5TAkZP
         bKoiou/bLQm4tc93SEZls+IELLnhulSyTC8vSOzl/YD5RJwTd6A0n5BfQoHHsXK2SvV+
         lLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007506; x=1703612306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7o02eCOkYV+S238EYknUAxPRBxnSpRC9xTw4EPIh2A=;
        b=GohmwqG5zpJLBqozS67GTix+WlF9lsgpOGWcRnfgFShEbaAbT1eFrAWSCDxp31IZws
         OthZlGAqgHm5h3E7byPJ9xgxpZShcCUFGjIM97/rGiDoVLyVW5Ldkr5KeosRAlaggiQM
         w/gYJ0lLEyGncczQIPRZwyskXeC7PM6LUXtFexaSqaimCSCglSRxPEUrVlcWmucBX+4d
         hOrgcdZ7Qnop1rPrPOArHNZgYLpkdyGu1Y9wFLSnGGO+Ock3K0whct6IAd2Z4nzAkB+Y
         Dtsj+zuYPjVEN4ty3R9/OBcX31fxukB91GPyo43oEp1hGoeTqzl88n9UgRoil0qLvQAQ
         d7yQ==
X-Gm-Message-State: AOJu0YxHpH9s4ZlAnjRomCq5Lp1XezAjms3IK5MFQO2M50PWQy5ds3oA
	13RGxn+7FRWTqpX+teKsvE9EpV4ez7Q=
X-Google-Smtp-Source: AGHT+IGFrVq4h1xGJXazAoP7IjR55HBym+DCtCxrj8jynZNeImVv5OAXSEP1v42Dw9qSJ/fMld4Apw==
X-Received: by 2002:ad4:5ca6:0:b0:67f:26c9:ffdb with SMTP id q6-20020ad45ca6000000b0067f26c9ffdbmr2385556qvh.22.1703007506353;
        Tue, 19 Dec 2023 09:38:26 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id w12-20020a0cc24c000000b0067f056e121csm5472098qvh.97.2023.12.19.09.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:38:25 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] arm64: dts: rockchip: rk3308-rock-pi-s cleanup
Date: Tue, 19 Dec 2023 12:38:13 -0500
Message-ID: <20231219173814.1569-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.43.0.76.g1a87c842ece3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Perform the following cleanups on a previous patch:
- indent lines after "gpio-line-names"
- fix D0-D8 -> D0-D7
- sort phandle references

Fixes: c45de75d7a9a ("arm64: dts: rockchip: add gpio-line-names to rk3308-rock-pi-s")
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../boot/dts/rockchip/rk3308-rock-pi-s.dts    | 120 +++++++++---------
 1 file changed, 62 insertions(+), 58 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
index f2d7251de298..b47fe02c33fb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
@@ -143,6 +143,68 @@ &gmac {
 	status = "okay";
 };
 
+&gpio0 {
+	gpio-line-names =
+		/* GPIO0_A0 - A7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO0_B0 - B7 */
+		"", "", "", "header1-pin3 [GPIO0_B3]",
+		"header1-pin5 [GPIO0_B4]", "", "",
+		"header1-pin11 [GPIO0_B7]",
+		/* GPIO0_C0 - C7 */
+		"header1-pin13 [GPIO0_C0]",
+		"header1-pin15 [GPIO0_C1]", "", "", "",
+		"", "", "",
+		/* GPIO0_D0 - D7 */
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio1 {
+	gpio-line-names =
+		/* GPIO1_A0 - A7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO1_B0 - B7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO1_C0 - C7 */
+		"", "", "", "", "", "", "header1-pin21 [GPIO1_C6]",
+		"header1-pin19 [GPIO1_C7]",
+		/* GPIO1_D0 - D7 */
+		"header1-pin23 [GPIO1_D0]", "header1-pin24 [GPIO1_D1]",
+		"", "", "", "", "", "";
+};
+
+&gpio2 {
+	gpio-line-names =
+		/* GPIO2_A0 - A7 */
+		"header1-pin10 [GPIO2_A0]", "header1-pin8 [GPIO2_A1]",
+		"", "",
+		"header1-pin7 [GPIO2_A4]", "header1-pin12 [GPIO2_A5]",
+		"header2-pin46 [GPIO2_A6]", "header1-pin22 [GPIO1_A7]",
+		/* GPIO2_B0 - B7 */
+		"header2-pin45 [GPIO2_B0]", "header1-pin18 [GPIO2_B1]",
+		"header1-pin16 [GPIO2_B2]", "header2-pin44 [GPIO2_B3]",
+		"header2-pin43 [GPIO2_B4]", "header2-pin28 [GPIO2_B5]",
+		"header2-pin30 [GPIO2_B6]", "header2-pin32 [GPIO2_B7]",
+		/* GPIO2_C0 - C7 */
+		"header2-pin34 [GPIO2_C0]", "", "", "", "", "", "", "",
+		/* GPIO2_D0 - D7 */
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names =
+		/* GPIO3_A0 - A7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO3_B0 - B7 */
+		"", "", "header2-pin42 [GPIO3_B2]",
+		"header2-pin41 [GPIO3_B3]", "header2-pin40 [GPIO3_B4]",
+		"header2-pin39 [GPIO3_B5]", "", "",
+		/* GPIO3_C0 - C7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO3_D0 - D7 */
+		"", "", "", "", "", "", "", "";
+};
+
 &i2c1 {
 	status = "okay";
 };
@@ -250,61 +312,3 @@ &usb20_otg {
 &wdt {
 	status = "okay";
 };
-
-&gpio0 {
-	gpio-line-names =
-	/* GPIO0_A0 - A7 */
-	"", "", "", "", "", "", "", "",
-	/* GPIO0_B0 - B7 */
-	"", "", "", "header1-pin3 [GPIO0_B3]", "header1-pin5 [GPIO0_B4]",
-	"", "", "header1-pin11 [GPIO0_B7]",
-	/* GPIO0_C0 - C7 */
-	"header1-pin13 [GPIO0_C0]", "header1-pin15 [GPIO0_C1]", "", "", "",
-	"", "", "",
-	/* GPIO0_D0 - D8 */
-	"", "", "", "", "", "", "", "";
-};
-
-&gpio1 {
-	gpio-line-names =
-	/* GPIO1_A0 - A7 */
-	"", "", "", "", "", "", "", "",
-	/* GPIO1_B0 - B7 */
-	"", "", "", "", "", "", "", "",
-	/* GPIO1_C0 - C7 */
-	"", "", "", "", "", "", "header1-pin21 [GPIO1_C6]",
-	"header1-pin19 [GPIO1_C7]",
-	/* GPIO1_D0 - D8 */
-	"header1-pin23 [GPIO1_D0]", "header1-pin24 [GPIO1_D1]", "", "", "",
-	"", "", "";
-};
-
-&gpio2 {
-	gpio-line-names =
-	/* GPIO2_A0 - A7 */
-	"header1-pin10 [GPIO2_A0]", "header1-pin8 [GPIO2_A1]", "", "",
-	"header1-pin7 [GPIO2_A4]", "header1-pin12 [GPIO2_A5]",
-	"header2-pin46 [GPIO2_A6]", "header1-pin22 [GPIO1_A7]",
-	/* GPIO2_B0 - B7 */
-	"header2-pin45 [GPIO2_B0]", "header1-pin18 [GPIO2_B1]",
-	"header1-pin16 [GPIO2_B2]", "header2-pin44 [GPIO2_B3]",
-	"header2-pin43 [GPIO2_B4]", "header2-pin28 [GPIO2_B5]",
-	"header2-pin30 [GPIO2_B6]", "header2-pin32 [GPIO2_B7]",
-	/* GPIO2_C0 - C7 */
-	"header2-pin34 [GPIO2_C0]", "", "", "", "", "", "", "",
-	/* GPIO2_D0 - D8 */
-	"", "", "", "", "", "", "", "";
-};
-
-&gpio3 {
-	gpio-line-names =
-	/* GPIO3_A0 - A7 */
-	"", "", "", "", "", "", "", "",
-	/* GPIO3_B0 - B7 */
-	"", "", "header2-pin42 [GPIO3_B2]", "header2-pin41 [GPIO3_B3]",
-	"header2-pin40 [GPIO3_B4]", "header2-pin39 [GPIO3_B5]", "", "",
-	/* GPIO3_C0 - C7 */
-	"", "", "", "", "", "", "", "",
-	/* GPIO3_D0 - D8 */
-	"", "", "", "", "", "", "", "";
-};
-- 
2.43.0.76.g1a87c842ece3


