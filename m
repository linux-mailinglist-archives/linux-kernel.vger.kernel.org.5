Return-Path: <linux-kernel+bounces-61804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A2B8516BF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B6E1F21865
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EBE3C495;
	Mon, 12 Feb 2024 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A63I6iYT"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331883C47D;
	Mon, 12 Feb 2024 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746931; cv=none; b=niywRmGsNZFa0KN5OAsV7E/m9yy9peOu+4yu7ou0psu2Zonki62GZ2znr0oVmB4jusizNF+ugYYXeawSLAA2ThV06xkD2w6el4z324Gzym6Fjv2MSqBKAaU6IncDPfOrAHrYuC41K7Lq51mZMJjlGfQg02QaUjCzQAH7cQNuzsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746931; c=relaxed/simple;
	bh=2NxEfRi/KZyukI5j1INkNRmDIlc5v9XgZNfzqtBrPoM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JElFAcvO/7vofdApVHHZx5Q+Eg3yTH1nc4RULI4/EibFC5STEZscgqv5aAH71pS8hd4bpxLMx8TZVfmjG3VQHWi1PR+ASJkbqxJoxyFnU/cic7S5EU1HgtpMzuyzTsm2kFIg4uUKUmewgUpf1bMrvPu0l3WXwvFdXF3DPOAnGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A63I6iYT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3cb228b90bso74446666b.3;
        Mon, 12 Feb 2024 06:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707746928; x=1708351728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KS39/++6JsxDU3N8okrEe8YXDzy7pHHaWYVzpuOYLgg=;
        b=A63I6iYTKLYwC3XEtc36kn7RnU160EDVHGx+K+WixC+Z99OGJkVM87PxqEws77cj8R
         4MP3/4bKFwFtcKvg0HHn3tpGXEHeX3dZ/zc774ZvfHeOSCuu6rNhnM/5b0nQUlVAwwAO
         kH1u6wO7ghfwAWht0TM16RXkkvI7oGRBks6fCFZI3U1y0mWWzDE46dIV09RnLczc6aQs
         KcDiShyzTTECLXsI8QFzktJtkfDgC2myfGA8Hr35Jr0G/yaKzyvARUxXZwS+587I/h9D
         UeQ7TrSrsInU68lyd16VC2Z+Av5hix6bUrcekENaZ6fcQi4au0LlNZX+Czd13t9d+65L
         qCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746928; x=1708351728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KS39/++6JsxDU3N8okrEe8YXDzy7pHHaWYVzpuOYLgg=;
        b=gHyMG2fiO/Qoa6G460HCpkBP+KpQ/JZQm0rgsISi0G1166wBhhLK1j498LBmCFmsQ3
         KCCGGuUnv3NVZYEopUXwR+WiBYs+DplCOhUima5wPhb1lph1ZZulxcKXElrbI1iAcz1A
         enM6RN2EHKpfW3wN7TgBPJ1G3lHFyAQtHYvCda+ZB+CjSvYlr04/6KlcTGHPjC8KWg77
         HtqJz0U2ULisC7L6nimwgNIn1fNzwqTm4PrQ/b6XtrYIB7wYkJiBv2vmZZnO1cFaZHVE
         O+OH3pJCvvwMg/1Heeo01hSuCY9ap3xhf7yOmL/d449ABhX3Mw4AIlcrc8667C1QIt49
         iHLA==
X-Gm-Message-State: AOJu0Yx3PJ0FrBJ4HywSowXR1f+TyMnrywrGLNKxQ0+wpeOtDazzuGD5
	GtGgEAfE2IQQGioQKCxMSSkLetC6PniAJu6RhU+Objr6LPOLmCcg
X-Google-Smtp-Source: AGHT+IGfVEJx4LWDgYWE3ld0HjRSOgXQUBR9hWzUNXX3UUSMz8RLw8CoziSBIt169QsTPnHdSfN4Qw==
X-Received: by 2002:a17:906:74b:b0:a3c:c5ee:fd84 with SMTP id z11-20020a170906074b00b00a3cc5eefd84mr1233060ejb.48.1707746928063;
        Mon, 12 Feb 2024 06:08:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6BXAYSTB4A09X5YCrrAMe2VWbTRfMKzuotz+gBQ5EH62N1Dv5uAe34IayoaXL/DFVIUXGwDZlFZyUlC/OT2601OAkb2s2fkmcINYk8aaJfqL3z0OBTJWeLXGECSdC2AsP5xXTd4dhj2H2g/VXDee7heK5cMChdVFfLv0pwXaOSGYhx0yOyLYf5wM2yIe5jg9mASNtGpKvU9FrQ0TSNwBGQ6k8eTAW1rv1JcbIQFU7gHai7KXZQHup13Ps27T/x5Iq6XjbiQFAwig0AOHDLNoRHeRLAqemeqcnG8Ox1wXiwSUCH2xHI1LXWmP+1KzwtWYXTLJeJgxNnlvX5AoCGJKganRMUDmWj4iOIJF6fvNgoCGFg2F9HF7yw0mDWOEGGLHn6evxoJT2Zdc8jp8ngMdws7Z2jAd9tE0plip481CqEphQ5TL5/9ivVoA3l5Lqqvk8IA==
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id kq11-20020a170906abcb00b00a3820ec721csm247967ejb.8.2024.02.12.06.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 06:08:47 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: vendor-prefixes: add smartrg
Date: Mon, 12 Feb 2024 15:08:39 +0100
Message-Id: <20240212140839.27150-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

SmartRG described itself as a CPE manufacturer and produced few home
network devices (e.g. wireless routers). Their SmartRG SR400ac router
(smartrg,sr400ac) is covered by in-Linux DT binding and DTS file.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index bf6d8261725b..80a7c07401ed 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1305,6 +1305,8 @@ patternProperties:
     description: Skyworks Solutions, Inc.
   "^smartlabs,.*":
     description: SmartLabs LLC
+  "^smartrg,.*":
+    description: SmartRG, Inc.
   "^smi,.*":
     description: Silicon Motion Technology Corporation
   "^smsc,.*":
-- 
2.35.3


