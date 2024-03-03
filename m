Return-Path: <linux-kernel+bounces-89752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D7786F51B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A1D1F21D74
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDABC111AE;
	Sun,  3 Mar 2024 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="O5ImmSGw"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2A10A0F;
	Sun,  3 Mar 2024 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709472441; cv=none; b=F61id1dN+rQW2Z1AW9phM9F3KO8zpo7kT0DkbaqXlfhb2lPmCHwTy8IwHX901SYIf8XBv6Qw6DMFyRcTPD3PsiF/WM5aLaVeM05hJ1ZL/GZgQFrdbFS9ZbKEx+33WdPiRYAYGrNixL7KAr0nTL7HX+hBQR6NbtiuFSClBe81O+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709472441; c=relaxed/simple;
	bh=D9PVfCtOceEPMtM5kWx2Ho4/ZrvOccigDQBF8avyyf4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=o09ag6lh/P3czp7xvZlfwrI11ndhkJlYEw2iZN5OInCqm/aQO044TJ3aJJhnUXdtiEktqefDnKAkg7wk4+EaRWkqQ8f0q/ZkacOY2ip35v4A0zx+bPhn6/xCaaZuMCYEpoXxx8A1278eUaVfeyy0Dp7mmBRgWnorXyj9LdU2ggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=O5ImmSGw; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709472431; bh=i8Bxkmf2drHM5vNPWa5iX+GHyc2vunjy4ejEFG4DAMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O5ImmSGw49BZHMe1ELU4Gdp7IOsDCovZ8nrQUKN2ux+dQQd6NOTtUn0nUQ1t++cuG
	 P5CwCjpPPkELDY2FgEqz26Aosh95uXeAyc4fxMsLzr5Qq8w/WGg89ERhoIYnpwRcfU
	 LGDhlPK9Uj9RXFItzBfP5E3dimOZpiFloQkcrdkg=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 6C4A707D; Sun, 03 Mar 2024 21:27:04 +0800
X-QQ-mid: xmsmtpt1709472428tcvk4o5e0
Message-ID: <tencent_D5188EA5B85A31AC21588DBD7C7482ACDA08@qq.com>
X-QQ-XMAILINFO: M4wVjRC01ue0+G33WpsO1cBFfVWuRqPaxKy/FWVo5X9yBGqFkDQrfnMOHC/Tz2
	 U56uBIQiZvr1QKE/j7s2Q2sbpsN9KtmeRCeU5jEIeN3FsFUhMUnYBUXSKYMg7WyIPMBiiQ1z3Dv5
	 lZypDLwRGAou+VtVO355nzWHjEfE1IV48aeVVSidHESKxbzt4FYb15QtZm8eUy1tN8wAgBpiR1ey
	 IyBoOITnA2HWIdnEcPw3TUh4BcJF3VGM5gHBMNYRWOaNf9QrbsuA7CbZRa9TPZV3G267Mti/nmE8
	 US2NUmCbAVS46Lp1FVbMIosZy4xulbc/3WH1UPIs+igrDHrIJiwIGXD6H1RGpJV2CIhbe2civi/R
	 tJgVSEUz+j9RBuogd95PQDGHskqPoBrrSBRZeDm8E2psrFOy4jSZ5IVjqzTU4n6WPYZxqr9flqFO
	 strx2E8Vr6BdP1w3mqKh/jV1ph/aRtbsm7tnM6KS7z1p8sDIp00yH87d9KjTP5/a2v44Nu3Umct2
	 1gUbgLjoZf6dBFjIzA3FPF2A+dRXuOKae5xr9rM2prsYF3xugxdNOORdCmF+6+US0e09GitZl7Cg
	 6UDqs/BDbVtYBTPvDlLRSlWOfoQdHfeiJDfG/iNXjpHUW3A9i5Md/lfh+QnhnQSZ7ms/xp1HJ+69
	 bbAoOXuxOX1cBNs1uhMOITgmLCgTfN195AFdleqDYZj5Qnvw/17mOiXXCtKiq5CkbODcZ+xzZ1pY
	 pIZb7E9fcj2XAwhv4KZQ1nGXdnA0ndLqktaT2gpLlyVQgWDAJeTddC7rTUCuvUPtRK1kIF8IoMwX
	 ZsduIJvNrgYZzqK7YAETEHh/yboDYms36P1zXl+GKIZ7/vLc9H1cfqNwRloOk6P7mhgSSu8fjk3w
	 BnBSFDJKT8pRgHIQk8v0foOEbcoNy5ZY8lBRgJQ7dHIG6AsRHJZuHHUh0Ftw6dLfub0BqC/w5c7m
	 aStITdTwbH2WtICxRjHkoAuJ0Y2FvYveheIbQt6EoNl/L6y8yKZkq7YNPJxV5+hQux0tcbovk73p
	 VJdFa0Gyk5TYu/i4Is
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH 2/5] dt-bindings: add Canaan K230 boards compatible strings
Date: Sun,  3 Mar 2024 21:26:24 +0800
X-OQ-MSGID: <20240303132627.553698-2-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
References: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since K230 was released, K210 is no longer the only SoC in the Kendryte
series, so remove the K210 string from the description. Also, add two
boards based on k230 to compatible strings to allow them to be used in the
dt.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 Documentation/devicetree/bindings/riscv/canaan.yaml | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/canaan.yaml b/Documentation/devicetree/bindings/riscv/canaan.yaml
index 41fd11f70a49..444758db964e 100644
--- a/Documentation/devicetree/bindings/riscv/canaan.yaml
+++ b/Documentation/devicetree/bindings/riscv/canaan.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Damien Le Moal <dlemoal@kernel.org>
 
 description:
-  Canaan Kendryte K210 SoC-based boards
+  Canaan Kendryte SoC-based boards
 
 properties:
   $nodename:
@@ -42,6 +42,17 @@ properties:
       - items:
           - const: canaan,kendryte-k210
 
+      - items:
+          - const: canaan,k230-usip-lp3-evb
+          - const: canaan,kendryte-k230
+
+      - items:
+          - const: canaan,canmv-k230
+          - const: canaan,kendryte-k230
+
+      - items:
+          - const: canaan,kendryte-k230
+
 additionalProperties: true
 
 ...
-- 
2.43.0


