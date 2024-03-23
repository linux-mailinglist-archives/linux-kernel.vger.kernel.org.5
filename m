Return-Path: <linux-kernel+bounces-112328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9CF887871
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53875B224B0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696654174A;
	Sat, 23 Mar 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VEe9MiCE"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC9F18057;
	Sat, 23 Mar 2024 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711195996; cv=none; b=KVDRLM1WbRQUchNwGs92rYfkilERQdDg1fMrRKz22bHHIKRFc8SUjiIDl/y3m0AcKYld+cjn0VRV3JZGPGIGpEG89lnF24DNgcHFfzniDR8JygTzJuCzEoO+kQ+xXH4ljrWI/pyWoRvSaVzfeIEADr2lwWZqYNQXtU/TV2rgft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711195996; c=relaxed/simple;
	bh=ltIIjFq44lCINtdu+jtCNpd5iuP8k5qJZbXbXOcOLIs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=G33RXr/PhdOWfOcAnUfdrKqm+F9c9+Fav5RcUWUg/zEMVOVyCx7/mHTyI8d74FMzt/T7f7V0nERUwdy0OONJJXt6w1Pg1I9wO+UO/T2utsnTnoNS0JpQI02aDmallbrRE3fAgCHnDG1XNYDRx9WhTaxwnmdlh3b8WamAspYGjXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VEe9MiCE; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711195987; bh=zZkfplMllcGZXaAHOpijHZhZw8UR9G8J39uQSbllctQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VEe9MiCEtSL6XIltfGKIjLdJxBdxoTn2ftxcoAjvNgs8mgWi6Hc4ZFvXfxk4qV78v
	 LMkqn9i5HrQSj9zqCSt4l3lCB1FeeNK+Jnl+q6QmuLUd0QeYaRynuZGVq6CL/Xo5EZ
	 0LwnexVF/dJ2+3cU7B8emJDUWlk4Wc9DSjJZJwy0=
Received: from cyy-pc.lan ([240e:379:225d:8e00:b91:b2e7:7c69:8554])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 32594C7F; Sat, 23 Mar 2024 20:12:37 +0800
X-QQ-mid: xmsmtpt1711195983tnrpaiiik
Message-ID: <tencent_E3E0973695E3306E5D4C41C84DA30F5FB506@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeiexUNVyYWNTlxWuqPcHDTGFQ3bWaqzeOLy8Zyn+2kMxyOmMrE2U2
	 rhfI7jZQWix3KgacKtk28pjhwFUQiLgDzU5037aHSyAs3/RXqBbGThIBIbA/eGmP6hZW5fA4wjlM
	 PpH3YVcID2ZBakBIwLuuzMIuRXsdSOhoL5pnk1VRRrpdZHPDs9ZPKgIVpfiUKKu08OHqweEWQcB9
	 Lq4Q/nSvRQoCXqrv3KO2Mp3h601TscUSkhdj9bOjQ9piDqkZXasTuxgbJrIm9veGmTtvT19fKi3P
	 c1BwQevO35E6KGoeX/mTpfBkgIPiRqw79j2iOLtEU3WRGDBTOvspZ2sQYxJkGvkuu4BctknDajTO
	 wvl+Khec4apVpV3fLqLJZAL/D8LhjN53S8qhS00UJqLmu58Qlx8jprnY8Fdme51PgvDw15VtoK3a
	 Vmvt29QUZpVkqDQ7lAJ6AyeiomaUCN/yxQPgSQ1KiNPOes4Je3sHfJFyT+QVPeYKUofZztCEJY94
	 yAOmAUUVFzVBU9h1VmqgIPWZ7kNT8U/cZ94jqXGhiUZncNpFZNjqilFKkVOmdgBvLMA4MkNItQLW
	 pVKpZq/abV/uyxTK5H8b4IpcH9+nYJ4Dt6vD24GXkmvZfaLXkYjAWlyNIi8J8/FaPPGkVD3FpGj2
	 wmxXzV/cBctc3lEyzcuTZHxdRjNzehljX0fewMO8WN/qcyMqBRybfRlNUF9zs0Pl57OeMm4Akifi
	 RK1h54ASYwhVV48x3tfgcW6ub21X+xz2uhhNemVFgmk6zxASYR1TWYYn0+rI7YQLb5mmQSXWzCTN
	 dlKa+ZC+qMmMBQJa7lDKmsRDxzSV1m0aaKcVMaMVPmCU7KUl/fYKvlCrAiPO4m3fuhLXBngJiBOq
	 lKoKaYv7t4vvlRQf8AOyjfB1cEljZwGMzu4IR9tIj29vrCi3cQaFoc1UVAkGtRY5tFgTZuyFG8Vp
	 lSqT3o+LCj5LY/WC9Ak0M73eRjjQkb3ObLk+Z0zU4TG/EFMqxFVbC0A72qNhar5/TyLolEi2TZMm
	 r2+9PEpn35jlVcVI6AUQ6CioywxOo=
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 11/11] riscv: config: enable ARCH_CANAAN in defconfig
Date: Sat, 23 Mar 2024 20:12:23 +0800
X-OQ-MSGID: <20240323121223.1729328-11-cyy@cyyself.name>
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

Since K230 has been supported, allow ARCH_CANAAN to be selected to build dt
and drivers for it in defconfig.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index eaf34e871e30..1d5524cdd47d 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -33,6 +33,7 @@ CONFIG_SOC_STARFIVE=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_THEAD=y
 CONFIG_SOC_VIRT=y
+CONFIG_ARCH_CANAAN=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PM=y
-- 
2.43.0


