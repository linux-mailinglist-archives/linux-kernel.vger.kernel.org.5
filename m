Return-Path: <linux-kernel+bounces-70323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C2D859611
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CAB1C20DBA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70267199D6;
	Sun, 18 Feb 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8mmDD7S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F7D168A7;
	Sun, 18 Feb 2024 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708249234; cv=none; b=VuXBMSvTZAI2W6Kzb2LvlJe/IsWeCBp1jx9LoYAg4M9rOzx9okWf/AYtq+Qn1bDcZDocvToblP5fmi1mSHm4Lgk/BnEtsoKRHfBQqS/z/SrXF7yT1YQdeP/A1vP5uERrG8dDrwpvFpGpDWWwl9n0bhDOjmfU/ZSBkspN9oZHoKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708249234; c=relaxed/simple;
	bh=g/cYia/nzuVeyrMQsTsvao1OEQbnaDqgWqKJyaK7rY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pz9wZEXXURRyzRHOFLa1TFEbWGbG1t4ndw7gZh0cEy1SzZxvfOefXVMz22KoeZZVZru0re3Qaosv7DaHiQK6ueexH9RaIt+f7g9LW5xQfN8EWHrs9Hr/peOMkIfDGkG9yU/zkmV/EvIgMaDm+w+01N57NR/8XHaj8b0pi9ZN6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8mmDD7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D3BAC433C7;
	Sun, 18 Feb 2024 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708249234;
	bh=g/cYia/nzuVeyrMQsTsvao1OEQbnaDqgWqKJyaK7rY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L8mmDD7SjB9RkrGIg0nde0/NyvsttIMhJOhWW8hLYbczEOE0oJjsGSLZIWEo8V7n1
	 cl8PdsHVoVduSYaZsLrAyB3ZRmBSjj1QdYwROheQNqhEgoXp11H1hBOPfeFblHuwHi
	 c35h4ZssPTxtZQuhiUBw760eeGbz4qUJYloZAQi8Ym9O0OA5Tpk2OtmWYF9d/oFkH9
	 G0jdLJJb5VeVtNi415ZHjQQXcHf50XdRpsQSwqoM4wvnpHe6EhwWqeTSChJgeyqj8i
	 RMB+Per1R40CTH6VWoTzf+e86XFdoWXW2wC6OfB4kBWhQ21s7DSV6cSVGf62l+Oszg
	 0YqL7fx1HbBvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B75C48BF8;
	Sun, 18 Feb 2024 09:40:34 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sun, 18 Feb 2024 17:40:30 +0800
Subject: [PATCH 1/2] arm64: dts: hi3798cv200: Fix the size of GICR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-cache-v1-1-2c0a8a4472e7@outlook.com>
References: <20240218-cache-v1-0-2c0a8a4472e7@outlook.com>
In-Reply-To: <20240218-cache-v1-0-2c0a8a4472e7@outlook.com>
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Alex Elder <elder@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708249233; l=1243;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=cM/+jwZOd1PTjdjnQjIchbxxptzvx3CBS8/AnT/3vpc=;
 b=/A9JI75VcknvkbU5W9gkLRmoqf1WJh/ohHjKqGbIMBsKkkK/WPK5yfIjww3AcQbSkUzL8JDSV
 NrPoGdyLs04AXuPMwP/6CSlzS2G1hIP7BvdWXE43WyHj2CAK/4lqJ+l
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

During boot, kernel complains:

[    0.000000] GIC: GICv2 detected, but range too small and irqchip.gicv2_force_probe not set

Looking at GIC-400 datasheet, I believe this SoC is using a regular
GIC-400 and the GICR space size should be 8 KB rather than 256B.

With this patch:

[    0.000000] GIC: Using split EOI/Deactivate mode

So this should be the correct fix.

Fixes: 2f20182ed670 ("arm64: dts: hisilicon: add dts files for hi3798cv200-poplar board")
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index ed1b5a7a6067..d01023401d7e 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -58,7 +58,7 @@ cpu@3 {
 	gic: interrupt-controller@f1001000 {
 		compatible = "arm,gic-400";
 		reg = <0x0 0xf1001000 0x0 0x1000>,  /* GICD */
-		      <0x0 0xf1002000 0x0 0x100>;   /* GICC */
+		      <0x0 0xf1002000 0x0 0x2000>;  /* GICC */
 		#address-cells = <0>;
 		#interrupt-cells = <3>;
 		interrupt-controller;

-- 
2.43.0


