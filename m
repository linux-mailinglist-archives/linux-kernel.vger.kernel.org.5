Return-Path: <linux-kernel+bounces-105533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E698187DFD0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861A71F21248
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09431EEFC;
	Sun, 17 Mar 2024 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhIhBSdH"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAE51EB3A;
	Sun, 17 Mar 2024 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704877; cv=none; b=p+Ocni3FlNILjBFhC1+SC7Qfk+p3EaZ3jClTrnshlXNcVOmOQReggS2q8mHQNcOHBCHygNVmfF0s7nH2Yhu/eh4EJCI22S9TXyFgpjmh7iZUHZJ0glFPmxssck5qm3khUHU9pkKIZk9BHWgowPNAvmZ5Lu2gCIC6ViFqGvEfSwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704877; c=relaxed/simple;
	bh=oyR06qU+csCnIicxC6KaxDeCepNpijanUR+yklL+4uE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mf4MUsQBc23uchUJDwGDCnl7v6hwbZcln/wNL7FAf0d7uyRbDqieuugdWRO2W3nQTAZYrpywppxeoS9J9/nAlIVIS+NmmEsPCxfNGO5jvbNPx8THiluJMMle9kv3pVcWvAfrjAGMTR2gBAG9gJ92Ge68vWt7q8QXt6eTqpx8vMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhIhBSdH; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d220e39907so54800521fa.1;
        Sun, 17 Mar 2024 12:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710704874; x=1711309674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ar5SPvQbP2e4cGs9D4/VmHfS/OBugCDvvOGlm53Vplc=;
        b=bhIhBSdH/WRr0gqxvPvrLZjsCwBVuL485Ph5lQCXNWyHoG8VP6QvrM4ST4uioyUxCb
         ecydKYxRAsYmxp8d+P/7tM4KsrEXW7MBp4b8YD/JsWTsdf1afozCZOgLZXScchVPEaqd
         pMGd5v3W/cf4rItBVIYfASPlJejdAtAULOnQbuPXGs0350oODiZy0LR2OcR0eaksGUjH
         qKB+St74No6s3Okk5TAGunbeDuHE28p8abZjV2r6GKBPDvGR+a+px/VqNe/lcRRepQ0x
         TlVo/yPyi1RZuRl6XFsUsQiu+G4RKzbYhbUoiV76O0n7bADnMafOxAMhqwGR1tLuYyx2
         eE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710704874; x=1711309674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ar5SPvQbP2e4cGs9D4/VmHfS/OBugCDvvOGlm53Vplc=;
        b=i92ZI8Bp0rnhJRfKOA2r/J2tqlvG/lRpD9Y9tcFPUC+qJM7VAFU1qMNDTPNVyy2PpS
         t6c+SPcvD+OhZ4kd3xGwAt+PJrBF3SwwRvnDaiwl/GrPpLI0XWppktJBj/7ORgZZHkWn
         vqKElbbo/7Rq3eVzRXrGXubmx4Tdv3bt2cMoz8pWvgpiWx4qP+0SctqNX64Bm7vQnEln
         bRnm28cQ/rJNeHaER1jhsf28+FLZgFw6HBE3uxdagyjQQxLPFGit7uu4llVkm2IsIpg1
         6PIItcQhzIG2WoR/gTnYa+lB6uwn3JFPolD5uvhbkxNzU6rPpoddJnALuX7tvt1Mcvq2
         Gt4A==
X-Forwarded-Encrypted: i=1; AJvYcCXIxqg/JMvLzsSOtW77gMtypJ/gfUl853bMyN3TPT1forhVcJfr2m7ehAZt3bOgMWYBiAunjhhxEwxRkECREkuALc3SVvlF5TAUJaNk
X-Gm-Message-State: AOJu0YxdnzY99iBsiVsXMDqNMyZWkVnnT8CUDD6qvVuYfhN1RGSyV+X2
	bLS/3hU2wk9BV/pNOKFChOxCHqmD+k30ehUlWIrN7az5TbHfXdc1
X-Google-Smtp-Source: AGHT+IH8YbsixVcrBCz8Zv/9yOZXhoo7nnGlxmguft2CGY+/Y2/EBPRx3/Pqyo8pju4M9zKICoIIFg==
X-Received: by 2002:a2e:6a07:0:b0:2d4:5ce9:f909 with SMTP id f7-20020a2e6a07000000b002d45ce9f909mr6902582ljc.17.1710704874055;
        Sun, 17 Mar 2024 12:47:54 -0700 (PDT)
Received: from ALDERLEJK. (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id i24-20020aa7dd18000000b0056ac092a7fasm8234edv.87.2024.03.17.12.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 12:47:53 -0700 (PDT)
From: Kamil Kasperski <ressetkk@gmail.com>
Date: Sun, 17 Mar 2024 20:44:49 +0100
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add t95 string
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240317-add-t95-axp313-support-v3-1-0d63f7c23d37@gmail.com>
References: <20240317-add-t95-axp313-support-v3-0-0d63f7c23d37@gmail.com>
In-Reply-To: <20240317-add-t95-axp313-support-v3-0-0d63f7c23d37@gmail.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Kamil Kasperski <ressetkk@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0

Add vendor prefix for T95 tv boxes of unnamed brand. It's hard to
determine the actual vendor, so let's assume t95 as default vendor for
all t95-branded tv boxes.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 04505cb0b640..65025ad4dcd5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1416,6 +1416,8 @@ patternProperties:
   "^synopsys,.*":
     description: Synopsys, Inc. (deprecated, use snps)
     deprecated: true
+  "^t95,.*":
+    description: T95
   "^tbs,.*":
     description: TBS Technologies
   "^tbs-biometrics,.*":

-- 
2.34.1


