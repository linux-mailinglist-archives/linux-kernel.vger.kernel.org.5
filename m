Return-Path: <linux-kernel+bounces-70380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F768596D6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 13:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016281F21A31
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 12:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2571A64AB0;
	Sun, 18 Feb 2024 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C10tmYII"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012863412;
	Sun, 18 Feb 2024 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708257788; cv=none; b=lrtGJRoxzaK5Y+cC5EwBIId2xUBI4fxIIcxDh7sdTNMvPI2La0WttXYUB419iYFxLDqv5ZcK6kWfmpVQlSy5gd2PCf3kjSc7Bf2P3cVpFSwGgJ25C+4h0A+b2amT18LHgVdl7e1zEuttE79R1RPldZvJMvtGtYmBPi7rX83l4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708257788; c=relaxed/simple;
	bh=RPUmB8TnTdVoKukhHeVUW8RKPIT3OlUDg9hq4euJK94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvrzf89Xv1NgR2tomwzuBWcs/S14d+aDl6yRqZQ59AdH9fW9hl0mQQM++XucaKwxZbUfy3PWkPRl7aq1NsFgp6kQ8omdRbJXJyl/+Yuatb2z1FLlXMXwiyyroDIUfVhlNuaCJTOBXvqrNmqcDBmt0BXb8QWoG45FQoicrBbTUKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C10tmYII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDAEEC433C7;
	Sun, 18 Feb 2024 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708257787;
	bh=RPUmB8TnTdVoKukhHeVUW8RKPIT3OlUDg9hq4euJK94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=C10tmYII47FOSk1mOrHEymRzoTTfZWyRW8oVUF4Q8g8a5ZlQk+Y6rT5vUJEArVCw8
	 OYm0Ko0x7HyVaRdow1RMMYUrWXT40KZydT5kOBtf8WGbMx3F3bqQm+KXuCh0NlxW7D
	 EPJVf04LMYF7VIWlgVJ41EC8JLBOh0ZVUFmvuxMgzrE38xiic2FRYOQNT52pQSpWIQ
	 OSMS+L/B+iyfyGQcjfv1YJveP/mqQJfzSe4DPdlT/hTSJ7279iBZa4lSIyPgd9QsQJ
	 LaMb5bUk9+Z1BWO+nRZLj0FavZO6QW6Fp8JBtB6Ofae8b6DJoAGeYMlEea1WQSjosS
	 1o9iZvIUOTVlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F6EC54766;
	Sun, 18 Feb 2024 12:03:07 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sun, 18 Feb 2024 20:02:51 +0800
Subject: [PATCH v2 2/3] arm64: dts: hi3798cv200: add GICH, GICV register
 space and irq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-cache-v2-2-1fd919e2bd3e@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708257770; l=1117;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=oWPOXVSM7W5vHY31kDr4p2HrgQkuCpZx2sc6S9SlCF8=;
 b=YbBBZa81olla9r1dJqBTLzU5eZwlr9EMPAU11UChDqur5df31Kx/+zKUl+9eMR6I2jiXr8mlW
 b4PZ90CnhK9BmpzF3yRdh+HkmJCb9f7ZfAsvKVslY2q6zD8eJ4GMr4D
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

This is needed by KVM to make use of VGIC code. Just like regular
GIC-400, PPI #9 is the hypervisor maintenance interrupt. It has been
verified.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index d01023401d7e..fc64d2fa99eb 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -58,7 +58,11 @@ cpu@3 {
 	gic: interrupt-controller@f1001000 {
 		compatible = "arm,gic-400";
 		reg = <0x0 0xf1001000 0x0 0x1000>,  /* GICD */
-		      <0x0 0xf1002000 0x0 0x2000>;  /* GICC */
+		      <0x0 0xf1002000 0x0 0x2000>,  /* GICC */
+		      <0x0 0xf1004000 0x0 0x2000>,  /* GICH */
+		      <0x0 0xf1006000 0x0 0x2000>;  /* GICV */
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+			      IRQ_TYPE_LEVEL_HIGH)>;
 		#address-cells = <0>;
 		#interrupt-cells = <3>;
 		interrupt-controller;

-- 
2.43.0


