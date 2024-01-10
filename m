Return-Path: <linux-kernel+bounces-22525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A2C829F03
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00247B22652
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAE24D589;
	Wed, 10 Jan 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Pp+AexdE"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AC94D103;
	Wed, 10 Jan 2024 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id C3C9628B588;
	Wed, 10 Jan 2024 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1704907393;
	bh=DxtsSCEvWQRHWiPHNXgzK9xMclvnNxJ+k/fFzf/cKLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pp+AexdEAIHFFgNZSmvhttyO+r9qJ2uPA9N4i+VFnKlFxp3jkhP7+R3KxrmWkv1a2
	 WdXcwjZvdpr2LTLA5fRyriU5fvvmbfa46qIiP3o59sMbhdw0Js6N4AiM76XWcTQ61o
	 DpsmzCA2GDEY6xJK7otYa1H4cQNCgfkOs3Uw2kSk=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 1/6] dt-bindings: iio: pressure: honeywell,hsc030pa.yaml add spi props
Date: Wed, 10 Jan 2024 19:22:36 +0200
Message-ID: <20240110172306.31273-2-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110172306.31273-1-petre.rodan@subdimension.ro>
References: <20240110172306.31273-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spi-peripheral-props.yaml requirement

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 .../devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
index 65a24ed67b3c..89977b9f01cf 100644
--- a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
@@ -99,6 +99,9 @@ required:
   - honeywell,transfer-function
   - honeywell,pressure-triplet

+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml
+
 additionalProperties: false

 dependentSchemas:
--
2.41.0


