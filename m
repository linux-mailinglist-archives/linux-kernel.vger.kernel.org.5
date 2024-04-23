Return-Path: <linux-kernel+bounces-155963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2E78AFC01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87876289FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119CC405FB;
	Tue, 23 Apr 2024 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="FDF1nKYm"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD172D045;
	Tue, 23 Apr 2024 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912079; cv=none; b=S0nMFleCM87+bd+letSG32IfNzFK2dwKodapfD1U9P1OM9Y8vLWmrKHdVJWUDKSpSVB4NcDq5YI9Z92V6NV0xr+6iuSe8s3A0QFLzo+FziO5TRDciq2Bt2ZdrzAb/Hw7rVLjc+oXdANA8YRxddeNGvkHTdn02A/4slVIrzFSrXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912079; c=relaxed/simple;
	bh=sPdQp0y78+aQ4Fsgv16GP6aktf1T+o0Ad2IvNQ7mtBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/sgSVg2bbRJWdlyGpp9rhRsheNmsdtOLpxf1uqMTtDbmntWeMEFbvEuiXSpPKwTPwRIcGv+fbq46otjcY0N/ii4xgsZI/stdL4Ruen2hOCeGoPYWT1c7iU0dLlk0XvRzcC7wH+nAp4KHFrjxjnvbKAkq6CvqWVYSC0OnLuUlY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=FDF1nKYm; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id B48B347A59;
	Tue, 23 Apr 2024 22:41:09 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	phone-devel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Willow Barraco <contact@willowbarraco.fr>
Subject: [PATCH v2 1/6] dt-bindings: iio: light: stk33xx: add vdd and leda regulators
Date: Tue, 23 Apr 2024 18:33:04 -0400
Message-ID: <20240423223309.1468198-3-aren@peacevolution.org>
In-Reply-To: <20240423223309.1468198-2-aren@peacevolution.org>
References: <20240423223309.1468198-2-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: ******
X-Spamd-Bar: ++++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1713912070;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=hlnyfPS5DLUVzYwzjrSWJSZ4OjlFWvwqBdiJD2oce78=;
	b=FDF1nKYmRgxkjKMC7adv/4y67VUjqBxJcmtSVhHQcoS8nTaAWd+tXzFaSIaINcMlmAVOW3
	kBJzxKIE5VTxxNMkTgtqfP7igJhw5rrvtQ5hnNZ/U4sw0TntAT9TapNfBBOUnHXMTJfMcg
	C3MqiYn2+Qn3sfIGGQOUs9YqlOcIU/Y=

stk3310 and stk3311 are typically connected to power supplies for the
chip (vdd) and the infrared LED (leda). Add properties so we can power
these up / down appropriately.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Notes:
    Changes in v2:
     - add leda-supply
     - add supplies to examples

 Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
index f6e22dc9814a..43ead524cecb 100644
--- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
+++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
@@ -29,6 +29,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
+  leda-supply: true
   proximity-near-level: true
 
 required:
@@ -52,6 +54,8 @@ examples:
                 proximity-near-level = <25>;
                 interrupt-parent = <&gpio1>;
                 interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+                vdd-supply = <&vdd_regulator>;
+                leda-supply = <&led_regulator>;
         };
     };
 ...
-- 
2.44.0


