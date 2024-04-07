Return-Path: <linux-kernel+bounces-134556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BF589B2F9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D67282FF2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB403AC0C;
	Sun,  7 Apr 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="J9633zE6"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46769225A8;
	Sun,  7 Apr 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507534; cv=none; b=ll1V0qfOx3oecNdTM1/FUwHIh8ke3BRTg+0LeB8bYwUOuvFVX6Y4spy4fkUOVpWLA/0ET9Uxhr/nVN+HS5vdU4P3z63uyZHQiakLXT8gUMI4TGeM3An0CET+ppVMJpl45Oh2GKrC6QGXqvpXmP5oUUSayJkOfs/FgWqSl5WZfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507534; c=relaxed/simple;
	bh=QRLQxeqsECyJ6uun0xKaJizzaw8Pb5i5/HMBcCU6mS0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=aKP71MhXF7Z4J4MstWsW0blY2U4jkeK3soxCt8wezB/5orEa73aC2FgdeydPFi5RqmLdyOtCEWeEvqrABKU9ktI5dU7h0GCZg8ZY0jxaLwDISySraTcBmYsTF2RQe9uEocQd47uRbHy9NuQ3SijSaT2LIg5UrtHRvoHs9s7k0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=J9633zE6; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712507520; bh=kvuS7K0wl30nwl4M5zznAdLvDfFhfeZr9JFWkFZyoG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J9633zE6eDO5yvqUwW1Ddp3VmbvacNA32WcMKAlZNaBsjMupWTy5J8EoInSKw5OYp
	 kGfHOR4O3lNDEIMe6tSdd1X17DYmMyGSpEO2zMH+wv/b+ryRaAB1U88+4m3ePEeDcp
	 D5HGsert4ATcusgG24PfngLq0ETQIt2UkzSgi/1g=
Received: from cyy-pc.lan ([240e:379:225a:6d00:f878:7a6f:5832:7f4d])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 726A94B5; Mon, 08 Apr 2024 00:28:38 +0800
X-QQ-mid: xmsmtpt1712507322t25li118q
Message-ID: <tencent_4D85743622F39109466913393EE2F6C5980A@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYSFCBfYc13/eYee6/t1+VQFnXBRNc5Skm+aaWl+3lKK0ti+e0dhX
	 XBsaTfhi8W7XH3op554FblqV+VA0e8v06yPBRLBPj+IIjwOsry+ZuAsOXWHOH7RsPHHkx3Uaob5Y
	 6Sz4ahIdg0CcgR0DMqko9hpivs7T39UXiLAT1Cqa8bIJKWEeHOOAQyL447jpTqGHz7UfK/mwhJ5V
	 O3C520PDa16uv+iJfIHViWe0TiL26dHr4uizsEC7jL0x3es0KeQVLUfLl6s5jWvNK+Xu4F37DcAI
	 AapG+IVhuf7EvQB8ld1HAZGr/OKuTJNSVUi/5aokfhvkbQTSrIFGbtT2j+VYfmR4kk+AbYrB30oP
	 V0kOl9VTmk4yByRmMYGQA3dreUZAbeONzIfy6KdLOfAXyQE7UpCvmQ1uDdRy9rRAywpVWhSRUdeZ
	 5zFjjQVJS6JoSzqSTzfzDP+8Cs5VyYd3nB6osaSPrSg9v9tUp6oaW4eUGIE5FK/Ra95Fd68JltyL
	 G4zx69w7AGwW2rcxNn4XrBXGPPQdS0XGhr1rEFNWKfv6WtWyuBHy4FF21BZZ5v2icMsgRnjW32Pn
	 V3ywvcOFhHTpSjqEq68GNZT83oL6oppnNXH9M69mJMtIjTqPsbJUG58zutR0GnDYgyuO4O75LUdu
	 QHQDG3mig0vQhZxIGavM9yWXY84uSa34RffvnPy8yDizn4+00X1SYiUwlSJ2NkBoUeu6q4FWHnoW
	 aHrpDE9FkwuCE5hUwHCab+PP5iHSbj3k7RfstGgHnICcvIR0M8ecmRfIVm0F3x1QU7gF0fhgHBcC
	 ztVVWDSXTbADbGRRQEzZqbJ5XHhu2tu0NK+n+0nuaLW3PTKMuQuCb0jrGowchVGiwEhbN4oYWXmL
	 ZjN8LpXrcxTiMFk1IkRzx4JVbM9TaGWPFL9HXOr/qcHFu+92Apjhg7ALoxuFHLst7YEIeUTaQ3X5
	 bHUqHCagzFwg+QlveRBbxLLLarwo8V4VQFqtef5879yNREDuPvSH+uDSQ8L78qM4XPojpKCRLUhA
	 ctCQYhGwjQyohmGO5aFcUqdkTh134=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND v8 2/6] dt-bindings: add Canaan K230 boards compatible strings
Date: Mon,  8 Apr 2024 00:28:31 +0800
X-OQ-MSGID: <20240407162835.3199788-2-cyy@cyyself.name>
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


