Return-Path: <linux-kernel+bounces-112326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF87887869
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F847B2207C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA573B1AA;
	Sat, 23 Mar 2024 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MKC5HAdf"
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ECD3E48F;
	Sat, 23 Mar 2024 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711195989; cv=none; b=hM4NCaWkQxd9sa9h2PtsYZk+vPeyL47LNp6C4KKR8dymx5O9GXPykzIljK6Y9N6oKSD+6oFgneHIhix291+T/Ur8jnGp8zJrxWDZomKjrQuUMW5yYUOOhsTbSc9mEsWx3R9wWZFukFxgs0gQYFShCJXlTFXuaI3goUmqk9iq5X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711195989; c=relaxed/simple;
	bh=fL44BHoWJuapWxF1vtqLCKXKI7WigSwRHJtvP3wbc2Y=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=opX+MwARtRk3sNJtncAqNmLw4erWNrtj4zPyuX/c8Cy5riaKfMQ2v+2iqowUgwW1WFg4Tp9SjrzKfdCoigESO+vsdRaPFT3XFbTZi6SvxwUqClGdoaJhZzWJtWs8QJDa2wMp0ufe7beObiZxyfcVg2gO4vRgcLqJe7mMVVYtb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MKC5HAdf; arc=none smtp.client-ip=203.205.251.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711195979; bh=egExra67k3YChMagH1xWaPLg0q0pmTviVHV20R/fW7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MKC5HAdfQsc2nrepUgBhWJnE/tL7b02SiKi0mo9FTAxMctQZDX15Oh9wuiLxzK/ZI
	 sdHiO4O/+7ma8K/3AOKHVgDP8i+XKoqKVwI/Fk7iMjMykn6Q9tyCWFfcn+7+a7ZzCD
	 93Uy3Tcxn42zE+6HWaBphoMX8QzW46XbWWQULazs=
Received: from cyy-pc.lan ([240e:379:225d:8e00:b91:b2e7:7c69:8554])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 32594C7F; Sat, 23 Mar 2024 20:12:37 +0800
X-QQ-mid: xmsmtpt1711195976tu1lz28yh
Message-ID: <tencent_6D10A9C63E3E0F412EED33477B5CDB98C207@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8RA6sM/aK2Q/rOau4mOSO9cg/EhJ5mg7yFfp/oYnklKbxnc9Xml
	 RjF3T8lkX7vUn4LpjxulPMX3NLCENF6YShfieexD96piot1adQWkeEPkyG3XfvcwnTNUaKAOH1/1
	 cx4UGxRRe81wnfHJRJ5f/Iy1UQjpbnm/7am6aYwJdwUKfhE/LEa/cTNPrRKuFRRO1kxiJWfczI5D
	 gP0XOQi9rHQXYiKTNrV62ln2IMuxkcLRafx5D8gw5dPhv50XDJk+ZX+qAVTmWBck/JIPQ1vUDsNN
	 NaioEnqxq7csmhAzj6pK/E69MaKzrTVWtRwyI6Q+4AwECqjDDOLNgGEnAJOrS+/dKBKdqsxIaCPW
	 tGf9NpWIYJ5cvo4JLK0Z620dhFZJiwnlpvF2MQOIJi0nWW5DazXZ9KLpf3AjrdiklumLHAFf6glf
	 cyq8Cs8AWYbN3vd3c1/VcL8R9cVIokV1K1qb7g24/sfedFuQZg1C6yypM+b38LnxwZ9TBgyXQu6e
	 j5paGDvYab9rBBSDO1eElUcjmeEdTZdJw4gVyyQCiQ+vzw6G7+9hq5pq5iEkT/lGeW0cNWFYikeF
	 1/80kIa/gJ+eoja4LHpO9fMYmFbwwUZXnufVOMrLi3Ht9L5sBLsXG417r6IBA/KTEEQ/zNWwz+WJ
	 Mdys69aenjTnGvwWnAj7WXHFV/6ANDvaA21AobrgaO0ypImlPNtUUVH0gJ2mbWy5h1z0SK9HrL0+
	 H81Uv462A15s2nrEzwu+7bl+VeoG16V2qiX9YKrcjIIQuTKfOLXWkbTgxyyrAKGOSlArDsUMFCd4
	 JLgbLfdZilP/dHZ6WXTWCETd3/aky0wnbK8PX9YKb7x/N+A7X27eUcejnsdoZK+jIpjRCw19OfLs
	 z0TSnieQZqyxk2aFqraahR5yYgwhSHPQfjwvy9eUARMmf7WoOJEbchDQBdJzynHCXqMyeQQGhu5l
	 6phj/wkl1FvQ2+ATXBIvoCVERXC7jHPbYXWRGKbwsRtxSeufy8F3jCPq2WVk5L7H7LtPFQhe//ls
	 wpn3a9uzeRtVTQR8HS1pSuw18uPfAklNhF6+sWXqrxIbGenBOGFXGRiJ9Yjnk=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
Subject: [PATCH v6 08/11] pinctrl: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
Date: Sat, 23 Mar 2024 20:12:20 +0800
X-OQ-MSGID: <20240323121223.1729328-8-cyy@cyyself.name>
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
SoCs is already on the mailing list [2,3,4], we remove the use of
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


