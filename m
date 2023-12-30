Return-Path: <linux-kernel+bounces-13398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FCC820493
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70517282295
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530AD8C0B;
	Sat, 30 Dec 2023 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b="W8zgIgCt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4442B8813;
	Sat, 30 Dec 2023 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6tel.net
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:12ac:0:640:b64e:0])
	by forward501c.mail.yandex.net (Yandex) with ESMTP id 40E7360E6D;
	Sat, 30 Dec 2023 14:18:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3IVUxO8g5Ko0-5KxRwi7a;
	Sat, 30 Dec 2023 14:18:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
	t=1703935107; bh=n47Gea6rGFU10OYrbHw+VPcV6QRBypXud2PYckOKEwc=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=W8zgIgCtuNeM5x2ACniLjtz5qpWGIoyAWFaKAoiHL4ZQSorjY2WmZqsUwWX3nIbz2
	 7WGgZ4V4rsE5bKYeW752PGYcQtDVlbkHF57zGNwogBabWnGFtk+pqAKWWIkbxCyluL
	 218FQG1R4C3GO3sNmIyWmIZLxzpz5IXzEn71UH/I=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From: efectn@6tel.net
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sebastian.reichel@collabora.com,
	jonas@kwiboo.se,
	inindev@gmail.com,
	Muhammed Efe Cetin <efectn@protonmail.com>
Subject: [PATCH v2 3/3] arm64: dts: rockchip: Add support for NanoPi R6C
Date: Sat, 30 Dec 2023 14:18:01 +0300
Message-ID: <0f9ee0baa6c9de4d54dd6d13957ca15a63ec934f.1703934548.git.efectn@protonmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703934548.git.efectn@protonmail.com>
References: <cover.1703934548.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

NanoPi R6C is mostly same as R6S variant. It has M2 port instead of a
NIC port and different led labeling.

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile              |  1 +
 .../arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 634b9be47..f2d13482e 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -115,3 +115,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-khadas-edge2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6s.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6c.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
new file mode 100644
index 000000000..497bbb570
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3588s-nanopi-r6s.dts"
+
+/ {
+	model = "FriendlyElec NanoPi R6C";
+	compatible = "friendlyarm,nanopi-r6c", "rockchip,rk3588s";
+};
+
+&lan2_led {
+	label = "user_led";
+};
-- 
2.43.0


