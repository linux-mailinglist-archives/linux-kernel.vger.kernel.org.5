Return-Path: <linux-kernel+bounces-71553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991F585A707
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51AEC283B74
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ABD44C6E;
	Mon, 19 Feb 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahAItWfJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11C446B0;
	Mon, 19 Feb 2024 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355221; cv=none; b=YAyNjp+39h4qQU0hjr6F8I6m8IeRp2SuilpiXKTYIUl2gn5iHJV8z6IwDdmLtEUNQQ4rjtyWKLXSFCz4vJl/W0jCAfQTstC4MONGj4V2zDPY3LxZK24qfjuIYudGMNT6deO9dRQ0tw6xlsZcP9waDqxMqtdVjLpkSEi70y3NrOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355221; c=relaxed/simple;
	bh=0uD/fPZtAQRPWqpEsRxWQPIXiCQh3Fi1MJM8sSaEG04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fv5tme5xtreKtBdh0impc/GiJ/H/qIl4d1BXTb/ZRvgoXHrfy8rLAbncfekWEXoGCuvTOcACUMpiVFyCwLtoQvbK98D4PAYFYtGa3jIDgnRKiMt+kggh3TxXW5wbleC7j9iION/fs4yXin8N11ITeLoJar9c/446yYV6xRoB/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahAItWfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C25AC43390;
	Mon, 19 Feb 2024 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708355221;
	bh=0uD/fPZtAQRPWqpEsRxWQPIXiCQh3Fi1MJM8sSaEG04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ahAItWfJKxeo6GypLUSP8U/jf5k6cnNNEiVkRIN7dpHU/QQHSyUZX6+uoSYVPbvDO
	 WrZ7B0HTBd1Q5Lup3Sjz6ZU7avoO74SadNLnTY+R5X4GVbaYpQz2FpfL7lwRMXrRtq
	 uAIoH2vZeoK3G4Pio6cdmLv63Rp6IPiaEa8l2ndodRMUFVgxGwckLJ80PztdsqIJ2A
	 f1sDP8I1qHUXFqxofJ/sbzRH2lNBzlTbM0FIL4iwol1KwklsGJ+lD2GTHd6XvynyAl
	 uhTKG6IXF9kUisee/FiFsqWEsrW97B1c6LOi9W5bcfk9ywtZ/lauczwcZBSypeThrM
	 bUTYjlcZwOasg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B01C5475B;
	Mon, 19 Feb 2024 15:07:01 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Mon, 19 Feb 2024 23:05:26 +0800
Subject: [PATCH v3 1/3] arm64: dts: hi3798cv200: fix the size of GICR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-cache-v3-1-a33c57534ae9@outlook.com>
References: <20240219-cache-v3-0-a33c57534ae9@outlook.com>
In-Reply-To: <20240219-cache-v3-0-a33c57534ae9@outlook.com>
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Alex Elder <elder@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708355220; l=1236;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=Q7LcOT/VwpsuZcFlk8XRnwmi13g7rI7h0WTW2e9avFs=;
 b=Jm1sLBoWsNwRJnBJqT57uUsQ1DHPNPKwfkMsWU3hTpw3/doshoWyTEdH8NI4jO9bvXfuXAZ5F
 FGleHPqE4pEDExYWkqaZcbEFAOM4CmVWgzh11Fe/xVPEr+ime6GIurZ
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

During boot, Linux kernel complains:

[    0.000000] GIC: GICv2 detected, but range too small and irqchip.gicv2_force_probe not set

This SoC is using a regular GIC-400 and the GICR space size should be
8KB rather than 256B.

With this patch:

[    0.000000] GIC: Using split EOI/Deactivate mode

So this should be the correct fix.

Fixes: 2f20182ed670 ("arm64: dts: hisilicon: add dts files for hi3798cv200-poplar board")
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
Cc: stable@vger.kernel.org
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


