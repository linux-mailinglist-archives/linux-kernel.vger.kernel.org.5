Return-Path: <linux-kernel+bounces-28011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13DF82F909
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE051F23DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ABB13E20C;
	Tue, 16 Jan 2024 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+vuUVhy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319F13DBBC;
	Tue, 16 Jan 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434832; cv=none; b=To1iPycbldnxQB6yYFzRottsuIpMZIhssUlS+odoG5ztBZmcq3vkv4NxwB1AiSA5F6l/jJCLWJDm5di38IeIm6QMSUSFXbRKb4bQgQ/c0kuyVSPvJADpjq1y2gInO1X7RKs0bkl1lueBwCQwZ9MS2YoPWVs3dUWC9xWxr1qYwuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434832; c=relaxed/simple;
	bh=nGHY1WKzTqPdqg3P8pbhZCk7xp1yaqoB8FolSVNnx1M=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=j5U9UKaUSRUKz5WlgUuteJs4sjT18TCafphqN5P/FxdWV7V5PkwRfRLletqEu4T2hYgG2pDdd4wDwANqEZlrHcNx9HimAMjSJ/97IcX1AuzM3owrvYA2xTAQlUUd0kPMIq+Cno9JZuoeGfN4rTYRx9q7h14LAc1dnO9A27mlv+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+vuUVhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A708BC433C7;
	Tue, 16 Jan 2024 19:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434831;
	bh=nGHY1WKzTqPdqg3P8pbhZCk7xp1yaqoB8FolSVNnx1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+vuUVhyNKaiqgxLxGIt4DJyKiMqafOMcSgxGuu++55EcP994537Mz8M37sBbDlnM
	 DZeowou0XF8c5nuuc1D2Rjj91JWc2U3BCufJ+C8jyiPdFH3cXsJRQ+A58Z3RuQeRuh
	 cEnIEUETqgTWLdP88GN4KevnMl1+1vPYEsB/sATs6qMMTm1HugN2ifAmRQTlQkXZEK
	 MGtQTF/FoEyXDTdyYN8zIGxG9TpNIVLp2vkW4mOFhluvFvcEWS9wNfaPoxp9jnQ6kL
	 BKf+vcLue5U+GbtY5rgo+UWf4SVz8vSNCFtR0W/rMNssPSwjxKsgDiocYWKUmar5zr
	 r+6getBnJuauQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	orsonzhai@gmail.com,
	zhang.lyra@gmail.com,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 099/104] arm64: dts: sprd: Add clock reference for pll2 on UMS512
Date: Tue, 16 Jan 2024 14:47:05 -0500
Message-ID: <20240116194908.253437-99-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

[ Upstream commit 829e3e70fe72edc084fbfc4964669594ebe427ce ]

Fix below dtbs_check warning:

'clocks' is a dependency of 'clock-names'

Link: https://lore.kernel.org/r/20231221092824.1169453-2-chunyan.zhang@unisoc.com
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/sprd/ums512.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/sprd/ums512.dtsi b/arch/arm64/boot/dts/sprd/ums512.dtsi
index 024be594c47d..7984492ef651 100644
--- a/arch/arm64/boot/dts/sprd/ums512.dtsi
+++ b/arch/arm64/boot/dts/sprd/ums512.dtsi
@@ -291,6 +291,7 @@ anlg_phy_gc_regs: syscon@323e0000 {
 			pll2: clock-controller@0 {
 				compatible = "sprd,ums512-gc-pll";
 				reg = <0x0 0x100>;
+				clocks = <&ext_26m>;
 				clock-names = "ext-26m";
 				#clock-cells = <1>;
 			};
-- 
2.43.0


