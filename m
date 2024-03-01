Return-Path: <linux-kernel+bounces-88150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE7E86DDEA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5D81C216D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AEC6A322;
	Fri,  1 Mar 2024 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="S5DkjEqf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="pu3ZH6CI"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6986A33C;
	Fri,  1 Mar 2024 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284471; cv=none; b=f8WkQUNXx4rHm2uMy8RK6YJN6YyE2VVFp14TTMJwMtsPOg7WC/s4MSvyr7C4OzBpEN7YUW1ZaHJ5C9A68Wi61P68nokhBvBoJoKT+XawSd6X4K8IwJPUhd2L8K8NO0PaShGh2R8LoQkIVIszavHXHGL4MFXy7Ohb8qeREd2HzZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284471; c=relaxed/simple;
	bh=XGjTdZR2rJ6NF8Kb1+Wm6lixYVJIXt3y/YzRgj1p7rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lTNGhNrbFlyhBLYf7R3qbByAqVDh/NEQSfgVpJ8CAz4+wVEL3VXYYvzCq8755Xgy5MzUS6/oI9vXmQ2JC7RitqxoetW5GBjkfNijB0lh22KxVBfB/8xhmAsDTZWILDfU+uf4OnVwpPUYfhK4bNJflaQsCMOom/cuZountQ9g4AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=S5DkjEqf; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=pu3ZH6CI reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709284469; x=1740820469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bzeXIprzlHg1nFVTjQGVxhMB4poPZJof1rFr0PREwOo=;
  b=S5DkjEqf47/6s2mzUy9wOSfGAV5eOSdIO0YdR3jvZPjJDE5hrjQCJPvl
   uGH4cGRPN+kXfOiVPFexUbabPIWnsRW2Smk03z+QyhkEmOczL97tv7Q0R
   amRT9IT9Q56x6Q9CYSAVMkfEA41PDcdEX+yS4bcGCoGOK8h6KZ8enL+iH
   IjmBq0GJOu8zLjE8mFjNsZImOqje6uGFRMh7VeOTRJnQU3Xd3EBTNpSka
   in3pGHkUGcmeZ0QyeUqf212+oCE1ZRClrnXTWVCqGVWKRWMtvJnNGTNfF
   uEu0aIJ5VZQ72i+K8NsdQOGwpwn9yFKJQ1GOUiNXSQM7MpVcC79c7r0oJ
   A==;
X-IronPort-AV: E=Sophos;i="6.06,195,1705359600"; 
   d="scan'208";a="35682435"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 01 Mar 2024 10:14:27 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8E7E117341E;
	Fri,  1 Mar 2024 10:14:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1709284462; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=bzeXIprzlHg1nFVTjQGVxhMB4poPZJof1rFr0PREwOo=;
	b=pu3ZH6CIp+ye6gkRlk81ods5UqJdgVpHnC6vDjgYBt8vM8+IUPrttmpMoFEMDQC04uuq7v
	cwhUHvWVZhPy/+k+fVEfCDBlGGRR7iyTljTCyGgGRjIkUWVnZLcPmmOG2nY9nxxg7LXVx2
	n5ppVJfBP19zmzVOd+LK6hTU8lWhWanDAwnaRRKIOYX3VcruyCpXVP9b+YAxmMLWafcQJV
	kCQaTsiNCLzLH8Pd/KYRvl03dVRt5kIrPPnjVnDTuKXZwGRhra+GDkhj5oWKy23Qicxjnm
	ITj2F0Y8sJQdZDs20aZr1TyMSfTEuxspoRRcV59T2AANOo3ImMA2wq6MXDP/0Q==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: [PATCH 1/5] arm64: dts: imx8mm: Add empty DSI output endpoint
Date: Fri,  1 Mar 2024 10:14:09 +0100
Message-Id: <20240301091413.3050689-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301091413.3050689-1-alexander.stein@ew.tq-group.com>
References: <20240301091413.3050689-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Also add a corresponding label so overlays can reference that node.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 22b813f6d8405..dc8643d899612 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1168,6 +1168,13 @@ dsim_from_lcdif: endpoint {
 							remote-endpoint = <&lcdif_to_dsim>;
 						};
 					};
+
+					port@1 {
+						reg = <1>;
+
+						mipi_dsi_out: endpoint {
+						};
+					};
 				};
 			};
 
-- 
2.34.1


