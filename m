Return-Path: <linux-kernel+bounces-113745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F8688865F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8A01F24F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1D7149C73;
	Sun, 24 Mar 2024 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Svlkzqlz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF481DF7B8;
	Sun, 24 Mar 2024 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320751; cv=none; b=dwspfJ1t72+MPe9eB1kXOMrBZc4LtC7F3P9TyXaU1gfZq5FdvtPFVRxFJYZPBrZYybCd3eOQEWFVZuxGCbCkf3Q7pcebe9H23/wBMHa1H/mzO+A0txnftni21rrpGFR0k9n8tUV1XlT7NEb6CAEX+QPlDnIyixzozyAnk9nd6Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320751; c=relaxed/simple;
	bh=+I604YvrVbmBP/fR3nTzqZgyNQVHXkAtJ9TyLm1Qv1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvhb8SjNXEx1bWQNTKLKW5OhlQcwAI5nSjKC5HajJP43N/HiY3bdo10IWdoim7X+SSvQGj8ifC6uRCw0CURs6kFH6IpRX1DYGQHOMGJ5n6LQdCGaxHs7ipkwK1OmmfYa09/1s8rKLbSrN+fNlmgX+CjSFEWjRh/88PnYurMcVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Svlkzqlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9C3C43399;
	Sun, 24 Mar 2024 22:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320750;
	bh=+I604YvrVbmBP/fR3nTzqZgyNQVHXkAtJ9TyLm1Qv1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SvlkzqlzeAG1vtLpq8UDLZjGJ93d3RB2otBD+eqTLrczyg9EFpRiR9xR1RVJt/JoY
	 wluPn4/ClPM59Mtho60jd2EhXH85Mtjx1V4hbtycTeJ4BY0MrEiBBm+lmubjfocYcF
	 xsonGvm68gAj42d7iXJBKcw3QbiACZKMWMrpuHW82n6JEK3popTkLiAyb2QBOHaHnF
	 XVbDZ+F9O6beg4fkgBPxWVZO5urXDs24Zwy05Vp33xBDTfdyKKCYbPoJpcEY3Y901D
	 vWqROmJC8ZGwZxVLPoJpepW4CinJhAIC91GAVUnKTd+7or9vB6jJSyTLDmejWBGZe5
	 SVBk8/kJDGzlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 314/713] arm64: dts: imx8mp: Set SPI NOR to max 40 MHz on Data Modul i.MX8M Plus eDM SBC
Date: Sun, 24 Mar 2024 18:40:40 -0400
Message-ID: <20240324224720.1345309-315-sashal@kernel.org>
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

From: Marek Vasut <marex@denx.de>

[ Upstream commit 13ab6f174a6b577bd7d09124b47ec8ace2682e42 ]

The SPI NOR bus routing on this board cannot go above 50 MHz,
set the clock frequency to maximum of 40 MHz to be within a
safe margin. Remove the comment as well.

Fixes: 562d222f23f0 ("arm64: dts: imx8mp: Add support for Data Modul i.MX8M Plus eDM SBC")
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
index 5828c9d7821de..b5ce7b14b5434 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
@@ -121,7 +121,7 @@ &ecspi1 {
 	flash@0 {	/* W25Q128JVEI */
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <100000000>;	/* Up to 133 MHz */
+		spi-max-frequency = <40000000>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 	};
-- 
2.43.0


