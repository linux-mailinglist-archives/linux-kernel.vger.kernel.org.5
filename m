Return-Path: <linux-kernel+bounces-106242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDD287EB4A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DC5283046
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BAC50A97;
	Mon, 18 Mar 2024 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frBbk/gM"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383F15025C;
	Mon, 18 Mar 2024 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772997; cv=none; b=GskYJJShNPmrP5yL7BXvIdijR3z4asJ0BcurNjyJ/zCeu662hTqt9N3yYuKRohrxhG7QvFbZx1RB3Ifeti65ZDW9Q1ZNU1tDhnekyHVi+odwua3Kg6l6bjcNnh6KJjSxXMev8JR//5a8KTpJ1VsA3gU5MOEkXIrXvrMCemvCjj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772997; c=relaxed/simple;
	bh=L+YyUgKXm7mXO2F1jnKfA2XkFD8GgpbXJ1xpVHzqxCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phnilFHQXy3SXo8e/N81Vq5TPrvHdqkbaQllfOt/RiyxmaratIdajolRp3t7IeNlepbRO4Yx+ijz84waWCbaP+oGhym39QdfRps80xLBtqxUfjw2bYf6LoSD2NuKSOWFGXXXvhY07D8lUbHBu0nzdLz1NSDOQws07Rzf2WrKfig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frBbk/gM; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d48f03a8bbso23776141fa.0;
        Mon, 18 Mar 2024 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710772994; x=1711377794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLoNxtDFqdGEjimt+F9QdVbWBB2oEz5/x/CYpXSOOaI=;
        b=frBbk/gMYvfnokj4WviVBXvzi/QzB8wYqOt9jMWwxaEayZNNNHFzFXTr+rPxWx4lv1
         oZzxQuEGVFQQ9uwbKNeAvWdvrof9PGZN02bAxAcHtXfcvE0w5wSDYYuWHd021Uif83Jh
         B7Fl5y+p7+VOrn+rJ4HaGqVQV4qr9LAsAd9Bqg3ugO0VhRoU5lpbZFbFg40Ke55Oi8R2
         xwBTCLioeknjQDH9lQUIOeEwkwmCPevMF+LTkxPo0hadBAnz9c4+bQSY2sUT3nfQ/Rzi
         sy9Ghd7vTQLiTjNxp8LIag4BCpTAuMztMjr2C6ktvWTy8lvbRvUG1UShBvdDk93yUAZh
         zUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710772994; x=1711377794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLoNxtDFqdGEjimt+F9QdVbWBB2oEz5/x/CYpXSOOaI=;
        b=NzKJZHHCvmyxtdZMiEUoScZIQlYZ6DjXDEi0oulXo1PTCZvG2gO7dgLHcNmLlJ/8Zk
         OsyfoERKxwA7KkL3u2YK+8G6T4sF73UNSJNGqIeUrKYtkZidiMnBCix0/t2auwMY0f0/
         FUiLugPKPBcDuuHAeCLAKRcZzNF4j4QzGv5u8z41DEoTjoMRgsRsnBTJCA4lw9qgB9Uf
         OC3lYop4UDNkN2Sj4/cfcw+AQiWT9q09c9tpZ6kNLz+xZ7Sup8pr9AUo3rpkABz922f4
         Yc6ZqFg0x7RfyIgScvXvCtGW8mgzVFTPDkLlChqwJFJ3YpIJQaZK0guj76+zIcRewBg7
         QnTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMnTbPNvKwxt7vctRCQ/Mt3iljjp1qtI7ERIdDxbXqESyh1lOTwmlbN3xcWnV0PscmPOw6c2l55nYLWmxinIk3vRG0ChnK3PGHOsyEm3h8oGuuOZ+zh/F2+DPt06K7/v0sFj5AB7X/+FTT5c8NvE5ouQTf3DmqbC5dtdoHrxdRBo92QNmF
X-Gm-Message-State: AOJu0YzsHITxB0VW6awlmQS+Ja/lVjPRx8reVeSIOd8xjsS7pjazoHCv
	nNMhcdK8VewtHUWLWTRsNid82CCDVpQnJUgttKekafnsi05SzrZL6rEn3hxyC68=
X-Google-Smtp-Source: AGHT+IGjoYnukpG4eO5TtJ4prZn2yanYYPFcjDz/gUfb9oTrL5j9OtP4sPkUJx9gZzBzbwSei/YZiA==
X-Received: by 2002:a2e:7a01:0:b0:2d4:91c4:fca8 with SMTP id v1-20020a2e7a01000000b002d491c4fca8mr3002839ljc.11.1710772994439;
        Mon, 18 Mar 2024 07:43:14 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a2e9c49000000b002d476327311sm1527486ljj.18.2024.03.18.07.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 07:43:14 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 3/6] dt-bindings: media: cnm,wave521c: drop resets restriction
Date: Mon, 18 Mar 2024 17:42:18 +0300
Message-ID: <20240318144225.30835-4-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318144225.30835-1-brnkv.i1@gmail.com>
References: <20240318144225.30835-1-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Different designs may have different amount of routed reset signals.
Drop maxItems restriction, add a small description instead.

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 Documentation/devicetree/bindings/media/cnm,wave521c.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
index 6a11c1d11fb5..2cb4f68d27ac 100644
--- a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
+++ b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
@@ -34,7 +34,8 @@ properties:
     maxItems: 1
 
   resets:
-    maxItems: 1
+    items:
+      - description: Optional reset lines
 
   sram:
     $ref: /schemas/types.yaml#/definitions/phandle
-- 
2.44.0


