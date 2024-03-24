Return-Path: <linux-kernel+bounces-113069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284C3888137
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22FC281EA2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802C5149E09;
	Sun, 24 Mar 2024 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj+Cb/m8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE889149DF2;
	Sun, 24 Mar 2024 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319877; cv=none; b=goo7yiJFUQZADg8OBfTvID65kkRXy5iQ1hzO89VY262nSz1EkKkwqVXSkrmLui8mpxnbZyMomtHNd4cJNPZOYxyOlQ81jIhD6OrHafNRkSwiR72xZLsvujBY3jySc5vgdeuNctZ5kaN5b0mQUEFOoDWA40hVfWB/b0FmX3zk9XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319877; c=relaxed/simple;
	bh=uFJCPcfK3HiaF30YI8WVLqKDVaeGAnvAx86TI/xeRLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbVcdF3NbxfXaSoUOB9ll9t259DUwQ7YAm5QhOD3ou1hPsSsXWq1PbUJf5seHoG/EisNp8z2qi+ExeSxumFaUYbQmTTN8u6cTtw9VIw3VE4w1jnF1dc45Taiae4Lxe6uoDdr0twL1nD8gkSyvwxP0UNPjrauIfKSx9wMiIwCmpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gj+Cb/m8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25F6C433C7;
	Sun, 24 Mar 2024 22:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319877;
	bh=uFJCPcfK3HiaF30YI8WVLqKDVaeGAnvAx86TI/xeRLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gj+Cb/m8D2f4mqxRpVOdU9B0kV6xx0Se9EQB4TkOjvKK0zAyekJb1XLHxzYoeS0gX
	 gSR+bnYw0HrE3LCNiyiNuUtoF8lrj61ywgVIZAoEvzZdtUPFU1iA4gno4llO4+/lpV
	 YUz2gqyw+I6WIAO7DGW+rxqDWX+ykBMQVgy8h7bbqQ/XTM7x8t3D/+u5Z38Cu4D+6d
	 U6PUWotG6Tv3ffrApN+ILZnFhEbyEYPGQBoIfA2Y1h1QvVnPq8h5726mAxZDiyiZDf
	 QtfLa98eaxqgdsuyiSwDibuRdLn4vS4R4HoFdTujjd+BIn4FpSSajSunNSwZL7WAsC
	 r2kJ3E0p+4jtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 182/715] arm64: dts: mt8183: Move CrosEC base detection node to kukui-based DTs
Date: Sun, 24 Mar 2024 18:26:01 -0400
Message-ID: <20240324223455.1342824-183-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index b6a9830af2696..bfb9e42c8acaa 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
@@ -360,6 +360,10 @@ pen_eject {
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
index 306c95166f3fe..5c1bf6a1e4758 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi
@@ -339,6 +339,10 @@ touch_pin_reset: pin_reset {
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
index 382e4c6d7191c..0f5fa893a7742 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi
@@ -343,6 +343,10 @@ rst_pin {
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
index 1b3396b1cee39..90c5ad917a9ba 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -937,10 +937,6 @@ usbc_extcon: extcon0 {
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


