Return-Path: <linux-kernel+bounces-112329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5285A887875
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DD11C219C8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2351B802;
	Sat, 23 Mar 2024 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="miHk/05I"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBDA168A9;
	Sat, 23 Mar 2024 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711196054; cv=none; b=iEDUp2W2jx3H6H+rCNfI1/85LsGoctpo8Aqftnowq8lDLDgr9mvd8Y3pOg3Vz7AiAZAj/M+hE/E5q4MKAvcwTxqBm68gzJy6194KyrLGDSashSPD3/it9iJyh34nayabpBYhlqUwbgAid6NwyQlNuSd/OjykOIBwfdMLV+7bMLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711196054; c=relaxed/simple;
	bh=Tg1nwe9aMz3XktKq+4CLyzDfAPQOslnqwY5AnLeeCpk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fOSW5jd0ZSQPu8K+g3xqVyYmhypiavt3qUlfkqMfI81L/Ha5/w9eTkZvaZRzVLRjiM4hgZnoAsonz5j6sjIJFizQdu2mx2pRd+uGq4/L4fjChYMbLMRUJ/TasZdstc2QuARnlE8PxgRzJPYhGl2J+mfJyLKLuBAUy4cXnmrtBQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=miHk/05I; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711196050; bh=Mhw9uIUtgqh31+f3FsQG870+GJ/mAlkg2CUWtyQ+yl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=miHk/05IsnWy3kwq60Y/nPZTunQW0pVP1lrDR76LOPhziWrbYBylsvxdM6HNUYjAS
	 xLWitHRqxqFrDCkv8LW6pkehaRuD1I7hUdzNWVGxiuKTeYq1JQ9UQpEWzhNNASlrXl
	 1IHV74YaIpdnQh+u5yhDIRCwgEhnoJxncOrLMIW4=
Received: from cyy-pc.lan ([240e:379:225d:8e00:b91:b2e7:7c69:8554])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 32594C7F; Sat, 23 Mar 2024 20:12:37 +0800
X-QQ-mid: xmsmtpt1711195973ti896svy3
Message-ID: <tencent_F06FC1196D1D47235C8898CF10ED4632BE07@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIe57aA5A2c3PUOYwJgdumhef5e4VKF8/tfQppXOl3jPTQThZWrmD
	 JEQS5Th9U+9MN5UUYs4UhH4mr/pyaxIiagnqvktF50wn+8rGQt0+FmE7ALENpb7DKKuvIJbL7KP6
	 75kjlhsFVPo9/LmCwAbHfwhPpByX8UySgI730L2GTODL5luhmyM69+xh1phkVgCTxBJhTX9cgWr0
	 Xaz01wv1XqJQFNQsBJG8JNzFDcxy8umEns6zQ/xg5GNwyRqtYmu2lCTjgMtV8qbzMFXSAqeFd/+u
	 z/Q8pOgLv7BoEd84oN8hqyf2wNwJ4oktvYvQ+s2xEjC2T9jQZ/M9MuFTUpUtbt+MonVpiIKlz9ra
	 O7bWmSTcZsxFJDuUI5p/J/ox7SoyCPbtslEr56c/lY+2cOueR65/yWrrTRovkIHJ+h1yOg3+KV5+
	 I1PdDWFo5OJlydJFTLbzum+qF0h/Fo+1lEhKrbMYHPORp5HUlWSNl4vHoEG1/yVivOV4fpyWOPaG
	 z4eEZ5GIA5M3n2xrv/CRG7r65akpOArndjo80qULCr64tEEeeMPazztamSFJ/boBENS7XvqrnXAv
	 qx+jIU0cGH/UemhCBWfZjv6iLKzMHQZL+8WaDne65w0+jSoemT1Au79h601lZYh8546KAOVdA+oO
	 VqODt586V5WfXqEbPi7nPXfvT68150zFhmPBKYJ1/kDExZkKPIwW1q8wvS1yqenld0fEGmVDeZvi
	 R5jgWO1chHTW6fQQyd2ONhXvIXWU4kF5ag2BR/VvsJcdU9yzKJ4IU5sZeHgFlVfiAf2N7JJkBrwJ
	 47p0WYZngFeqd+YqrFDFvjq7oWf4FTDWvL78+CKgRTHDJKeBdqze3ilrr4zpsHqAuZ3QbP513HJl
	 ZU4XY6pAp7r3x+EKLR9kkxDquX6uZB2GZpcrUR0UKNyoo0Vod173SXcXw7TzR8EUQ/kQarrTnEsK
	 ery9lOzpwKGp26zUtd2c8GnH274l5BOLHfWluvTXFBjrA7LBgsK1ME7JZglY4c++npiLrHVZJdrQ
	 BmvduzW3xKxYQ2LUfIp6ozDiK8n68pWwZDJFDwjL6fRvbHJCa+feZ6a2FCG6blUePUyjQKTA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v6 07/11] clk: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
Date: Sat, 23 Mar 2024 20:12:19 +0800
X-OQ-MSGID: <20240323121223.1729328-7-cyy@cyyself.name>
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

Since SOC_FOO should be deprecated from patch [1], and cleanup for other
SoCs is already on the mailing list [2,3,4], we remove the use of
SOC_CANAAN and introduced SOC_CANAAN_K210 for K210-specific drivers,

Thus, we replace its drivers depends on SOC_CANAAN_K210 and default select
when it has the symbol SOC_CANAAN_K210.

[1] https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@kernel.org/
[2] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7ed0a@spud/
[3] https://lore.kernel.org/linux-riscv/20240305-fled-undrilled-41dc0c46bb29@spud/
[4] https://lore.kernel.org/linux-riscv/20240305-stress-earflap-d7ddb8655a4d@spud/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 drivers/clk/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 50af5fc7f570..7517a0dfd15c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -451,8 +451,8 @@ config COMMON_CLK_FIXED_MMIO
 
 config COMMON_CLK_K210
 	bool "Clock driver for the Canaan Kendryte K210 SoC"
-	depends on OF && RISCV && SOC_CANAAN
-	default SOC_CANAAN
+	depends on OF && RISCV && SOC_CANAAN_K210
+	default SOC_CANAAN_K210
 	help
 	  Support for the Canaan Kendryte K210 RISC-V SoC clocks.
 
-- 
2.43.0


