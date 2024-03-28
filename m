Return-Path: <linux-kernel+bounces-123341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A9B8906DE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5EB29DBCE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686DB136E2F;
	Thu, 28 Mar 2024 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="z4LPhXyV"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89133DABF0;
	Thu, 28 Mar 2024 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645605; cv=none; b=I/jV7GGjWErK72ZJetUqp5E6uI53wY6BxxWDbqxvPBkbTqvdXitaBpxabfmCsHd7NEkj6XAIqT4CWWUeF9SQcnSClS/g0rpK9llvVn8Q27sQtNnzzaIKpxkLGPeXFVmCuahrN0VlhXTWkYqwEjYqlAXSZonr0wPbXbNxDm95U9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645605; c=relaxed/simple;
	bh=AEu9Sglkr9wdSb97oxxzIE2MzoxKVKrdc/kfiVcPGkU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=OcQzbZjX1jPSYm4OkGKN+iRYs7mnoMPUJ8Tl32HcNy9XMr62T2DCR5TUL7MuuVovsI00t688mS542/9GU5MO/pGXJauDrB2lAA/N9RhGbfoT4X19NZiYswuG/qeZK3d/XxKSedaM7z1KRGxliShxmR5DyqBR4o+5s/WbFP9xZ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=z4LPhXyV; arc=none smtp.client-ip=203.205.251.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711645594; bh=RnwPI3xUzFH0YfHcr806XZGfdJDxCh40cBGvRvtlcpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=z4LPhXyV6zXEPym+gj6mxKT1QL2cG0syvinZaEvp1/mOYWJ4A/pX+3cqoWfvnka0p
	 Bbr7+FoWEYpRWrjOlZDh46s3G6Hxz8/AwOJjULFchn/5f/1PEkGFXIrQKNvf8JGkJa
	 +UWbn7wB8TU6FVijnCEatUur5kKhEnIG8EhWlYF4=
Received: from cyy-pc.lan ([240e:379:2277:8a00:7feb:196a:dd5b:c05f])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 199B7A03; Fri, 29 Mar 2024 01:06:25 +0800
X-QQ-mid: xmsmtpt1711645591tckem6orr
Message-ID: <tencent_9B2484D4343EF1ED092E6A1F3A66E206C40A@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9xxghampKTcaF5ygM6Xb3xSu1tk3h3SU9QixsXNmc8ddLbj5+bM
	 VVOLuu0xXtZ0DO9etmedCYZOVEFeWmtfQKaowR079nT94bzbxvjJr6m5Gykd2e/sEAYMkxERPtHb
	 xtvwT2TPDvwDpg0siCck/O8aEb7NgNctEMkTdj6Px4aGCFerSGGUW7G+QAoMApznDrpnLwFd+/WH
	 2v9UCo1KCwJSiQwdSCEAIfU5wxPc7rroWAC36CbIl+HzkP/nN27ZtdsH0KkJUKnrLe53gRp+F6ki
	 I+CxTQs6erhGmNo0vg2M4E+eE4mJEyZqFKGMMB6XgKCzW3r04yTOAzWJ9EerY7KTArJitCzp4O7p
	 2zfM7QTyvCe7CBOVIMuRhvfyOf1k/uPUK8nu0I1SmX3IjA48fBD/lHWAksTY3PiDuQ5fyPPQd9gJ
	 +E/M0CAnu2f14ACDd54RFzb4rL+lGwRo4Dlp2g/nLrAUTb0Ks0GXT/wnliHwVDaBQKvEnGWWwdhJ
	 sU8qp+1dVIfS+Z3Am/2JqYGF2PxJhbtHJk48TinV4lQK5sp4wuUuJ9qb1RaEB7GNSnsWIr/AyBXf
	 coysIo15AnyIPfrFaid2LTZNLBSDx4x6Q3ZkKYPVKED0/Jm1bRHoILu9X352thpGKWzc41ewAJyb
	 DoDaWcUM4mw3AtSBeVPJ4s3sx+wvRstvF/tz/Afx8l7MiFdumk7BV5NLmnPqaAAe6tBmcom/W9RM
	 I3cvcG26hhKkC6VvIJfKRt1Ww6V/mlspajE0Ei6ecbIpZfWwsXYGHEp0mtmUSuwkh4Ii5Wl06gYw
	 5UzhNv5O+3EpSOIAqiSdpg+29BjxxZF8fhr2iuHAUPW1n7fBYr44lOAtTXrT99DYE0VckGpAGbTQ
	 FOwvNnuKFEDoMsaMX4E9TH7dL6nf1d+xLPegg92xl/ys1ClSfdo76G6+H6jdmKP/bwzF7dPI8YVi
	 5bejQZHNUIKLJAdI0lnb4VNAafVvLD1kKdXW+KKBl4RFA1P5qj3+G3D02Uz9/DpTPQTTtxCJd+/Z
	 SKkkl+kfkaVBR1mkEA6AgUTFRKqH1l+nd1pbz+/Q==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
Subject: [PATCH v1 2/5] soc: canaan: Deprecate SOC_CANAAN and use SOC_CANAAN_K210 for K210
Date: Fri, 29 Mar 2024 01:06:10 +0800
X-OQ-MSGID: <20240328170613.120131-2-cyy@cyyself.name>
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
SOC_CANAAN and use ARCH_CANAAN for SoCs vendored by Canaan instead from now
on. Thus, we should also change the Makefile here to use ARCH_CANAAN.

Then, since we have introduced SOC_CANAAN_K210 for K210-specific drivers,
we should replace its drivers depends on SOC_CANAAN_K210 and default select
when it has the symbol SOC_CANAAN_K210.

[1] https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@kernel.org/
[2] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7ed0a@spud/
[3] https://lore.kernel.org/linux-riscv/20240305-fled-undrilled-41dc0c46bb29@spud/
[4] https://lore.kernel.org/linux-riscv/20240305-stress-earflap-d7ddb8655a4d@spud/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 drivers/soc/Makefile       | 2 +-
 drivers/soc/canaan/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index ba8f5b5460e1..fb2bd31387d0 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -7,7 +7,7 @@ obj-y				+= apple/
 obj-y				+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
 obj-y				+= bcm/
-obj-$(CONFIG_SOC_CANAAN)	+= canaan/
+obj-$(CONFIG_ARCH_CANAAN)	+= canaan/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
diff --git a/drivers/soc/canaan/Kconfig b/drivers/soc/canaan/Kconfig
index 43ced2bf8444..3121d351fea6 100644
--- a/drivers/soc/canaan/Kconfig
+++ b/drivers/soc/canaan/Kconfig
@@ -2,9 +2,9 @@
 
 config SOC_K210_SYSCTL
 	bool "Canaan Kendryte K210 SoC system controller"
-	depends on RISCV && SOC_CANAAN && OF
+	depends on RISCV && SOC_CANAAN_K210 && OF
 	depends on COMMON_CLK_K210
-	default SOC_CANAAN
+	default SOC_CANAAN_K210
 	select PM
 	select MFD_SYSCON
 	help
-- 
2.43.0


