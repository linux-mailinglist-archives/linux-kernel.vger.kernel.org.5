Return-Path: <linux-kernel+bounces-90803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20346870535
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA662841D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F914F5FA;
	Mon,  4 Mar 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZopN0P2U"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5E495EC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565418; cv=none; b=QxdKqkzKTOiMT7NEJ4TEANiVYQO+H6o2JnKC4rTsJRErE3McOLFR4SbDEA7o3Zcf+JgYa4cs1skMWDoqQ1YRmikDE+mc4btMEkEnAzTnJWN2sKho7ckboPlBZVnmIGKYp6rQCQdHx2Q23tCYh/T2MXIUGChoR33hOjktis8u88E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565418; c=relaxed/simple;
	bh=ETeFvo3wbUuXHXxemScmOu2seWVe80QSlx6B/IsK5O0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=JLbdpDO9bL1n3684xU3bQvvdEP3xfLFDZJ00Azi3+MfhJa62QMd3esR18J8pQiTINkRvcIdharLdTixk77mHPX9eTPc2WzsC0rL3a2dVmlIblUtl9uvK40hSFhgKB+FAghK4J7RXakeBCxzJAGlqKhv3bLAUY6AMb/c3hFJQhlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZopN0P2U; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709565405; bh=QCJNzCmklfQ5NgNTmfCMQlcAPni2vZ8VItHC2T73jcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZopN0P2UfwiSVQdqXOystS1rlm7GgMbuVJ1XdgrsIc9sCzVDJ/PjshZ5hZ1ipVr//
	 rVuqfdVzMfFisIzr4W6h2HtEtPdPIEjqebCvyEtR8uFiydWi08VxCpJNbCTIj7TFe6
	 UVqMOCYYRKxRqrg5s/zGBjJYbIA1N99Q+QTgTLPA=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 42726AAD; Mon, 04 Mar 2024 23:16:39 +0800
X-QQ-mid: xmsmtpt1709565402t1mhl1zai
Message-ID: <tencent_1DF18DF87C3E8281DA758E55B82831AD2108@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85No+fsVuxhrDBql3W1UvGQ7Qv5D8q4s73qVKZ4qGKfodgjOikGJh+
	 F9YqSkX5fQPcm8/c6VyllKAcvCCZxmJTQdiMDhj//C8hZM1dd2O9gyyzK31uvCtmNo2A09Xx5Yzm
	 eNDPyyep4R4r1c+aDBoT8DJBMFCisvtHfFgzVHv7tly0J0rXOCd0/uqKN60O9cNZROD2dwic8+pp
	 t6Kc8+kzl8n030JmczW81szdQQNT9wS6Z6QgeW0MtDIofa4A45JXSmZNxPpap7qhQvVIMts7MVKE
	 FAk6M8PLaM4JDh1jf0nAh9D7fXZ9kC+L7AePrN95G50dVeP+7J956qCbdYysK0Nowj6+Byt3arxN
	 A50Bi3yfH3FD4VOHgSdjLziPcFYiLFptMJyXRzhWFNLlfjgwKGapgeiac2TpcCgtBySzzRcehepL
	 4qHhpAQ7UPhgu4QLyQPiEPN2hF0Wis1tVgc27zwDAv1J9lY4kh3ChLFaug5jtrXj1CKUnDUTNhk/
	 VALbq5xXut53jJhuDo8vgK0LwR28FGRHIUWjjCFwwPatxXSzUBkbb6GIpjTbRO5+D3kulTCEIbCK
	 mBUMjzbNTvAnWTcvE12N1gHrQIJ6NkZreSe3zmO7b8ZUJRKBEAM0LcIa5wWseQUO5Fu44x2a9hhl
	 21CuNmQ7uZLwDA5RYuAy1Ziw9/W2gHU4woZ3QT9pKd4aLu5HzsErs+uJuo1EKl+fjsgOT2EfXxQH
	 lq7S9Wqc2ZYMZO211bJis17odpggPKDUjQS6tnLwZEy8OX7Yar1r/sD7MZCY9XDwj1kHnXFYikvE
	 +6RlACioxjttm9TCiCc37EIuAvLoXIukKyGZcdGVk/8lqCl9obhdZuPN0dmegbr+G7Kxj/DD6hO/
	 4OFlkRXAliQ6/VtbjIg3E5enggsm6RIuK59Pjq0+/n3G3z24R4ByBLtohFS/+b4XcySFynsjuJK9
	 PTPC+HIaeSsL+9jQjASfOr+KX+vSDki+SipDqeGzf2aP2T9itPl+CuuZPRImxyIuZPkJj7t0/NqC
	 u3PjXi/QMNQOojx3MzaGlusomeygNb2OaSf4ku1VtvEGjKsyBdMad7rYDD0PpciFqdSrWcFLnq0l
	 J9L5s6
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2 2/7] dt-bindings: add Canaan K230 boards compatible strings
Date: Mon,  4 Mar 2024 23:16:21 +0800
X-OQ-MSGID: <20240304151626.759150-2-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com>
References: <tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com>
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
 Documentation/devicetree/bindings/riscv/canaan.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/canaan.yaml b/Documentation/devicetree/bindings/riscv/canaan.yaml
index 41fd11f70a49..12a78bc95992 100644
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
+              - canaan,k230-usip-lp3-evb
+              - canaan,canmv-k230
+          - const: canaan,kendryte-k230
+
 additionalProperties: true
 
 ...
-- 
2.43.0


