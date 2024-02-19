Return-Path: <linux-kernel+bounces-71555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 963E185A709
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474E4283BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DF344C70;
	Mon, 19 Feb 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGIJ8r5v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6E0446B2;
	Mon, 19 Feb 2024 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355221; cv=none; b=C3cs2VcNHRqppddP15jW9UREtMFGuJ/QF37skPv+8vKQMX+TO6FfTlciKodp7IbgjP16oSlrMhrzGn51BUKfY5H89r5jJZ7WQOWeFXz7gMQYBdJxyXKW5HBiMlYcs7AakKZZN9QuR+nGLreZi/BNYy/Ct852KFaRgJs7tgavw14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355221; c=relaxed/simple;
	bh=ZMHx0vXY3BCnqeeGRXitQ/9VWNOaOqi09FTpVeOGZiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T+8Ykdt+PrVvUSyNxsEXRO2Tb5ZVwhPvYe8yaTkKKUT1DSiqEh2VylAxYdqnrG62nzox2wwhFlMmhKsfRwSCfYhakO27Ruj7NNqEP2ajRzQolixr+q0Ah+f8/JogWkK4RJcz866x53DgiRGYzyYhd3FgazEzpL/ecso6I4PEo3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGIJ8r5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E83BC433B1;
	Mon, 19 Feb 2024 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708355221;
	bh=ZMHx0vXY3BCnqeeGRXitQ/9VWNOaOqi09FTpVeOGZiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dGIJ8r5vC/Wom7KdLtQbklUS/MgZliqOr/U2dp4sUTRNlGJnsukNQJpAtFMWtab2P
	 54jojOTACU+x7Tzi+fU92Lj/pgKXs29YflQ4N0nNeiyoKC6/2sIOwin/xvHsg56UUO
	 uNZ+IjhqhZCcqEucwoAIBwH0zJs0sZqMu8jZtc8IQCTmfPySsOibgCo92Qcy0v8k9X
	 V/cMqJNIsUp0UjtsOSV1vdDnkwKsso+ab1rN3gPctQEyFxyYNVPLnoTskMZkRGAfhS
	 kUDgEkbRiHRs7Edceu/bcRulUtxNEMGD70NeqXD4ZPIDJBskMY/oN6mxSViG78VrH8
	 fUu8PiHdqM+fQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B41C54788;
	Mon, 19 Feb 2024 15:07:01 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Mon, 19 Feb 2024 23:05:28 +0800
Subject: [PATCH v3 3/3] arm64: dts: hi3798cv200: add cache info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-cache-v3-3-a33c57534ae9@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708355220; l=2828;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=JCsSJLmRtX8xpTr7tVRxOMtB1SM8sQgXyZwjBU7p06U=;
 b=xqgpLfoVrqGs2VoZ+PuH1dOy0Z9Fq4MUu+Y3kHKp1cEtduRNLeydUq8AxTXjj8so/JunkHLKW
 Q8mtsMytX5+DXoRi5eQY8ceAPKRU3PIgKKnWzdSWoZKfDdtYhrLPDqF
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
Cc: stable@vger.kernel.org
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index fc64d2fa99eb..f6bc001c3832 100644
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
+			next-level-cache = <&L2>;
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
+			next-level-cache = <&L2>;
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
+			next-level-cache = <&L2>;
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
+			next-level-cache = <&L2>;
 		};
 	};
 
+	L2: l2-cache {
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


