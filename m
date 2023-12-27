Return-Path: <linux-kernel+bounces-12189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FF581F114
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2763E1F21EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3CD4653A;
	Wed, 27 Dec 2023 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RkJA4PFc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EAF46538
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so2226365b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 09:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703699862; x=1704304662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qFdk5z5GkjX88rNpaFiaLGBWYiEnPzJT6afZDm+eY4c=;
        b=RkJA4PFc1fPlGPeup903dlfZcEiqEV+5E8gOOr9f9qcjFlAKUY+qRYmxi3blePvH3I
         RCUu0tFNhy69ZsAqYE67ZQ1WzqZOEa/e+XYdra1c2naVAj/t6goggAn/oE2mgTIwQpI5
         EkIdqqQEIr8+lxSmsXhopAq/+WtZY4iMI9son/X2VbgcfukVvKsDJy928hfWEa3CTib+
         dMRJGNtuB8gUXUPPt/HSm5wduE+c8bcKykqlOKSk7UbnhjwV0C8LhhFRoF1pF/gTeW1M
         bQ6Ly5wfVZVW9lUI3Ysbzjs+PjvL1MQ8lUVfxEKwVPcrFq7fqd7CByBAPrUUmR/TIZZs
         u7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703699862; x=1704304662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFdk5z5GkjX88rNpaFiaLGBWYiEnPzJT6afZDm+eY4c=;
        b=FGl6Fa5qPEKX30bn6aUKabvJvOovoG+Vb1G4f4MRIAwmjazCyJY+SUA0kLCHJxcLi3
         /tqlSG0E/nhOiZfdWhP2LSSXYhB6TbYa78ifAurlHf0uMkZbcKBAIiAWX+nUA437upK/
         x80UXiQR0qFnB6SysnDN8mHZtPsZmCAl4t7Gdm9zIIXGm8JNRXnFSTIr6dd/lyIP1eAi
         r/nDi5z3DxFwuJxv5MOiv7qTqPI0SKT4oE7bB2nlt1GHmqG5NfhB9V2Him5OPoS2Jm1H
         Adc4YitgXAywqrGqiuiQPEB2WwTCP+KrzH+CWVlLnz3OcK0k5LZDp39xdcUIgdOu5tsY
         wB8w==
X-Gm-Message-State: AOJu0YzMwBrc7Kdd4CRqScFvWLXyuzxEO/ltPW1DgsqsolHoExnZDgqE
	96pB2een7o8Km7+ReVwgCat6RhkgqC6FkQ==
X-Google-Smtp-Source: AGHT+IG3LdGjYzMPRmS6MMdVEdOJ+KYoJn8AAAezZGQEdrEgTXTmxvLQ77RqjlA7YgUPq4uTh+mQCQ==
X-Received: by 2002:a05:6a20:4da6:b0:18c:64b7:b217 with SMTP id gj38-20020a056a204da600b0018c64b7b217mr9235433pzb.22.1703699861863;
        Wed, 27 Dec 2023 09:57:41 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u5-20020a056a00098500b006d9bf35dd1fsm5198094pfg.142.2023.12.27.09.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 09:57:41 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: riscv: cpus: Clarify mmu-type interpretation
Date: Wed, 27 Dec 2023 09:57:38 -0800
Message-ID: <20231227175739.1453782-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current description implies that only a single address translation
mode is available to the operating system. However, some implementations
support multiple address translation modes, and the operating system is
free to choose between them.

Per the RISC-V privileged specification, Sv48 implementations must also
implement Sv39, and likewise Sv57 implies support for Sv48. This means
it is possible to describe all supported address translation modes using
a single value, by naming the largest supported mode. This appears to
have been the intended usage of the property, so note it explicitly.

Fixes: 4fd669a8c487 ("dt-bindings: riscv: convert cpu binding to json-schema")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 Documentation/devicetree/bindings/riscv/cpus.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index f392e367d673..f166c729c482 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -62,8 +62,8 @@ properties:
 
   mmu-type:
     description:
-      Identifies the MMU address translation mode used on this
-      hart.  These values originate from the RISC-V Privileged
+      Identifies the largest MMU address translation mode supported by
+      this hart.  These values originate from the RISC-V Privileged
       Specification document, available from
       https://riscv.org/specifications/
     $ref: /schemas/types.yaml#/definitions/string
-- 
2.42.0


