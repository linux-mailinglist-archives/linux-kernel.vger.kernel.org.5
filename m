Return-Path: <linux-kernel+bounces-8048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6319381B18B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21653286CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5FC50272;
	Thu, 21 Dec 2023 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPl2Z2mI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E40650258
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3367903b4dcso516919f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 01:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703149251; x=1703754051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mmp2BpvyTxAcamyi3InOfkuuoCxM3N59/lufaFAw+Ac=;
        b=sPl2Z2mIMjPnhXx5yxq5LXlB9pIzDmD6+Ib6PaVUFwFDPbcw+ygc0iZaCSbVMrIjQg
         FT4Zxg6UianwPD89bRQTi+AGyz1yXY6tgBy61+9YlOCyDh0A8FkBzw4hjO8B1ISazUa1
         rXcJZ2/hmcMJcV0XDVCzv0eVO2o0rnQvSgrt1jffuLAD3oc24MDy2XDtLIizWEjVnuTj
         mGLRdaDFByd4OkdSFE7HFX1lVv4CkmCrtYqL1xMm5Si9KahumqvW4H6+ocR/Azw4Vdnv
         DPqiPebTrtGLqVLa66vkvfSH9zbbFccCg5erMgF68VS1sbMOdMoRuduXdp4sv5Sy3Ect
         jehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703149251; x=1703754051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmp2BpvyTxAcamyi3InOfkuuoCxM3N59/lufaFAw+Ac=;
        b=h4fk21ocFGrWV/4kP4k+1Pdanv1KGpndPwaFG4D1QFuZl54UKfU3y1EgoNwnGAO8Uh
         K0ou/+yf56ZGtx9zV++/5A7P53Fxzc1MIzJSDlSOE7hAAYPvAV2fxX6ixEd8Ses91yfL
         InrdDwh9IIeB9Nxk4SaYrGAi7n7T2R56xNSCUdq7pzf5l48wnybAkXesJLYhowbQYbtq
         FR+W1lBKsYPhsp2ME9usipII0y5y+8AJf5D8pJV+pk0Ut2jFHgp3XXdFslEn3eL6Op9b
         zAQ2o1lN+ETwCz7/yDTXK5AoyH6hOfse4z8PuePry0UIvj56gZrUVT6NGFIL+UqtlZJg
         IOdw==
X-Gm-Message-State: AOJu0YzgiWO++JVEOR3DfeZm3wXIOKXt7fue2EqjoVJGhvfGlN/ZjxIw
	cPa3Yz8BWPFeI5rQX03GAx6/Rg==
X-Google-Smtp-Source: AGHT+IG0f2gUZlFOYKxp5bxwe1u/dGjFlsWPWeQnkLcyvxzmwlVs1GWMPSB6g9ccz2VX8bwSQiNmhg==
X-Received: by 2002:adf:f54b:0:b0:336:6a2d:f60 with SMTP id j11-20020adff54b000000b003366a2d0f60mr655749wrp.75.1703149250795;
        Thu, 21 Dec 2023 01:00:50 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id o10-20020adfeaca000000b0033677a4e0d6sm1523900wrn.13.2023.12.21.01.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:00:49 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Cc: conor+dt@kernel.org,
	mturquette@baylibre.com,
	alim.akhtar@samsung.com,
	semen.protsenko@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] dt-bindings: clock: gs101: rename cmu_misc clock-names
Date: Thu, 21 Dec 2023 09:00:45 +0000
Message-ID: <20231221090046.1486195-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
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


