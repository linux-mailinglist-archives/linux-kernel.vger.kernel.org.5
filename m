Return-Path: <linux-kernel+bounces-91273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 204A7870C26
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9290B2154F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424C24C62A;
	Mon,  4 Mar 2024 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XSrv4dQX"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D766110A2B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586395; cv=none; b=DeeyIRGB0uIKf91SinC3xdg6xHZwf5F/veyIBxQf/Nd2dverV+/75DdDGQbSnbsAbqGOIKnz7Sy9gQ/UXDeIbosCJs3O4qRRzZ2tWVq/iMV4MvhGt/zoEtCPZmdQCundOM/UBidoKtbLORWBZLB4SMLwyvNqG/4pOTm8UrsaYSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586395; c=relaxed/simple;
	bh=26W00FlULPtT53WS7JJHCeTCGslg4q6uY3zEvZELiFs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=oESew+CfRCBnzNoLA+Tr6FSsWsQpUjsivBXsh0+vKcKOf0RseSX6yn//0lt19NF0tyxtoXowlm15uFhDix5vs0xEKym/QSnwf04RWs0i8WpM2u/gwWTDues6tdIBbMjemgivOOCuddaURcfboePO6PVGIb93CbsfrkMN56EBucU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XSrv4dQX; arc=none smtp.client-ip=203.205.251.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709586390; bh=yn1cIjHa9vkof6V1goAAhCCMm4gF0ibpVzJy1HW4a8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XSrv4dQXBOC2xL5+Wa99iLC++GfdIxdUAy9+UjLIolP8MvHy2kOPDRi04dhTAAsA1
	 m+LUmV7FDtRUcx3Wp4Cmty290Af2BPpfJJugQkLBi6rLCv1GDBlaMKndtq/y/dO9NB
	 hePX8/iIL5m0O6neWtxHJAym02S+mVu7IxAVW6Es=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 1953A8D2; Tue, 05 Mar 2024 05:06:21 +0800
X-QQ-mid: xmsmtpt1709586387taroak3wd
Message-ID: <tencent_919C60B8F6882311AE464C66C86223041F06@qq.com>
X-QQ-XMAILINFO: OVnuYaVQwYrz3Qs08LMvf9PIYBjThuYCGem3KXxKB57Qnaqq3pWtrNTX0zj5jv
	 qck1u+VHEuIBqQNefXcq0v8sWAGOfSFjEadtD4EdSk0aZAk4z08YOdekgs16li0wyn7sdjwmvXL7
	 0wLI4jK6PQJMszFFKvA1p2AULMNO9BWDprEiVdCcL2BjCvDEfNhS0LU4EL2//bKixMzOZ3zWQKPE
	 Fcv39oyYu1vsgeYJ6ck4gxgr/2DaEWE1cyxzolJ1yfDWzS23H72gCBHKV5NlTVLBJjH0UKZvvVhx
	 hG9LCOZVYNh5c0KOTYAxpQ+GiHggTNMJ+D3d1nfR9k08LBjVCopcxicxg762qTmkUOeTNzaEnZFG
	 lV8dAYqPcwF5K18xHrKN4LSvWhmEhnCYGgHcP8Ubc6jkVIGQNg22zVKsS7amICuTZ+wD2ZoDVFqU
	 JPiW7/SoJWo2TvFJLeSaZUWa5UQucAgOMZ3D/WI/bgd3XkNR8hJ0Tv57epUtpbpq94Y9inqqOkB0
	 3XNOYc1k0cS8BGraC7STc/OuDfK4d2amieaTD6WMguTFeb1op6VAIVItKivBP+b6cKCeJIGAaiYN
	 KGXHAXbgkoRPNrxBFLfqLeQrc5x7utsRGyaR4ZeephyoHrzNCpisJRFWn4grwkDVsaaX+A80KzPE
	 AuJfwJuXFtiDuOYDGseEyb3D2EhoWlMwTHME1Pc46z/g0mHGDrQusGnDqdJK+Zr0M9cf73fZ28G7
	 ED0IDX31R7EaRp19VOzBWQodmw9OJKzXwRZ5K9iGm0UNKXRqeKaY8zKPVfRvGAsHGG1Qwz3GLHlo
	 Rwz6GVwTtvNYUr7cfSflF5A/q/5hEw8L9e53UhqK6qQW3IkHS3K6o8d+7qwYK/GkbkqofOqQ/Ur0
	 TzbZlDfwzxKRiTu0ws542sw0xAfMV45omo6PGHKai7L5aorCdWNgdEsA4TKBfCqQroyPjJdxWWNq
	 QChhY27yi9CnYJR2KfJ0gcA9jkiaG00n+ahhPmUUlOaQv1Fd+Ul+a7yoz4rqhEKowixgo/3hzO1Z
	 Tn6/R+xWZmglfpOyg6NJEcu06AdoUvcZ/3O5kKzTgP7QYIFIpfxskXgBfaLW1CWp00h2NTGg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/7] dt-bindings: add Canaan K230 boards compatible strings
Date: Tue,  5 Mar 2024 05:05:56 +0800
X-OQ-MSGID: <20240304210601.777883-2-cyy@cyyself.name>
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

Since K230 was released, K210 is no longer the only SoC in the Kendryte
series, so remove the K210 string from the description. Also, add two
boards based on k230 to compatible strings to allow them to be used in the
dt.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/riscv/canaan.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/canaan.yaml b/Documentation/devicetree/bindings/riscv/canaan.yaml
index 41fd11f70a49..12a78bc95992 100644
--- a/Documentation/devicetree/bindings/riscv/canaan.yaml
+++ b/Documentation/devicetree/bindings/riscv/canaan.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Damien Le Moal <dlemoal@kernel.org>
 
 description:
-  Canaan Kendryte K210 SoC-based boards
+  Canaan Kendryte SoC-based boards
 
 properties:
   $nodename:
@@ -42,6 +42,12 @@ properties:
       - items:
           - const: canaan,kendryte-k210
 
+      - items:
+          - enum:
+              - canaan,k230-usip-lp3-evb
+              - canaan,canmv-k230
+          - const: canaan,kendryte-k230
+
 additionalProperties: true
 
 ...
-- 
2.43.0


