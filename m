Return-Path: <linux-kernel+bounces-144315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671A18A4485
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1540628145E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FB3136648;
	Sun, 14 Apr 2024 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="Lx4uQdlL"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C83B297;
	Sun, 14 Apr 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713117467; cv=none; b=cRF6PWpFI/uEtun2GxtXk2fP/HtvxvcUZCXZTiZMTTLZIxHnudkVeerI3Ehjxpev1mAU1aWkGA9fvDMWBr5w2qv/TqysAdinaRpeHmBHsgeY85+Hpza2gRh33XJ6hpHF5tcr5Bq3wEaw494HzUQ1yhI39iUZ1E6qHRnfv8rE67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713117467; c=relaxed/simple;
	bh=lu+Op/pdvzNr08jKWJJbCWriMq/Z9Ad7CPKYV4e6O3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+jGtX1QiZ8UEhXv8BakipA18BMCGsLYmTHthNR8z6I1F08SZTdywPkawo0qv7P76abLHSWznGD2HNihDWFuHFKM8FzzeSGx3nQ0SB1oOAXC/hduUdpZd1yNmSdnVFNDsGcrZJ79Js821xdVK7NhQgXVSHrB7xoJfFDseIX+OeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=Lx4uQdlL; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id B694A477A3;
	Sun, 14 Apr 2024 17:57:42 +0000 (UTC)
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
Subject: [PATCH 1/4] dt-bindings: iio: light: stk33xx: add regulator for vdd supply
Date: Sun, 14 Apr 2024 13:57:13 -0400
Message-ID: <20240414175716.958831-1-aren@peacevolution.org>
In-Reply-To: <20240414175300.956243-1-aren@peacevolution.org>
References: <20240414175300.956243-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: **
X-Spamd-Bar: ++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1713117463;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=CesaFwldMwrSvD6nWyMyYyBUiPFFE7iFAN11Z414ucM=;
	b=Lx4uQdlLS7jsXaUgeIRq2ULGpkrC7J9Np6EBiZIqdpS+VQcICSMbuWkQiUcKSqZLL/WVzq
	Il08BR6tlN938EPhlGLsv5/PoURrsWbeKDin+fUDEMX8rEJkmG1+3Uwo0ZFjWy+6NtAh0f
	GYE00rsAzEtDTdluoNdsg5G5AJ0S62k=

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---
 Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
index f6e22dc9814a..db35e239d4a8 100644
--- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
+++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
@@ -29,6 +29,7 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
   proximity-near-level: true
 
 required:
-- 
2.44.0


