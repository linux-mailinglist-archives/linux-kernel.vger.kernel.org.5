Return-Path: <linux-kernel+bounces-123342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB5C8906E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222DB1C319AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26F513790D;
	Thu, 28 Mar 2024 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jFofzEIQ"
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC42C3D988;
	Thu, 28 Mar 2024 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645608; cv=none; b=mPXoCWmmoUhB9qZOw3ze4GQxz+1C57zBP2w8t+z8lgMbqYH9ehYXozJ9mLZPebt9NDodXmlNN/3h8Sbo3+7PFVK5jw1BUE273zIRTEDzth6qcavisbjAOewW5MLJwe3Ol40PQvlfii1lXKyYJIKmcAVcCCUqa9Wv4QRwpNuuFB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645608; c=relaxed/simple;
	bh=I/qGT6THkR7Oe1fklTwpWUDoOAdPYVU/72MDEA8l3uc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=AMOnDoEtl0o0gRLOS/Cy5OV1UdYgoxUlSBV/IHhnwQOupk44V5kmpTFjAG847ZVvsrloDE2pOiVzBE1MbxGal9/6J4mxLudDgCeBVVryNHNb9/zHBwRNYjzlicCU+cfhoXbKLoYkqiYcclthu614ChhiaaRK+KhYrveAdZT/PHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jFofzEIQ; arc=none smtp.client-ip=203.205.251.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711645597; bh=gwLy8EHIrL7+lUNma349SO3H+5GaIQblVCaOrJwekyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jFofzEIQ1LZK/TMBKP4ln9u0EH57DRWbvqd9XFfOdv1B5H1gSE8sAHoY+ed2SYHVn
	 rIdD6Ib5CN/KTHamDav7h/awYqDWnPcn3+mRllgA95lukt1RCG64CBQL0BGpzZnkjU
	 1ikGC++bS8NrAcuXVbarQUBxoZPQSfYTUZlxvrUo=
Received: from cyy-pc.lan ([240e:379:2277:8a00:7feb:196a:dd5b:c05f])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 199B7A03; Fri, 29 Mar 2024 01:06:25 +0800
X-QQ-mid: xmsmtpt1711645594tp24uy5gv
Message-ID: <tencent_4FC67CBE4B41306D52C71C5CEC989690FF07@qq.com>
X-QQ-XMAILINFO: M5WvXNp9ZPrQurtbw2kfLYxuV4kvz5IMKbHDLqezAnXQBFGRi/vH2JvXDuHJ8m
	 GwscIy/reNZCHHLZSIz/tKsD4X96rRjH5tX4Hc9Q4Eou9TwpAeEspgv0RO2xP+GPVy7WMCPxB8WG
	 D3wYPa29Mi86cVL+hV51vRRILct5aONLYi/3Vx916HRmpmRSrsPOakmDBo6nloIDWTzj+4q8Lum3
	 AlOgN36kChzj0i3aQ7amE9MhRnm2lf3Z3WiThgoY8LoFsNwU+hMmg+eIEwnCP3c9/HQpqe72Gg7J
	 7QzsFvIxaO1yGWpNIxztIhcIVbj853jF//l1m77wJ8e5yyvRpwmauHQsmpAKaawdWF6jhYCYapjq
	 CrGDkwN5QJk06DD+H0CHbs+dVpWnwZr43UmE3D2eOMwk3odxhyAZxHOVrMxIlyvV+YpGpfJL1XCF
	 mQdmvCJgNBLZpMR8EU5wjVJqivVnqqeQiu6nJjSIImgScyc+DXOIhYUVVO/JN6mIAaofzHvp8RsD
	 S6FndPhCgVNztifc/hUmOulHf+jQP/x4mS7Tuj8tFigQ+RlmzGcWDAHy5Z5WTnTuK1sdjUDxoQHT
	 x0SBqrL5hpW7hWILUPY9gj9HIqx1W5MQ6YqfXAtSSsVXORfnoxxsYqwW7EjqtBUNsxbjnANSYuor
	 JKcj6HmjQ97xAGNCHxLIlxDOyVNl+4nrlibYDQRmdQf1J7jgPtLIretR/UOCEXS0EbZ6KH5DbCnm
	 c004RJhjtASDy7k84y6QXVNjq7I/Gklgyvof5BLPVOeA67M44cFMHdhPI6RTyG5f44gPxpwbsOHc
	 h8h2CAY97edCTHbjWiYwT3hwkvpW/mAxnyZITHEy8FRbUcZju5L33sSjye/ZUDWkRzZnqmy2qzqB
	 lyejbrX8G2kcElySiyZf1bHZ6yNAqcU5xZWG/jOY7qDDVesQcr8n8Onai4F9cLQdZIzE7Ekga26b
	 qG6I8UGm40i6+jG9ELmRDu6zL+jkE4L78JPwAyyEN5DGl/n4HEFD0uplS/NWIWxJNJ3YA1EqXgOE
	 thCXnt/OHVKChjWtiTyPMu+ORceccGkQuXKUcr0w==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
Subject: [PATCH v1 3/5] clk: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
Date: Fri, 29 Mar 2024 01:06:11 +0800
X-OQ-MSGID: <20240328170613.120131-3-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_2E60E33C1F88A090B6B3A332AE528C6B8806@qq.com>
References: <tencent_2E60E33C1F88A090B6B3A332AE528C6B8806@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since SOC_FOO should be deprecated from patch [1], and cleanup for other
SoCs is already in the mailing list [2,3,4], we remove the use of
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


