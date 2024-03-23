Return-Path: <linux-kernel+bounces-112323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E123E88785D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970781F21CBA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4F818E2E;
	Sat, 23 Mar 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="d7a0vtx+"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97B4DF53;
	Sat, 23 Mar 2024 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711195968; cv=none; b=L3s/hn7vDZBJTUunSv0DeTl+Fial1p0pSTSHVhULN/gquxeTlPCXP3ZXomddGAk8RcAsq7modB+dpFii6NCUbVe5Q9iJA/zroKzAJZbUQS2rst3MPzau3kjnm6gjgkQv66ScveFA4QM+kw/7LwkPESIWMZAENhFYdLbijADQPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711195968; c=relaxed/simple;
	bh=yBdloG0WlBW/GMrbvFyZvFnt2wwgqgqwvAUviaTWWUY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ad5IE5onm+wroCx9Jlpg3Uuv1eFihc2feF4yCNf1+xlIUOkxAi5bgkZEeaM1NEETJIvRj3RKVBQ4qEgbNML46OA/3XKGkZxJv9qpOwtGvJw3nw8nHfFwoOp6BAd5M6ZPg0VY8NSfNScFhF3OwXIshtqQdfnXAvoC3N50aL94sK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=d7a0vtx+; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711195962; bh=GtPTI8Yys2Opga/0sm4OTBYHCoOZG/cPKGGmNpGSVMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d7a0vtx+YFst6K5J4oakR5Lv7q5OUjaQFSsPtt4J0C9ki4JHAA+FtIW+bEAG+qkjx
	 OQwS4t19DljgI2zTLuqvk9jvt1f6hcrTTOkyeLAPoSCRQr0s3CgD2cGAAsvzdIQpVd
	 kj6IElAGQfXzD383uQiOiMJYWXHOEBKf4mnNw0g0=
Received: from cyy-pc.lan ([240e:379:225d:8e00:b91:b2e7:7c69:8554])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 32594C7F; Sat, 23 Mar 2024 20:12:37 +0800
X-QQ-mid: xmsmtpt1711195957telpxi4j1
Message-ID: <tencent_7B2FC4BB51846F57B042FBDD710DF7306605@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCDSzsEAV2QCRQjRAFk9o+8r9VM5Zg5peC8KBDAe+tCwfmZFuFs3
	 87mjOAZQ3JWiRJZuNzVyBHTZW1AvYFLpr3X4rBcZHJWGRvkfTYELoIH1xgHhnfxZaik2cQpnYTYI
	 h0GCf4o71ynN1usGBQncedropdAUfM3bpUiAqRIGbmVwyIEs9TUqw3ntmq6qEY/he29XKcpTXoTx
	 kx0V1AyxX4eu5o/v2mD+OrtNXjgXg+b0acKFZuZ7Vpdg990NT+Qx5CSX8XVPhcrmRtulwk2xov0N
	 E6MSuRc5ftBB542NefvPqhbxOyjg17N8RELxE8PudXbyYzVr4niRul17KFLT8zX6zIzfmfbAUBRo
	 WDca6iiyZzxPGcs8AnbhCOQPKJPLGi4FKPQ7EI5fCy0tIR4oC6krBumeAJ8I7GRzTJNwQKtWa7rS
	 gpwCHoSlfZrvyA4Fj+UBJt57Nn2LcR2vP9JT5qjMsg06LSUA21xjX/Q4A1KWHLCfuSdaVy3EL0Xn
	 lZTaI5DRjy74neDRw2nM+PycPmy3MnaS42sfdrDoQeyS5tsBeUnUgVNDr1DKL5ok8Csu5vntkvuG
	 I1IrTfO6OPoy9buA8Yd4z89YgT5yOvZxqMpoqtgrYdbaDykOIRczdu5yQQRUglj5KRqEUhLkEu3A
	 MDiRJ2IoQTAHKZv3IlSzEXUTPZoesnawQQlelDmsjRbHprA8baXz+vPGA20A2znf80XL65Conmnu
	 LarJRSjVfndi5X518LGk5C8PcPNTkHJgniD0JMQ9CiYlL18tKsL5Z6d2VL46l+jpLXHdcK9Xk19H
	 e0V+nAPi/598WfDVpw9qgGQClPSRRo9nCLrmp6gp9wyKmA6NIKeZEu+Ah0tHaZmd+gSgwI2pSWKI
	 djFNfAzNssZK0JaSi0c1Pyd+zpUNdMp9ZMBsRa7FmkdIqiOIGc8FOZEJHWA+KvzdZewLBW5ZN4xZ
	 s8XzeHPuKCRdjo3mHBkQre8IVOmW4w9FLh7v/4vXUy1y/ED7mg9v7jTCr7Kg3CEmwmG/9M1I3fsH
	 su2u152ZYCjkVsRJddiuCDpuWzwZY=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-gpio@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 01/11] dt-bindings: riscv: Add T-HEAD C908 compatible
Date: Sat, 23 Mar 2024 20:12:13 +0800
X-OQ-MSGID: <20240323121223.1729328-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com>
References: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The thead,c908 is a RISC-V CPU core from T-HEAD Semiconductor which used
in Canaan Kendryte K230 SoC.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index b252c3966b8b..02f939449e54 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -47,6 +47,7 @@ properties:
               - sifive,u74
               - sifive,u74-mc
               - thead,c906
+              - thead,c908
               - thead,c910
               - thead,c920
           - const: riscv
-- 
2.43.0


