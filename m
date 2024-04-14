Return-Path: <linux-kernel+bounces-144152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E298A427F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C906B1F2122D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A92B446AF;
	Sun, 14 Apr 2024 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="fnyxALMY"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC1374D4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713100549; cv=none; b=VjQ0gP7mB5mZvafKkV45+yOYIkRqoDVsbP4QonRva5TXGiaXfPLlPv0W5Luj3GsJpWgYeJy3j6cppSKeiLn4B9KbOyhG2KWhYkQxiPMua2v6kVvjny6ecPIb5XfKjFukCcoAVnnzyGSpIXrt0M+CSPo1ZmsR9isB6rrUIDVw3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713100549; c=relaxed/simple;
	bh=ZZ14a+xGBxVbS9UyGqLCpDblbQXeN7FYNq1QZzw1AF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkmJ9NIT6HN5FS+t9uJ7k8Dw0NeRIj5vPXaA2+S8iIEgm8MexEw7z3vQLNIK3s6vC4j2M7dJ6ajCmDin8b39tJ3+897bDwWvuKfc3jU0Yv1RaUuySZw6Vp25ZMDa5wk1GSyvd3A88dcPXKncvcOCa/o5u+L02al1m3PiSiPqIgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=fnyxALMY; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713100540; bh=i9Z2YZbnmy3lJZINsktbGNNm1ZmA69He5guvitkDSds=;
 b=fnyxALMYrNuTjDBm1NzL/ZOXtf5MvKUIH3gancZDiOTQWFDrHzosPkw730gJcWRmug7wYWBLx
 f4Xy/sES1dbZRa3qv9qylW94ZXoe/T0eafJv3oqOm06WKNDh5GWA4/X/aBnwHXziMLf9a/mKcOn
 rr/JBuUJX386wKglTmTcz7ptYG+pKjU9l/qtmH2CB8Imh/f+sDltrUyyqNJcyf3c4aGzbEo/IhR
 YICWkIbaQVxbizJzbxIry1wc+afQ8unSdg92RVkT4QUxlD8iXJDaElQdj/L1U0ScgeEzyt/EPmj
 JhyaNC2knvBEKgejnTi4iKVkOtbDUZn/QF5tUphJ6pog==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Add Radxa ZERO 3W/3E
Date: Sun, 14 Apr 2024 13:15:23 +0000
Message-ID: <20240414131529.1730506-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240414131529.1730506-1-jonas@kwiboo.se>
References: <20240414131529.1730506-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661bd6fb3b53c644336284d5

Add devicvetree binding documentation for Radxa ZERO 3W/3E boards.

The Radxa ZERO 3W/3E is an ultra-small, high-performance single board
computer based on the Rockchip RK3566, with a compact form factor and
rich interfaces.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 4bd033adeee4..2d43729bebab 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -804,6 +804,13 @@ properties:
           - const: radxa,rock-5b
           - const: rockchip,rk3588
 
+      - description: Radxa ZERO 3W/3E
+        items:
+          - enum:
+              - radxa,zero-3e
+              - radxa,zero-3w
+          - const: rockchip,rk3566
+
       - description: Rikomagic MK808 v1
         items:
           - const: rikomagic,mk808
-- 
2.43.2


