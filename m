Return-Path: <linux-kernel+bounces-137928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E0D89E9AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BC81B224C2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE14F168D0;
	Wed, 10 Apr 2024 05:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MdYUda89"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03F8B676;
	Wed, 10 Apr 2024 05:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726761; cv=none; b=D7kUYV96zUg96h+iw1G4CYXddbsI5mHAJbY3hu5shFv+BwZJdZXwiP24JqAd4WzLQ4QzUiYvXDoHQOGfyIrPFGwb/h1MVzqYcbKVlxZRkOHuFRN+nmrazvYQ0LVAv4xIsh2PUYIRE5nL38B3NF0dCFRDYw1CKOXTlb9lK6IaxoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726761; c=relaxed/simple;
	bh=uemkmvspv5ZB3wuB0TCGG9ab6fnYyfqgNmfpNNRHrkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r5GWiZN++IgdF0oDifW25iswzTeu52vyWvdZvKLCzMCssXI76JZBgzQZZzG6wkVUo5lAKy4IcjTiGj8X+q1i1am7xIn7EAsuvfX/gV0Q9Tfl96J9HoOeCjmdtd/MJZx5ZTx2ex6vAiQOeP6kjFuuixaxjwaf3ZQ0lBdsNsU4Heo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MdYUda89; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C971920003;
	Wed, 10 Apr 2024 05:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712726754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pp6MTv8ndXhkZFAi0mOWfa7deuiDrn7kLeffrdA5z5g=;
	b=MdYUda89nrrNToShetXSgAldJEpsyLQC36tFBUb/UHYzTsDvcF/BeLK/p0FO+at1aNg3xu
	hj1ABRJmB2DsWkUGLeICvDT969+zaoqPWc7lcD24sfdVf2Q2Bxyol5GbJBDDG7LdnCSgQY
	/9i6U7Z7vMnyABs5DU9z9yxF91zH9PBgYTnNNGTtEBICU7C0JPKRgkaeitRg/ygtX21lVL
	YcJQDPO1zYgrn2hgtIKtnwaOfMntWL5HVIGfGz/SLTX85pesxhDtHt0+rtr3M00TclMd0s
	VMjCT0KwDMAlCILpVPCnBUS+0XHx1yIjNGx6ttOqW5DR1p1J6EPibkMB4V8vMA==
From: michael.opdenacker@bootlin.com
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: riscv: add Milk-V Duo S board compatibles
Date: Wed, 10 Apr 2024 07:25:17 +0200
Message-Id: <20240410052518.2945789-2-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410052518.2945789-1-michael.opdenacker@bootlin.com>
References: <20240410052518.2945789-1-michael.opdenacker@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Document the compatible strings for the Milk-V Duo S board[1] which uses
the SOPHGO SG2000 SoC, compatible with the SOPHGO CV1800B SoC[2].

Link: https://milkv.io/duo-s [1]
Link: https://en.sophgo.com/product/introduce/cv180xB.html [2]

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 Documentation/devicetree/bindings/riscv/sophgo.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
index 9bc813dad098..2bf58bd6f3a0 100644
--- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
+++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
@@ -22,6 +22,10 @@ properties:
           - enum:
               - milkv,duo
           - const: sophgo,cv1800b
+      - items:
+          - enum:
+              - milkv,duos
+          - const: sophgo,cv1800b
       - items:
           - enum:
               - sophgo,huashan-pi
-- 
2.34.1


