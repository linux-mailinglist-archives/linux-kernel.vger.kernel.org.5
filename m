Return-Path: <linux-kernel+bounces-70378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2A48596D4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 13:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8D61B22000
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 12:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3B664A82;
	Sun, 18 Feb 2024 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFgJRQUE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD44EB55;
	Sun, 18 Feb 2024 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708257788; cv=none; b=e8gRmK4Y1nUsqBS6FFmsBETH7cjckNJKNIaCIVSj1/DSLTvLG/2lu4tEdVNGWAIf0Z/CU5tbcbd+bZ51sMz3K5OYrntxINUspIoSE4iiEM4Miog+WHV65rPtAQkeqhPD/rxq/V1Cr8RIrQK9eD2poKiDkuivbP59RB6G1WAm9zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708257788; c=relaxed/simple;
	bh=g/cYia/nzuVeyrMQsTsvao1OEQbnaDqgWqKJyaK7rY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qMRzoxoVI1u1Q3PH+x45KYV1ehV5xJqCmHpsJ+KK9CCVIS+nymtDRyLuJhZSjhnUl9pdHsIfe8RpfHoJG2yhZP9083otTC71VPNuQc+eOe0andcwavK/rDbK4MGchpp0bAqb+T0ijY4h0sEMTGngnbchMtguwr+p/7IiLzBr8P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFgJRQUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1FF9C43390;
	Sun, 18 Feb 2024 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708257787;
	bh=g/cYia/nzuVeyrMQsTsvao1OEQbnaDqgWqKJyaK7rY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OFgJRQUEY++TYLS206WQNO+jt8L+7q6Gmudd9RZLe1c7+gN92qdBgXuXcwkuyA9gA
	 e3JIv5D1AgaCkpgLcNOBWtBhn2FhHMPFShzNQN2o9odSb7mJF8BRP77xFr4GfbzBe2
	 7g3SBGFOaKHtT5WazFISJ9SpUVOrQ79XU+YJdLH6sgIETN7J1Yh8st1m2jbpUgOLMW
	 Ik5yO9/yNdW+GO7OCPgRNlenbcUNnug6L0JQLM4QX95msoTAEm6TkbeYnbgBgR5XvJ
	 GWS2tZi63d4XFvuibZDiRVqrUN5LfNegxdxoUzO0XR1o7qG8xoLICqt6+Ga/8LcGgw
	 8nHU/gxmVDj7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F3DC54764;
	Sun, 18 Feb 2024 12:03:07 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sun, 18 Feb 2024 20:02:50 +0800
Subject: [PATCH v2 1/3] arm64: dts: hi3798cv200: fix the size of GICR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-cache-v2-1-1fd919e2bd3e@outlook.com>
References: <20240218-cache-v2-0-1fd919e2bd3e@outlook.com>
In-Reply-To: <20240218-cache-v2-0-1fd919e2bd3e@outlook.com>
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Alex Elder <elder@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708257770; l=1243;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=cM/+jwZOd1PTjdjnQjIchbxxptzvx3CBS8/AnT/3vpc=;
 b=9ye8m+R+egKhjC5UJ+pb6xvl8IP230gTwbautYtnWhtxuD4VgdJgtFjSOfy8w1OnxjZ/Xfz/d
 3/khw/OdTQlDHls8FP7JFJJ6nhA2eFmRHIk3RuxiJkK8AssUaCT5xFy
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


