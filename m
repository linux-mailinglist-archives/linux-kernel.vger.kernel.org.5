Return-Path: <linux-kernel+bounces-89751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 235CF86F519
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5D21F219D7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0935110A17;
	Sun,  3 Mar 2024 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ln4A1qum"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E734F9EB;
	Sun,  3 Mar 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709472438; cv=none; b=Ncj5M6tSL1SoZUVGFs12AUEJIoxFT37MJHDpvSVfBRrWFAHyteB1oXF8nIaetjzDn2pnrhdGfGQS2KJvxLsrsmqh9mvouulNOYwk8QWHi3i30jN/UF8uH2aK7xbt++O0cI60KuYWUtKpQZPzGcNeisN1mYg+lEDfqrtjLgv66q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709472438; c=relaxed/simple;
	bh=NbF7f5ogh9nUMZMaLzVmp6AZ2KpgXsBCrTJOIRIb9Yg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rB/TXfMsG5hu3/7VfZpcZ+YCp0llnPnyppoaye+k1km6lfyf1DjwbMn+8lmxRoCaOfRzQtgjeH/ACs81+HtW213Ue71YC52t+EHBU9beiNlce474cIy8wecuZng9l5uxBVStUqrF27IIzkgOvzOZdSmVJU6FjXVQNGIQY4v4shE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ln4A1qum; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709472432; bh=rFMECsDJ5IFHw+IvpG6sgKMg8QyjajlU5QopKTYKlmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ln4A1qumBAqoTIAKgaLBFC6QtV7V7+0dmv28Ado1pYk9JNs1awiDQUha2caE4jYzS
	 lZzr+XDe3woxxrV75EhL9cO92lUGVy7iFyDbb9KelF8haqtCiqRvcZWBWn1Vm7o7Xp
	 5jTPZsdaKLPrEpZZrHwvT9DgpVJ1aiYEAy2nyrgU=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 6C4A707D; Sun, 03 Mar 2024 21:27:04 +0800
X-QQ-mid: xmsmtpt1709472430t70p75nqs
Message-ID: <tencent_4F1B21F8A605B7B4091DBB70B5635442BE09@qq.com>
X-QQ-XMAILINFO: N2/jAoEINgTTzf9liOgkTdvZcW6SafzHc3KT1jJ7uCGqdTo8dpUlniyEwVuc/h
	 hr7U6mKSsBM2SzBYRQW4/5CKh071601RFdmNbaI+qEUoLU5zb1FAHfDqA+Dr1+ZN7taur6LnIzU4
	 vvNWVibvyjZ1A1aiB+wMMET6CFJi7m5ssV3Ut4g7+/KHFVpsyLZYMSolS5q9d6ertu1wCTKw1+hM
	 GHVLi0rNOhq50WKozjSoiwROJYClkaPqV8m8EmNLFfVw8gVpiprxtldcqO1V/S3B80F3cU3sijCW
	 qzxm6YhxyLyKanVmTOiG2XIrFZxwaxgsf5v8QpMa16+kMWM5zy7tCxXq4W0GhfL8LtdSXRTpXLVf
	 S4H5FgsyUJb2SuksYPB5R53J3+Cx9VCKMb80mjMJGiok7/ebIUBBmUe71uhabjWpuustQW5q9l6U
	 scsQsr7oGlPx2rcaQU827xyCwMewBxWh/Rrw+AwGcJEWkwMDTkJL6zHJ4qIKp/1zTF5MxsB08hyb
	 HfE9eZj+SODdhq0T9lizMzJnY4kxnbLyJhTZyyDuSLUDE7h/e9xf++uke8xidWIj10vBrBLpkP6E
	 61BHb8Apm8ExmowhIjoSAkcoZNsEV075AUTZBXvgSDSYAK5kGi2aQaErsw7dHUVufpE3+Z8tK/+B
	 2t2/JY+bJTRuGvNYvAo/zEowsz5elEjyslPG06aLvBH/zXVJFvdv+nI0JGy/ua2Lpd4sOL5ptpTO
	 O50nV3Gi6vXEb65bPyCjCKdHSE07DNAyLcp8SAtghb8HcbMeukZqX8SIfw0T1Bc78XP1t7ozfyl+
	 4a8npH3PizYgTfEd4wroXfpiRHXbWmHeLRnYpGIoXAMkxMqJ4YDf1BK8FN5ARJaYOftxDa3js+wM
	 hGNlYvba0aChvI3hYfHSCkP4gf5D7Zp4zcl+QyY64Me1jFkz+UWsdZ8iaReo22EjmGKlUSBEuk3g
	 HsUSb+b2NeiHG1ldShVk9kZUcSo6enhu2hvutEVut0YsczXbWJe1Pedm0BYNMSithifXWlqrjyl9
	 lxoGzg/Upgp6tdR4/zPfYmwfIcD7wQIWauNLuMGlWxVVmSptA61T09iksvQRY=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH 3/5] riscv: Kconfig.socs: Allow SOC_CANAAN with MMU for K230
Date: Sun,  3 Mar 2024 21:26:25 +0800
X-OQ-MSGID: <20240303132627.553698-3-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
References: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since K230 was released, SOC_CANAAN is no longer only referred to the K210.
Remove it depends on !MMU will allow building dts for K230 and remove the
K210 string from the help message.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/Kconfig.socs | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 623de5f8a208..b4e9b7f75510 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -75,13 +75,12 @@ config ARCH_CANAAN
 	def_bool SOC_CANAAN
 
 config SOC_CANAAN
-	bool "Canaan Kendryte K210 SoC"
-	depends on !MMU
+	bool "Canaan Kendryte SoC"
 	select CLINT_TIMER if RISCV_M_MODE
 	select ARCH_HAS_RESET_CONTROLLER
 	select PINCTRL
 	select COMMON_CLK
 	help
-	  This enables support for Canaan Kendryte K210 SoC platform hardware.
+	  This enables support for Canaan Kendryte SoC platform hardware.
 
 endmenu # "SoC selection"
-- 
2.43.0


