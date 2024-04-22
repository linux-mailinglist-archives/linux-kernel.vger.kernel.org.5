Return-Path: <linux-kernel+bounces-153725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 857D28AD239
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EBB1C20A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B99154C0D;
	Mon, 22 Apr 2024 16:40:00 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794CA154432
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804000; cv=none; b=h5WL1F40EJTmxDrlXqHqsiSBQ2YmyW8IJDZsVPE3UPftg3wE6mAz/B8UxtbWiI2sZnA0pK+VPM3FCroGzzRIn8B7RKcA/JoYRevd8CWD30o7qrnSkmwBRZa0FsiKt4BRCSfys4TSKbkj+hlVkEjxQeMboVUj/OlamWRwY9ZrJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804000; c=relaxed/simple;
	bh=lc8/NBQhJTYQcoxGBAazKCGVegY7WF0/Ta5NFBDlSBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UrQ14pLzSsBlaUOqD7nNQevMplBmDsrFh7hq72VpL9kTlxbeBC+odcJcECwOac7XVKgJZVxIk4532LUv3bvAR+NlOApjk+ls0+7wjc1Tr3Oq62n85uQQ+HpJRPXLORerQDbKAjkonAU4/kTqrDIB6BG2bH49VAZwhcq7qtEWG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d85.versanet.de ([94.134.29.133] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rywhu-0004gq-0t; Mon, 22 Apr 2024 18:39:54 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@theobroma-systems.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 1/3] arm64: dts: rockchip: fix comment for upper usb3 port
Date: Mon, 22 Apr 2024 18:39:49 +0200
Message-Id: <20240422163951.2604273-2-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240422163951.2604273-1-heiko@sntech.de>
References: <20240422163951.2604273-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The comment for the host2_xhci points to the wrong port on the board.
The upper usb3 port is the correct one, so fix the comment to prevent
confusion.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
index 9bdd14799eff..2aa43e7430e5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
@@ -239,12 +239,12 @@ &uart5 {
 	status = "okay";
 };
 
-/* host0 on Q7_USB_P2, lower usb3 port */
+/* host0 on Q7_USB_P2, upper usb3 port */
 &usb_host0_ehci {
 	status = "okay";
 };
 
-/* host0 on Q7_USB_P2, lower usb3 port */
+/* host0 on Q7_USB_P2, upper usb3 port */
 &usb_host0_ohci {
 	status = "okay";
 };
@@ -259,7 +259,7 @@ &usb_host1_ohci {
 	status = "okay";
 };
 
-/* host2 on Q7_USB_P2, lower usb3 port */
+/* host2 on Q7_USB_P2, upper usb3 port */
 &usb_host2_xhci {
 	status = "okay";
 };
-- 
2.39.2


