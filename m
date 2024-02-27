Return-Path: <linux-kernel+bounces-84214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A25086A3A7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3F41F244E9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241A658AC7;
	Tue, 27 Feb 2024 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFpjlYEU"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6BF5822E;
	Tue, 27 Feb 2024 23:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076364; cv=none; b=We2pTnlj3xofjvSwse2l/7munnFmQ71lFgXeGnYRhzoa7qlETK4tfqyNxuyzQwTuBlxgwzEpRg75xQexH6cITHDWjSDUHGw/1RVRicjjgpCUrNO1KquHyuPGddO8wFpocOpjdS4S6mDJuWkbNx35hCxoiFVeUJ9kJBZfDebeEaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076364; c=relaxed/simple;
	bh=ynmmt98E9Ci0kqTck29vbb63BJS+v/oc/x3hJQS4grQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gPvVFdBasr8CzPumD9hQI0zIb40tVkV58ikdSXivQoHAuQ/7QQxXEI3x0J2RfGQ3oFi/wXkMFETIgfH7R1JYXLgU9GLusUt1ihUcGjnLvt7nd9/oON6EPjy2BAjGlKSxY8bZOGT0zAfNjkN1sRBsq5tpjjzuj/bKxUNgy7Fx4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFpjlYEU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso163656f8f.0;
        Tue, 27 Feb 2024 15:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709076361; x=1709681161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xtbn+FDNjujpPzD3jmB3iR9JG4D2RuAxm5BC1nUBpuo=;
        b=XFpjlYEU5qXIhd6hQG8NYE3laEKBicTJgDi8yMsdXSSND9qlZFxlxpYM97ubqfZT1O
         BFAsxnMtLTpziFEeLj7tXL/oGXbqRWC9m33sAhvGcW0rN/o9/9sJP8wwci1Sd2eCbm3Y
         3aYk5PA0MOayJAeYgW8VvK7bRaVz8OgpPPZeh2IGBRES6Cl+e9rV2Frgp04zvgq6umBg
         Umhu1qBjeBjz13JNH4WWizqNdiiM8TlJnGjw5AB7ea9gMCdSD/0IkOXzjRjWwxFouBbh
         lMGA3ZfCp639fw9xm2U6sEfhXoOEBfXaEO/2/deuh3flAsF1x7CcXv+0hW0ocupKXcIZ
         xu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709076361; x=1709681161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xtbn+FDNjujpPzD3jmB3iR9JG4D2RuAxm5BC1nUBpuo=;
        b=d1UkHllG5QjyuIJFXQxYRseO2cwyywuTc7dE+pgYzDQ0yo+YsQYK4uaf7KzvK6Kknc
         5F4FKPU935w3JZIRRtnd04GvB+SKBJV6Uyvmfllj9RCDxWVOz7xk07J/Z8N9GOnR5q1c
         Kzs5Rj00jzt/lVJkbj5fTI7vnkruIusNzgWEul/OUEhgUQyfiam7sO/ncwkd8hNszFco
         EWLMYAauIeRMHM8PNM4rkUOLtBSLIMQVRwGG4XT2OC5nP3sgn/pxP3vtoZsEzvSEVxhq
         PxYxqrGkT3Sh+2f9cOhuD8wLx64hiNx5HiNSIOHeXg6hEShHG+0fHEJ/nryJCkcvVhZg
         aXQA==
X-Forwarded-Encrypted: i=1; AJvYcCV2AZISA5brR8Q2iqY3FiaHZ8mlj9wwwDygk9nN2rnH9/+Nj2ODZIZPj+LZVIsFLmrCSi9knrA3D39oQT+rw2B85ra8U6rUKvUijwJ/hEXaw0tPaKSRmacKTyNjaHePUp9D1PRYORUrXwZruHM3D326XNQ3RSqw/hPq8rUWJHzwAwNL+/gOa9C8lIoA
X-Gm-Message-State: AOJu0YwniHwrBHi+PUKyXzqcvulmy8g0ROZeQgIkTANr/QN/ZRYFpl4G
	JkrgrT4Fn6sJRaa59ykTqkF2ZXLAckJJAhyNGyzLMGLSHwzJICTQYzDWxB3a
X-Google-Smtp-Source: AGHT+IHHVqb8hSoU6tdNu/vV7BvrdXIaV01NcPyQB+G8llM+dG/LoUBcvVaaoXUaMX82lZiGbfngEA==
X-Received: by 2002:a05:6000:103:b0:33d:1ece:d618 with SMTP id o3-20020a056000010300b0033d1eced618mr597294wrx.8.1709076361149;
        Tue, 27 Feb 2024 15:26:01 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:e6a2:98b:e06b:631a])
        by smtp.gmail.com with ESMTPSA id co22-20020a0560000a1600b0033d96b4efbasm13014444wrb.21.2024.02.27.15.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:26:00 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/4] dt-bindings: soc: renesas: Document Renesas RZ/V2H(P) SoC variants
Date: Tue, 27 Feb 2024 23:25:28 +0000
Message-Id: <20240227232531.218159-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document Renesas RZ/V2H(P) (R9A09G057) SoC variants.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1 -> v2
- Replaced RZ/V2H{P} -> RZ/V2H(P)
- Included Ack and RB tags
---
 .../devicetree/bindings/soc/renesas/renesas.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index c1ce4da2dc32..09d3ce97efa2 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -513,6 +513,14 @@ properties:
               - renesas,rzv2mevk2   # RZ/V2M Eval Board v2.0
           - const: renesas,r9a09g011
 
+      - description: RZ/V2H(P) (R9A09G057)
+        items:
+          - enum:
+              - renesas,r9a09g057h41 # RZ/V2H
+              - renesas,r9a09g057h42 # RZ/V2H with Mali-G31 support
+              - renesas,r9a09g057h44 # RZ/V2HP with Mali-G31 + Mali-C55 support
+          - const: renesas,r9a09g057
+
 additionalProperties: true
 
 ...
-- 
2.34.1


