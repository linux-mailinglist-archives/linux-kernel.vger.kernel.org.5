Return-Path: <linux-kernel+bounces-113095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D3188816C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E51B28806B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606C115444A;
	Sun, 24 Mar 2024 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBmPdzbo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F61154433;
	Sun, 24 Mar 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319903; cv=none; b=TmNx7Rd+ebGcFF6TGpF25GUGeOhl5L4W8CMRETuupbRROWgBq9qC53Ki4cL3KEU974WtXjxXTaSPqFDh2OUEjrY4lS+i6MALBR6WLQSgrqZ5idjXVsR+//O+vJWOwDJ7cCMH0JHDTzbb3i80XVLKyp/dH+KdGCSKkjN+JCMP3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319903; c=relaxed/simple;
	bh=H+N6wK2nOlHM64kSMXDBu3o5Ttw2i8hWbdQcvOy8Jpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cs2K43lysA8gFGLW4nHScGnEb+8mKfmgl4xp+qVyb+YLfe/ue1Noi4VD6FzLAbeMb3WIxK3SMf/NtEXurIqN9UY2OICXybiLMaajjOMlD5GVeIZYjXbOWTxg5h1DEv0T2WROEbsX1roe6N60T+ZLjKU4Xggi0BVhmKdk334ePQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBmPdzbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE28C43390;
	Sun, 24 Mar 2024 22:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319903;
	bh=H+N6wK2nOlHM64kSMXDBu3o5Ttw2i8hWbdQcvOy8Jpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cBmPdzbofkxQcicuzwMsJmShkncnLLZyf8l4HMfM5IA5cC7j0l0KMK0fzn7tsHBq3
	 nipjJYWtOhZ1vRgAYT4YUwzBU3pzJk2fDqc2XiofQjn0L8qIjNXMg2f03sKczV4Owc
	 dQHERKEY482zJET6Px9sScPoXXpjLt3gCwZ8Cy2K0+2z0n6JivnEkN+uHYf0QSQeOa
	 OkWs7MbF3DWaihpYR/tYxAZlg/IdINaboukkmlel3YpDMxTzicaAAXn9EJqdU7IB4l
	 ctd8crqYv53KRbdAINdAtFWdTvUxHjHHOtEeU+PvgfxzdMIVtvg33AkO8DqsAQSJ3Y
	 QdVcb0yOm66bw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Roger Quadros <rogerq@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 208/715] arm64: dts: ti: k3-am62-main: disable usb lpm
Date: Sun, 24 Mar 2024 18:26:27 -0400
Message-ID: <20240324223455.1342824-209-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 464b7565d085d..c49fbce5cb707 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -640,6 +640,8 @@ usb0: usb@31000000 {
 			interrupt-names = "host", "peripheral";
 			maximum-speed = "high-speed";
 			dr_mode = "otg";
+			snps,usb2-gadget-lpm-disable;
+			snps,usb2-lpm-disable;
 		};
 	};
 
@@ -663,6 +665,8 @@ usb1: usb@31100000 {
 			interrupt-names = "host", "peripheral";
 			maximum-speed = "high-speed";
 			dr_mode = "otg";
+			snps,usb2-gadget-lpm-disable;
+			snps,usb2-lpm-disable;
 		};
 	};
 
-- 
2.43.0


