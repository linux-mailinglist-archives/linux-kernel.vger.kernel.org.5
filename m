Return-Path: <linux-kernel+bounces-123351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B608906FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A0D1F29296
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA2C44376;
	Thu, 28 Mar 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="OOcmOZlV"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41EA3CF73;
	Thu, 28 Mar 2024 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645975; cv=none; b=inr1FTU7dAbj/fh7VEGyCNSrDdhXsMQePwEASDYpWD6p7bg9Sp3IeD2TxFsY94k+Pm3DHyopY5kJg/p7Y+QFKTKmsb2gbsV3XuMnJUnzuuJfoQyuG0ExQmbqqiIVJwOYYFY+NkAyxIRrMsAB4NMCN7TYxvCkTFZ6/2539C0b/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645975; c=relaxed/simple;
	bh=NvDiTdvu1oocEd4z4WVUoGVua3pG0iHjdYEeWj5pFOw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=S3ie5oDk+l77/eqme4++9A/jVyoUiA43vv1lahZMnNpPRUxjDZAQ0AFUcifUTOesWPUakM0G30NFeMsa1Ft2W+DOlLp6Tybz2u2I2ghPccJbkLzeICNUUga5ItJsk6cy+bdwSDjI3ngSfOOPj9W7fRP2yX4vTl+1QS1fukPWUC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=OOcmOZlV; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711645960; bh=L2lkCcExhcCSZci/+XbSJe7RshMmWIbz8lRm/dAsp5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OOcmOZlVFdg5q1a8eyiAp4wBEg7I7HD06iWvaUsYQtaehNgmGqjFP8ZzjO61iheXf
	 DLFg8K9wKHuSJEFzKNNHJVWtr6nT9t6i3uCmnINRwX1W1XeLdVcHp9JOCJc7tygE9g
	 5UA3aVjl8Mu2RPagl/Ks8mLjc4XDR/lOhr+m6YoU=
Received: from cyy-pc.lan ([240e:379:2277:8a00:7feb:196a:dd5b:c05f])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 199B7A03; Fri, 29 Mar 2024 01:06:25 +0800
X-QQ-mid: xmsmtpt1711645596tdwddzrgm
Message-ID: <tencent_DB11214C8D0D7C48829ADA128E7BB8F13108@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTNMP2jtZxLCFW1PIkrRFpEbd8CFMBnnDWS+4rcko4Wwu1VcTYYI
	 Jv+Qii0fPVnQFco/q+0pNKeDoK+4aqtPIK78H9JnOIM07p2UpArsZk0bUPw3Ia9NKYw44Fo7YQNw
	 D38x8y+sGFVnXgB5HwOHLQ8Gq+wmy3tlpThH+4ftr08MFZ7zM8pUBrEXsPN3bVZAA/MnzqrYQx9K
	 qqvZQk1H1nIIxZSB4H20CEnH5O49hlUPhWmKyPSZG6xLUNWf8e/KMh05dD/NoTaPYG0RQu7BMHmf
	 IdHWmNPvo3HUacip14GUl+jyUb/0HuFffyAszOql4ZXt7ZSYQAWwE3d+fQGwDbhRmSnVZNJWws7G
	 GOEJ5SPh0ZULLP0fWhV27X8zLwyJLdzek4JmIq4l1kyiyfR7bvt+wSyryOMEboSoSKyJv84oHVWJ
	 E/HVW3q2QeSaV5iqtI9QqXPGLieKYeGpaeiG9XSFFjmkO6DdILK4kZ9wd4BKPbajGCkob5zS8Skp
	 1voYk6+8NxaxMpmzQVMtmofs9DEre+mgFK9gTel8Uzaajgt0p7GWzUCq8z0qgLtlV1YpmXkgix2b
	 AiWCctCng0910fXjyg5ktmhiHaNyhOvigvg20dmRSBcf7k4Dbww7B0wDhemkjBTSQ7DhYDXcb+pG
	 639LFTFVAk09vuiy16OGagFCP2UXdtIAbBTWkAN46+2uneR6L/jZJwqUw9KFCe44AkmTV69eBc7w
	 4nYSxLkFMBPpFM+cZs1i45jAi4h+BFJrQ7gVfbPdmOMOfq6YkqRLPh8koRp8jS8lHx/NuTEfSwRV
	 RXxzrKtosbYvffH2VxPvUS3ZA31s5MwAL1qo9cetC2EHcBwQ3L6wxtKmZIUT5C+/C5Q110Rog+9i
	 GlsRpD6Mw7jHIW65xKdbYxf4XwpVYLrCojZASyzIapW1MTb75Z53HlzFPrFxoVhdyk/kKBAsLET3
	 340vpJumhJgwec5gRqTLq3Hga2d1CppBT8F7EwUZ4wvH65scjd/C3d/vh9dFt/Y3xO2mS1qGJitd
	 NwWinoYcOqg5/IPzKge/GcNhq95Zk5sVDqd0lj7x9h6/fUV1sY
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
Subject: [PATCH v1 4/5] pinctrl: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
Date: Fri, 29 Mar 2024 01:06:12 +0800
X-OQ-MSGID: <20240328170613.120131-4-cyy@cyyself.name>
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
 drivers/pinctrl/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index d45657aa986a..1be05efccc29 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -235,13 +235,13 @@ config PINCTRL_INGENIC
 
 config PINCTRL_K210
 	bool "Pinctrl driver for the Canaan Kendryte K210 SoC"
-	depends on RISCV && SOC_CANAAN && OF
+	depends on RISCV && SOC_CANAAN_K210 && OF
 	select GENERIC_PINMUX_FUNCTIONS
 	select GENERIC_PINCONF
 	select GPIOLIB
 	select OF_GPIO
 	select REGMAP_MMIO
-	default SOC_CANAAN
+	default SOC_CANAAN_K210
 	help
 	  Add support for the Canaan Kendryte K210 RISC-V SOC Field
 	  Programmable IO Array (FPIOA) controller.
-- 
2.43.0


