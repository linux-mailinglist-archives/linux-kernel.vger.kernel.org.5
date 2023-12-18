Return-Path: <linux-kernel+bounces-3409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04101816BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69EC28425E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C91C19BCC;
	Mon, 18 Dec 2023 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl3VtVr6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F592199B2;
	Mon, 18 Dec 2023 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2345aaeb05so130262666b.0;
        Mon, 18 Dec 2023 03:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702897591; x=1703502391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8/JnmQCAMS2cYksRjeaCp4G2NnTSXTyff3BziFBU7s=;
        b=nl3VtVr6BDStbfPZLMYexXd7g2bcfGMs6OUasXKEcnITBO2e0CutWtPzDF8RwAkNTR
         KdR41AkpgnF+yuMaDgWyixzl8nFvmJl8X5u49IBHtkRmoSJLoRT3GShqIn2qnnx2jNsc
         15DaMp9ZfUKD9Tf8wrsA7y7DZnERZF7q5qyGl/oWaiTJQEdMKKITTuDuVdKdctqjxUoW
         x1bZesBFUXuP6Y3lRkqqJoP68WnYDuC99MXzesJQGo1ZQbxZUxARcJfwCrtNXxjIOUV2
         P9m1BQgejx6Y0mBi5mJQNrAUJqIQ9pp2utaLwKLyD+GaW/aggOhZyxnyBhIAOwl3rIb5
         uOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702897591; x=1703502391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8/JnmQCAMS2cYksRjeaCp4G2NnTSXTyff3BziFBU7s=;
        b=MYLiNmMAuvt4TTq70834b0MiFHnhiOC6cT26jMEbX/SLSjYp4obgubyq5Sjw4bLe1e
         VrGq/+1SkhYkDvRDRZe4VQ542nZDT7DQ9CTExtNL7FMl176Q3i0bNoZNUWlSmmGsl2KC
         Fn3toTDpZU2v7AvYtCjy51MgJXS3msmEIgNYqXGMaXFBVw0TbU3vLR62cYmAeZUy8kGJ
         feBAmSh0Ky7DtSdMpWS0r4yMcoEovsiiXMvBtoBOryEw3BB13Np22qecR8Mz7oCqOfaX
         kF9vOw0hHS0LhV3RX0SySKJWyMK0XJtBsXJk0/cNwr/xWKr+XeePM6IZk2Ql6Vnyq9F5
         DosQ==
X-Gm-Message-State: AOJu0YyEriLUuG1EwOvzKglyr6HsShO3byX/CNqMWVbw8KGy3jQXHLoF
	i7OJ+jZsD2c0YlruBS4VL0M=
X-Google-Smtp-Source: AGHT+IFf3fTdcqRMdf1nMW9QU6h5ioPHWtIwlndls7xDU+7sKH62DkfHYo+TKGbOTDX/dltHActCzw==
X-Received: by 2002:a17:906:fd86:b0:a23:26e4:862a with SMTP id xa6-20020a170906fd8600b00a2326e4862amr2021405ejb.88.1702897591591;
        Mon, 18 Dec 2023 03:06:31 -0800 (PST)
Received: from localhost.localdomain ([154.72.163.164])
        by smtp.gmail.com with ESMTPSA id pj4-20020a170906d78400b00a2353af1f7bsm1406769ejb.92.2023.12.18.03.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 03:06:31 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [PATCH v2 2/5] dt-bindings: opp: sun50i: Add binding for D1 CPUs
Date: Mon, 18 Dec 2023 12:05:40 +0100
Message-Id: <20231218110543.64044-3-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231218110543.64044-1-fusibrandon13@gmail.com>
References: <20231218110543.64044-1-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for D1 CPU OPPs.

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
---
 .../bindings/opp/allwinner,sun50i-h6-operating-points.yaml    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
index 51f62c3ae..fddaa3216 100644
--- a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
+++ b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
@@ -23,7 +23,9 @@ allOf:
 
 properties:
   compatible:
-    const: allwinner,sun50i-h6-operating-points
+    enum:
+      - allwinner,sun50i-h6-operating-points
+      - allwinner,sun20i-d1-operating-points
 
   nvmem-cells:
     description: |
-- 
2.30.2


