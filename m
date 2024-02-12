Return-Path: <linux-kernel+bounces-62150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99520851C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46456B2A65B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B09548790;
	Mon, 12 Feb 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="Q15r1vqZ"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B345BE8;
	Mon, 12 Feb 2024 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760458; cv=none; b=IzuReJtOoKvb/Cb69CZg/5r4/88ehmJYTanAV79GE/bEx3oFTOeetH2pglFIftDyMDXGRofwBqHFL5v8cDyJRptTUGyPdMatfz+l+oCuHmF87rmY0da22uiNwfBTcSbd5LBZ5i9r7Kk5KfxlvUh1h5tM67Mz5f4fCKlr8nQm2BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760458; c=relaxed/simple;
	bh=0doP8NnUjaTfFjdMWPvwgVTOH9eAL0HI3FuMS2w8NvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZniEPYKuaOiExaF4KvBH/c0/5azfsPv0aMDTaJWtPLQD+Z39sYnWmfZFVL7wVn8jGK+BoVLC5DUzLCxpyOUCz1//8PtpnPzGtvPNo02mpVoDNKhIrpp7S6gpRawqWDoM86Ff8B16dcVbN6kkaCuKR34dX7+gKhjt93CEk7tR6FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=Q15r1vqZ; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1707760453; bh=0doP8NnUjaTfFjdMWPvwgVTOH9eAL0HI3FuMS2w8NvY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Q15r1vqZ4gduuegRPgA2R/8nGOaW4ZWeE/pcy9ZKsX7Awcnnp1830TOGdT33wbJY3
	 YVac8xAzV270WqTJFjfyHm/u3MgSkJMr0o7Lbfzr0ploVARQhrsPDRa8ZYrtcym1P3
	 hLGKpC6yw0scauuS7b7KyfWj0/rJjj/5+RSP1mSc=
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
Subject: [PATCH v2 1/4] dt-bindings: vendor-prefix: Add prefix for Voltafield
Date: Mon, 12 Feb 2024 18:53:53 +0100
Message-ID: <20240212175410.3101973-2-megi@xff.cz>
In-Reply-To: <20240212175410.3101973-1-megi@xff.cz>
References: <20240212175410.3101973-1-megi@xff.cz>
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


