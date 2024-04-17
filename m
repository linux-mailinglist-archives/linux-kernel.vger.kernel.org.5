Return-Path: <linux-kernel+bounces-148004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3A38A7C78
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BBB281E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF0869DF1;
	Wed, 17 Apr 2024 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZS6Aln7o"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA06B2AF0A;
	Wed, 17 Apr 2024 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336405; cv=none; b=smxMcXG7hoSLCYOlNOTI5hFX4zi7e80qqFi8EqBlaTDgwWz5BOfn8IatFNLnJQsAIzH3ITERbIfvNHCeK/FYm6w+SkzXIPZWcwdkeY6Y4px2EgzZG+St7Wk1b6wYlMAOl2hBU0pixlA75YxqvTi7kFG0vJUxtwD+K4qAInARco8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336405; c=relaxed/simple;
	bh=tcmTB/yqTm0azekw8XuAVwpuhHRZ7bX8pdPX3I4AKCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tk8h8P9DbL7Om4Qh/fc549rIpGE61Q4+98zAz8x584q3U1sY1apxLGGp6FsGfximx5v+HQ1/qCgzMcTzTGlNGtOWgTPhR7Q7dbSNrikyh4v5dWnLcbdxFkh2uMou61EWyQzL0Hc49VWqjkhNcNMif73y8IUuNKGk9n3UzFq/jdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZS6Aln7o; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DAC25E0003;
	Wed, 17 Apr 2024 06:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713336400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C56Ut6AwxxgRCtKAR2dRDxFR3VgYxqC56KrmxNaKKpk=;
	b=ZS6Aln7oXzQupDbo2b976Q2CiO6il/RJFNWEAeRsH35wn/fu2TfQUaaQqvqb57jZCH6VS+
	gT8GEQ9vhQF/jHesphzZZ2VEOoha/0PMfCh+HjbJx8E7psZfLOb1rbNd+pgHiteCzmx89d
	Ym9KuzS4FMqGHeiqpLiSxYLY2WpuQiw84iziwa6WCwHcBKX9zPKWYBp4CZc/a1PDcDgx+q
	AB/8uNVjEuAJ+UQWN1jM2ET6aVrgOfg4JIRiboDdnacE2Osw7fKRpok+uPoTHjiLOTtvBP
	+o4TojoMHG/Tp5l43O3jxK/0l7VXfc7P0R6N8hMZyXCDFwGiPrHfy8cy4SxtOw==
From: michael.opdenacker@bootlin.com
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Subject: [PATCH v4 1/2] dt-bindings: riscv: add Milk-V Duo S board compatibles
Date: Wed, 17 Apr 2024 08:46:25 +0200
Message-Id: <20240417064626.3880187-2-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417064626.3880187-1-michael.opdenacker@bootlin.com>
References: <20240417064626.3880187-1-michael.opdenacker@bootlin.com>
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


