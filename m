Return-Path: <linux-kernel+bounces-163342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9CB8B69A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115E71F22A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBE317995;
	Tue, 30 Apr 2024 04:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8jKIz8M"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1CC17589;
	Tue, 30 Apr 2024 04:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714453147; cv=none; b=LvUklwk8mXivZL5Wl9hvBupdBu9bsxLFxp+ig7UMto+k5gsWIIrZOw92I957QJuc9EB/vwmbfdvYTW/tiKbhdjuhh6+dI8xNz3PAmRFpR9CGfOSH0pzFyKNtt1wBk8jNuNo7k4fYMWD64siGLMAOcTvvtopMh7q4i+kIdA+Jmt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714453147; c=relaxed/simple;
	bh=DGxDhpPjL3gFl/ggNxQHtbO4GsURGoyTqDRUKxmkBBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eC9kleplO3h9lo+l++GJAJweSaMaxkUNq9lI6h66XpEdyTAlagYtO+EkYbnCn4ysepT5FpVGfeaEqXF7nf6ertoawbZ8r44t9/xTw1cQL0Yi6vAW8eNNyvAvaJeWnsvOD2+Lprt6vEvCMSNlo0ffKhwYwwjwasts/cMlyi7I2sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8jKIz8M; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c8317d1f25so3086367b6e.3;
        Mon, 29 Apr 2024 21:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714453145; x=1715057945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeaYT5g7d9utEUSwKoSkLuLBwRnRBLyYUxuEzkcAcCw=;
        b=c8jKIz8MGNhse4lIjZKS24dF+GstydZDpOEPkLT0R8h0retNrD+PbcPmw5WBwHbdG+
         Eh4ltK/19vb8363M61p6xm8I0wmZAv4yrI0weuL6ZCKrvTm+3maOwKnEq5yg2rz5G2of
         WkT6CvfLDO11dzC82E3KiTAJ7LcjrmAsvDNllMwxZmhA+mtLsUAhTLFDxOBRDqBeSFU5
         zFELOXbub+CVrvD3ZD4x+rNVXtfywk48HQ7fgBJo4niuU0UeEahtKkm/jDLhRvVBTuSt
         KDcefS8bhd1u28MA9oJkqxlgtU49MbkZTnQso9ANgcqJGpSF4nTy+JX4b/hkKPdq059F
         faMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714453145; x=1715057945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeaYT5g7d9utEUSwKoSkLuLBwRnRBLyYUxuEzkcAcCw=;
        b=FDJXFn9pN+rUc5TFQhBRglGLjHRE9wMHSOBdr01Fh+YpNOqsxq/CECmcSrY7JTgirx
         WpqUg03zmouORK55nLyFUki3o72SYeuLgzuReTM8ahMFuNSnvQtlZMxyj1K0hlJeWHSG
         DUSh++aUC6GrQUOEMnlzKXc6FhWOv0I+aGcv31ZpboHzfZbYWT07OlrIcE72XN8kvp5z
         w1hAvMoBC2WILVLQTH6xCLopwNvABFfiSS2vActzmoMuaJfFlU+1/plJmQn0Y9F0tVzD
         3a/V139y/yjNfUZ1j6oZqp2yULaT9sZ4Yn3viKlPUNh9JdS8zOtwUeWsg82QSGJVXYx9
         0NQw==
X-Forwarded-Encrypted: i=1; AJvYcCUfz7gk0yrVIRzmC+r7vsO4wb+QtyzCUk3N3btPId5PpQgHhNui9/RS+Yq2y9Ac7U9lE0rsGxO0Za8ioa+YfhrwSs/nVHiiCSah+4Gvq290+1dQwuAG/y3W6t+ydsES9J5iJBUCh9wrWA==
X-Gm-Message-State: AOJu0Yzb7k5RDC27aMSMdhkQSlyoKDaeuvISSKsO/IS/dQmfE5nMBgRx
	kn0aOYA3PTF7vk+HVVAfGhk2XlEyGDVruEBoHHY1aJMu6Ao91TiL
X-Google-Smtp-Source: AGHT+IHmrSS+CBGU8XL0VitjdjUROW5sUl41rCN7wANbP+xrMvxqWiPNClTVDtzKqa8V1sbDHDNi1Q==
X-Received: by 2002:aca:912:0:b0:3c8:2c9c:6e8c with SMTP id 18-20020aca0912000000b003c82c9c6e8cmr12269648oij.48.1714453145194;
        Mon, 29 Apr 2024 21:59:05 -0700 (PDT)
Received: from localhost.localdomain (125-229-150-10.hinet-ip.hinet.net. [125.229.150.10])
        by smtp.gmail.com with ESMTPSA id e15-20020a62aa0f000000b006ece85910edsm20226483pff.152.2024.04.29.21.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 21:59:04 -0700 (PDT)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kelly_hung@asus.com,
	Allenyy_Hsu@asus.com,
	Kelly Hung <Kelly_Hung@asus.com>,
	Kelly Hung <ppighouse@gmail.com>
Subject: [PATCH v7 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
Date: Tue, 30 Apr 2024 12:58:52 +0800
Message-Id: <20240430045853.3894633-2-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430045853.3894633-1-Kelly_Hung@asus.com>
References: <20240430045853.3894633-1-Kelly_Hung@asus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on ASUS X4TF.

Signed-off-by: Kelly Hung <ppighouse@gmail.com>

---
V6 -> v7:
- Remove incorrect tags.
- Modify Signed-off-by field.
v5 -> v6:
- Add Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
- Add Reviewed-by: Rob Herring <robh@kernel.org>
- Add Reviewed-by: Zev Weiss <zweiss@equinix.com>
- Add Acked-by: Conor Dooley <conor.dooley@microchip.com>
V4 -> V5: Update all changelog from v1 to v5.
V3 -> V4: The new compatible is a BMC for a ASUS X4TF server which use
a ast2600-a3 chip, so correct string to asus,x4tf-bmc.
V2 -> V3: Add a label to indicate it is new compatible for bmc.
V1 -> V2: Remove blank in front of the string x4tf.
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3..0047eb4ab 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -74,6 +74,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
-- 
2.25.1


