Return-Path: <linux-kernel+bounces-31886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BEA8335EC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00208281A23
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433E2156FB;
	Sat, 20 Jan 2024 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="FrNdaZvP"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D2154B2;
	Sat, 20 Jan 2024 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705778439; cv=none; b=Rv/KPLIyYy7FF4yVhNnA+9d+RN1FpTOw5AvTxZ9BBn8DSr7qk1jOhO2hR9pwyGUeNFLr8p7NUokvL6mweFMcUZs8flgVhn8Tlx+GKO33+DjRXJe+oLRON3pqnh7NoHE0Vq1K7Cw3H9TFP2eeEhq5EH5wbSEkml3WFYA0uegDwHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705778439; c=relaxed/simple;
	bh=Fw4+Qx/UzZxbIraZPU8RA8tsEt1yKuD7H1frw4FQSm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjQe5fvJmsY14rA5xGfgWMoWU+EhIZs4nTOQWXjbx1fIf0CjpfWkdBqaixwgdbtuVrDpOu6Qc8blYNErTV08JPN3LuF3ZCb+eWpTQXUhw9rXJm7slvGxPHdj0F8woY1rdThjCDg8/GoueL9K6UE0+q/ldsfB04URPHNIOeCgvj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=FrNdaZvP; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 35061283BCE;
	Sat, 20 Jan 2024 20:20:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1705778436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4U7NZntIgsai+sVAztcP6Q/zXpVehELNTBE/Azi2els=;
	b=FrNdaZvPRb4vzpUgOivqOU3vkE+a7rzRFBa15ZOnCVAKks9STpUwCkKGJtA2/mYJttT3mx
	7bdeHqf4JHp/UbLDHwyGtitVZlDk9Uo/RpS534nykudHEbDmNrNU2ViVaPDjrdN5HB5y2i
	mgoSGQGSvg7ZEClqFvJO6UPIG4TkqBU=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 116C04577A2;
	Sat, 20 Jan 2024 20:20:36 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Markuss Broks <markuss.broks@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [PATCH v4 4/5] dt-bindings: input/touchscreen: imagis: add compatible for IST3032C
Date: Sat, 20 Jan 2024 20:11:15 +0100
Message-ID: <20240120191940.3631-5-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240120191940.3631-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240120191940.3631-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

IST3032C is a touchscreen IC which seems mostly compatible with IST3038C
except that it reports a different chip ID value.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    v4:
    * Reword commit description to mention how this IC differs from the
      already supported.

 .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
index b5372c4eae56..2af71cbcc97d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -18,6 +18,7 @@ properties:
 
   compatible:
     enum:
+      - imagis,ist3032c
       - imagis,ist3038b
       - imagis,ist3038c
 
-- 
2.43.0


