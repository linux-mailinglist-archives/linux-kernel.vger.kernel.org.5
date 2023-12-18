Return-Path: <linux-kernel+bounces-3617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A540816E84
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8362F1C24566
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5249895;
	Mon, 18 Dec 2023 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3GA7TZ4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE0683B16;
	Mon, 18 Dec 2023 12:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E37C433C9;
	Mon, 18 Dec 2023 12:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903498;
	bh=NkBDOcwd+mXjhVoiXLCAhNzbOz1XH1NLtu9Pn/+6ro8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D3GA7TZ4aEvtz7svyFpQ7Vy/XudNBHR7ClQlPrrE9JqEkoVvCyaTr9ZkyES5Y98V7
	 g2LjgdMxKCwHXAk6eSSgfI5/RYIgK0X2ylVcbpauLSIijxP+9utGIsLPSAl/TTc7d/
	 tacVXL6j1frXJ0Z/oo5UDWKky6h0yZA4rXOux6LLHQWAUmq4mdGqbnF0dKNqe/KFp1
	 C/HMVKKYwoSWe3MJ2+40sbNYEeVMlWAFlcDdIHSLSurFBw8BvxQYJ32yLcGPkxf1n/
	 s+OcN5xAn0nCf8Mrcf1WQBCsJ2Y2y2u5A8EMJ97IG4ghd/oDpevO39ynzGkmRwvwbr
	 juTKxigDn6eIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	tsbogend@alpha.franken.de,
	zhoubinbin@loongson.cn,
	git@xen0n.name,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 16/18] MIPS: dts: loongson: drop incorrect dwmac fallback compatible
Date: Mon, 18 Dec 2023 07:43:50 -0500
Message-ID: <20231218124415.1379060-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124415.1379060-1-sashal@kernel.org>
References: <20231218124415.1379060-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.7
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 4907a3f54b12b8209864572a312cf967befcae80 ]

Device binds to proper PCI ID (LOONGSON, 0x7a03), already listed in DTS,
so checking for some other compatible does not make sense.  It cannot be
bound to unsupported platform.

Drop useless, incorrect (space in between) and undocumented compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi | 3 +--
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi          | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
index f878f47e4501b..ee3e2153dd13f 100644
--- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
@@ -130,8 +130,7 @@ gmac@3,0 {
 				compatible = "pci0014,7a03.0",
 						   "pci0014,7a03",
 						   "pciclass0c0320",
-						   "pciclass0c03",
-						   "loongson, pci-gmac";
+						   "pciclass0c03";
 
 				reg = <0x1800 0x0 0x0 0x0 0x0>;
 				interrupts = <12 IRQ_TYPE_LEVEL_LOW>,
diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
index 7c69e8245c2f1..cce9428afc41f 100644
--- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
@@ -193,8 +193,7 @@ gmac@3,0 {
 				compatible = "pci0014,7a03.0",
 						   "pci0014,7a03",
 						   "pciclass020000",
-						   "pciclass0200",
-						   "loongson, pci-gmac";
+						   "pciclass0200";
 
 				reg = <0x1800 0x0 0x0 0x0 0x0>;
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


