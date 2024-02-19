Return-Path: <linux-kernel+bounces-71554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E7685A708
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9442833C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B1A44C6F;
	Mon, 19 Feb 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAT3um3x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB169446B1;
	Mon, 19 Feb 2024 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355221; cv=none; b=lDe4p88RpJhRxWXOEjQGcMLXnyujVM+Lok5gY5kDauzJVjYkVG4jIKL+XcH0YXNwvkV18I0chqMplZStZQnFAgoSepLk5MSwLzk9ihTpGlg9cr+KM7VX4Dl/c++cGfdWJiw86kWzVWJsLb5ynTyaVnHJLhQd7wplhT4rAvojjqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355221; c=relaxed/simple;
	bh=RPUmB8TnTdVoKukhHeVUW8RKPIT3OlUDg9hq4euJK94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kVryB06vA/WUd08R5VZ/t9y/s7HjvwGeFMPbh8EEQzzhCsGIet7Yvnoe1jXjsQeNBVTujqAUeUsAqMFtwirXKUi8WDOg4vH2y4SZugVh08vIMhxEpAcLPc8hBA68b/5tJ+11rm751FU4Lw+VyRgqijUUXxBRblJcvC7j6qRY7g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAT3um3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EB31C433F1;
	Mon, 19 Feb 2024 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708355221;
	bh=RPUmB8TnTdVoKukhHeVUW8RKPIT3OlUDg9hq4euJK94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bAT3um3xqfYuyN9hwfSJ4Lbpf5VWebxr4RugixBwOTv294NhjsRe+H7RAZo+5/iSr
	 qg5oxkdTFTOvy+5R7fTLhaHepfhrLk7p1PXeMtecBxjrYf+EsBslfH+GmoaSR3ZBpR
	 d+5XUjDgGsZKwGGv2iCMntkgTIjgXHicuJzbsJOSJc8XUkvTSmLJ2JhfstVAkZpFrc
	 tzOAypEb2n9bE9kTmYze0lGfVOUhLz290P6IfLGrhw3gK5X1H+xWwyO+laZwT4F4sg
	 mviRy/anaEcX5LUC4wDIlLSUWa+P98F/FYDra0BsYy+0TIAhW/EBqpLfxq4C4u1Dkn
	 wwTWKQMo0uvhw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F72FC48BF8;
	Mon, 19 Feb 2024 15:07:01 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Mon, 19 Feb 2024 23:05:27 +0800
Subject: [PATCH v3 2/3] arm64: dts: hi3798cv200: add GICH, GICV register
 space and irq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-cache-v3-2-a33c57534ae9@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708355220; l=1117;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=oWPOXVSM7W5vHY31kDr4p2HrgQkuCpZx2sc6S9SlCF8=;
 b=/FnJ4jqTMm6uyoHP9rZXBktLTdCPZvHTR3101rtPQylnDigXhthwv/HvdBRI8vAaP5oYbRtqi
 QxY1QvVd/7jANK8eTA2Fker2F5B1Huf7MQB1rZkT31lnLt5M6F4+mqW
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


