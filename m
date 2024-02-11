Return-Path: <linux-kernel+bounces-60956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE778850B8F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2A12836B4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A05D5F85C;
	Sun, 11 Feb 2024 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="RHpm9zAZ"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C05381E;
	Sun, 11 Feb 2024 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707684744; cv=none; b=KKGHsp/5/0AnvEjlLETncWza3+T1v9JfaTSmlzXmTAcPITu8pupAiozVtmPV6kJIUCgqtcFLwJ7un0i2OgZ4efmwOebeJYuI8Y0xvPqOby6xFVKii63bPYIuS5YWN7yVqyl19aHdy0wngL9vUWsRk2x4LQAT8srXRRKFcGTIdGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707684744; c=relaxed/simple;
	bh=uqEZgYBsSQiZQx5PZMW8uvMomw0NsNNRKqLIfbms9vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjZqt/eaCRtLDmVmaHEuKZERQUZ3nSJuJO4Gw7Ps8yFeqhLD38zSvYWxEfCumJzJny3WI2pMiVUwSPSWmqMv9uX2kT6KFEmHS5sFzKplZ5IAvbpWTbDVz/rCEoRVPP7DMmqvhp/eFx0hNKFiJKKgPGdg8wN4RqlGa2DJ61TojJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=RHpm9zAZ; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1707684739; bh=uqEZgYBsSQiZQx5PZMW8uvMomw0NsNNRKqLIfbms9vQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=RHpm9zAZ/zyVkl1fbT8+59goSiqB5NXzv0QZmi+ubstofQhpUUlHG7yC6t9mr/Frh
	 XDicwu0+GPS34pRpYs7a3QGfJn5gqxRS0usFHkr5f2fCZrFKtQaD+xIwH82FhHprJi
	 p421qfYa5NYTxlAJE/z/wsyX2EYFc0iBQEasLnZs=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Icenowy Zheng <icenowy@aosc.io>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Subject: [PATCH 1/4] dt-bindings: vendor-prefix: Add prefix for Voltafield
Date: Sun, 11 Feb 2024 21:51:57 +0100
Message-ID: <20240211205211.2890931-2-megi@xff.cz>
In-Reply-To: <20240211205211.2890931-1-megi@xff.cz>
References: <20240211205211.2890931-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Icenowy Zheng <icenowy@aosc.io>

Voltafile Technology Corp. is a company that produces MEMS sensors.

Add a DT vendor prefix for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Ondřej Jirman <megi@xff.cz>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1a0dc04f1db4..82e9f64c90ff 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1534,6 +1534,8 @@ patternProperties:
     description: VoCore Studio
   "^voipac,.*":
     description: Voipac Technologies s.r.o.
+  "^voltafield,.*":
+    description: Voltafield Technology Corp.
   "^vot,.*":
     description: Vision Optical Technology Co., Ltd.
   "^vxt,.*":
-- 
2.43.0


