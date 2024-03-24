Return-Path: <linux-kernel+bounces-114179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CA48888EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD0228931A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76FC24A869;
	Sun, 24 Mar 2024 23:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddbK77lv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11556206306;
	Sun, 24 Mar 2024 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321501; cv=none; b=at71JNxtLEO4+Eq7zT9oiOU+B1XT2HODn6gVDlUw3LES5sZtSthvyy4hO0YOzcgHMlV75kZDh59mPG3pt/Ip9kOf0pp1YWnNLow92zLpKU9KumD6iRTRcpM7vsyGA76wYqA+bEmi9rIgR10oxlsDKUKptGF+dQFEYemupBuUSUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321501; c=relaxed/simple;
	bh=nuS2DSyb0HoYpvjFVvqmQJZCzRsWtxviE8APCm+LkS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUO42B6uw5P/steuRziN+OTEBP0egtatdUcM7C035yJg3K25ciwSbEe1mV5hIx1WKBURwGSAlEIfbMbMNEuvZJ3QYfs8OUGkGSmcXwnyIlDmFIxjjYBgYepiRut2oGYjUrzfkGbjXVLQbGQgs0tUsq/IWehDURn/o0pgQUFAz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddbK77lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8E2C433C7;
	Sun, 24 Mar 2024 23:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321500;
	bh=nuS2DSyb0HoYpvjFVvqmQJZCzRsWtxviE8APCm+LkS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ddbK77lv5FaFtbH0WK9Mz2DlSo6YReku2VrdWWJPvSd9CWhjoKdsQGRtAN0FHczI2
	 MeeOGSFk3GYtNVX9pFcpSRqXZ/gNWS8kmVLQutytf7Sxr3rPzlZsSWMl/oAAO9vGU2
	 t7Smil/APVQpdJiy1W02de7s4hUmYSrKZtqDSd1GsTjBYHBjyD/2RWjS2GThM/243M
	 xO70JEXhL48xFmoTpIehDtID2nzcL7d4HLV75KpN2KcZgZ5JXSX1DF1c5yPUjVHznL
	 F+CBTlBsryx0mARnpUjHtqMsVadxkmY7TGYYuOZlMQZVPcM84Oma/bgxJYadPwPWn4
	 ZRk8EsQoNkw2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Roger Quadros <rogerq@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 226/638] arm64: dts: ti: k3-am62-main: disable usb lpm
Date: Sun, 24 Mar 2024 18:54:23 -0400
Message-ID: <20240324230116.1348576-227-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

[ Upstream commit 9c99b337a8755a09df7735d4324ae26a6eca6261 ]

AM62 USB works with some devices, while failing to operate with others.

[  560.189822] xhci-hcd xhci-hcd.4.auto: xHCI Host Controller
[  560.195631] xhci-hcd xhci-hcd.4.auto: new USB bus registered, assigned bus number 2
[  574.388509] xhci-hcd xhci-hcd.4.auto: can't setup: -110
[  574.393814] xhci-hcd xhci-hcd.4.auto: USB bus 2 deregistered
[  574.399544] xhci-hcd: probe of xhci-hcd.4.auto failed with error -110

This seems to be related to LPM (Link Power Management), and disabling it
turns USB into reliable working state.

As per AM62 reference manual:

> 4.8.2.1 USB2SS Unsupported Features
>
> The following features are not supported on this family of devices:
> ...
> - USB 2.0 ECN: Link Power Management (LPM)
> ...

Fixes: 2240f96cf3cd ("arm64: dts: ti: k3-am62-main: Add support for USB")
Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Roger Quadros <rogerq@ti.com>
Link: https://lore.kernel.org/r/20240209130213.38908-1-andrejs.cainikovs@gmail.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 284b90c94da8a..6d125c86c2d35 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -613,6 +613,8 @@ usb0: usb@31000000 {
 			interrupt-names = "host", "peripheral";
 			maximum-speed = "high-speed";
 			dr_mode = "otg";
+			snps,usb2-gadget-lpm-disable;
+			snps,usb2-lpm-disable;
 		};
 	};
 
@@ -636,6 +638,8 @@ usb1: usb@31100000 {
 			interrupt-names = "host", "peripheral";
 			maximum-speed = "high-speed";
 			dr_mode = "otg";
+			snps,usb2-gadget-lpm-disable;
+			snps,usb2-lpm-disable;
 		};
 	};
 
-- 
2.43.0


