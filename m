Return-Path: <linux-kernel+bounces-2219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA68159C6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63DABB23B4E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C016F3011A;
	Sat, 16 Dec 2023 14:13:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA9B2D7A7;
	Sat, 16 Dec 2023 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 343F824DB84;
	Sat, 16 Dec 2023 22:12:54 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 16 Dec
 2023 22:12:54 +0800
Received: from ubuntu.localdomain (161.142.156.108) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 16 Dec
 2023 22:12:51 +0800
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] dt-bindings: crypto: starfive: Add jh8100 compatible string
Date: Sat, 16 Dec 2023 22:12:30 +0800
Message-ID: <20231216141234.417498-2-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231216141234.417498-1-jiajie.ho@starfivetech.com>
References: <20231216141234.417498-1-jiajie.ho@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add compatible string for StarFive JH8100 crypto hardware.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 .../devicetree/bindings/crypto/starfive,jh7110-crypto.yaml  | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/starfive,jh7110-cry=
pto.yaml b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypt=
o.yaml
index 71a2876bd6e4..3b14320a107f 100644
--- a/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yam=
l
+++ b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yam=
l
@@ -12,7 +12,11 @@ maintainers:
=20
 properties:
   compatible:
-    const: starfive,jh7110-crypto
+    oneOf:
+      - items:
+          - const: starfive,jh8100-crypto
+          - const: starfive,jh7110-crypto
+      - const: starfive,jh7110-crypto
=20
   reg:
     maxItems: 1
--=20
2.34.1


