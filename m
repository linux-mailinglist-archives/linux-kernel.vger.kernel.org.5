Return-Path: <linux-kernel+bounces-70321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD0985960F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1411F22044
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5203418E00;
	Sun, 18 Feb 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCnzg6Dq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B97B149E02;
	Sun, 18 Feb 2024 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708249234; cv=none; b=ha9FGkQsZ2LCxtEMMm8lzrfH6dKjAvYIwUUzCTWtq1hlgSUB5/DFjoub6LA2K8i/lNHHge39gy+k+3+JaluhIPhG5BgUAetIvVvWH7ywRUyuWVhJO99iW5vAKHSnLoYXLAX1ePye0PEnMC9ZgO5MGf25erVCEnYBmHRB0r+4U2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708249234; c=relaxed/simple;
	bh=Bj/bQ2trWxsygHgiKr1seous7X6UroCh0ciTtTi41Fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GKBJZpPLlslSrTo4qttr0Sem5p0GLEptyKH8KKs6Y4CylduWqXLBBKUMgacCNLAWXXio8jV8nZoN3bpuRuzNFKpjDUZsvdogOdV5x0RH+Cn3n2NgrEfEAVCmqZuZnZmXLeGUSlNMuA9mokiy8H1WiNg7E6c6y8N1CxBZ8083Y4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCnzg6Dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C0DFC43399;
	Sun, 18 Feb 2024 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708249234;
	bh=Bj/bQ2trWxsygHgiKr1seous7X6UroCh0ciTtTi41Fo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SCnzg6DqpN1VlV9sEoiPAv/1js7cezWgZLDm9Q5+6yGe0yQncX/dEzxhR5W6epVqz
	 56FB92JZlUGPurZgyQXxzEO2NIwXAN01Hx6SzwWFrr5EDhBwdUowQtzQppIfJ1jIRD
	 6L1JaZ92cmstDwfaBXKhd0rXk/yKOWPGduJ8gtJnb2YAUfesdRDasCecgUNZ6B3hHW
	 BMch3/8/2wRQXqXjoLj68UPz9mdnIE4kFxY8ckl5saPnJ7YxBqnpeAg/+RcUZdul6/
	 118bqLt7XzUKIlUCSdCX6z4fM8e6nobS1JNGd7luOg021dJqF68xy025ZBa725ar5M
	 jWqbtniKbRe8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3595CC54764;
	Sun, 18 Feb 2024 09:40:34 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sun, 18 Feb 2024 17:40:31 +0800
Subject: [PATCH 2/2] arm64: dts: hi3798cv200: add cache info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-cache-v1-2-2c0a8a4472e7@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708249233; l=2811;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=7KtnkY7Pm5plqx77OK2FVNdCRnse/+VsWvkr9ingato=;
 b=JgA/U1XbhkecOKg3NeY5nWpK5pQs6KzWIhJQ7X5xYdZ3SEesjg9+XYCBOp0+LuD/DF19H6XYU
 Vv1JSbzdVzpDkyQ+MyZfC9+r5HMNAtIuLJYhviNxsTYQACEzr1IuWHB
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

During boot, the kernel complains:

[    0.044029] cacheinfo: Unable to detect cache hierarchy for CPU 0

So add L1/L2 cache info to the dts according to the datasheet. (32KiB L1
i-cache + 32 KiB L1 d-cache + 512 KiB L2 unified cache)

With this patch, the line above is gone and the following info is added
to the output of `lscpu`:

Caches (sum of all):
  L1d:                   128 KiB (4 instances)
  L1i:                   128 KiB (4 instances)
  L2:                    512 KiB (1 instance)

Fixes: 2f20182ed670 ("arm64: dts: hisilicon: add dts files for hi3798cv200-poplar board")
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index d01023401d7e..33ded6b97f61 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -31,6 +31,13 @@ cpu@0 {
 			device_type = "cpu";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			d-cache-size = <0x8000>; /* 32 KiB */
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>; /* 32 KiB */
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
 		};
 
 		cpu@1 {
@@ -38,6 +45,13 @@ cpu@1 {
 			device_type = "cpu";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			d-cache-size = <0x8000>; /* 32 KiB */
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>; /* 32 KiB */
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
 		};
 
 		cpu@2 {
@@ -45,6 +59,13 @@ cpu@2 {
 			device_type = "cpu";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			d-cache-size = <0x8000>; /* 32 KiB */
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>; /* 32 KiB */
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
 		};
 
 		cpu@3 {
@@ -52,9 +73,25 @@ cpu@3 {
 			device_type = "cpu";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			d-cache-size = <0x8000>; /* 32 KiB */
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>; /* 32 KiB */
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
 		};
 	};
 
+	L2_0: l2-cache0 {
+		compatible = "cache";
+		cache-unified;
+		cache-size = <0x80000>; /* 512 KiB */
+		cache-line-size = <64>;
+		cache-sets = <512>;
+		cache-level = <2>;
+	};
+
 	gic: interrupt-controller@f1001000 {
 		compatible = "arm,gic-400";
 		reg = <0x0 0xf1001000 0x0 0x1000>,  /* GICD */

-- 
2.43.0


