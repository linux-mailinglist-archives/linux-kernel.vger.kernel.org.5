Return-Path: <linux-kernel+bounces-10475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6551C81D4D2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2030B2832AC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C372B12E53;
	Sat, 23 Dec 2023 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="ZINjSLDV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F45DF60;
	Sat, 23 Dec 2023 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1703344839; bh=vgxRANyqwlVPMwtKO8SOOWvi4Qkx3vypc5+xq1xEr0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZINjSLDVY0OoHXbxsj9YVKlz0LOOm9CBTp/aoSExKjl06wgL0kU4GkIObtM7RUXki
	 S3/p5U8JKktj5a4hl9yv7EfH5KGQCEhlKjqk/RMKqWE0bsOH2rZ3Xudn270WM8lU64
	 mUNga7cCa7tXazKqjHKYP0A2a38TLB7xq8/jQlqVju6i+6+eHAe3gnPYdoKTAYzqra
	 JIakXUHd5/plWKjpuF1pZSm21uFpLCDMmOX2dSu1xL7I5zg5bUnGBGkZ8LVj5sjcwO
	 3VuFw3d7BgvSblpUof1N3XK3ifq1tM99pnH7xhpZ4s5hdpc7yJjWB6lqyuzKOjRPsu
	 mSdCy6tV9075w==
Received: from arthur.fritz.box (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 1F08237195B;
	Sat, 23 Dec 2023 16:20:39 +0100 (CET)
From: Manuel Traut <manut@mecka.net>
Date: Sat, 23 Dec 2023 16:20:17 +0100
Subject: [PATCH v2 3/4] dt-bindings: arm64: rockchip: Add Pine64 Pinetab2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231223-pinetab2-v2-3-ec1856d0030e@mecka.net>
References: <20231223-pinetab2-v2-0-ec1856d0030e@mecka.net>
In-Reply-To: <20231223-pinetab2-v2-0-ec1856d0030e@mecka.net>
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
 Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>, 
 Danct12 <danct12@riseup.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Manuel Traut <manut@mecka.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4

Add devicvetree binding documentation for Pine64 Pinetab2
which uses the Rockchip RK3566 SoC.

Signed-off-by: Manuel Traut <manut@mecka.net>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


