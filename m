Return-Path: <linux-kernel+bounces-90806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34B687053B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B2E5B29063
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878F6535AA;
	Mon,  4 Mar 2024 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="j3ol+2Jo"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CC74CB36
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565420; cv=none; b=P16MvYAYu3fHOjVxf4r8vCH79qZHA7/pUL24ZyaighJcvk/YD9wiWdoEBYfMwJzykta3SFaeasFC4rrtq3I1xrZyaoOFb40pGbsV3j+zsOQBIKJ10WWRGzO35buYUTR+W5Icv3t10rAEFlw5QCzruwALQQiEL+K48szXQ7LXzvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565420; c=relaxed/simple;
	bh=kOAHXIVkNpGVFPmgvWaDzJT7LEV1p/mFzFaumoZj+yo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=GTtvOU3gz7IQQwnUixGuDJLdZImkq8cFNIy+2rc3AwLw/j6gEXq0koYRYrOZnGK6FUdXLqdWbraCXbOOtvGxp5m3lEoq8z9m99ERa1K+YO7IUnPJ6MqdQH5blJDw6t0Ew5LFDCjBYyjll8byJPT67qdpEuKcGg879+ozElyrzOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=j3ol+2Jo; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709565414; bh=n2s+gXwdW2+QjJ47xTyefHF5QVT8S/PZfQcur2EDRe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j3ol+2JoIQBph5BuNY5V5Szf5bJnT0hygqPtwgwqTzSEeBfsGwmZ1QhmsJ4TsZufN
	 msiWhVhaRGvpcCpWM1neuK71sMNtT2Of7m8krmvXUoNlSUWzZW59DxGcU2iIIXP+UL
	 lsBdf62uWj7MM8lV/tI+RlHzkgY2Jfos3Bg0KY84=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 42726AAD; Mon, 04 Mar 2024 23:16:39 +0800
X-QQ-mid: xmsmtpt1709565411tqrwawkx7
Message-ID: <tencent_FE1B7BF85E04C1B5C51D7F707D6204436809@qq.com>
X-QQ-XMAILINFO: MM4ufCTznNl4MMW3F7b3Ci74hjocqi2o1Nihg6PtsJDuuka/8lkKOKSSViFeiX
	 7CE7lvTCYTehIzUI1qKDREa+4CRiyqbM2hu6vcdDoKNG90fQwD5fD9IuSE/HcElo8x+dJMO4p6V+
	 ohW4++CDtyjeFrXNGks2vv/C6JdjmhkR0sDNUig5864OlcvHd17ISrzCJ7YS0MvH4auu11ikjzlH
	 0uJLoRTmf9bC54ZVUoE5Ns0I/pYzGsZtJIvOBT4nln/f9dbt5BmwjFaKVuDbh3+Uy2yPj3dhLOcy
	 d19Gl8pKrZVpmWdPz9ps7HIpLVpPBE5HjLlwOinGpCiD85jTH6e5DZM8hW1SN01V7Se6K2LLpq/e
	 1ObOzq/2MpLp2wm/myhzJEIO9shIOYGN154JQSTNtSPyPUrJWfiBkYhuNNeVABm0QwMY0C5WBA/Q
	 UEGMR9xtdQAJfqSUQNDfn6Yvq4sdS3iwRwZeRKPWQYdJGmjyghNBCKs5OUdb2Gyy+HqrCR7VpOko
	 bmtA9mCdceG2yejcwupzL0Cc3LPaZrDaWjSNBJqBj0x29vyR1K2B1jr8CnPsMj2nT/hVuh7gqnqj
	 eHpSYOB3CzE79/YhM5ICGyFZLdgEQbMqHwwcgnRF7ARUnrz7Q3IevKd5pfNGSM6o2kw2q6UUb00K
	 ln58Uj3kh3Kmly5Mkx1wa30mOXJ4LizjWM/jwjhslVDuLGmAET8J+sFraet7IxX36m316aObQLlJ
	 McIpbrzcz78Us7qfdYWF4btBbks9+6dCXn/9VFc8DnudTgvJ5nvezx1+jZet+4d6z/523WB3ZDha
	 1OP21XZZ8JHKmlkEZ+TnhEi8dYAAzE1oePD2QgcbBUg0KOiEYv4wiTSIUSehUBLwZbGZ3xRqLZik
	 2OPViMecRiBaUnbRLXNQ7FyF4UyYZxFQwuNYiVk1iDTmKkFMdzfyPwy+8LJVd/8Ekj4w5w1A7/bt
	 T2BXRsyrlZj7hqfFGyxntSo4gHtXp7jTy/uxx1RDeYP0AASf5cSVIHwEeduuiC4UDqaV7Gw/Iu0O
	 Hthi81egjBt3C3TfyWGWpoEeSHnrsMhTERTV6pf76lUJ8oSOQV9xQa45OZKzI=
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2 7/7] riscv: config: enable SOC_CANAAN in defconfig
Date: Mon,  4 Mar 2024 23:16:26 +0800
X-OQ-MSGID: <20240304151626.759150-7-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com>
References: <tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since K230 has been supported, allow SOC_CANAAN to be selected to build dt
and drivers for it in defconfig.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 89a009a580fe..20b557ec28df 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -33,6 +33,7 @@ CONFIG_SOC_STARFIVE=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_THEAD=y
 CONFIG_SOC_VIRT=y
+CONFIG_SOC_CANAAN=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PM=y
-- 
2.43.0


