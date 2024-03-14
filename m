Return-Path: <linux-kernel+bounces-102917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F6387B853
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240771F2350A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1F910A3C;
	Thu, 14 Mar 2024 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="Rp2t59M0"
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224ABFC0B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.182.159.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400259; cv=none; b=efK+YzHBmI7JVuCMg0BHBcwf5JKztR7bEHUhp6Xm7o9hEdF72Ds0MGFLRj6S/EHLW1NK3OMe43iNJ6kvg0TzSzw3PN3aelk4JygJhh7MxQpTqfUlzKAWmiebwmA/oAbcYTwdy4ErRWiq/Na9DCUqB2ZDhga+RHa4pCVbpp25dII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400259; c=relaxed/simple;
	bh=M+mo9Y0CHfPVQLKoZETkdBfevQ2LMWQyIi/HAshdRT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocFWJ8BeVAUfdOIGENNP54qJ5HTSoudU5+w4Y/8AfcMOubmVu9JSohM5C8AiuDYC8KQK0OTgoKHCQT8cgaroJlHUIZ9+diogYTv/vOvlQjjPbLMGVPvQ3ULZeYLTrOmg3mDx/DgbX/YjtVMDaXZZU+dql+jGMliKtiITH7jKgrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=Rp2t59M0; arc=none smtp.client-ip=62.182.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8EDC11E7C2;
	Thu, 14 Mar 2024 07:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1710399889; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+UBrzMeNJuIEWIdnDs+QZQBlvEK3sk7AsllHTSelVpQ=;
	b=Rp2t59M0Qujo1GwlJ32wph7no0rX6TCkCwukSBJZWzL+ncrlZML490GAKp84KPEvAT4Kb3
	pzNPoG8iNj/QQiIfoU/DPYfrx7mGkPQaGZwAlJIH41zJBIGE1NPwdaO0o2p5Ac2eDnPcvK
	tXv8OZubEydNYZhg6tI0w4psoSc+KZvxgmM6mDrpumuT1/zSatItfTP2mAiLSISAjg0v/T
	AEazh+AEBgaAK8tz59nb/aouIQUmy8Fbs5liIHVMEXtcYOhc8aTH+roakaAAh8joN4CSL3
	mHok3shQyrT4RS1c9C5Jd+FUE/dUmkjB+sJOjliSSRKSZD8fNN2eNNdbUD/r+g==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v3 4/4] arm64: dts: meson: add dts links to secure-monitor for soc driver in a1, axg, gx, g12
Date: Thu, 14 Mar 2024 09:59:54 +0300
Message-ID: <20240314070433.4151931-5-adeep@lexina.in>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240314070433.4151931-1-adeep@lexina.in>
References: <20240314070433.4151931-1-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add links to secure-monitor in soc driver section for A1, AXG, GX, G12
Amlogic family for use with meson-socinfo-sm driver.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi         | 1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi         | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index c03e207ea6c5..d47f056117fc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -407,6 +407,7 @@ hwrng: rng@5118 {
 			sec_AO: ao-secure@5a20 {
 				compatible = "amlogic,meson-gx-ao-secure", "syscon";
 				reg = <0x0 0x5a20 0x0 0x140>;
+				secure-monitor = <&sm>;
 				amlogic,has-chip-id;
 			};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 6d12b760b90f..45791ec6694a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1689,6 +1689,7 @@ mux {
 			sec_AO: ao-secure@140 {
 				compatible = "amlogic,meson-gx-ao-secure", "syscon";
 				reg = <0x0 0x140 0x0 0x140>;
+				secure-monitor = <&sm>;
 				amlogic,has-chip-id;
 			};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 9d5eab6595d0..a8c1c72543b7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2026,6 +2026,7 @@ cec_AO: cec@100 {
 			sec_AO: ao-secure@140 {
 				compatible = "amlogic,meson-gx-ao-secure", "syscon";
 				reg = <0x0 0x140 0x0 0x140>;
+				secure-monitor = <&sm>;
 				amlogic,has-chip-id;
 			};
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 2673f0dbafe7..656e08b3d872 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -471,6 +471,7 @@ cec_AO: cec@100 {
 			sec_AO: ao-secure@140 {
 				compatible = "amlogic,meson-gx-ao-secure", "syscon";
 				reg = <0x0 0x140 0x0 0x140>;
+				secure-monitor = <&sm>;
 				amlogic,has-chip-id;
 			};
 
-- 
2.43.2


