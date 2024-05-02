Return-Path: <linux-kernel+bounces-165874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8993D8B92C7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499BB283FED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAA13D6B;
	Thu,  2 May 2024 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="LOGwYftx"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611F9632;
	Thu,  2 May 2024 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714609760; cv=none; b=M6ReWlW0wF9VRxpPq9/WGQn3TMGcudf8i/s9ekfUBU8zy0qM7ckoqwJUjSoOU4+470CKMe6yKoq8Pemw27FSjSDKX65lhRgJ46ahUo+/d8x/1lwAH/SNOmOIW3PLwU5PctkUs4jMEjqgpPXVtwJptiFI+Bgs/wuFIborRZ36JGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714609760; c=relaxed/simple;
	bh=zx7itYB2pqlDAHO/qe851IzW/ctsTQNdGPbi9lONciE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFEwmx2F2DKJ15GYBqtQFZGlyJlBK0hZmBudFFkIw62mCPAarFeb/32juDCbh6Vx28DQPUjnVhlDE8zjDi5PzMMu0ds5p2OM33auuHaFX8yIOzlvgKk5G+Ngp65W1DdyEaAfQNBb+XXN0yINK8+lAv+TPg2wtICRwQUnHaQif2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=LOGwYftx; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id A4EFB42E7;
	Wed,  1 May 2024 17:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1714609759;
	bh=pdhGoauaP3u5/TiAgvJi449opSxHErH1PG6XaVzDukQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LOGwYftxmZ5ApJHD7cyCl0ldBta9IffsoxjIIYDpquuxcjzkUyixPIUiZYPCW6ccq
	 iXAEqCKrpIdtFYKJH2ZmpQNuwLz+UkDUDA11G+oaO0Wnv2kiHu34orJeOL9QMB+7+v
	 vnOo+/DMGsBx7DBsucR+4r2UzF5kTXCpHK5CY+UA=
From: Zev Weiss <zev@bewilderbeest.net>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Zev Weiss <zev@bewilderbeest.net>,
	Guenter Roeck <linux@roeck-us.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: [PATCH v3 1/3] dt-bindings: trivial-devices: add isil,isl69269
Date: Wed,  1 May 2024 17:28:31 -0700
Message-ID: <20240502002836.17862-6-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502002836.17862-5-zev@bewilderbeest.net>
References: <20240502002836.17862-5-zev@bewilderbeest.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ISL69269 is a PMBus voltage regulator with no configurable
parameters.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index e07be7bf8395..98ad7f3a7853 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -160,6 +160,8 @@ properties:
           - isil,isl29030
             # Intersil ISL68137 Digital Output Configurable PWM Controller
           - isil,isl68137
+            # Intersil ISL69269 PMBus Voltage Regulator
+          - isil,isl69269
             # Intersil ISL76682 Ambient Light Sensor
           - isil,isl76682
             # Linear Technology LTC2488
-- 
2.44.0


