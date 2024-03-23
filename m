Return-Path: <linux-kernel+bounces-112331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE4988787D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A236BB230E4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150AF1B7F3;
	Sat, 23 Mar 2024 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="a8s4ZS8k"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94770F9EC;
	Sat, 23 Mar 2024 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711196195; cv=none; b=W0jNwPFfabX3NsERgXRMebG1DMF8Bhi4F4rOs9gV/5n1U9xO27f6yTDQO0r4wKh8xehGGvcDuU/WaDeGtjv5ersc53W/yDPgh4Bvk6MJPWKv+NAyYxmNWclIcTlsQEfJ23PqpHlXXJMt421kXAnSWVURFJJpQJ7bQf5eO3cOnZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711196195; c=relaxed/simple;
	bh=VY/sGrXKFyoKGGx/9bHqzS7Eglr7oAp1+7lX9qZ4AZg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=QhqIgGIBPsosZ9rRtDIHKGf2jN6RS4J11qf911HEZXFHfuzzh5p/MWdMEX5/jcIdOZQr5tLCjdHMGAmF+6bfbMKX2jqDcZXedYFx7z7BiiKr0vYzuoRVLxQ/vivN9DzXn+BeDBefV7uzqMdNw2KqnJlwA/n19TU/kOmS+99c6z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=a8s4ZS8k; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711196180; bh=prkqax1s/YPOiuAZGsCqzxUs5Mq7p8+18pkZu3zCxio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a8s4ZS8kCinMQEBfC4n1k5obHtzBvp5gzvBzqed8Nnssq0rwTndxYacsxzyXUW+st
	 wHy/n0YQL4EP9q9C4S3jic7TMRZVRnccfac6+vjlcNQmI83SmVI6clLZHHivyscsTF
	 Uh2cxZ7phT1z2gGyrjbwNwt1nItJTSmEhLK81N9E=
Received: from cyy-pc.lan ([240e:379:225d:8e00:b91:b2e7:7c69:8554])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 32594C7F; Sat, 23 Mar 2024 20:12:37 +0800
X-QQ-mid: xmsmtpt1711195978tnmlc3wz9
Message-ID: <tencent_09DCFC98C510B846023E004101ED10C70A07@qq.com>
X-QQ-XMAILINFO: OakVxA/3u/8RJY9aJxFZniVxmyjuv+LnRwH4BurKFJB3iN1qA6IOmp0/dMwmGq
	 INFrrIaazWaGFoEuymArxkohE6PFoK5yiXKOvxcdoT8D5n8yfqfYPpSw9lGIHfmkVheMdL2z5pt0
	 9vYFjBFTEAEY+EHInLHRem7AesRCeGKMrAqbPsGPm+TSdIzUg3V1oZdW8RxDYENgg9ZXCa172B0X
	 Gz9E7NicSdmTzdY63OFO0IpMvqmIYKgU9zdp4rBlsI8Qk/KLBkv1h9B5kv6aQ0SaKP5741c6C4S5
	 E3Iq2mOMUkKqWKHwYZg1gor5WBdZu8ZVnBQIzqYtoov5VFQ1c4HmlJyPm4UFb2WFhUi9aAnPuFSp
	 KN0SpzT/ThmgnQAyKWIeXWocwRzmbCywWu44Xz2K5uVNTvecAfNCJU9ix6OL6tYUK2q8HpbX83GH
	 gViqq84mYBnl+Bm363O6gQC4zoWydpo4DkEn6LOkYviXPxA0Qqzb5pDTPrbkf992jDcYTam1oAfe
	 foBX6gMtX3rrhkDzUaSe+VaPutNlIArRzaZxkQIAB/FSiabGD46XrQw4k69xJjbq5eZNwBxgLPuJ
	 hH51Kge4KnM0dXNQ9backIuoneNkl4OOY2aq7RtHibNy6QPDNJTXz0Gu77EOm9hmlK+b35BpZ5Ju
	 x3CIFB8ZFxyg7XWghwzcbFwhZP4nB02cDxH6ykrVePXY3xsCOsCJWqt6eZaw42KDtBfc3+WSjkhA
	 EiEgZyMUFMOxicnQKkk76Q1Sp7AaqA7KL68slHTRz+1Mcgr5EfjPVjhAKaZNl5v8zOg9KpT4dUGJ
	 y2qv4l97K1/Y6Yi59CMw/oJp1UGHwgv1aFrDOoGJCC8A+0WvSw8fqjjIWHvaAup+IBbPXpKov/sj
	 WKND29wrN3sXj/qLz8nerguDF8O3J7BK6292HjwkRrqMI43CiUABAbmOkDEV20yniYCkedSicui7
	 4tIllPcH6NX0I8haL2cqKlQGACvNOVHe3nC6DzRoUjkkQbXcCz797BdLeuxoyVKqfKc4azC6aRlf
	 0ZPUJNzOvSY7aatIEhBh2IOxOy3OZPVkBVmsCYLPt0JNw1gx6P5OrZEaBgF2+9awiLpvTbWWx00E
	 pnjcW2v7rt+3Y9oUA=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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
Subject: [PATCH v6 09/11] reset: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
Date: Sat, 23 Mar 2024 20:12:21 +0800
X-OQ-MSGID: <20240323121223.1729328-9-cyy@cyyself.name>
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
SoCs is already on the mailing list [2,3,4,5], we remove the use of
SOC_CANAAN and introduced SOC_CANAAN_K210 for K210-specific drivers,

Thus, we replace its drivers depends on SOC_CANAAN_K210 and default select
when it has the symbol SOC_CANAAN_K210.

[1] https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@kernel.org/
[2] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7ed0a@spud/
[3] https://lore.kernel.org/linux-riscv/20240305-fled-undrilled-41dc0c46bb29@spud/
[4] https://lore.kernel.org/linux-riscv/20240305-stress-earflap-d7ddb8655a4d@spud/
[5] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7ed0a@spud/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 drivers/reset/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 85b27c42cf65..7112f5932609 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -103,9 +103,9 @@ config RESET_INTEL_GW
 
 config RESET_K210
 	bool "Reset controller driver for Canaan Kendryte K210 SoC"
-	depends on (SOC_CANAAN || COMPILE_TEST) && OF
+	depends on (SOC_CANAAN_K210 || COMPILE_TEST) && OF
 	select MFD_SYSCON
-	default SOC_CANAAN
+	default SOC_CANAAN_K210
 	help
 	  Support for the Canaan Kendryte K210 RISC-V SoC reset controller.
 	  Say Y if you want to control reset signals provided by this
-- 
2.43.0


