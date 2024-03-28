Return-Path: <linux-kernel+bounces-123337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5298906CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6527E1F2792C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2B87E787;
	Thu, 28 Mar 2024 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pA7jMrWI"
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA513BBEB;
	Thu, 28 Mar 2024 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645549; cv=none; b=Se6/gMu5UcebWBOkJs2vgLvSp8Cnzf4YyU59JRuACeX6+6bpoglp+RoCXFQSqd8ssYEUjaq5PwZunqAqDDK3PaBTEg8DYmdqwMbzghBIQMp89i5SWDRyyhouEP3z6iTSe/Oq1Wo9PGb0hDyqRNlDGcmdQQ+cSaDcsLN622okIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645549; c=relaxed/simple;
	bh=gJC9/6C1oV101Vj85n8xf1JyGlC/E4qL1YrA06etUf4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Jm2mShk19YIrISLWOXS8ns/PnSBYThTQxBxMqjUvEXWLPn/1fpLs3lPjp+rzA4OLJysVRgLdvk1o22ahEpDzJAszrcj/kCi9bK2fK3SfrfoSBtbKX2nYVHKfMo1DC0L8R0hBEjfU7hwrEvYE6pcTRB7iN10P9mb+n4XD2uq4xaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pA7jMrWI; arc=none smtp.client-ip=203.205.251.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711645537; bh=8ssu01htiYsJMJRjHgP4bblrXVq0qnGeiqD2k3sHcKg=;
	h=From:To:Cc:Subject:Date;
	b=pA7jMrWIuxQHr6YxFCLosUI6tQUdS37m6QxE24bg6NOKxXkzYKKStC1cKtdayabMt
	 3dm5tYOJNiGLi6PRPBPwpE2/Detr7ja3bYudWcpe9cgn63FRehSN84bn+0oTteWMU9
	 zsTsLiNT7tgS2VOihCcx/PErnEDg64WvhNxQA5wg=
Received: from cyy-pc.lan ([240e:379:2277:8a00:7feb:196a:dd5b:c05f])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 11335EFA; Fri, 29 Mar 2024 01:04:19 +0800
X-QQ-mid: xmsmtpt1711645459tb1h7s37q
Message-ID: <tencent_2E60E33C1F88A090B6B3A332AE528C6B8806@qq.com>
X-QQ-XMAILINFO: ORuEwgb9eurk937hgCQc/4UpQ04yu+q4iEC8YqNyGIVokpunePyEspOAdrFfaD
	 TAZUrsoAzBa67OyGvySF9OBMgKTkKIA8T9Hh4gpac+UcW8/4s8lQd7TSLbfRX04oJHBeBehpJkfd
	 yfaeUq2t9XWRzewmbxDNmZnmNbLP0qX+UD/NwvtecOIdyIqwxui8BLG5InboZ6yxLJUzWx18OJaZ
	 NInfgjkEajkg2BM2REbaOoWjRfEjruia2KRNVsPlJAq07Pf3d8zvtf73tlBgwJOi+FkldoXYgh2h
	 w8cm0GXPJCQiCABsLHlJhR3UE4HV1eovUOFvp+8cfgJv+sXKzcDxPojDqRVeA3uhvkj1zmEdtWJ5
	 WATnrSDp6GF4vwgZrQfZVpD1tcR/vLF62gE4KXr5PoUfbOzucC2qH2Fu5iWBGqlvazAO6MPD9JwC
	 2e1PCvQJKcUdhJ9BXsZDw7GBRAY5uFPBasxEqEQqJVXjDYBZbvIk6dGK+Z79sRji0ZaaHfrFaIl6
	 bTxdAcHvVxeooFqsHRn6Tu/UurCPRsVP9RD05M2SzsfydgKujJ1yZXmD8YTC+K6PmbBC+tQVRcLP
	 FzMqCVelVo0RRmDRgM6ZnQS7rZ2jMxAjJ5hdHig09+STq9uLx9ttCE+ntZF0m4K4skbvjZT2cmW2
	 JqFBLShKuoCiwkasVXJC3httmDVrxUWLnwLBfpl2povSQkyM2m+QjAj7jyxESOZW54MTRMuTuvZ9
	 vve4pLChyAuYBQOmOtLXzgUkEectMa7nVL9xCuK9JfzmmZ+HNx07qcUoHQK5gVuXrsA9tsHLT3Ac
	 frPaHmtg1waA/McJfGlhrLlS9LtG5cWUvX3kUHHXPVZ5Zg6M+uq5bAUzXbkyL/mzikYXO8aPQnjG
	 88UNSETFrJ0WKvwOHTukplXk3KVJLDf38eukbzd+h0TMgFaI4DHnWcnCqgH/nc0L/6EIQZIc1rsz
	 rHe+cUi8/DeoWlc8u8r3mEN5P63Q5VE2QVS/0iyLsEP6/UYJ46cW0iuvjx3UbtZw4LwejHYFCDI2
	 uCQC8CZQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
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
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v1 0/5] riscv: Kconfig.socs: Deprecate SOC_CANAAN and use SOC_CANAAN_K210 for K210
Date: Fri, 29 Mar 2024 01:03:22 +0800
X-OQ-MSGID: <20240328170322.119305-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since SOC_FOO should be deprecated from patch [1], and cleanup for other
SoCs is already in the mailing list [2,3,4], so we deprecate the use of
SOC_CANAAN and use ARCH_CANAAN for SoCs vendored by Canaan instead from now
on.

However, the K210 SoC is so special for NoMMU and built for loader.bin, if
we share the ARCH_CANAAN symbol directly for K210 and other new SoCs which
has MMU and no need for loader, it will confuse some users who may try to
boot MMU Kernel on K210, but it will fail. Thus, this patch set renamed the
original use of SOC_CANAAN to SOC_CANAAN_K210 for K210 SoC, as Damien
suggested from the list [5]. Then, it made some adaptations for soc, clk,
pinctrl, and reset drivers.

Note: This patch set is used to prepare for Canaan K230 Support, which is
on the mailing list [6]. The next revision for the K230 support patch will
be based on this patch set.

[1] https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@kernel.org/
[2] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7ed0a@spud/
[3] https://lore.kernel.org/linux-riscv/20240305-fled-undrilled-41dc0c46bb29@spud/
[4] https://lore.kernel.org/linux-riscv/20240305-stress-earflap-d7ddb8655a4d@spud/
[5] https://lore.kernel.org/linux-riscv/2b0511af-1b5b-4c90-a673-c9113bb58142@kernel.org/
[6] https://lore.kernel.org/linux-riscv/tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com/

Yangyu Chen (5):
  riscv: Kconfig.socs: Split ARCH_CANAAN and SOC_CANAAN_K210
  soc: canaan: Deprecate SOC_CANAAN and use SOC_CANAAN_K210 for K210
  clk: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
  pinctrl: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
  reset: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210

 arch/riscv/Kconfig.socs                        | 10 ++++++++--
 arch/riscv/Makefile                            |  2 +-
 arch/riscv/configs/nommu_k210_defconfig        |  3 ++-
 arch/riscv/configs/nommu_k210_sdcard_defconfig |  3 ++-
 drivers/clk/Kconfig                            |  4 ++--
 drivers/pinctrl/Kconfig                        |  4 ++--
 drivers/reset/Kconfig                          |  4 ++--
 drivers/soc/Makefile                           |  2 +-
 drivers/soc/canaan/Kconfig                     |  4 ++--
 9 files changed, 22 insertions(+), 14 deletions(-)

-- 
2.43.0


