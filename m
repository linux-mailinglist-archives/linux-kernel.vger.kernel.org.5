Return-Path: <linux-kernel+bounces-60656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 081B185081D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E601F22A1E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824B6482DA;
	Sun, 11 Feb 2024 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBDMlzPJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1AA4C600;
	Sun, 11 Feb 2024 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707640239; cv=none; b=bsHlJm0XugTN9Iw+UBqMnI0sHkjvvbQlV2vfPQ89hi/W5ecA41KdCHPRdqq22yQL52u+Aa9TJS+eXtdFeGXprCUHX+a8gF9nCmvSsw5Nfg/STG9JkiuC2tF9i7spXhAJJKyLl2XaWI/h0OReMKdmneMCmLo8t1TbERwinIpOIjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707640239; c=relaxed/simple;
	bh=P5YLYD6H2barwQbUJyuy1ic5ANsbxNgTsIlabr1argw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxMIkW6Z08g5jXZcLLy+qi0fHMqP0qcZlz/JbRM+qsYfGzCpJdsRRCJSTYS+pLeeU0LWXDhVJ7txAfbU18TyD4hRRKFOUEufOfo7v6XtsObQqXZ3aGW8mjuPWBiGNQFJ49LeKcwS5M9a78/o2beNag7Y7uw8JGKSq9QfvD9V7Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBDMlzPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082B5C43390;
	Sun, 11 Feb 2024 08:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707640239;
	bh=P5YLYD6H2barwQbUJyuy1ic5ANsbxNgTsIlabr1argw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dBDMlzPJR/r2SJfn/2zj0UVSerbZCfru09XO12kY0UEpIywVi5IEFrqZFUtXLtLyj
	 AqchY12D030mG4uQmMBKfnMEr7CAmkX7RyWhq+lyvX+C4BdEDKNOJX3nvlSDQndWcV
	 hYBAgsBy4oMrTs91I6J5ehwJIsRoXsAmTWximuqA02VDFZqiaq21BOowvRLbPvVx2f
	 jKKtpcuGgwjciZZ4V1oKDYO4Vk4oaGfSA3SDptgLzfvZ/2/3kprL3Ons46D7HfDIhL
	 WzPvy3t6WPqeK245Da6ksmrc9wQd9ad7W+Nbi8WWnipBqO98QyptnNv4uXfWKdLu1B
	 P1JK64R8YDupA==
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
Subject: [PATCH v3 1/2] dt-bindings: arm: sunxi: Add Sipeed Longan Module 3H and Longan Pi 3H
Date: Sun, 11 Feb 2024 16:17:38 +0800
Message-ID: <20240211081739.395-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211081739.395-1-jszhang@kernel.org>
References: <20240211081739.395-1-jszhang@kernel.org>
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
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
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


