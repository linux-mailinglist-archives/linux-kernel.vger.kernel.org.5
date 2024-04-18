Return-Path: <linux-kernel+bounces-150790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815BA8AA497
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109BD288891
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEE3199E9D;
	Thu, 18 Apr 2024 21:03:43 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70F5194C9D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474222; cv=none; b=hVhmdx+D/TUHKrvJ5tWdPFyFfYR4DI8Uqc/A6o4FYpZuuugKehfgcBQDYj4888dm0QaitK9nPAUlRyX7dg3NpAC4QFj0auEV0evSCSfeRWJZOJ0aYCmrsl+9QYx6YC+5kXFoMvQtuU3wuccaTdcwVCn5fReVhdq9V526meqwI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474222; c=relaxed/simple;
	bh=ZHy/tyfN8jh5oGs0auDduY1xUfLUtPfzzp4q8DJ71X4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RJqqj7R3yVrHtPtyZNrKm6jm0QIuLCvGlgBqV7q4pKfIdTb7Ncz+QnuyGEiVlpGK8Ecko94kKMXgzM0LxjcrmBObDOytTCJ8kwk73asKSIbRrOSbqNbkjR8Qe90RsjStVx5hKLFBuNnpCE/r7xWUMnkh+rFIp/aRSlDBNZ7sZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861917.versanet.de ([94.134.25.23] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rxYus-0002jJ-Rq; Thu, 18 Apr 2024 23:03:34 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@theobroma-systems.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 1/2] arm64: dts: rockchip: fix comment for upper usb3 port
Date: Thu, 18 Apr 2024 23:03:31 +0200
Message-Id: <20240418210332.2394871-2-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240418210332.2394871-1-heiko@sntech.de>
References: <20240418210332.2394871-1-heiko@sntech.de>
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
 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
index d672198c6b64..214f8258af68 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
@@ -260,7 +260,7 @@ &usb_host1_ohci {
 	status = "okay";
 };
 
-/* host2 on Q7_USB_P2, lower usb3 port */
+/* host2 on Q7_USB_P2, upper usb3 port */
 &usb_host2_xhci {
 	status = "okay";
 };
-- 
2.39.2


