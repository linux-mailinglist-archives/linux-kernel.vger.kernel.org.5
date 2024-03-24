Return-Path: <linux-kernel+bounces-113712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2164B888E53
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E681F303F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464D8129A6F;
	Sun, 24 Mar 2024 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEkGP4LW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0653686655;
	Sun, 24 Mar 2024 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320698; cv=none; b=rrzMyjGSR70wujVuEDuP6iqTSUJoSEUmvhhZgVdjeV2NDa98fUt9VHC8MIqKp2pNezbifTP7UF0SXCK+Jm2D9PeyvLiZErU+mUKCGAJwPUvWK5HIuFJLLX2O2eSJtfPJtYlfJPBv1MuVXfWKi/hmn2pK20+Cv5x4s7FsIEZQUOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320698; c=relaxed/simple;
	bh=eZSo9kCBaG2IU8ylLywZO1b09ydCwcFYWeesUj1vWRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gijc6htwH+VyBw6xDGinHpa/xUd/0Nd3c6IxUNDDLP7ofiPCpi7fkfSzbLmwxenxisLqQ/I4tLGe3VnajC3865FVZA/9uDDytIYh9PUn17VRDhS5wwAwNhnGbCDMRyIQ3tahhvmeSzEVhSTEl6awQF8BTtgARkgV9165Zhrkr8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEkGP4LW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FF8C433F1;
	Sun, 24 Mar 2024 22:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320696;
	bh=eZSo9kCBaG2IU8ylLywZO1b09ydCwcFYWeesUj1vWRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GEkGP4LW6kj1wYlB7R8TWH6P9xP/NJwdaXLwaItNUW8Hs0ht6aY+h4Do48kI7V0R3
	 OSzHUp2okU5+IJivDVSsjCRMe9YBpRwH9JLfqywpXDUJTfXEcDdnt2WrrrD0NHOsmn
	 Yj2SFWXEkgYDDu/Isz1vvBXznNd4igqkY/qcyyPXDPYIpUKJF9aBdX4E5rDZk68e14
	 0QXN3yTG4wi7gNRo+Su1iovRhp7NRqOxZWlUMmp6V2PBu3vTClrAA35ekK/6MkvK6/
	 XOfmUGo9rY4Q3LedSG7pOG1CDGQk/UwNnSn7P1bhSCVD10iZCA/YPUJBPCCua0/zSW
	 d/Ezh4t1YsTjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Roger Quadros <rogerq@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 259/713] arm64: dts: ti: k3-am62-main: disable usb lpm
Date: Sun, 24 Mar 2024 18:39:45 -0400
Message-ID: <20240324224720.1345309-260-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index e5c64c86d1d5a..c1ace4a376d17 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -623,6 +623,8 @@ usb0: usb@31000000 {
 			interrupt-names = "host", "peripheral";
 			maximum-speed = "high-speed";
 			dr_mode = "otg";
+			snps,usb2-gadget-lpm-disable;
+			snps,usb2-lpm-disable;
 		};
 	};
 
@@ -646,6 +648,8 @@ usb1: usb@31100000 {
 			interrupt-names = "host", "peripheral";
 			maximum-speed = "high-speed";
 			dr_mode = "otg";
+			snps,usb2-gadget-lpm-disable;
+			snps,usb2-lpm-disable;
 		};
 	};
 
-- 
2.43.0


