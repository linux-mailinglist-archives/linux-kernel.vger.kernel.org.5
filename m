Return-Path: <linux-kernel+bounces-1116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B842A814AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BDF2856DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340B936AE3;
	Fri, 15 Dec 2023 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="bYyoIIIo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD8A364D2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 60A533F2D4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702651155;
	bh=5d0QhzVl7C6w8MyPA6on/NHcmfCtxfOh1Mcdqcw1JG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=bYyoIIIowGXb8//aNctKmzMiKCGa/JuSam238X5sqVLTTfamCwaOp7byQroAeLf2R
	 MkGlJ1IidyBUf0UKL/XL7gLyGGutEzIjB0ko1xeZiAXQx33oBqUs5rR27H8tyN8doy
	 S56IVYdK5c3wnNaOjB0LcJXycO+UoG0vZ1Fzj3pLP0xHCmq0mBaX2F3D0CQjs6C43O
	 3caJXM2Lf1rt2UZHjwgsajr48phtYwpKLhZjWSqaWc1/rW6iNpWNCdK9y2TtTXgLLj
	 sTbi/lhNSnPO3P6PNXoDdIxyoz6pdF8CcLgyTb95wYQ7kUwH1Bb06/6zXKQ4MmSWDK
	 aMxKWbDOXELwg==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5528b4ab7bbso375016a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702651155; x=1703255955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5d0QhzVl7C6w8MyPA6on/NHcmfCtxfOh1Mcdqcw1JG8=;
        b=AGWKNN3TsykFH4i70UYSOYTDSfxiALTfCzntLc2t7qomIRBtU5TjzmFdB6jC9waW+k
         TZfIsTN5f6hwIiY8njsqKkGNHf6VcjrtpliXJCTLAqUshEKnJG13Je6yzIJIhD3jXgyr
         zT/BJ9zVLmklM2s1se/5E09P3U/ahy4wrG98APcWTPVqYcQZ9dPa7cLOjQU83bGdz2rw
         6j/y7CK1yInQl5wQ6OMTql4T+GJKVchNC17QD5ePgZkiZwE8FQn2GkGzFZPzIOfXKTTe
         UNCtRHWxhIcdhFKb0YkQbyzdrpHYkIwa0HtEHDWuVMZKwjKM7zQXo+oeNBcQOuN8h+BS
         VAwA==
X-Gm-Message-State: AOJu0YxxH2VdK/w+IW2E8MevnyFVd/c91suC1hC7VN+p5rt3FTgCgC75
	1sB3BWY6AWdgNQdIuzldUxXxMNgvbKGdzwZH8g1CQvfzKtu3W1camR5/cmKg0/M7zKzbnkGSbty
	R4Ksw6GJmNDgYj1e5M+jjlfqOii6arMUt3Zy1KuTyBg==
X-Received: by 2002:a17:907:e88:b0:a1c:ad6e:f27b with SMTP id ho8-20020a1709070e8800b00a1cad6ef27bmr3397168ejc.78.1702651154972;
        Fri, 15 Dec 2023 06:39:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhb7PhCXQlTmlO8Dr2ltcQSzgklP4jZY0/NHHCOpfEFcHKcRabJYeTEWK6MtrnQyFAiYLIWg==
X-Received: by 2002:a17:907:e88:b0:a1c:ad6e:f27b with SMTP id ho8-20020a1709070e8800b00a1cad6ef27bmr3397152ejc.78.1702651154724;
        Fri, 15 Dec 2023 06:39:14 -0800 (PST)
Received: from stitch.. ([152.115.213.158])
        by smtp.gmail.com with ESMTPSA id tm6-20020a170907c38600b00a1db955c809sm10789122ejc.73.2023.12.15.06.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 06:39:14 -0800 (PST)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Hoan Tran <hoan@os.amperecomputing.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v1 4/8] dt-bindings: gpio: dwapb: allow gpio-ranges
Date: Fri, 15 Dec 2023 15:39:02 +0100
Message-Id: <20231215143906.3651122-5-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215143906.3651122-1-emil.renner.berthing@canonical.com>
References: <20231215143906.3651122-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the generic gpio-ranges property so GPIOs can be mapped to their
corresponding pin. This way control of GPIO on pins that are already used
by other peripherals can be denied and basic pinconf can be done on pin
controllers that support it.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml b/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
index eefe7b345286..ab2afc0e4153 100644
--- a/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
@@ -65,6 +65,8 @@ patternProperties:
         minItems: 1
         maxItems: 32
 
+      gpio-ranges: true
+
       ngpios:
         default: 32
         minimum: 1
-- 
2.40.1


