Return-Path: <linux-kernel+bounces-91272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 198D3870C25
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5488C1C20398
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959F11C687;
	Mon,  4 Mar 2024 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NsaDB7PP"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2B8947F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586394; cv=none; b=p6jxJ6DtyTIn/lav1CdAgPY12x4Aol5kBLxbrDGtnAMD6RYI6/R1DoWcbxkwric5suaw9gYRdxf3CvCRMcfLIpakXWZrcjcaBZhRavyhrBLww9j6FQ+PuMPggZVQVbVWMWTaypxQ0NtrYsHVwBVY+ajq8J8+jOSbNz9L40j7V2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586394; c=relaxed/simple;
	bh=iIg1m/HJGO+YBecXFqvZUlmsxmUTnWYkXWH5ivM16oA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=cEjHx9f871/JazZU9OQPeVUganFsmettC8mzMTaplnV7B67NdmBUhEnPVSXac7NTkbQS783ooFk4xPyo1M2M8/hNwf9dvKVa3UeRJlT7OfjvjIo9LeZBGuY2ELgB79y/T+uWClu/O2D4sVaXORa5Na5qM1/YGV7+ZKl3sG7umJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NsaDB7PP; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709586388; bh=s7QEg+O5WzM5yI1q1lQPoUf0e90dpB5qxk5MpOdViLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NsaDB7PPAxypurlm6rlAl+cL5nLuE8Ls1vqlARtzQI6ah5iy0jAyNZWDmkGGHmspq
	 SqnPbEpgG8Onklrc+C+P2YXL8mKnR4FHA0tlXMrJzN+h5zfUfcikO7abwhOWORD9X9
	 4TDjZ9VrhrhxHK5t6SZ188hbQk8VAHKsgPsz1rME=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 1953A8D2; Tue, 05 Mar 2024 05:06:21 +0800
X-QQ-mid: xmsmtpt1709586381tcdoc9q8g
Message-ID: <tencent_2C7B0851631A9F9AA0A4F6A9E30EAE5F0C06@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznRKnYlSRS18X9ZwJFLn74xBtXc+wY0Wb28ataBnC1sYFWy81Njd
	 ejrXyDqdB5c3TUxeogi9GQtQzV9z680J2JVlXFSQ/wi/808PVqbg7m/SaWAQDwb6hyhB5ld1zeYk
	 9rxb8WbosrUYxu+cpzUIDoSfoXqWW37zqzkU+25WvLuoKUkMdrAq5lQg5CViq0xSAc7fonMSerF/
	 Efx0w/0juW6BmjGDbxTzeZjpULgAqjwyWyK/fkGKNkyzNdMOZBMIwaj3UxXfQpd8LUQoHrUvxkdN
	 qQqh3CJaxT9F317ztLKIy2XeTPQnX9lsfFmqRIrwt8a21ESzHeYbGRdByvZ3mlVlfMQXf65CRADd
	 GCQKMGBazhJ4r2qGNHG0IqTLrWkyZZ5Bu/wAZ7v7wg3v2IIE6sdpXsjC4OW0Gg2RgspucXF+V2Cx
	 Tq5GOCN3tH7qtocIRbddcfw86PP8AXx28CQ/Z3TiiNkqolXM7CCBaFvgVevmBmjJhL5TUb7h+NRv
	 /j7SpEgPwU8+nst/yJ0Ztw5fzP7v4gXmFp9eO6DQg2g0fHSoIbdijGWho2qEogGtck1G/m8gNsi/
	 XuhpJ5aU0NuSIyGD/NHELLBpkr7SBVPIQ81uuch02bxGAM/SXmuw/1naezn1a8EY6Ucgq3PSRk1S
	 NoQ+XPssbXVmF1stDDheEbnsqFxu7gn+tbR/yv/v4l+g/BOgUBQxBTQhSk+7ZujbAUbMo8Ws31fj
	 F72evz97+jszst9CFrPyU/zMRAUpmFBEUJEO84h1v+J9+Wgn+XF4PrFcDkG6WUFYdkhTqwMezSwN
	 E01xJNBvL8DbBazA6iEWyMwVyGeZsdDjcxH395RWiOf2bNM/ZeqF2CSpCBHATmBy5eeBwdYVOhLE
	 a1oCSm+N1rHG3lOc4CDFdPIMnSBoocHB5UxBa6R+ZpmasFYxwEC7V7NmxNH9pfGZnfTVyCHXLLLA
	 x+5tdgR+lMCdJZGz8LxytPWe1KQkjGBwwnBpmMibKPKlTbCfOtspbVKykbN7pzOwrYxTOzrEOmE4
	 gDgr8qagHCG8SD4yJGclpX5SBtV+g=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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
Subject: [PATCH v3 1/7] dt-bindings: riscv: Add T-HEAD C908 compatible
Date: Tue,  5 Mar 2024 05:05:55 +0800
X-OQ-MSGID: <20240304210601.777883-1-cyy@cyyself.name>
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

The thead,c908 is a RISC-V CPU core from T-HEAD Semiconductor which used
in Canaan Kendryte K230 SoC.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 9d8670c00e3b..e853a7fcee8a 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -47,6 +47,7 @@ properties:
               - sifive,u74
               - sifive,u74-mc
               - thead,c906
+              - thead,c908
               - thead,c910
               - thead,c920
           - const: riscv
-- 
2.43.0


