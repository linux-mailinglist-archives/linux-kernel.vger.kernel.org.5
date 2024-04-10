Return-Path: <linux-kernel+bounces-137980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC15589EAC3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AE45B23063
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3526228399;
	Wed, 10 Apr 2024 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Chnr7IK4"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FFE20304;
	Wed, 10 Apr 2024 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730197; cv=none; b=Han6ef+ZI0i04sOqUB5cPuBU0maFnxmmYQqaJRj0wmGaNH15sPrR8nxuM7d+k1NH0VailHB5jO39pklfdXBm3Yxc0etTf5RCRBX+8QGYo3qTzZFmnDv21msj70hI/7ZmuQBMyY3piUlQTM+nXuHNxVSrxRCnVKIbxrVQfb6mxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730197; c=relaxed/simple;
	bh=tcmTB/yqTm0azekw8XuAVwpuhHRZ7bX8pdPX3I4AKCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7XU2+xHE4zl6pb1xiIE8AR/60ofKq81emAeo55B/mOCbE6imO7MVNwGzpXGGXDEdg+jYP4qSeJBzJPixlGYbfsWo92mRPOcUpnYPUo3NUXIKPkef+/V7mrp/b91k/K+gph2msDYqk4wIYnWYo1M4k1PiYuhVv9fzPiQJSK8bok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Chnr7IK4; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DA0120003;
	Wed, 10 Apr 2024 06:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712730192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C56Ut6AwxxgRCtKAR2dRDxFR3VgYxqC56KrmxNaKKpk=;
	b=Chnr7IK4+kllupfl7AHpVPsMSnPrf78TSiya9/6gf/9kgwr3JvG4+GD0YGvC9oXV2XYO7s
	ii01PbfYbs+MWzHDkHo5G3QzprIYqqxnyeavEn6uwGg098mlCn3ppcx1XnzduLyMHQdwPz
	aNavdha0P/zIFf/idKL/RyDetAfsH3n+YM8rLIZmAGCFJ2bY368sDyPWZT/nZ9oNe08Ib3
	hxvxxKw9kSGrAC8SqtxNu/WQKXlkDCRj4WgRbBA7j5WAAAdVEjgZp8X96JksJ7XzNyYklX
	BjfN6mFprTaeyNVJPgHjKLTn6VJccTpSXUSpkT3HeUyWBYsMlltcSfNbznJ5QA==
From: michael.opdenacker@bootlin.com
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chao Wei <chao.wei@sophgo.com>
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: riscv: add Milk-V Duo S board compatibles
Date: Wed, 10 Apr 2024 08:22:53 +0200
Message-Id: <20240410062254.2955647-2-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410062254.2955647-1-michael.opdenacker@bootlin.com>
References: <20240410062254.2955647-1-michael.opdenacker@bootlin.com>
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
 Documentation/devicetree/bindings/riscv/sophgo.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
index 9bc813dad098..1837bc550056 100644
--- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
+++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
@@ -21,6 +21,7 @@ properties:
       - items:
           - enum:
               - milkv,duo
+              - milkv,duos
           - const: sophgo,cv1800b
       - items:
           - enum:
-- 
2.34.1


