Return-Path: <linux-kernel+bounces-134557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F0389B2FB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD141B22822
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FB83A27B;
	Sun,  7 Apr 2024 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DBprVw5G"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C534CDE;
	Sun,  7 Apr 2024 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507705; cv=none; b=qzFF/prDdpPZJMPrkIh2GILkzfvKNPbL4Hy3WSp1QHaY4T+4ZeiT7Kp0KjJdXpd7+lXqNkYETwSA6JalWAikBAFY8wjlcV3S+rOWzykgVqwfak2ODiGzRTOul0L+vjc/WA0R/Gz9KHDr/1FZLs/fNMwl2N6rc0e8GbEyL+F/2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507705; c=relaxed/simple;
	bh=SvuWEiVGbOlHkDXGOMfy0DuPC10FrXOek3EFaoiDNyg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DZdk34TTM73QKB3iIgBXta7T4/TIPc8Vif3QOZjYiElwkelQZteiYIgAlRsOEH+pj6te+2wU3+Ix03Dle2APrUFRV8wwm/ocWFV+PmPQfRGUfN5vql0oUDT1G87JYBBbZFOlICeJhUEyCk5h7Hl+xoyv5C1rbrEAuX4pP9ukick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DBprVw5G; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712507698; bh=jaM56XVEDkeOpfko2CLF+2oPCWKBzRPYG5Ofw5dlTQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DBprVw5GE+N6E6yPpeKPGsLaoAoH2he1GQklf18B9g69lu0RlVnH6YxJH0sCe8/jQ
	 +mGbF2/C+ge/UVe6e5Zl+gUHUFxmmJM+9Yp2402NIqOz40Q+PNnhCgbjnqQxrEog0C
	 rMcu+64S8w7CMsPbPiJ9XmOtc6xBvjN25X/sLJes=
Received: from cyy-pc.lan ([240e:379:225a:6d00:f878:7a6f:5832:7f4d])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 726A94B5; Mon, 08 Apr 2024 00:28:38 +0800
X-QQ-mid: xmsmtpt1712507325t5ks6qhnw
Message-ID: <tencent_9DD48D047C4682BDDA948EA4B82931992108@qq.com>
X-QQ-XMAILINFO: Nfm/+M6ONQ57Qt6yN5iF/TBLIB1w+PKYNvuvJze4N61HwImZaNRggBtEY+Ezus
	 nfpnHx8vStyMYeCQTLPsWIg2ZqUekXYZouaoaAgpNrgZmVL7QkrxFLbPO6zCjIxndt2uu/6fpoX6
	 moVNFQ4y0syjixv/Vw7bLkQ37JsCiUnkLR5ctAFbKW3sFWl8ggstiMtonysk16NBwBHfjGOD6a0g
	 HYh5Qx5s7HloVh6OVQAkv5SQrcBDQJgXh3YLwYycs4WSX5O26acyqt+ujah5zKyevNUKUrPKc9X7
	 921Nlvofo8Mif8VYUZag2c9qP1fqaCXw4elRbtonmwKW1qmxsa2KIBQhQqPVIhDFR9BkQQYpPWMu
	 ndKTnJvfwWEEl+M19kOf6U92k3WydrSfImK1FPGEyCfpII5FVYs23NGatFLl1sbVYilTrNMuSMPH
	 DDBvMUUJMy8S6YqfNMaKmKTw+bhlnMAE1L+A37ABZ/0XOFFPkTTjsPJSjJIzpTz547R2iG+TgI3e
	 qndClDSE6uO32nnX6ulYf9Sa2cidblGGWXRpWboq+Rk0m8hmtHCwJwAwolGMWnrPiWGhPOKr9cwy
	 8uUXZ5mM8tOQ7xDjjXvN3Q5eYiUN+daFfH34R5isCmxM5EiDWnxtmfwFpHml7eeTozvL7RXE5iMb
	 HiRIPgtzyVdgNn0xpbv4pYAYkL12Kg06fzZbC7OWoO1CPKNKB0dGEOfSzKyVeamaBN1V5l5z3320
	 G143C1VRor+nKRfdLhYagZieXsnFv9SRce+sKLRPdeftGgGrueuSLWZOIl974VW8Qac85J+S391S
	 Re6uRQBSrUgtCY8n0jBtz1Ote6pAC3tTB6o9Kw2+Sk5G6HRPml9cM9kcJOhUcRL1H2IjsDGUCyFD
	 rjEIXT6kNWOF6rwx21EXRDUqIBCJP4amPzXnT9rK26Op7JHm6OjhVQbMFoF8rvpz8xSchC6MwA7T
	 5tzNUpTmg0jAVLxYv382KjXR35Vr+EV9njfJFPgfJrUvBgWLwYmZeodCbu8t8ZLe8DJz08YLMU9l
	 zhuewI9plCYqhHFSqNuMb1mfu0YwhON7EJhUXXuw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND v8 4/6] dt-bindings: interrupt-controller: Add Canaan K230 PLIC
Date: Mon,  8 Apr 2024 00:28:33 +0800
X-OQ-MSGID: <20240407162835.3199788-4-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
References: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for Canaan K230 PLIC.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 709b2211276b..122f9b7b3f52 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -65,6 +65,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun20i-d1-plic
+              - canaan,k230-plic
               - sophgo,cv1800b-plic
               - sophgo,cv1812h-plic
               - sophgo,sg2042-plic
-- 
2.43.0


