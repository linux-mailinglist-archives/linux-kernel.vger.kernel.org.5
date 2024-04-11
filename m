Return-Path: <linux-kernel+bounces-141364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D0A8A1D50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412D9284238
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C944F20A;
	Thu, 11 Apr 2024 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="YCeYWXVg"
Received: from smtpdh18-1.aruba.it (smtpdh18-1.aruba.it [62.149.155.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DCF4F5FA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854874; cv=none; b=o3Z4GJr8X1ON6cI8LBjQEzpyZPDIS8yJ0v0vzRkz0Xk6tsvXAdXe2+0q29y2VVuCHUteq20sDbksCd8800C7FAC2MiASEN68yHXKm985ufwxJH+YaSrVS60FCfSkRZWETuxtwrR2dTqscmhkDFoOoGpHON2eon9gUjxKsyVCvo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854874; c=relaxed/simple;
	bh=wokwSIBQiIeFcBRXPB14uD6rIQQtKsyeMXpmFXC5hCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BVToAoksSM6ID2MfoWC3J4fTP9X2VzRz3symjeQ0L+8cmvSEfbEp4an2C7NZMIwHZaQ3vFyWPk+2Uuz1ktoHFD8MW6B9fiLrFQ7oG1eIORwoH/TNmMO8keb176tQTIF6URWDaw7DStLXX68SVuRZxglmuAiJ3BrKAujW4UPSEyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=YCeYWXVg; arc=none smtp.client-ip=62.149.155.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([77.32.15.153])
	by Aruba Outgoing Smtp  with ESMTPSA
	id uxkPr7ow7wcFeuxkQrcyeL; Thu, 11 Apr 2024 18:58:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712854682; bh=wokwSIBQiIeFcBRXPB14uD6rIQQtKsyeMXpmFXC5hCc=;
	h=From:To:Subject:Date:MIME-Version;
	b=YCeYWXVg928xf8y/IWDS+fmzqnm9YeCAz5vbm7ReRvzFqfzyFtIRKqOQvqMKQ/MCo
	 MYrO+GpkxsNYCmXd3AJHQfYQqNU6RU0ECHbdnK1GAqDEfAAT6KZbiOCa+Q3jAkuDvg
	 /5zzQQV5X6DyzJASfiks236XxWgBH89SfsNJh1FX06UyhTj6iAnV2/nkjaY6Fln/GH
	 ydN/vGFmoAnZBGlNiINlpqEK8g3ArVbt2inrrMICovgqz1eQojQWUI2/eYv0NymIjP
	 0KdFjmnhq6Zd7hvaSKjjYL0BwrgaUztF9r70UN/flRvOyyoI5PZeCU8uyGr2zlRbi1
	 VRaNs3nX+OM3w==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Robin Gong <yibin.gong@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: [PATCH v3 1/2] regulator: dt-bindings: pca9450: add PMIC_RST_B warm reset property
Date: Thu, 11 Apr 2024 18:58:00 +0200
Message-Id: <20240411165801.143160-2-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411165801.143160-1-fabio.aiuto@engicam.com>
References: <20240411165801.143160-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJYRY/5Ve08dc1q/JaUZVbtbk14aNWluJ7DfA7lGePbtos/ErNjMJzXXPKUbX/pIHdlzqbCgyaHmVkWKnqfO//WkXh9vAdXvAySzk82jYhykv1eSISF4
 9qn8lRVbuQFqiHUGVT0q8CVbDwvTNsZcMhwknMyazijrz3eztZQl4O1vmP/lvGzwvP3R8THiPQBWx9/mRK+0lLoRfl8AZ0jrbeZXEn2CaJGnVgCjFceH5oL3
 J/SuoMUILSUCcaGlXOXN+kS/oo3IZieC+jYeGvTQZI17LzJqzMu7eV2c9BRIyiwpd515qaR5XsqROrir0ROvd5OQ+LlSPK6JUGd/FkKCfQ9N0RY1yMpkCEwb
 J57ktMvaQHtOa4pELOrv0Z+r9qF87rNTPhXym+IW9rqu8NIt7MBqN5J8lTmAL7MovtfZPtA/EMM6wUYqX1+FFtwhQW4f6lQRwoPpmHQ2jiWVwqhuM1aBwAhw
 jsw2Zv8mlL8I4ehV

Add property to trigger warm reset on PMIC_RST_B assertion

Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
---
 .../bindings/regulator/nxp,pca9450-regulator.yaml           | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 849bfa50bdba..865b259dac37 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -93,6 +93,12 @@ properties:
       When WDOG_B signal is asserted a warm reset will be done instead of cold
       reset.
 
+  nxp,pmic-rst-b-warm-reset:
+    type: boolean
+    description:
+      When PMIC_RST_B signal is asserted a warm reset will be done instead of cold
+      reset.
+
 required:
   - compatible
   - reg
-- 
2.34.1


