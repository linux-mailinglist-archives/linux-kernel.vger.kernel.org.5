Return-Path: <linux-kernel+bounces-51082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CA0848640
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B83BB23B39
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 12:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10A45D919;
	Sat,  3 Feb 2024 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbTDN2il"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB902748E;
	Sat,  3 Feb 2024 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963884; cv=none; b=gWTWE846ZZunVSgL1N1BEomHACNk7ZhkDfXc3NnwFkdvdGpVlaGNnr6Ko39U3a69A0CTJRe03brCnoojqp7ifdsZe288JJWz85eDZ/sB5tUlohN+IC2m49Wd1m+yZ5hxQnBTXD5OIgOFKEC3JnQRBdKc5O1RYr0qO8F7Nyb9oEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963884; c=relaxed/simple;
	bh=H/bu6BKu4henAxKurhmLapVwIutG4jc8dd1VxLB60rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcdjtRQYr9sc2f8/DY8H/DmqnCIHyQtvIyGzGlbKcn0LVP4K3NLVAZStOL4iBwyvD5+xTlRgjgYHNIqTL3XUooPteE/6Mf7gJRRi0NqKFLZGHS/FvepU3bIjGTjU8Fx2PoiP4az5nx841JMTHkFJ2Uc6SWl3VHRKx3XGTi+dBDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbTDN2il; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D978C433F1;
	Sat,  3 Feb 2024 12:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963883;
	bh=H/bu6BKu4henAxKurhmLapVwIutG4jc8dd1VxLB60rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QbTDN2ilh2/ZQPRk9gBZM973guGk67ZfxKTGFguZrj1c8TAgL8k8+unpUc/mxax3q
	 /utiPBTlWPUetVvLsaf0MPl0EmxpsPwMMR9poNAN1F8Lte76AiqtZ0my+9w65GZdAq
	 l1gflAMU7VGC5xxxpsoNl7lr8pCJ76OAVBClJs1T85H2lwtlt8x8meiRKc9phvVWMG
	 JvwbZaCHNTx5FFhRhRzcmEiPSdLyC3yqv9Z0FHUM8QfHCKhZwmvtZu3BMUaa1gH046
	 /M08QxnxgzZgBDeeFB5dpSBTglCPNwrWgNCVuMqohnJmb50KgQtPN5Zf9BnlFZozlz
	 40dJ1T90csV1Q==
From: Jisheng Zhang <jszhang@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: sunxi: Add Sipeed Longan Module 3H and Longan Pi 3H
Date: Sat,  3 Feb 2024 20:25:00 +0800
Message-ID: <20240203122502.1259-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203122502.1259-1-jszhang@kernel.org>
References: <20240203122502.1259-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add name & compatible for the Sipeed Longan Module 3H and Longan PI 3H
board.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index a9d8e85565b8..a97d44ba10ac 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -835,6 +835,12 @@ properties:
           - const: sinlinx,sina33
           - const: allwinner,sun8i-a33
 
+      - description: Sipeed Longan Pi 3H board for the Sipeed Longan Module 3H
+        items:
+          - const: sipeed,longan-pi-3h
+          - const: sipeed,longan-module-3h
+          - const: allwinner,sun50i-h618
+
       - description: SourceParts PopStick v1.1
         items:
           - const: sourceparts,popstick-v1.1
-- 
2.43.0


