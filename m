Return-Path: <linux-kernel+bounces-20807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4968A828579
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5D31F258F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D3B38DFB;
	Tue,  9 Jan 2024 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gzKZso9o"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D253716F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d5a41143fso31754895e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 03:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704800951; x=1705405751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmp2BpvyTxAcamyi3InOfkuuoCxM3N59/lufaFAw+Ac=;
        b=gzKZso9ozQXUuUXknRQwUxtyxc+DwTqu5SoIrUguYh2z9R/Q/diDjfoVwZzXSJ2HM1
         8P3vmTS11ikWQhMCzApIMo73tTcSSsClgMd6UlZ72G12i3NfjHFo14GSUIIzLR6eN0HK
         ONjxae7oGkPdluzXYA7+Jt6fHhjG5ll/RsBl2MktvRpIPYslspRRXUqcI/Hl/Lyws+ON
         0hg2qV4Lhj4+f8PjjYyrjCF/UELHBQbTlT1867JcKJtRM1XE57UbPF7enAAHKpbBFzR3
         XRNUR7eD4tuBCjyQ81wosmwzkI3D7QdMAFwpyrxhGRankyuC/2j0eZPmlwWyg0X17tqh
         QWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704800951; x=1705405751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmp2BpvyTxAcamyi3InOfkuuoCxM3N59/lufaFAw+Ac=;
        b=C4iVzntYqLeoLmrCXoQ+zgfaiDQPXV0SNUbGYBzM7zTyl+gQHzcS1aEnIi3A+quy4t
         LvlcPvP76Ttqh+5y4VBOmjWfVm8/Bvsk1RLeBBiFH7zPGe9rZewRzeNcoZzuX4lWbYmF
         HFpCAcA1f6S4+tt1EQgvK5nDG1Pdh+yM6b7uXGjv48n7Ax5PaZ04jKjiBWXa09WPyNyJ
         js2/b1s4SSbtWbK4c6QpTCGHUIQ9ko+j1AsDXpXoTEs85Y981Eb/9D68umsjFfHJx7Y1
         RBlK+Nb01LDnuxvKsl0j39t017feZKDQwn43yY7r3K27E/bt9g0AobuHte5NIlMROpk3
         PUnw==
X-Gm-Message-State: AOJu0Yx9x1NMLI6EsPH2vRyg/fOruVU8zkfD9VXtyJoFHDIsXUNDjrRq
	7oBs4DxBwer5PopbX6pGKhB8Td6egNn9tw==
X-Google-Smtp-Source: AGHT+IHSMakrUSHIrcnYR6pVA4Us/42RistQJd8RJ5YGq9NmJknJtFm4agS7HU4biZqw9DJh8YArYQ==
X-Received: by 2002:a05:600c:4f81:b0:40d:5d9a:adc with SMTP id n1-20020a05600c4f8100b0040d5d9a0adcmr2686156wmq.11.1704800951670;
        Tue, 09 Jan 2024 03:49:11 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id bg30-20020a05600c3c9e00b0040d62f89381sm3335699wmb.35.2024.01.09.03.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 03:49:11 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	peter.griffin@linaro.org
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	semen.protsenko@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: clock: gs101: rename cmu_misc clock-names
Date: Tue,  9 Jan 2024 11:49:06 +0000
Message-ID: <20240109114908.3623645-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240109114908.3623645-1-tudor.ambarus@linaro.org>
References: <20240109114908.3623645-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'bus' and 'ip' are sufficient because naming is local to the module.
As the bindings have not made a release yet, rename the cmu_misc
clock-names.

Fixes: 0a910f160638 ("dt-bindings: clock: Add Google gs101 clock management unit bindings")
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../devicetree/bindings/clock/google,gs101-clock.yaml         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
index 3eebc03a309b..ca7fdada3ff2 100644
--- a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
@@ -85,8 +85,8 @@ allOf:
 
         clock-names:
           items:
-            - const: dout_cmu_misc_bus
-            - const: dout_cmu_misc_sss
+            - const: bus
+            - const: sss
 
 additionalProperties: false
 
-- 
2.43.0.472.g3155946c3a-goog


