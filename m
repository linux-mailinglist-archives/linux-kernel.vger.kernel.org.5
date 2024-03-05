Return-Path: <linux-kernel+bounces-92931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1CE872845
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466431F27FE2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F1612AAC2;
	Tue,  5 Mar 2024 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZouTvjQp"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21212A16E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669006; cv=none; b=LsFYreLMVcdRsdRJDKtU8Pm11q7AeVI3Z0kfzWMVtHu78hK4SgpztjueVXyfY+VoYzdbidYG+1Guy8N9sldo/NaKGfc/aV2zxV0Ti7HkQuCD+E/u3IkZ5MG994OanFI15kInvPjSRKiTK0J+RMnVs7oOou+r4oBGpGV9GbtjH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669006; c=relaxed/simple;
	bh=zbLGPCosxyiyPvcOeTiYkPlr94hbstxP2Hhj63j/SKE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iDcei7fZBYaMLF7Q0S5T3AEoz235NddCDEyNZFm0rXC1tQRb6m3JAeh0sp1i/cHfQ18qkiHNzkDtPONXpzIg21DaHCeACdDDdUC84BqE0/+0Pzby3RHBBM9Khty+qCeoBsRHtbuhjoW/m1u4iXCiMsvEusaBa6uUmXFfrCq205E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZouTvjQp; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709669003; bh=vpfgwixO8WjqhB/6stnV1JiUyPCqfxYij9zHMp1QwAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZouTvjQpf1bZ9BeqPtAUpKJ18sKL2h8ccqHJA25scMpqaa9lrhH7kuogGM80FipxA
	 ioQtAriCmW2mVkuIFp6tWFOLS0G9uBx1DcVR2dQM2WOQe8miz9wOxjjKOe4+UXBXPa
	 lAZeq7ijlMgCdNIfIvmVKJbT19nVXX+i3s7q4BuU=
Received: from cyy-pc.lan ([240e:379:2267:e200:bd8:e8f9:fb59:de48])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id C898283; Wed, 06 Mar 2024 04:03:08 +0800
X-QQ-mid: xmsmtpt1709669000t3bslh3mh
Message-ID: <tencent_8E66E30C9FBB60BB36B9230E2E56CC770806@qq.com>
X-QQ-XMAILINFO: MiIS17MxlZUacsC+x3E/aOAgPni7ooIVOC/z2wi/LOdoBJsDW6ySDB6qGkTo3S
	 Loc6IjHEkJLxIW/IkNxe2jCwM4YYYY6ZLJ5lLYjo6GH/EwQM6BrbA4CPQTSw1NMeOSmCqqpqKO0E
	 8+UYvzqZIcP5KyJMTnH5un4IBq5v/2D88UAZ8CpyAsRnQoJ/bCO7io7uXoQsq5a6/VvgJH4AZ+f5
	 LqnHaIKbJQ08wQIuSzVDRRxVc62vMHOsxhfD1PL7Nty6xH+tOnxAy2ooHYNSvR5r9QE0HV4GwO0i
	 PYIM1h04pCKcwE/CWM3oRVSFlei3h77GbRCigJcC99bPZ5v0I8ERMA2IGcpI+5y1schyFIY081il
	 kTUaJVb8yEK7wT2OvBQ5GrisO0BCAWuoRc3O6PTnEsncZxmaHSGiDk3drk+i4vR5NDLZcR2st2dj
	 iWSxCEgeWk/Gy+vzR5W1To8CXoGOiecrRZnmiNI+9B6odoKUNOsPcsXWD+s+++6a/xin/v0qsLkc
	 FdNN3cXvoCn1I7HBvumtGl5BTxDPgaWOpFZNkYs9a/8yZfVeeXA5FzGQZhdCrFV/e7+1FZjj4G6U
	 KXokBLkuY5gMe5cnUqdjOlmvL8M+l7L0pKI4g6q6CI8YaQ75+CpeP7Wq6j92PNYuYDng8/hTqZSA
	 2ijoOJ1WgpYQJlfYVZj9IOLoFDjprdH6pAzJSCD7fOgD9FJiKdOWL40uRgSXnc1Ec1YFR3TbtYVD
	 KI9Atu1TozIQDzeKJ7eaH8JGMp0kD3aO5ev2QgMz9zh0PPqZPPNty8OFGVUSapjgIHdCmo5l2Yo/
	 acOZyH/9ee38PL2/eVB+mNDaUiiOxGwcdvaVH+Gw+btkVSHJ+EdqXAL5kSPplg+9HIo3YyvxrFJU
	 wqqT8eCBsTxnCeg+z79ycrpD3xXSFHNAuN/DD+x8wD+Cq3kMb4L0H79zDacATnFO4uovuzZ0fw2F
	 TyUQFVHsBlPh5r+SK7YElisY9SjGg5uh9W2XLSbAVtQ/rUFHjtTsBR4nGrgW5VH5aidzsPc/WUPU
	 f2kq6BrlU/IdgH5TgSjfKJfSf7UG3mbtG8UTxxzs0JLCC4BQL50I5yMC85kNwUwQhgchtmcdiWbm
	 4ZK7PxGj/Z62KU5JiTY/LDWU12t/KhPVXYjVucYO4qf3o3XNDDhg+mwoIUVQ==
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v5 7/7] riscv: config: enable ARCH_CANAAN in defconfig
Date: Wed,  6 Mar 2024 04:03:02 +0800
X-OQ-MSGID: <20240305200302.1093082-7-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_FC10B3C630BE27412FED2547245CBE18D807@qq.com>
References: <tencent_FC10B3C630BE27412FED2547245CBE18D807@qq.com>
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


