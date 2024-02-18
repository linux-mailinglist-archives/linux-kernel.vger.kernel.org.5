Return-Path: <linux-kernel+bounces-70322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661FD859610
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61ACB1C2154A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6251418E0F;
	Sun, 18 Feb 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIPyyi5Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFFB149E15;
	Sun, 18 Feb 2024 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708249234; cv=none; b=NAKN5hUXnCI96ekTFAp0wVPZUxtzfIMpgKbsi2ZB3xqr3z2Qr4pYmSR+Xn5q6xATmR0TlyzFfc5d2RZZCAmoitI9udL53bY1mYd6Tks7M8s+ib9r8GBXhft0I+SmlFaCAYk980LWVcNfiPO8KNT1WFkgStVSwwkg44/4d0+ueSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708249234; c=relaxed/simple;
	bh=Y2yL2MQNl7y8iBg/28LLbPzlCYDMItit1WDiqTg7AR8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UZHa3P7iB4Y8FPGNthClMrOvP+wpqseaB3cqXbPaM+l9zi+NwdxHvypFG3+cu6w1inRCj9Bsd4BEF65RiZIAw2bA2r/ONBFxdgNR0F9VvAXwyqUJ9JKKUverSNqno11Pgl9PNnGuAIXVwKPAiXwvIANJCjKUYTNq5RuL8e7DGpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIPyyi5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CFA8C433F1;
	Sun, 18 Feb 2024 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708249234;
	bh=Y2yL2MQNl7y8iBg/28LLbPzlCYDMItit1WDiqTg7AR8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=IIPyyi5Q+VftsUKAquvijrRVhh8GyBx9jZ74iAHaTNkXivnEa7d745blyFXvccY13
	 CyTaIl+hPcctEKAiavUBCOowmVfvg/vTFxPFsUExdKQoMKx7OfIcJEG2rhKmXP+IE2
	 k3pvirZ8AmyE9TLm5L11kEBb8Fc2j2RWbfnA9OYZ1Li8kHoi/oePwTIfT+D97YM0Tn
	 hetcRdL/cUS8KmizGoAnuj9rTEx5zvFMTBqTu2CgrZ1bTfO6JmtzlobqzOjtRkuEdL
	 SiXiu95JSE7w8cr1RKPFUBRcZg+oJBr3RT3u2g5he5Dx+2pkEMFik14puH02XydmNm
	 aowlo6Btt8lIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E985C4829E;
	Sun, 18 Feb 2024 09:40:34 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH 0/2] arm64: dts: hi3798cv200: fix GICR size, add cache info
Date: Sun, 18 Feb 2024 17:40:29 +0800
Message-Id: <20240218-cache-v1-0-2c0a8a4472e7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3Q0WUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0ML3eTE5IxUXUPDZIukNHNTM7NkIyWg2oKi1LTMCrA50bG1tQC79Mk
 MVwAAAA==
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Alex Elder <elder@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708249233; l=1327;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=Y2yL2MQNl7y8iBg/28LLbPzlCYDMItit1WDiqTg7AR8=;
 b=EzwalVvQRDgmdAMHbQNlXT2iUSev7lM7NJ4H5zbxJQZQ6mLZu7IRNbdTgROodx4If5ifkW/Md
 +xhp0tJPbCaA4ajzfD5jG9+NTZnpZ+53fA3+S/6SrAMxiORlxl7NucD
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

They are tested on a hi3798mv200 board in fact. Though the 2 SoCs are
highly similar and the CPU should be the same. Still, Tested-by are
welcomed.

The patchset fixes some warnings reported by the kernel during boot.

The cache size info is from Processor_Datasheet_v2XX.pdf [1], Section
2.2.1 Master Processor.

The cache line size and the set-associative info are from Cortex-A53
Documentation [2]. Dts for other SoCs are also a good reference.

From the doc, we know L1 i-cache is 4-way assoc, L1 d-cache is 2-way
assoc and L2 cache is 16-way assoc. Fill the dts props accordingly.

Dear maintainers, maybe consider Cc to stable too?

[1]: https://github.com/96boards/documentation/blob/master/enterprise/poplar/hardware-docs/Processor_Datasheet_v2XX.pdf
[2]: https://developer.arm.com/documentation/ddi0500/j/Level-1-Memory-System

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (2):
      arm64: dts: hi3798cv200: Fix the size of GICR
      arm64: dts: hi3798cv200: add cache info

 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 39 +++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240218-cache-11c8bf7566c2

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


