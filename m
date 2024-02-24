Return-Path: <linux-kernel+bounces-79875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B902E8627D8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49998B2194F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDC354F8C;
	Sat, 24 Feb 2024 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmleCXU/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE250A80;
	Sat, 24 Feb 2024 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810396; cv=none; b=ExKASN0BXIa+LfIXh5zsCNFT8TLFNSuBslXYsI0K8Beb923pm+qhydxjSPOo0vjbQRw30KRMx8C2l6uSI2fZaxyQm4lVhYNtOoaOb8O3byWxdkea1k1epXxbsOFqNnjPNem8sNkBw28kOnN+tpEFKEcAnv3KrRZqZ/cb4M+pDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810396; c=relaxed/simple;
	bh=4k5fPYp42gH3QLf+/maLO3ezxAAlAX85NAtYohge+G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLOdr6QOjBjlsiWW6H40owcSQXEsYhggJPXx5ipj3p/X/tWNF0m4aqeiOKLLSg51ApCWACTZxRtMfZLr7F58TgKNp/ERVfRQVoWvkzbMjREt3kgGm2TEX1UExMDUKYYeg7Td+Ax6SoIK2GB8gFPMkS0tfzV0921hssaGpZQ0my8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmleCXU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131D6C43609;
	Sat, 24 Feb 2024 21:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708810396;
	bh=4k5fPYp42gH3QLf+/maLO3ezxAAlAX85NAtYohge+G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fmleCXU/t8V0jrOZUtQTkApfX0xT5LbeQZ9jCZ5dzH3yYUeO4shKdgR1aXUQqeecL
	 NXxmvkRBDdRmbp0jM/9+C06mNJWi6qlusLDqrkW7iO3pHCrbXt4fDBa0gucDroCuyC
	 0uOIkNmH3tKp63gBQt8m2SE8SYktRifv8a/Bp9TdJR2etOja+coyu8CNFFl4p7e9pJ
	 VC8Tx5yQFQMzXfT7phNpVCRbeO0vFk4fsJYfE9hmRlDAUWC/fXwVuVvRTbPLNSGede
	 eBMQRfKe42vbB4IWjf/Ywp8e2g25Db3CtBImwLaXzVtpk9+zZztbmwsoiQ0er8mMwg
	 rhGVQMz4AUFCg==
Received: by mercury (Postfix, from userid 1000)
	id 3F95C1061140; Sat, 24 Feb 2024 22:33:10 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 14/16] dt-bindings: vendor-prefixes: add UNI-T
Date: Sat, 24 Feb 2024 22:29:46 +0100
Message-ID: <20240224213240.1854709-15-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224213240.1854709-1-sre@kernel.org>
References: <20240224213240.1854709-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uni-Trend Technology is a manufacturer of measurement
and testing tools.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1a0dc04f1db4..e945e76696c2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1484,6 +1484,8 @@ patternProperties:
     description: Ufi Space Co., Ltd.
   "^ugoos,.*":
     description: Ugoos Industrial Co., Ltd.
+  "^uni-t,.*":
+    description: Uni-Trend Technology (China) Co., Ltd.
   "^uniwest,.*":
     description: United Western Technologies Corp (UniWest)
   "^upisemi,.*":
-- 
2.43.0


