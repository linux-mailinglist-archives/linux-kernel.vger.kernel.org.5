Return-Path: <linux-kernel+bounces-71552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3E385A706
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C0E280571
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47945446D8;
	Mon, 19 Feb 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT++SGvD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C3037701;
	Mon, 19 Feb 2024 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355221; cv=none; b=KiYqrRNMXzFT/A/FtNH5/hvWvKeTGKi3qCMqC3DG26c99SpFNxxw7OLYSQuiJ49H28jrK0CTl8hk1k1iRrnzdrsu9Sa9ZooWZwYOc038vcWB/MvCgzebhPpCHnxsQtsX0IQgu0/Ri/PRFo12djTuIoIyLkUbBAcTw84HXSQ3A0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355221; c=relaxed/simple;
	bh=utfcqhg+6zII+yQBPRsJUw/zhNmlWQJxo5cBdL99Jgo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oZiIyT7hmnPmAI9yjl7zA8nW63nXX4VBWM+gGawe018Yt7JiRmfuOgaoLOx9qnAHlpbRAKa+xk6oBGXKSRxkgg2jPpRv7tV4iYv8K55Sol2E2+gYCGC20OC6Ym+enjWVTKNtSvevN2SMRGt5RQtoYv8hqdh0zy53p+BJQOUx+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT++SGvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32152C433C7;
	Mon, 19 Feb 2024 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708355221;
	bh=utfcqhg+6zII+yQBPRsJUw/zhNmlWQJxo5cBdL99Jgo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=HT++SGvDsxz8u4VkBNjnD9qaA4FZ+16ZmIttmZ4pI/gyVmxr2FcobkDuKqZNO/Qz2
	 1bTbQhSeGEcshay3q8urzY6H4K3fbWL0wb3ZXYxmpiKRVkA7Rkqoq4fdZu/ILdEoeV
	 ZD+yoTMNoG85h+6L+LipQuNRJ0+b6FtVuED2xuh89RVo0zCnYdq5D+LefHie/8M38+
	 XbloGf+1KXqrCZjDSQ67+R4i69GjUpQ2JniSXYTixgVKwYkn0f5SnekzWvNSIaP/Ct
	 BwrO2omdPNuV935qrmeJLytVvijNXN7I+o2VWMjleDwTKxr5VK6gwbv7PbICUw7/4i
	 gYYni4SFZBHAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1476BC48BC3;
	Mon, 19 Feb 2024 15:07:01 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v3 0/3] arm64: dts: hi3798cv200: fix GICR size, add cache
 info, maintenance irq and GICH, GICV spaces
Date: Mon, 19 Feb 2024 23:05:25 +0800
Message-Id: <20240219-cache-v3-0-a33c57534ae9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADVu02UC/22Myw6CMBBFf8XM2prOgDxc+R/GRRkGaVRqWmw0h
 H+3sNO4PDf3nAmCeCsBDpsJvEQbrBsSZNsNcG+GiyjbJgbSlGvCSrHhXhQiV01X7ouCCdL34aW
 zr7VzOifubRidf6/ZiMv6W4iotCLWpjJ5XpKUR/ccb85dd+zusDQi/fUoedi1NdZCTZvJtzfP8
 wc0A9KW1AAAAA==
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Alex Elder <elder@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708355220; l=1734;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=utfcqhg+6zII+yQBPRsJUw/zhNmlWQJxo5cBdL99Jgo=;
 b=2PQbYA0iF6C0vZng2DScPn60GvXq/i3yJXMaSQS9RqK0McpsKIIUTJEWHyebhP70eiowmjzyT
 ts1Cd5ksH14D6ALeqqux240ihttaargZG1Jx7lBJ7WdqYcjDbTAX6sQ
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

The patchset fixes some warnings reported by the kernel during boot.

The cache size info is from Processor_Datasheet_v2XX.pdf [1], Section
2.2.1 Master Processor.

The cache line size and the set-associative info are from Cortex-A53
Documentation [2].

From the doc, it can be concluded that L1 i-cache is 4-way assoc, L1
d-cache is 2-way assoc and L2 cache is 16-way assoc. Calculate the dts
props accordingly.

Also, to use KVM's VGIC code, GICH, GICV registers spaces and maintenance
IRQ are added to the dts with verification.

[1]: https://github.com/96boards/documentation/blob/master/enterprise/poplar/hardware-docs/Processor_Datasheet_v2XX.pdf
[2]: https://developer.arm.com/documentation/ddi0500/j/Level-1-Memory-System

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v3:
- send patches to stable (Andrew Lunn)
- rewrite the commit logs more formally (Andrew Lunn)
- rename l2-cache0 to l2-cache (Krzysztof Kozlowski)
- Link to v2: https://lore.kernel.org/r/20240218-cache-v2-0-1fd919e2bd3e@outlook.com

Changes in v2:
- arm64: dts: hi3798cv200: add GICH, GICV register spces and
  maintainance IRQ.
- Link to v1: https://lore.kernel.org/r/20240218-cache-v1-0-2c0a8a4472e7@outlook.com

---
Yang Xiwen (3):
      arm64: dts: hi3798cv200: fix the size of GICR
      arm64: dts: hi3798cv200: add GICH, GICV register space and irq
      arm64: dts: hi3798cv200: add cache info

 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 43 +++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240218-cache-11c8bf7566c2

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


