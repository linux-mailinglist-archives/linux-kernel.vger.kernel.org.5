Return-Path: <linux-kernel+bounces-113697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9110888615
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C9F2904E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B6B146A82;
	Sun, 24 Mar 2024 22:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgrBVCsN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE43F1DA146;
	Sun, 24 Mar 2024 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320674; cv=none; b=PTlhFlbwvJ4jNMvErUEusTBRXI36R/mWkXUoQOavXM3drgkqnaBd6RRiYU1uZBRn4yS6Qc353SLPtULCr3aCyayC2xutsRupvFOCBTMh2FJT6ImSEPHMgQ1NeGp49fMuSRf/yR14/rBqsokySIxWDrId5u9aZYALgD1cND9nl7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320674; c=relaxed/simple;
	bh=bkw6LBBKWHcbBc7OOt+mwhf3IPxZONDWRPDU6cL3dME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uw5fSg8wkibgXit7mPHKwFBVTJLo6BQs7Z5DN4OzNWd225BShaqc6gbHVx2YsZmoAwyLajpFm43QX4++2JD5kQyX1BUE6H9iG0eUZnXQRY56u8x7Eun23PJS6WTgeFZJYnI+8A+hDL94+tJGKw8HH0qWfojH4oSi208j3pkuOPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgrBVCsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD61C433C7;
	Sun, 24 Mar 2024 22:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320673;
	bh=bkw6LBBKWHcbBc7OOt+mwhf3IPxZONDWRPDU6cL3dME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MgrBVCsNQedCLI575Y0x5K3YQC6NO1RWCHaKfjimcuZDlJYDPAz50ktWBpXmccPIf
	 /c93nCo3D3GCJg9f1VHBmIW+ePSUAixUoVS95KhU5NiNr28yvrMyuPlZYInimDCGG9
	 jpaAys2dJjrxUdl248WjhlaEuaCz7mB7tPqdHowhLNsW6b2iafhgdbI7xCkJiIDCZ3
	 reB+nSOGNGA9IAlHy8X1FoI2GS71KT7Y563QYo/IjTgtBfsTFb2Tz8vfHrY8DojCPz
	 ryhFwZ887vGiYQMdGWOnwnP2C+8dypIYC1UUDsoYoSVn17PchvpI3YgPsZj4vMQcVX
	 BF9e+V6qX3FeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 236/713] arm64: dts: mt8183: Move CrosEC base detection node to kukui-based DTs
Date: Sun, 24 Mar 2024 18:39:22 -0400
Message-ID: <20240324224720.1345309-237-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 7881a27be0297..49a1c3ccb0041 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -935,10 +935,6 @@ usbc_extcon: extcon0 {
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


