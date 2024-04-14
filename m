Return-Path: <linux-kernel+bounces-144318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B65118A448E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 450F6B21DFA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AF51369BF;
	Sun, 14 Apr 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="k60ZaVvd"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED11136995;
	Sun, 14 Apr 2024 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713117482; cv=none; b=lKnfOmISm/X6fC+anjYzbqi8wc6BWY6lpOOICc/LJYRsLlg2a4fnq/STnqALDrTIo8+k90ug/w68E9EKoJC8vU2gnwOcOiBEzuduc9grUGakY0rWIHxzxhILbNhvAWIj6vwbGGgh+tk9g+POYCewcdEYX7qDewbXa91z+U72Yok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713117482; c=relaxed/simple;
	bh=IZ4ArRXGNTB7NRJq7uPcufZOTFJ3eOVFZCNrF9ub0b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIxJFwnuICQS9yKTnwR3vmp4Wk1T6+DeXV6Xup88dllfr6YOfV75Bv8iiYuHt/jkbYUxJilel9/LHiKc/N3ujD2THnRiQW7zPnKvDa7u4CezasxUGwTX5E0aUhjTddK2iJGuZAjLQqnBQ7OMD1+iOswCh18nNdRWZYcpbVksPF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=k60ZaVvd; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 17D3547963;
	Sun, 14 Apr 2024 17:57:59 +0000 (UTC)
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
Subject: [PATCH 4/4] arm64: dts: allwinner: pinephone: Add power supply to stk3311
Date: Sun, 14 Apr 2024 13:57:16 -0400
Message-ID: <20240414175716.958831-4-aren@peacevolution.org>
In-Reply-To: <20240414175716.958831-1-aren@peacevolution.org>
References: <20240414175300.956243-1-aren@peacevolution.org>
 <20240414175716.958831-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: ****
X-Spamd-Bar: ++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1713117480;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=6v+9LICWwNBv05pAzbiQ9LAhqjunLZ7gdVFFNyxU1mw=;
	b=k60ZaVvdziPJhGY/EVOspCAhKUai7wJ8U9M0QTYRcu3bnqfH6ZljC0sKXdOFyl3Rc6EZtB
	Df7jHgk5D9kypbfcvwbP+DtUUeHIWvbEHp9f4ZBDKi7YM3u1jBWct4ZQoRtneWKU/lNYxt
	ap8ClX1qJE7r8knOQPcjvKk4JK42gBQ=

From: Ondrej Jirman <megi@xff.cz>

This makes the driver disable the supply during sleep.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index b5a232209f2b..e87bc21db316 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -250,6 +250,7 @@ light-sensor@48 {
 		reg = <0x48>;
 		interrupt-parent = <&pio>;
 		interrupts = <1 0 IRQ_TYPE_EDGE_FALLING>; /* PB0 */
+		vdd-supply = <&reg_ldo_io0>;
 	};
 
 	/* Accelerometer/gyroscope */
-- 
2.44.0


