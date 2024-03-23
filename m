Return-Path: <linux-kernel+bounces-112335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566D788788F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889651C2217B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6B53A29B;
	Sat, 23 Mar 2024 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PsBQd8qv"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4DC10A12;
	Sat, 23 Mar 2024 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711196347; cv=none; b=DIm5f5C+wZ7v0XglmMHLSnfU7N5yNkwTHp8GGICeVJqjW+8seSGsEb9N7Tte6seLpsx4himsttiHIfs5YsJPQmNNL0ND7wUQxIe/niHZyq8hkUNW7BGN2WmcRCFTfJ8NLYPgMcKHs5+wH4suf4dl7kRSRjDlrl74aRRxx0QJ+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711196347; c=relaxed/simple;
	bh=SvuWEiVGbOlHkDXGOMfy0DuPC10FrXOek3EFaoiDNyg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=JhMmy94Dlo7GbPhjrb754qSViogUS9Czdk89HiXSVGO5gRbAnck5BVWSs1Ie0z6h9cYlYdtu+zMGftpYzQTOogFVh+AcUIkxIC7jj0EJMffRWgqDLaCeys4GQeM0r9FP/JOTGXEP9mQu43iJ81QpRBb/UCz2Y5yhQtWOKGpHY68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=PsBQd8qv; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711196342; bh=jaM56XVEDkeOpfko2CLF+2oPCWKBzRPYG5Ofw5dlTQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PsBQd8qvVhqnz8WiszdIuLqm9RMWW5eSc9Qqbkx6JUqtYAHrkkDiNjTaOa7hzvb+S
	 D92WrUiQD+iWMotXkumHXx0OZWMZgzmmISOEZUI/Ldi+edBqeHF16fLqoiD64bBkch
	 lA2LEd/epk3mpoxRed5mOGuyDa2tGyjGBVKje7bw=
Received: from cyy-pc.lan ([240e:379:225d:8e00:b91:b2e7:7c69:8554])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 32594C7F; Sat, 23 Mar 2024 20:12:37 +0800
X-QQ-mid: xmsmtpt1711195966tascze9lu
Message-ID: <tencent_1A4625C4B7B18B8F4430483BD71111372E05@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NoaOVyhodLMB6vQGFNYeNFWaGC50wVFAW8rjIf0HbkFl+03/qCU9
	 ZOpchX6kxJhjxYSYN02wRb8yAiqINgZqUAqGM1a2UmpIGpFvue01N+Bhal0WVYsPEGXsjPuz4SRF
	 c2raaIAeoRKbwiXhHIXgbXlIBoL4qYzCLS6iTiEPDmKwZds2FwLxJ9V8wTzkVTY+BBzIN1cZqNmv
	 ARkSXbJcOibyakXfJcb5jOZ2PppxJv3Kxjrfmv64eDqsjrEJ+fEagDT8ww2qRpvTV70fV2K7qFj7
	 XGAw+zaE0OQX03XSsOOlHoo4vGsfhTlD0dOM/5LRwKBS00FZFdcDw1HpRi3NDOM7mqCvdw3TiNIc
	 0N/VPlzvsVokkeubl6IGNeuBdmvWZ8Ra4/QwLJpWzXqHlPUcvPygfKrZpBrh/SJBwV57WqhUILSn
	 pMC7roTPKCAAKvvETI5DLYZUsdXnxzF9sZgclzuPswRoH1jYHdXca5vlU5oJAAch3oMhZCD2Pn92
	 heqOW5bY0aEjFWvP1D2IBiDhwQ+aXYsAzpGhNAUVucACP80BKRtTPHtLCpZ0e6LPBeiutFN2ureO
	 STCBAAL3kE/EuH2nJhE/2aOkKpN4PWETrQFeHJQ60WaM7e2wEfNJYp5lGPqiW+168e6cPWgmlwaV
	 b/eFlk7RXxRD06mWuSx774q8XKgGnwqBgXBECl5rsC9U+B4xVBPLl8nnIr+kiKqb7zB+Gs9v5u7D
	 eBZNPLEbwu4giqg7Dn08pTUYOdG38+KrW02sR5Fmg4dN1YPKgWPv19IJTapPwtKnhUUcwZIqnfZV
	 5v0azewkDEb94LlyXfXAM3IPIdyRv5uLOyNwpZAmZNo0S8Xti+jsE6nsFRy6Ad/0KBXrEdMpKFZ/
	 FFTVGf+a5FTurqorTmL+Lr1q6qMbzQ1w6/Hwzbq1s8ILsJL5a8TwNLzzN9/PU9XImHTeEqclt8ew
	 hOyP9LQlTor0Ema64tJAmJb1OGEDko3DnCVoJzm0n6Mvme7LlcHzR6g4ddpJKagVkA3TcyS37lcC
	 qUbF+h8+RQKiv1vprAmG+LPQwKJME=
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
	Rob Herring <robh@kernel.org>
Subject: [PATCH v6 04/11] dt-bindings: interrupt-controller: Add Canaan K230 PLIC
Date: Sat, 23 Mar 2024 20:12:16 +0800
X-OQ-MSGID: <20240323121223.1729328-4-cyy@cyyself.name>
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


