Return-Path: <linux-kernel+bounces-69206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E858585C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A141F249BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CD31369B4;
	Fri, 16 Feb 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="vfW7/1tH"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA531350E8;
	Fri, 16 Feb 2024 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109421; cv=none; b=PUjtRcgDtjnCTLOVRMtwx8aVbR7fAIFyxBIp40PSbSlYp3VPpaSKtUGLgRzSJ/c8cu60fE0U91p856oEriprk9Xb+JsjX+736Oj6s1MV2iXUMhDZl9NjX1VMn48XFVa7ZXQTRJ8HHp8TPA0VnpgRpx1jfVM8a2OXERKl5CW3bP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109421; c=relaxed/simple;
	bh=0doP8NnUjaTfFjdMWPvwgVTOH9eAL0HI3FuMS2w8NvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JP3b3caxayUOtJeIhbZR705n0smeL5JBe8gtUTPatPELv16s8QR4j4booWmRVFNuMgC9KOiSPTXOXcq4j2ub71U0QuWBm4rFqeG97QmiLM1fgs+CQxxv5u93eQZcrM+rVLv6YLlxnxy10HIpKOOsyDt3sM4119lWzyHOYeZYjA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=vfW7/1tH; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708109416; bh=0doP8NnUjaTfFjdMWPvwgVTOH9eAL0HI3FuMS2w8NvY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=vfW7/1tHEvRH5pJC4NO7TkAiymKpscLom2BWRN4PH8aNGa37o2pejToqou6XGaopw
	 /BH8hziympJPHgegWPyLKSt5udPV06rv92q5DMai5GOSwq5mdRcU1BLEq4/QptfLfB
	 8gxwp/lAzXex45m8smUWiqXDuoLUPU97O8yodP+Y=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: Jonathan Cameron <jic23@kernel.org>,
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
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: vendor-prefix: Add prefix for Voltafield
Date: Fri, 16 Feb 2024 19:49:59 +0100
Message-ID: <20240216185008.1370618-2-megi@xff.cz>
In-Reply-To: <20240216185008.1370618-1-megi@xff.cz>
References: <20240216185008.1370618-1-megi@xff.cz>
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


