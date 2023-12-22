Return-Path: <linux-kernel+bounces-9637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BFB81C8CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15AF1C21B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2F317748;
	Fri, 22 Dec 2023 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="Wp1UZsvh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BEA17742;
	Fri, 22 Dec 2023 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1703243145; bh=DMkoqTpYVUh34kGB9+2bV+tQDmFBMqwqCG799ZULLrg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wp1UZsvhJWTu7QxfjhITLWmicuclTIG9JdU2B0zFnVXPw5Kmrt+lsYf+UU1He27p5
	 ZpEGY312PpNs0sgTFqE9qUCxjv/AYyIwiglOtcuGp+GFPaOMvfB4Bam5qdlnztlO6J
	 8mC3n852S5t56LnAlqLhPFRRBXzykqmPc7r+4/FsNl+xUvsPlI3IEAEweVNRgLqWvF
	 cnAu1W4H8atVNCwnI8PRPvfF4YCwb9H2x7DF5qs6SiRjSHhm/LoHpfnGbXiXmU8N1n
	 v0haCaBeCpkClDvf11ui6QskEkhUXNVcsXn0aWQ0lCEL4gXoqKHM1tuDw6+bjyhYHs
	 u+8Cm6IxhEttQ==
Received: from arthur.fritz.box (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 91A39370D3E;
	Fri, 22 Dec 2023 12:05:44 +0100 (CET)
From: Manuel Traut <manut@mecka.net>
Date: Fri, 22 Dec 2023 12:05:43 +0100
Subject: [PATCH 3/6] dt-bindings: arm64: rockchip: Add Pine64 Pinetab2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-pinetab2-v1-3-e148a7f61bd1@mecka.net>
References: <20231222-pinetab2-v1-0-e148a7f61bd1@mecka.net>
In-Reply-To: <20231222-pinetab2-v1-0-e148a7f61bd1@mecka.net>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sandy Huang <hjc@rock-chips.com>, Mark Yao <markyao0591@gmail.com>, 
 Diederik de Haas <didi.debian@cknow.org>, 
 Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Manuel Traut <manut@mecka.net>
X-Mailer: b4 0.12.4

Add devicvetree binding documentation for Pine64 Pinetab2
which uses the Rockchip RK3566 SoC.

Signed-off-by: Manuel Traut <manut@mecka.net>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5f7c6c4aad8f..96d54b0587ab 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -635,6 +635,14 @@ properties:
           - const: pine64,pinenote
           - const: rockchip,rk3566
 
+      - description: Pine64 PineTab2
+        items:
+          - enum:
+              - pine64,pinetab2-v0.1
+              - pine64,pinetab2-v2.0
+          - const: pine64,pinetab2
+          - const: rockchip,rk3566
+
       - description: Pine64 PinePhonePro
         items:
           - const: pine64,pinephone-pro

-- 
2.43.0


