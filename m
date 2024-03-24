Return-Path: <linux-kernel+bounces-115872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 565DA88985F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104D22A3381
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE893814A6;
	Mon, 25 Mar 2024 03:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="livUQaFR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB4914600F;
	Sun, 24 Mar 2024 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322069; cv=none; b=o12DNz7GEoKl9YQaJ+4IlCZmijFce3YhHH6bYSdWusWh/3XJioKuBwVvEcNJZgaQPoIm5wqmL3aM4e6uSCoLeTJi8QTxun+aFX5fPmQkg8pWBMP6PR8nn7R+zPACrXyzkN35ncITwdx3hQ75y5qTGHIi3GcObdsnRu0VFQ6o4Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322069; c=relaxed/simple;
	bh=LJoL7FVENAJIiFqx9+N2Qkpe7UbQUGUTth5EZ2C6PEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqd4VeZdBauffwdy8MrISdWqv8XLF4PTvhf206yosW7zbkYKUSlM+eIRbwje2MLz0Wj7TFOksNOsV87JlrZWQsSn+e2F8DlQYO3ce+sWUSC1elDCFSlfq8ljI3ycx/IV0k29tvMord89mLBypbmiJpmleHR31d7sCIwop7Ff8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=livUQaFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23DFC43390;
	Sun, 24 Mar 2024 23:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322069;
	bh=LJoL7FVENAJIiFqx9+N2Qkpe7UbQUGUTth5EZ2C6PEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=livUQaFR3Ks+0WR3jUvt62hYxEp3vCfBiDiJgYwlbQFgWA03dtz7v7ocFmEiltdWj
	 2KqYR2Gx+E6as01SxPF0alyVIk8l9BLP81f0J5oSqJZ4coJ/jm5arNypU7m52pF/Za
	 J7dgOnsnyRrQzL+pVGEN5CMPvHqLwYNex6aVRM/KTC4rzD0WEBmPIbyGxANLptCr/T
	 eO35Bfbxqjzbsgz16r9VDDOT9iRQ6qN8h+RbBY5sA0fTkk0m09ORaz3xeOlJzfUofg
	 +Fp8esk7lohtiILF1aPY5aDRC7hhnqkdvB2yrBcBilZ0xxAb1QRLcXqBzGYrSnSHoN
	 UeyCg3LBd4jgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 142/451] arm64: dts: mt8183: Move CrosEC base detection node to kukui-based DTs
Date: Sun, 24 Mar 2024 19:06:58 -0400
Message-ID: <20240324231207.1351418-143-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit 04bd6411f506357fd1faedc2b2156e7ef206aa9a ]

The cbas node is used to describe base detection functionality in the
ChromeOS EC, which is used for units that have a detachable keyboard and
thus rely on this functionality to switch between tablet and laptop
mode.

Despite the original commit having added the cbas node to the
mt8183-kukui.dtsi, not all machines that include it are detachables. In
fact all machines that include from mt8183-kukui-jacuzzi.dtsi are either
clamshells (ie normal laptops) or convertibles, meaning the keyboard can
be flipped but not detached. The detection for the keyboard getting
flipped is handled by the driver bound to the keyboard-controller node
in the EC.

Move the base detection node from the base kukui dtsi to the dtsis where
all machines are detachables, and thus actually make use of the node.

Fixes: 4fa8492d1e5b ("arm64: dts: mt8183: add cbas node under cros_ec")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20240116-mt8183-kukui-cbas-remove-v3-1-055e21406e86@collabora.com
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi  | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi        | 4 ----
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
index a11adeb29b1f2..0d3c7b8162ff0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
@@ -373,6 +373,10 @@ pen_eject {
 };
 
 &cros_ec {
+	cbas {
+		compatible = "google,cros-cbas";
+	};
+
 	keyboard-controller {
 		compatible = "google,cros-ec-keyb-switches";
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
index 4864c39e53a4f..e73113cb51f53 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
@@ -340,6 +340,10 @@ touch_pin_reset: pin_reset {
 };
 
 &cros_ec {
+	cbas {
+		compatible = "google,cros-cbas";
+	};
+
 	keyboard-controller {
 		compatible = "google,cros-ec-keyb-switches";
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
index d5f41c6c98814..181da69d18f46 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
@@ -344,6 +344,10 @@ rst_pin {
 };
 
 &cros_ec {
+	cbas {
+		compatible = "google,cros-cbas";
+	};
+
 	keyboard-controller {
 		compatible = "google,cros-ec-keyb-switches";
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index de610874a9125..1db97d94658b9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -896,10 +896,6 @@ usbc_extcon: extcon0 {
 			google,usb-port-id = <0>;
 		};
 
-		cbas {
-			compatible = "google,cros-cbas";
-		};
-
 		typec {
 			compatible = "google,cros-ec-typec";
 			#address-cells = <1>;
-- 
2.43.0


