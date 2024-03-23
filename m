Return-Path: <linux-kernel+bounces-112333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45B0887885
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FA9CB236AB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094B41C68E;
	Sat, 23 Mar 2024 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UAwxZfTO"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87715C157;
	Sat, 23 Mar 2024 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711196270; cv=none; b=sQOVaJBx0ePdPV0J//XuzZA1eafIP3PzrSes44rwGidYo9KuILkl6yxnCzpaZYwxo6+QxVcWJ40Opt7rdH6wcS6046EZTw3gHLO+uDNpErpjjB3DFwnmyPOGxX6N5RgY3omltVk77o2RwluLh6RN6du4wWdQ8P5YUSiwpfbnuiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711196270; c=relaxed/simple;
	bh=QRLQxeqsECyJ6uun0xKaJizzaw8Pb5i5/HMBcCU6mS0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=doOA+ekHfqbxHcpvQi6yccxRcfNK8BaTOyJKBWL5t6ZgpGu4mt+2aV6/HOdlp71R0WKohVW9J8grHofFuR73+PaFRKGYYg6B8RaoLD1QEwcQdzx6OFfueaJaesytvHS0Ahw39nIMWl4j99qkBwciC0V96I8ioZdLEvyaujSvuZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UAwxZfTO; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711195965; bh=kvuS7K0wl30nwl4M5zznAdLvDfFhfeZr9JFWkFZyoG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UAwxZfTOnsMlrE0TydZIYo2U64LS6Whupe6SfLEEtEOlbmXjOxygdcxmK5wZ3cK2d
	 6Lltbx/BQLihIpvr/9ZN3RZMuh073rTY2wnl/VThwTXbxaCnHKCo0edtWmjS62xRXi
	 jRgecDXEwuLgJFvQOFB3kbkqXaDYI3HvwOSA/m4c=
Received: from cyy-pc.lan ([240e:379:225d:8e00:b91:b2e7:7c69:8554])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 32594C7F; Sat, 23 Mar 2024 20:12:37 +0800
X-QQ-mid: xmsmtpt1711195961tqo3gwp33
Message-ID: <tencent_1B8B214D8D4B7C2D8251DA428E0CB8013108@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeie4AIX3n0T6n2lu58j6vXgROfiC092HgAEm8RRTXfZaJpCzJ9OiY
	 2B7IOHvEe5F7TNPSPasm4NV1ylAM/5PTbvvLAZQKWxONeUuasKlNFaqFniXuJbAmXfkNXgjS/ZZz
	 OimQYeLT+dYTxJ/EIkojZeoS5ivI/d+OxLzQopg9DxHHf+IN7/cTQJpD+3CZltaKO7K5AwOZdGmj
	 CTKTJpKvbSugjXBsYoaxWNZpMv6VSspUOXTfnHfMND5W0cK5AUxRKRqj2/TNcEsLefe2TXaaW1pt
	 zmTyQ3GyRo3XCgpuYMhQZisBFfPtlx6QOh9MrH5l0C6v7GMjX/NEbBVh5WCqQ09sg/nHeOWxP3hp
	 oqiNSgxKNddrjrUy9zMTtwdE90mvNvHK3g3DLtqIjRaAy4cOddiEZHdnQh29hrvnM2K2PKJrm3rf
	 fRegbfQZYzl4O3N4Rb1fOimJxgnMEX8Is7NVK55JzYR5gd7rZqYVVeFV2t+xDmzcEPNcjiDawpyr
	 06xovEC5i6TYjxdMVYVsfRhqeQhRoK5zo+1KLniy2UI8tkKk8Upn5pnf+Da2N6jaltb3U1IogbsY
	 6km1CBdbtyJo4K7ewGF9kP8deREHeoMrJfmzQU+P2l5rxMU6Hy5Wcm3uhbJLZ9+hcIRZOTlaNpy4
	 b5OSShNl/P9PnZ8OJ1bA4/ZdCfdafoRZm4hKXEHYB9wSOhhDG4lUGuz+z5iJrCUrfBzs+U5xXmdd
	 XfI4GM3/nbRaHBcY18Ker+tzMJBTS/xwJ8VlSUAf9SoBc17iguf0PwElOK08rNH1zl71NRvzS40B
	 //uBduVqBx9JYSwCGlngR1wy/RQ+UQPH+rllMv+eByNiD3+9uFQF3EQJj47SG3QN3EIpxDI3OAMY
	 BAXG83xCcSc2tvgPdGWJWN86nWFZxBrjYEPwYLC7aYJfkuuvz4oDznP27HGQ5Ej6YjfQoBpPYg4U
	 HBkgRnDB1ylFphWhvEeQBAXLY8VezRIeDWfL+plC8WkZQjZK7wBnOG/BNoLzjTOUPTNpLDf8df8P
	 5lIPm+YKySKuJyNLDV
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 02/11] dt-bindings: add Canaan K230 boards compatible strings
Date: Sat, 23 Mar 2024 20:12:14 +0800
X-OQ-MSGID: <20240323121223.1729328-2-cyy@cyyself.name>
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

Since K230 was released, K210 is no longer the only SoC in the Kendryte
series, so remove the K210 string from the description. Also, add two
boards based on k230 to compatible strings to allow them to be used in the
dt.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 Documentation/devicetree/bindings/riscv/canaan.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/canaan.yaml b/Documentation/devicetree/bindings/riscv/canaan.yaml
index 41fd11f70a49..f9854ff43ac6 100644
--- a/Documentation/devicetree/bindings/riscv/canaan.yaml
+++ b/Documentation/devicetree/bindings/riscv/canaan.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Damien Le Moal <dlemoal@kernel.org>
 
 description:
-  Canaan Kendryte K210 SoC-based boards
+  Canaan Kendryte SoC-based boards
 
 properties:
   $nodename:
@@ -42,6 +42,12 @@ properties:
       - items:
           - const: canaan,kendryte-k210
 
+      - items:
+          - enum:
+              - canaan,canmv-k230
+              - canaan,k230-usip-lp3-evb
+          - const: canaan,kendryte-k230
+
 additionalProperties: true
 
 ...
-- 
2.43.0


