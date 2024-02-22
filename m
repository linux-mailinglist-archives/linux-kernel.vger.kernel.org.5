Return-Path: <linux-kernel+bounces-75757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8636085EE86
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B688B22BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EAB14291;
	Thu, 22 Feb 2024 01:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="iq7GakXf"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31098F45;
	Thu, 22 Feb 2024 01:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564435; cv=none; b=s9XEVCJBZg3LGbeeSqtBe6tiyF+wJ8sVP1tNi5bjdBTqm6YneG3EsHq7UhECPCoHZp1ZfanoYmafmZGWX3eXTlZh76y9qaZIyOzZ3VUewUa4Ivoj5S+czvxxWgz92Hij8U2Hn8CGaj6L9NNJhXvlrwfSexwmmQ8YV20yI2j/SrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564435; c=relaxed/simple;
	bh=0doP8NnUjaTfFjdMWPvwgVTOH9eAL0HI3FuMS2w8NvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHyATp1uNJzaReXG5tJ98uPaTEkpgxGb/N9UT369ZQnxTBdc87RNBy0YbpZlacfV9dcRuMgHEnZrExO5d3nOAFUlyVsH121DexgqIWPtHvHbbw4SE/zMLGrOoohnkMOHRxXFmPWs9HGirNJH6FoOikJAlSA8DtEboF/P8tVxqRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=iq7GakXf; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708564424; bh=0doP8NnUjaTfFjdMWPvwgVTOH9eAL0HI3FuMS2w8NvY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=iq7GakXf+bukH+iWRudss5bOmR47jiy6W27zx8eftEUHxhSTY2uYEs988LwLuOpxK
	 cNBQ7phqEGub8zvhkX585Sf73U3ZKOyxMWrv0kvJFTyvbzB8r4cbWgMBBTYTIIDMLP
	 sH+UR1N4SoNhdpQXrwdfTyvN0qRK+s0gP+t/2JLA=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Icenowy Zheng <icenowy@aosc.io>,
	Dalton Durst <dalton@ubports.com>,
	Shoji Keita <awaittrot@shjk.jp>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: vendor-prefix: Add prefix for Voltafield
Date: Thu, 22 Feb 2024 02:13:35 +0100
Message-ID: <20240222011341.3232645-2-megi@xff.cz>
In-Reply-To: <20240222011341.3232645-1-megi@xff.cz>
References: <20240222011341.3232645-1-megi@xff.cz>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


