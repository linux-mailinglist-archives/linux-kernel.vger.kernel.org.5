Return-Path: <linux-kernel+bounces-41141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 508A883EC71
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC759283C3D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91AB20B0C;
	Sat, 27 Jan 2024 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="RYFnCmvL"
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BED200A8;
	Sat, 27 Jan 2024 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.159.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706348928; cv=none; b=iJqPwmHBKUc9FYnYj+PyV5zrgZTW6FvZwaOxm/hnEvGlu0HWUP0E8S7ZYAzAuYxdJRYqiZDbD596pOpX2v53GVqQRplU1XyzcyH4bJVug+pKKO98R3rscEK3orbq0u+9zRwaEwzQ3j9FfMLrunfRkSnNdGPPWRGL0F6+tJ/S3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706348928; c=relaxed/simple;
	bh=b8ZKwzuKSR+B8npDXbJdxQemMwTR+ciHyPfl/3VRGTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoAPJkECICzIK+LM40oxcdWWrMqWSK/6eGAJWuL+q/nc0fZDLro/NNRrlcFqB3QuibxOXvhm8a5nY82U0sBfkWsMsHwx8kxqjy5Q+wvBI1j6aeun6JPWuTbL7NO6uOlJq8av6YZDoxxt8IUR19JnJqe2fTdVBRN36yD+YMf0Cag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net; spf=pass smtp.mailfrom=mecka.net; dkim=fail (0-bit key) header.d=mecka.net header.i=@mecka.net header.b=RYFnCmvL reason="key not found in DNS"; arc=none smtp.client-ip=159.69.159.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1706348925; bh=b8ZKwzuKSR+B8npDXbJdxQemMwTR+ciHyPfl/3VRGTg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RYFnCmvL6bDyP9Agh9Bv7DpCTWPQjzWgT12uEJLwrSQsMkqBZC4Le1W03EsfBAgeY
	 9tvpENJ9qaQb3GaDE4CgvZw0j1Jy5vmWUGQEh7v2hRZ0+rJnAQrwxiNgzzhkAVjx6k
	 61fUc+Kdh2xkPVgqt7jxnvMJEmWtV+Y/0Gz1V/6gClN6sSfNYS9av8mRrWD18QFfNn
	 GeZmKdJ/oHIlxNTa3VvinbIvTz/X+ntqW30hNan8X+F5Tq0AZBxxxBBDm6kR2ZVDGc
	 AsMgqNXg/JtPUFfRnhspYVAPvUFMKQUaNbMVfd1DBWmEZpvHSkjTPHNsocJblmWQcY
	 F3Lc5ZS05aOjA==
Received: from arthur.fritz.box (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 0C7E63BF7A9;
	Sat, 27 Jan 2024 10:48:45 +0100 (CET)
From: Manuel Traut <manut@mecka.net>
Date: Sat, 27 Jan 2024 10:48:44 +0100
Subject: [PATCH v4 3/4] dt-bindings: arm64: rockchip: Add Pine64 PineTab2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240127-pinetab2-v4-3-37aab1c39194@mecka.net>
References: <20240127-pinetab2-v4-0-37aab1c39194@mecka.net>
In-Reply-To: <20240127-pinetab2-v4-0-37aab1c39194@mecka.net>
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
 Danct12 <danct12@riseup.net>, Ondrej Jirman <megi@xff.cz>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Manuel Traut <manut@mecka.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4

Add devicvetree binding documentation for Pine64 PineTab2
which uses the Rockchip RK3566 SoC.

Signed-off-by: Manuel Traut <manut@mecka.net>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5cf5cbef2cf5..1b9740e2f3a1 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -650,6 +650,14 @@ properties:
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


