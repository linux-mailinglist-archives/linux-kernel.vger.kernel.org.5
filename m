Return-Path: <linux-kernel+bounces-148012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F28D8A7C97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC0B2811DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046596A025;
	Wed, 17 Apr 2024 06:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AfQX+e4h"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1469DEE;
	Wed, 17 Apr 2024 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336805; cv=none; b=q1ZaipemV8Odi0wLxdeIBdH8HbbvYIuEYI4NZnv4iQhWinJF5y1KuIcHikgB8qUaBIe3CDgUAiMKINUaq803sogqMxLmh8VxFABN5D43HUniuHWKkkdNMv+dPmnHPGBUJAtvVZ/qBpwMZJfHCwrTVN9eQd3xauMUXdKT8UW39b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336805; c=relaxed/simple;
	bh=tcmTB/yqTm0azekw8XuAVwpuhHRZ7bX8pdPX3I4AKCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=szyfbhfrtPn6WlC6oPi8N8zIe20EWWWnrryhALt8s2N1uzggLPqFynaqvX0pk1RI3B1E6hA1zGTwDvaT1pW7U4sEK3/liqDshUSkmgdGViQHdoTgps/Eq9MHMle5YAa1gKGLv7t+wCv84HkXA8a9JV5ZUvYnViM10iM92FwwDu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AfQX+e4h; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C53160002;
	Wed, 17 Apr 2024 06:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713336801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C56Ut6AwxxgRCtKAR2dRDxFR3VgYxqC56KrmxNaKKpk=;
	b=AfQX+e4hTltnLjoUMZPtAynv4+5ecp7qePkNmcbSzh8mvvQrT0YqC4iC04967DsT8ZP2Gg
	KDDWvZupQyqkInX/iyh4j6QPR3OWXKR9j/ujYuKGEPfTdpcxDKNB7h8SY12BWbL9pbU7J+
	Qhuv42WBsmnek+zDQOfprLJGYr8BwAFVXs9HQPPbzulB+yEgEczjT0hX8zhWZAoMKcR1SG
	B4i7RMR8amIKd1o00gQ+4by3WoCMoZGTDWv6K2ynGihFr8ntOJz9ki6AA3MWzHVUxgrPnt
	fOB5Ux0Mv6tc4e+UcijR72EflI8HifJc/nNpxbQ0dhndxoworeH010Y2viIADA==
From: michael.opdenacker@bootlin.com
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Subject: [PATCH v5 1/2] dt-bindings: riscv: add Milk-V Duo S board compatibles
Date: Wed, 17 Apr 2024 08:53:10 +0200
Message-Id: <20240417065311.3881023-2-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417065311.3881023-1-michael.opdenacker@bootlin.com>
References: <20240417065311.3881023-1-michael.opdenacker@bootlin.com>
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


