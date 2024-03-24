Return-Path: <linux-kernel+bounces-115783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D968897C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747091C30FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A390158DDD;
	Mon, 25 Mar 2024 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mvqe+XV/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E98145FE2;
	Sun, 24 Mar 2024 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322041; cv=none; b=F6pGCtHi3tcP2aolwaOAXoN24lVK4DYoi+CzHN3761d/2igx5bGzCNISwowvU0TT/ZYvW29ZMsw0LuKMK+GNhP45fq9G6Ju5DS8Q7OaDOsKHPXYMjDF1kYIKYusEDDOe461vhg7Xr+23NeBRR9b2eJ0XNEC/hV3F8j2esyymoPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322041; c=relaxed/simple;
	bh=rrqFKlqU7n/vOs7ZSC46MMJtC5zYor3a4qf+qKnzuIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYXfTcqkxVvogYSu/gCrKa2eV4TwdyWpm2j/z0jS2tzD+33XWf7QkvVmLa95BxiZvBL55pNKch0ALToueCvfVNqYZD4MPnxy7rCgBznUFYtEl0mEzD9uSgJ85Ng9pqX/U1LLvu53Px+YAdLbjMhJp0lHiu3TO8WF3o65pjofjBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mvqe+XV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64049C43601;
	Sun, 24 Mar 2024 23:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322041;
	bh=rrqFKlqU7n/vOs7ZSC46MMJtC5zYor3a4qf+qKnzuIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mvqe+XV/3zWPN8+AW4ut+UEF6i38kU3NsAvarpBnoAc1VWlO+RXZvwP0bD36aZ+dz
	 9xAYGi99ZRgTlTa05j2xUonwjCBfnt/9WaP7oKDM0v1i/mENuLdkxm71qQvyquBjbh
	 c29Ds4t5gkcwVI7tMxNxbKqraQIvd7YEkUuJ/hdq56ZwTo2yKfszdUQySHV0w9E+4I
	 6sHygY44UEkNBFZz8qPHzpjdDvhnBW8qczcpiJdbPglEWiMw4xkWxNo/GOv7IvRO9f
	 SrNQH6xGAVcpLKtUrMGYCYpweMMwDoCwP3bSgxklT2raJtS+NCdUHxzwrqDepWiQej
	 lPxj3HkXxtaaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 113/451] arm64: dts: imx8mm-kontron: Fix interrupt for RTC on OSM-S i.MX8MM module
Date: Sun, 24 Mar 2024 19:06:29 -0400
Message-ID: <20240324231207.1351418-114-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frieder Schrempf <frieder.schrempf@kontron.de>

[ Upstream commit 8d0f39b7d04d864e89b84063b124fd10aa4b8809 ]

The level of the interrupt signal is active low instead. Fix this.

Fixes: de9618e84f76 ("arm64: dts: Add support for Kontron SL/BL i.MX8MM OSM-S")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
index 9643d6ed9a7c7..d5199ecb3f6c1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
@@ -205,7 +205,7 @@ rtc@52 {
 		reg = <0x52>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_rtc>;
-		interrupts-extended = <&gpio4 1 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts-extended = <&gpio4 1 IRQ_TYPE_LEVEL_LOW>;
 		trickle-diode-disable;
 	};
 };
-- 
2.43.0


