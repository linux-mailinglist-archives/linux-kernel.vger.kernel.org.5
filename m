Return-Path: <linux-kernel+bounces-12739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE8481F97F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB411C21E27
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35C7101C0;
	Thu, 28 Dec 2023 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2f+35dD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2372E101C1;
	Thu, 28 Dec 2023 15:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BAAC433C9;
	Thu, 28 Dec 2023 15:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703776183;
	bh=mGxTH6p5jBX4gADoMF5pkoAX42XpqpwCDCmjdKTMyAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M2f+35dD6QEMZArOJez3a+/jjnPrKlMTqmhahD62L1K7PkeyNd+XYVGxFVDEX4Jyf
	 Qc7sThFnGLhGQCc2/sjcjKr3Q8VHV9iFm/x6WNz0pqWcpI01oYcC0isrOb5Xg9r+qq
	 8EI5XXaPuJooewtbFMuPyFIOGm5b4+7EU0upUYA3gv8oEgxz1I2AbPGTwO7CdfWy1S
	 4OrYmFPRZ9aj8VWonwVbawJ3nO3mGd/sYgIg/mvy9ne6R1LBjUR1phrvk+LlKwBI/i
	 91S9RqPjJJ/GYYQfyonLSg5tDh1xFesTg6mc9ziDq5I0jO+YJ36PeOM1MOMZcehINi
	 h7nwa6y+FUmQg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Icenowy Zheng <uwu@icenowy.me>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: sunxi: Add Sipeed Longan Module 3H and Longan Pi 3H
Date: Thu, 28 Dec 2023 22:56:46 +0800
Message-Id: <20231228145647.1470-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231228145647.1470-1-jszhang@kernel.org>
References: <20231228145647.1470-1-jszhang@kernel.org>
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
 Documentation/devicetree/bindings/arm/sunxi.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 11c5ce941dd7..34d8ae484e01 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -835,6 +835,13 @@ properties:
           - const: sinlinx,sina33
           - const: allwinner,sun8i-a33
 
+      - description: Sipeed Longan Pi 3H board for the Sipeed Longan Module 3H
+        items:
+          - enum:
+              - sipeed,longan-pi-3h
+          - const: sipeed,longan-module-3h
+          - const: allwinner,sun50i-h618
+
       - description: SourceParts PopStick v1.1
         items:
           - const: sourceparts,popstick-v1.1
-- 
2.40.0


