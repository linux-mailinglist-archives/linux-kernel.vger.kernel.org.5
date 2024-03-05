Return-Path: <linux-kernel+bounces-92899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBED8727BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E4A28E3CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766BF12AAFE;
	Tue,  5 Mar 2024 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="L5iOEki0"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F912AAC2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667560; cv=none; b=BDVNcvKpTmJkzWA0zgfPr7to1mPUtcyCAvhKF+gUIPnpRE8TaEXIliv7B7Lmf4Un6Ruqt/hI9SAdEgUqExsf7A4BA2ypGLIgQug/Mjdf3EOHRmoI6dwReGTeY5ikSLaGha5tDagUHjnJn3xcl+cOevfJk/NXWj/YldKSj/rJew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667560; c=relaxed/simple;
	bh=zbLGPCosxyiyPvcOeTiYkPlr94hbstxP2Hhj63j/SKE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=MPZCUuEHgJ6UxBj7nNTpawZy8ZVtUX/jCJZtWD00i/hxrR5wlPT7z9TpoecyWxPwsVkpMzsQiGaz07TsemjUY43MApZFSsxD9Yr8wZhxDVQopf8g9meWThnHosg4FExZZsPmQvbhwkZO7eU1pVTjq9Q/gAtYi5bHPhCS4yTBkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=L5iOEki0; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709667550; bh=vpfgwixO8WjqhB/6stnV1JiUyPCqfxYij9zHMp1QwAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L5iOEki0/Vw7zzMQskadGa90kyC3VahLZNwWk9SCknaaAKHMJxBtoRh6ceJh2uHii
	 7run6rXbGwm7KRk+1PLSIgG6x7fU7VJX8qulWfOW9iBtDVQV5rt3OTaAfzgdL86M4K
	 TKVnTZFju0aUDm+EoAOpvSZGlpl5fF8lr8NjBuyk=
Received: from cyy-pc.lan ([240e:379:2267:e200:bd8:e8f9:fb59:de48])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 9B6B9246; Wed, 06 Mar 2024 03:38:54 +0800
X-QQ-mid: xmsmtpt1709667548tsn8fl733
Message-ID: <tencent_45B4891DF371D3632042AA1BC5F8B6042509@qq.com>
X-QQ-XMAILINFO: Nq1uWKlIb9DMHn+IEp+nCFc4tIpsAONPQpmFByy0wSlIjTin+PQGW/T5EUAqaD
	 gBM+WEyXHZVL35R+I7Ms64Jqt5JB9ANcQKLf85RT6ffCXq4dN8qRsuw/N/HOrnaHlpaZRBWRxxgJ
	 H3cd55o1H2QlGRnhO+rwHusMM2myNLF381LQMWPiRpeY7J0AhD/ZuUPntQirN+RlfY2+51HKojjE
	 B7U2ztdR7NhnxHNEspzD5GSDrlJDgLF97hG0MsGgKh92YyHEA5SvORUqBR+/hFjqPlq1+CKpGqKG
	 Zsm7Ao8Mr/mB1rLc3gS23IMQrjf4zoYiUarKzJ2uBbejS7j5H+5OI8whWfBJagxl/LVGIG4LIaFZ
	 RMiBdZ4rD9kmeMIupjASOiebkNEE2f0xvqn6hOmZPqHNNrbNE72Ykoqzo2di9Po7TVOUlMmPF9TC
	 4DRJMx5so6Qn4ZhW8d3vjRidjm3Qz2eW9v5UMr/MhtzgSNZmib+s8j1Lm7xXatTV3Jxsu+IZJLDk
	 MCfNHK4mq0hMoWWTkH1QXIYsA3DgWtARIZtENaCMPAWOUdpB7Tcy+U0ntXbgwI9zeioC7InIL8fM
	 Ynk+7Cf5q4JD+bmNAdKAkad4FyhocZWcSeEu8EOOVlSEmQyOvOQH/JcitqF9gS0+sIplxtLTrX5l
	 4CVAhrW8xr6t25tYz16Voogx2+OejjGDCnbXVBNit/OYCJL+DpgJxAtSGaW8/dEkeWIGFBDvvtD4
	 UnvuvCj/YdknlIbOZWduBsx3+4fG9fEg/xakFypS++Nqnx5+s00jW1EvOHhQX+ULc5im3ZVgdcPm
	 TNPsXCIZKZyDc8Qa4fuUO4X60a/ElEAZh66jE6Z0Iba2RvT+G+XLKJOx7QaVl3StQFeFHsi69Cxw
	 RO7A7f4sFdn0dDwi6F4CS8NnX2qDTAgapMk2HmLHcpa7zujRDKVXPcPekCkiQ3P0PMtbIoF2L/TA
	 8gGjD0Lxap01JlHmQMTsa2jhullt3GJJG3qc42lq6G1oJs/UJ7wOlUOrKKq/O8RbquEp2iwLW/8v
	 Tco09Mg2PP3M0bwNmBLOzQxOjWYWns/wJFxxXCQ5VS/pC1pcJO
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v4 7/7] riscv: config: enable ARCH_CANAAN in defconfig
Date: Wed,  6 Mar 2024 03:38:31 +0800
X-OQ-MSGID: <20240305193831.1084556-7-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_587730262984A011834F42D0563BC6B10405@qq.com>
References: <tencent_587730262984A011834F42D0563BC6B10405@qq.com>
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
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 89a009a580fe..f89df7ddb543 100644
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


