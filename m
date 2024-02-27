Return-Path: <linux-kernel+bounces-82827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 775BD868A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F092847A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C96854FA6;
	Tue, 27 Feb 2024 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuch/eCX"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499D54DA0F;
	Tue, 27 Feb 2024 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020259; cv=none; b=AMjqeu/7hxckPbdIB7ohs84ifaLMWvrdJzBp9u5mP3Au0VCwAW8MtMV0EoAnpNCLyRFrXjk5hwRaSwu82E4CBBroIMjyt1UTNkeVZO1uUhpAXG/if2Z1EQIuLycUbP0l9hdW6Tl+5+VtgmZ2DJ9MlBAA8F4wNhm2AnMAdzProLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020259; c=relaxed/simple;
	bh=k6tfZJvEkmTx4lsSeEluF0eWkLB3XM9cxh/wBqdZzM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gaqOPcLEu8VhsrfYIXFz+1UulHsZSIjAVxOdpcRtmrAWutbP9MGzWWHcLOlex+E1jbKMHvud+10lGvCwX8XGkmkZ8nK974Od01WJKqcYUuco/G2RlY+OMKxc3WxzncB6onn03npIU7WGoC8EMnEvG8tOTjwXajB9CLSuFIm23Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuch/eCX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc5d0162bcso33404305ad.0;
        Mon, 26 Feb 2024 23:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709020257; x=1709625057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ExmgizukKPnIx/Jd8+Nc1AouYDtsU9zmeWHuFNKWB7Y=;
        b=iuch/eCXa0a41gj41vrzNO3SWux7wx0Ze7dcecakvxsxvq4NHG9/EfxrcEsPWK6Stg
         jfP0n7Gpt+FCGfTJhiYOFLIXlKqXIHnzHshBB6Jkqj1kjS9rHnVoQ8ap0aFOxWQy9yY7
         6ATOfdRvGKY/2X4/TGRfCzK3dNMRa+QKRg+9btB3ghdTujIONOlOIU8NQxYfg7J6NAEC
         sd4yi8QIkqLLOsBGzeR8P62or869wZ445TOzquZERqCBIq4kXEVc6l5+Qh2YnI77QaDf
         xncA/o8swKIv4nFtvBm4juvfC5jfpz3GBJdHVQC+Jyh9cx9UDeiCEL4AXqp36uHkSzkj
         a2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709020257; x=1709625057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExmgizukKPnIx/Jd8+Nc1AouYDtsU9zmeWHuFNKWB7Y=;
        b=IYsRXDtKTVm3ZZfsrz9u9kQqoeYr3Ir9vqiBIKbH9uE2UUNyAKr+n4/cvfYglY1GNU
         bQ+KdppKA5BHbxk1LDJjKrbXpq2TgoJNr0X/OSGFovW9ugg0eCCwPpS5ViWt8r2YJjoX
         TXXtKWoMnWX/+/WCa9w4AmzUQk2o/IwF0gs5k0laFAfmiExOxJuTzPP6qw7TCi118IhV
         KlW8xkWmxbsbHzfz3PUDpVPRrL6Har8v3Lm3PccYA6oB1iXKXlaQsz9JtAquFB9veogw
         N3By9OAxoE+4hewi26UkJZudA6Kuqupvw9sWK5uEWtwG7iHhLeoOWhy+xZaPqsBQH5Gq
         oo3g==
X-Forwarded-Encrypted: i=1; AJvYcCU83s2z/705xInIDQX5tUoBjIhWSICaZdhh2z3K8Qkkblod2ych2qIgoxLt/cWfNMnSD+Pejcxrc7s1rOpQWF4fxoxJ4DMEsco0cFdxpNFh9R5weezdUsSozUkC280B6v4kLwBk3ffKPQ==
X-Gm-Message-State: AOJu0Yxnm/igZPjD2QHa0pmfRvT6wlusl6qAxJIhy2EiDbhszfbQ/nVy
	wAkil6gik47bE7BvBcFonuCyRw2EyureHX9DFw1hKBCtbFqOt0uc
X-Google-Smtp-Source: AGHT+IHLm+Q43cnkgNUPohl9/qQKZ3tsPWyswxYw3q03WtrqmCJ4O2bIhb6EzdPpUXHCm0Mv6HHc1A==
X-Received: by 2002:a17:902:dacd:b0:1dc:b531:833 with SMTP id q13-20020a170902dacd00b001dcb5310833mr2214819plx.63.1709020257389;
        Mon, 26 Feb 2024 23:50:57 -0800 (PST)
Received: from localhost.localdomain (125-229-150-10.hinet-ip.hinet.net. [125.229.150.10])
        by smtp.gmail.com with ESMTPSA id ja13-20020a170902efcd00b001dc8db3150asm892658plb.199.2024.02.26.23.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:50:57 -0800 (PST)
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
	Kelly Hung <Kelly_Hung@asus.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
Date: Tue, 27 Feb 2024 15:50:50 +0800
Message-Id: <20240227075051.1577877-1-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on ASUS X4TF.

Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3..0d72a1a9d 100644
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


