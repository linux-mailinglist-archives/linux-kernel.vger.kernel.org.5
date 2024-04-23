Return-Path: <linux-kernel+bounces-154364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A10CE8ADB41
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F714B23D02
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADC0182D8;
	Tue, 23 Apr 2024 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="b5YDzs2q"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA5E574;
	Tue, 23 Apr 2024 00:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833035; cv=none; b=l4120I2hL9Z2zk8pjqoenwCituq7morwRgLSWBXkI9KaHX5KrbeCyzJFbbThuo7UixJ9VhE+559CpPwXA2/SOzjy2VKvey83vVry8NjS/XSlDeJ+QPY+CBmuDXqr/bQTWQab+5BPvg5fFiDEhQyL05wo2nfDQavNUotGLftK09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833035; c=relaxed/simple;
	bh=5wf3JZLqI6upNb+N5iKbqNKrv3daabbZy4Q4+q2D1Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hPokRwxdbuiY87a6+C8F3mIVtJNc5Nu79qWUAlPLrdgcOJE4LHYfIT6WM5qOptBfkEMgx+KyTZMGXLqj9+qvoWVnZSeT6CfGygfbMv9GCYN+H8DfRIyklOfKw1yezBXVU4dRIoHD6h9rRVhe1mixoKFu6aaF+xNgW8ih4eDqeZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=b5YDzs2q; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713833030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4TC68yymP75Ak5L5NmW4Ic8c+OFYL0ZiXlhMXToNWT0=;
	b=b5YDzs2qPHOpGi0lWbwotcXXHGEdno2XCkWbu0DdQLgiAG7C/Si7U8DsWyX3ND6MgMr+Ae
	dZKls3h11dutdJnnjNCxUgl/nr6nf7YN1T+abFqyEFBB3Q2s+N8O0DCFHrG67b5RPAd1GZ
	zgx83enO5AwUd7UcT23VyvwZxrqLeAMj7PEzGUL7luCfl9QfX+2lC8s2y3Z8oI6PJP4ByT
	nwcHUgOmBfZyC9VY5dSsV2mSEeDmtmDxJFImBMOuHm0A8GLQ9iqC8gV2YvXAs9APaGecAz
	fBJZCbNpQmvR8UvAqbpCPpfFNC80Xd1ZnSgPvNUuzWZtTtyxqA7sL4CnkZruDg==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	didi.debian@cknow.org,
	Marek Kraus <gamiee@pine64.org>
Subject: [PATCH 2/2] arm64: dts: rockchip: Correct the model names for Pine64 boards
Date: Tue, 23 Apr 2024 02:43:44 +0200
Message-Id: <06ce014a1dedff11a785fe523056b3b8ffdf21ee.1713832790.git.dsimic@manjaro.org>
In-Reply-To: <ec124dab2b1a8776aa39177ecce34babca3a50e2.1713832790.git.dsimic@manjaro.org>
References: <ec124dab2b1a8776aa39177ecce34babca3a50e2.1713832790.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Correct the model names of a few Pine64 boards and devices, according
to their official names used on the Pine64 wiki.  This ensures consistency
between the officially used names and the names in the source code.

Cc: Marek Kraus <gamiee@pine64.org>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    This continues the model naming cleanup started with Radxa boards. [1]
    
    These improvements may cause certain issues if some scripts misuse
    /proc/device-tree/model to detect the board they're executed on.  Though,
    the right way to detect a board is to use /proc/device-tree/compatible
    instead, because its contents is part of the ABI.  Such scripts, if they
    actually exist in the field, should be improved to use the right way to
    detect the board model.
    
    [1] https://lore.kernel.org/linux-rockchip/6931289a252dc2d6c7bfd2388835c5e98ba0d8c9.1713457260.git.dsimic@manjaro.org/

 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts    | 2 +-
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts       | 2 +-
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts       | 2 +-
 arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts   | 2 +-
 arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts     | 2 +-
 arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi        | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts      | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 61f3fec5a8b1..e5709c7ee06a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -16,7 +16,7 @@
 #include "rk3399-opp.dtsi"
 
 / {
-	model = "Pine64 PinePhonePro";
+	model = "Pine64 PinePhone Pro";
 	compatible = "pine64,pinephone-pro", "rockchip,rk3399";
 	chassis-type = "handset";
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 59843a7a199c..0b191d8462ad 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -8,7 +8,7 @@
 #include "rk3566.dtsi"
 
 / {
-	model = "Pine64 RK3566 Quartz64-A Board";
+	model = "Pine64 Quartz64 Model A";
 	compatible = "pine64,quartz64-a", "rockchip,rk3566";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
index 2d92713be2a0..26322a358d91 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
@@ -8,7 +8,7 @@
 #include "rk3566.dtsi"
 
 / {
-	model = "Pine64 RK3566 Quartz64-B Board";
+	model = "Pine64 Quartz64 Model B";
 	compatible = "pine64,quartz64-b", "rockchip,rk3566";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts
index fdbf1c783242..fdbb4a6a19d8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts
@@ -10,7 +10,7 @@
 #include "rk3566-soquartz.dtsi"
 
 / {
-	model = "PINE64 RK3566 SOQuartz on Blade carrier board";
+	model = "Pine64 SOQuartz on Blade carrier board";
 	compatible = "pine64,soquartz-blade", "pine64,soquartz", "rockchip,rk3566";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
index 6ed3fa4aee34..2b6f0df477b6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
@@ -5,7 +5,7 @@
 #include "rk3566-soquartz.dtsi"
 
 / {
-	model = "Pine64 RK3566 SoQuartz with CM4-IO Carrier Board";
+	model = "Pine64 SOQuartz on CM4-IO carrier board";
 	compatible = "pine64,soquartz-cm4io", "pine64,soquartz", "rockchip,rk3566";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts
index f2095dfa4eaf..9a6a63277c3d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts
@@ -5,7 +5,7 @@
 #include "rk3566-soquartz.dtsi"
 
 / {
-	model = "PINE64 RK3566 SOQuartz on Model A carrier board";
+	model = "Pine64 SOQuartz on Model A carrier board";
 	compatible = "pine64,soquartz-model-a", "pine64,soquartz", "rockchip,rk3566";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
index bfb7b952f4c5..dd4e9c1893c6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -8,7 +8,7 @@
 #include "rk3566.dtsi"
 
 / {
-	model = "Pine64 RK3566 SoQuartz SOM";
+	model = "Pine64 SOQuartz system on module";
 	compatible = "pine64,soquartz", "rockchip,rk3566";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
index 67414d72e2b6..e1deb9c13ad0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
@@ -13,7 +13,7 @@
 #include "rk3588.dtsi"
 
 / {
-	model = "PINE64 QuartzPro64";
+	model = "Pine64 QuartzPro64";
 	compatible = "pine64,quartzpro64", "rockchip,rk3588";
 
 	aliases {

