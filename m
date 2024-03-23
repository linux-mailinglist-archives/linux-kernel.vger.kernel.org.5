Return-Path: <linux-kernel+bounces-112334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EA3887889
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FEFD1F23443
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540D6374F7;
	Sat, 23 Mar 2024 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="upNpY1qV"
Received: from out203-205-251-36.mail.qq.com (out203-205-251-36.mail.qq.com [203.205.251.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5E2C157;
	Sat, 23 Mar 2024 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711196282; cv=none; b=lEQhrXHNAt9GHawDU2KytLtxzOHqH+Squ0V72rpALjTAjmF9GnTvqKl+5+z5Zd5uhKhukKkkQD5dEEP5THfyvkutimJG8kArat6/f2n7VFLoXzTYdQdsv3P49S3CclL7paomlkJ0426ZDTN1OmS9L9IV03DjXG/sJOp4Pe8fCMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711196282; c=relaxed/simple;
	bh=N+hdJ/K/367z9AduiEVjZAfGxfY8hfBNcT/rU+ctJoA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jXaiGDSCZROPlS4mayt1EqtaGtjfHpNQWCi4pYp5Y+iFYd9ue5MaAIi0stQjkgQCUZQBj02pecsN4IHMad7mgGd73SvfACXoGdG0JFrGVQHrkFDSlAuI7KmNMoD93PsgzitwBMnymXx9WzcaiPz9Z/FroEuygzn/q5Kfh51sxYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=upNpY1qV; arc=none smtp.client-ip=203.205.251.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711195967; bh=rcU9GmGkfYObnRvy+6sIXXI4nFg1KITAK23jcYZUxzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=upNpY1qVU9E881cMsUqmNFhtpMVIzGT5sbW6liaSbvAbFCDUTz5hRpZzKYPUwolaz
	 U0LqrL11TJofbymw0ovMkhodQrp5Q7D6ZGDx9ha6nKo5ffbALzfETU/gp4f1vCFc4r
	 9ByU/kyaKswTp/c/WNcxQkO7Q7zaPyS8xgVm91Vw=
Received: from cyy-pc.lan ([240e:379:225d:8e00:b91:b2e7:7c69:8554])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 32594C7F; Sat, 23 Mar 2024 20:12:37 +0800
X-QQ-mid: xmsmtpt1711195964t53j80xve
Message-ID: <tencent_F0BD08EE6A5F3B56E142C688870434FEF00A@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur94KfB+7w3r13yNMBf1WJ7kj32mtd7jCEliNb7/euZWq5fEPspM/
	 7TdDQRfBiBNk9WayPerDVe2Hmu/scyD0G2qiwwJjiKgfIryT91tvfSHEfpzY02Foj3/4Q1Xt2oP1
	 xPyqUfsYilHzBhwJ3iXI3rJdNfO3AybJ8f6L4nqoBokQj2esnVr4/rtc0C1kwbqXfXELl4POVOpy
	 Whfci+FqD4C0FfMK24Ngm674JLXuxd7YD8M5C0zsndswPzr+HPU7vxhI6+Mldg42t1RArrZHapqX
	 21hk4R+0cDdFNBa5tAh4LZgPVvbRw3RIiQ6HvOmP7bbEwGCst1noIA63vjX5lJE892Ac2Yrz/hta
	 FgHsIkGgEqdJO8JD/nLus+uN2HlQiLk/9ISlQS2NTw3EEN8JDGcwDZT9gf7vmdiMWD30OeSigLsA
	 a3wVS9Paf/EDjVj2MbVXQ0/P/nU6XDpQ9/fXkUBfOUYcZzshR9Xy5gLSiT3Q3uNF780qaKzxikDZ
	 26u0GyxTqZeAxr8idi9Y/pmNaKhAQlSRrjvwIEXGADSrtZ87OxMe+4KoCHWEQU7lk2ealsV1xoed
	 dYOl7eFHw8YQfC+TGQTA5Clf4sOEZexhANKhSCL1QC/Gd3XSxtHeWY4rdrxDFTk4I2pxWcg7rBLn
	 yFcumffRcVdPggT4amgdA6/QPQhBkvLH9bjbngW6HyPh/BKAVmaCkNqphIbYdZkxAQpY2dsYfWJ9
	 Pf44XsB3PrFh186BMZ7sL/mRLJrLq+bO6oaMgT1Aby2Xt3nWch8aVyF+fEBjuKEqTkHc+aGIDxnH
	 dtKqOSMN1oPs0JXs1gqOdyjsVJJZqOWdLI2fqkAazCWBXQkEVUBb8vR7WnbO3fU+0YYawyO0g2Qk
	 ZMhYxyhGA//ynLtCnC+wSFW8d3+LXejtMcyosUVjUKxem2K+r1S5EfzQ1ubnIOK/QG5AhNVYZ/h8
	 MzLp3LrrVAzvAhznNkGb50ofLv3P/24EfQEiZzIfIThSm2JC9OtnI6sSxs/PjUPLyZNYTkhXe35X
	 /NBP7bc7g32EO+0KxKI19Y48lebMDjfN1fbHdu2z1WjpmekcoGwFztLKUda2I=
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
	Rob Herring <robh@kernel.org>
Subject: [PATCH v6 03/11] dt-bindings: timer: Add Canaan K230 CLINT
Date: Sat, 23 Mar 2024 20:12:15 +0800
X-OQ-MSGID: <20240323121223.1729328-3-cyy@cyyself.name>
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

Add compatible string for Canaan K230 CLINT.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index fced6f2d8ecb..06c67f20ad3c 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -38,6 +38,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun20i-d1-clint
+              - canaan,k230-clint
               - sophgo,cv1800b-clint
               - sophgo,cv1812h-clint
               - thead,th1520-clint
-- 
2.43.0


