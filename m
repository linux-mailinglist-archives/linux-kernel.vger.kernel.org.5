Return-Path: <linux-kernel+bounces-70381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6B18596D7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 13:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78EE11F21AF0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 12:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD3664AB3;
	Sun, 18 Feb 2024 12:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5j4LxXL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6017D634E3;
	Sun, 18 Feb 2024 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708257788; cv=none; b=ID5dabY4jZKI8TiiS+5L3+npCWloaSfOXIe9CK4p5HLhSRi54OiXTH6yfOK9fD12zWn5pL6Sli5gGejLbSL6id725OkuPtcEzxUYtE6tSOiIkqNxVJ8T0U0CPFOZwLJBRhAUzg/+lU8U7u7Aw/zGB9azFJ1FN5E+XhvhsFzPUCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708257788; c=relaxed/simple;
	bh=2m0qq0O3uPCadp8spW3+jjkA33xPSYEwfEwk38XWt6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZWXS0fkUanqDfcyeNKLb+Nkfa0DsELHr5Yq5iDmPG+oXpQTP1esmZ2KC0dTONhHNhUYuoPfaxZA9fw2orY21ac7ixuJb0qmTSe9N1k2Gpcm238FG1PuBapHX8lRbNPlyyK/mYcXaZDZUhn9xuM1oxzcvkc1jjCYjeVKYj0hyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5j4LxXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED6E1C43394;
	Sun, 18 Feb 2024 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708257788;
	bh=2m0qq0O3uPCadp8spW3+jjkA33xPSYEwfEwk38XWt6I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s5j4LxXLLlK6oe6Vr3Qi7HyMsudpzoibNLNHpiQbCNbhdRlZ3UqSQQdBed7NN1JdN
	 LLP8Bf6oFr7C/EEDUUlrDwe+OF++yUEq9rzgTPf7JYJk/J15ahsoaCHJY62mnJr+FO
	 JzrEXTjuZlpKzZM8xU0jXj7YrxFbeZEZHb2/wWnaeGGOFkavlK9m1CSoz6nJRldtYF
	 OdY5+AY4Q5O8rjhrQg36n4dHq2lWKi09CKLCsqlAP7kdPLKkRsDJ2nd+8+wjw7YrDJ
	 Mm1B6Y9bisFa3SjzHmLo5ul0TflLWxdRsrE7bJnrCs2jj1XPSNda7spGAjOTpyeEa5
	 Wgel0Y1mDf+lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE386C5475B;
	Sun, 18 Feb 2024 12:03:07 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sun, 18 Feb 2024 20:02:52 +0800
Subject: [PATCH v2 3/3] arm64: dts: hi3798cv200: add cache info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-cache-v2-3-1fd919e2bd3e@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708257770; l=2811;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=JVX6c8jTFahxkecrZwVOU639nIRHmAeZFLG8nHeqRQM=;
 b=JfVOap8CG+9J+E/Wm9alsBTwAWzwAa30YeKl9pEufes8+h0zju2JexaoXi9zJ24xOTA6Ym/tx
 3BKeMaXqBtQA/Lc5JcMCrWHU37OQ1tA6/S3j7lG/WBT03JlR3QilC2D
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
index fc64d2fa99eb..0a9533786f50 100644
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


