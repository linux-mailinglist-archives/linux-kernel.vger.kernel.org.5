Return-Path: <linux-kernel+bounces-27968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDE682F878
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3442B25D23
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A151D132C2B;
	Tue, 16 Jan 2024 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOCrrk7r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17A8250F6;
	Tue, 16 Jan 2024 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434703; cv=none; b=QdqUcc22KPBn9giUwKtriIhHM583hUZlhepapMfoGl5eQMec9jjTpx4j8YtHJxZXT5tM7TL+WE7lWmga9UJnx3m3KOkqj2GDbONsJ4K1gp+0503bc2l/PpCoAQJxFryF7ms893I/ljTbLhbLw43QzdDIll8Fb428qU99LwvLNp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434703; c=relaxed/simple;
	bh=QoZWa/ZhPaxQYd196ykS7x8fPnYHIQxjy2Is77FyoUA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=qHDfmA+5aGeS0PIHVDd4aKX//cNUunCY/unASEo8BDl7PRa3AZhp/MFp6PdQUI972jlRmpA2NqjRskgIGkmAK6bOHyuaA0I4NCbuAF/ONFf6Uhepc2XvF0bwuXl/qUeGpVQ/sgqToyXNJDeMejoZXRMY8ahlBXZQabqshoytVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOCrrk7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2F4C43399;
	Tue, 16 Jan 2024 19:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434702;
	bh=QoZWa/ZhPaxQYd196ykS7x8fPnYHIQxjy2Is77FyoUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOCrrk7r0T3qLrp9rCMvkA1qdui66jZiN0js+r+Vlz8CcMvAHxAFQu/naIzZBWxTb
	 dx1D2CQ+iEFWAP3/Qah0DAM6LfeUzxovMEa9GAlRu6Xp05r0UKV0CQy5raCUq2xuLO
	 VTKf0lHWe+mkZRj0G8bi+5IMxojjRS3g7Wvr72IUAvrlYrTSzKckLVbGcbuq5zwgF4
	 XmscznIVaexNHgMsWZO5GWUn4TFoOqn63B6fHlF4e61eg7VcQjQ1BWEjeaj10uH8FI
	 BigW6w/WKE5a/OcqvleYm7YJghOG/r1/zZ2oeFzGccfHqLFH5BXxNGiEBop/dF3q5C
	 4z/C7+N9tVqsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 057/104] ARM: dts: imx27: Fix sram node
Date: Tue, 16 Jan 2024 14:46:23 -0500
Message-ID: <20240116194908.253437-57-sashal@kernel.org>
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

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 2fb7b2a2f06bb3f8321cf26c33e4e820c5b238b6 ]

Per sram.yaml, address-cells, size-cells and ranges are mandatory.

Pass them to fix the following dt-schema warnings:

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx27.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx27.dtsi b/arch/arm/boot/dts/nxp/imx/imx27.dtsi
index faba12ee7465..cac4b3d68986 100644
--- a/arch/arm/boot/dts/nxp/imx/imx27.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx27.dtsi
@@ -588,6 +588,9 @@ weim: weim@d8002000 {
 		iram: sram@ffff4c00 {
 			compatible = "mmio-sram";
 			reg = <0xffff4c00 0xb400>;
+			ranges = <0 0xffff4c00 0xb400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
-- 
2.43.0


