Return-Path: <linux-kernel+bounces-91278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4196C870C30
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75461F25A41
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3EE7CF32;
	Mon,  4 Mar 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jCWlCuWW"
Received: from out203-205-251-27.mail.qq.com (out203-205-251-27.mail.qq.com [203.205.251.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8931119B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586410; cv=none; b=NsKE+eWtEzHKny8o8W7D6Q/deUB27RQPCuE7TBKqjfdwCCYnu8JFZoF7L/n+PuerByrnEUTqJW1gJtw1+e01m057TCNECHYXEN1BxI8N8SGiC9MKWiC2kwyfDAPmwAftVs6nptNsC9V8Dj4sb54kUwcPY+44+7UfROJZKp5R4qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586410; c=relaxed/simple;
	bh=1RBPyuhoclV+3nHd2TvOxcik9pGmejSzJqo7b+biXls=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=doW2I6MBB3Pseox3KoFEhRa9upTe91NSVLnBQgfYLu1we14a956ogi63FV11K8JXHr6B9JUPyoPD3yaQ8I6+fHIBKEUvt77oOEL6rFM14W+kXLQL9z/cp4DhPsTv0TIINeepbmKayGtL4yS5DA1VCFDrIjc4KAIcSgmrE3reo6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jCWlCuWW; arc=none smtp.client-ip=203.205.251.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709586395; bh=Zq7j+pO9atzoOOHePaxM6b0KaYKNJGrtsSo0TfDn0y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jCWlCuWWYJ+fJkBYSAkqEsq1ls5f86p1GxuWmY0LxyrG/PVlTxT14rD6XV6LWWkPn
	 Ytv8br/QLJz98aSWlAbuQjGrRaBQfyEG7Uqdq8P0Kh1vWqbBuV7uEbQhjn0sNwyDgx
	 yBbKsIk6ozwx7hbLBjqXLwrVqG3n26UDW70tjNgA=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 1953A8D2; Tue, 05 Mar 2024 05:06:21 +0800
X-QQ-mid: xmsmtpt1709586392t2jklroa5
Message-ID: <tencent_0432DA968E39B81431F921F38D747C008208@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznhZHOdB+wuRpkNnO5yKpQhBGz3UE+dIQLnRktOPULLHEmxRfoDI
	 10MK/zPIKLM9Wdte/vVxtDXfnISN0jLZyYGa8nhKf1ZprY2DFe+64VyfP2IUq+awXf/vWxAIb+Lk
	 Mjs7vMejHw6JXf0ojrByWqdB5nhZkZyFUlGDWbaF7S6/w8zXuDJgdhiAveTAww+h5XTbFLjPhsvw
	 9sPI7bIBe++kzJ5l76xSsFAstQemDIXeWjjsuk6Oly71akKd81qbmMPjzg8YcT9UqytrkQTN3kgE
	 EzKoLfTrhzn5Ecqr9dECLh193hZ/MrW1s9MTT+0Dy94oX9uVkf+esIDMY0eBM/Re5pIbWGSg3FaP
	 21xCOhFh+eZNuaSWWPVg6UmpiKJw9Mi3E0M+mmogea1RRDwx096oRy2HTMh4ZyJOe9UH452P6367
	 xhIb9k/Q2jvtzPJ+BMQgRc7AqDS4Z+ojuL88KRt1Yw6uqISFaIeb0ikCQ0upFFwO5eXamYG8Vr9O
	 G1kqX7OPxdOgdx3Xvx3PEcswKRk3Qvmu2VWesxwGIsGIzsWVHNaFlJueDsH7gIIgAETY/BvbMqyv
	 P56tLLGvOzzqvpCczNhIUdGxAil0GIxRjS51axcjWDNcXa4hVmTHe5bWPpUeRqM+qvVAEBQIcAVW
	 dIT7xiabdUysS5sAFEuIAXZc4itcPIr9Fe5v0HO6tsWb030akqtydrJSRl9IlCpbR3GkFpGOm8/z
	 e9deXPd/JDHNuAKalcCpFrLldloua+giZbKu8tCrrM70OfmwTyAHFy2VlLG3j2nYVzNaMVuOAPKy
	 FHSOc4d4oiEfFyOcRvjH1kxpAynbU3E01Wu5z6zkYE9sNazTygt/CMhZIQ24CC2oU1LLFbkfdI3W
	 Fw7oFPy6sR+hnvCQjLg8foorVeO+sQxlHAhajs17QX4RH3+RNya0icqhH5Vmq6l5vYmX5CPfSGnC
	 +S804c95s+Sb7V0Bez4gud0p8QBY88pzYAnqAqqRY1sbGejWofgoEgKEI6hPtAklItqGhA/NCdoQ
	 5fGsQK4Cr9PHceujNi
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
	Yangyu Chen <cyy@cyyself.name>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 5/7] riscv: Kconfig.socs: Allow SOC_CANAAN with MMU for K230
Date: Tue,  5 Mar 2024 05:05:59 +0800
X-OQ-MSGID: <20240304210601.777883-5-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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


