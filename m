Return-Path: <linux-kernel+bounces-105319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C47787DC33
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 02:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173C32823C7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 01:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097AA79E5;
	Sun, 17 Mar 2024 01:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gezx1LZR"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7E1FBB;
	Sun, 17 Mar 2024 01:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710639370; cv=none; b=IbLsyLT/DbopT5pqwhvQDZr7Q1pb2vGuDh/Sldzv8e7nrkRVaPhEW2h/MK/TyzQRklks6b31vGdI85wcQVmtMkcXXBuFRLttgMrSJqDgQd7gmhOTY70+rtHBF4jKnwvIo8nSbCEwhUieVd7tjPHQLWMnkmBsHemQF+Qot+1V/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710639370; c=relaxed/simple;
	bh=iqesdghEcnwOh+0QdQK2UT0V3yXb8zQ3CiPUlwu6za4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+0cae8E202HrFOsy2SapHnBv9emK2moeEYuK2kN4pasmu2YBCYjv/aTjfScELnpjIx4ly1TO+ztEEdHBA/uua4EU/nd/8B5jS/GC5a4fyt5vj9pangT3MBvQN/pk5//F1/QHdaRp/Sw3UpFOQPX/Jb0A7nYyp6vVRdzIkwUkC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gezx1LZR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a466a27d30aso423458166b.1;
        Sat, 16 Mar 2024 18:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710639367; x=1711244167; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mldgZHXC40qWEZn3FORzvd3xQhVR/l/EKFy+VTj6VJI=;
        b=Gezx1LZRuWs251pDaepJ/35sORXC7sxgYeObU1CvIt+LDQz3dolNckFmmIHWnfqEjD
         exBEX9qp9aQSEPjZpcf4GCrsDibc4va9d11A7bZRavBr4r/1gerFV8swjOQw9uot6GM8
         RIXsWlRUx3aMq6YffcdMaOat2m24pyy5bT76YTCFZ60pzlj8gOxWSszNcRKcJDgMk3wj
         n0yvI4TzyEgOHcZplNTy3y+cCtrVLhti8jrFC+xUJNxVM0WfKU/BMR9psswq9EbFqUW1
         vWOdOJzEccWfh9nA1obcgcsHI2+lHbWPhmYOSdoOS/u0IUAXpCi4tc3scWuqX2VltgZV
         XRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710639367; x=1711244167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mldgZHXC40qWEZn3FORzvd3xQhVR/l/EKFy+VTj6VJI=;
        b=RnhNpgBappiwVIciAG2kiOUShDdc+b7yvBHdkRRidfQIXZiUcAu2WwNmi++cFNYYDt
         1vH0xpuXjk56MmmK1Wb6h7ojmWbSuKM9UH4KXETJckRRwd+l9kG9UOhLvEo8y6Tvr6zE
         GxRuAg9qZCI+/BX4Ln1WjPePmX3dMJrvJQbYmuvPCG+J/CkItnKZ7Whrdd8e9+3nk2zu
         lpnhBZvBrWgOXCKR7wIbYZ1yQDlfeH8k3PfRXKEoLiEUPVPvJ4XDSIV5pIemRNBg4H3q
         2zClrdLjQhBbVRn994t4JaiZ876nUZiblJQ4GPXWGqQKSJNGHo75m9NuFKYV/PzQ6sZX
         08Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWwThbdlAglBZYhj1OFn9VKHZrfEuI7gd9LNTba5gTaGDZ/NZcOFxsU4shh282xOX9yknTD+4KmE0S45Qza190Iz+Gl7/sbKpirco83
X-Gm-Message-State: AOJu0Yyhnq3By0mAsxJPNk1T1KkPe5+O1rd1kMOL5UM4CcqvMASRkB6j
	86PskfeSqZIu6kzS1aLDs0pRZ6DbTN5k2ZSi7pnlnObDnUQjtcFk
X-Google-Smtp-Source: AGHT+IEmY2wt2cMNTQFpTQtnoJDnHefkASho/KmNPwBLag9ZY1aMF86aWic69vO6I/zBDNxWycQPhg==
X-Received: by 2002:a17:906:684a:b0:a46:a194:bc78 with SMTP id a10-20020a170906684a00b00a46a194bc78mr1697690ejs.49.1710639366774;
        Sat, 16 Mar 2024 18:36:06 -0700 (PDT)
Received: from ALDERLEJK. (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090635c700b00a465b6c9a67sm3273109ejb.6.2024.03.16.18.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 18:36:06 -0700 (PDT)
From: Kamil Kasperski <ressetkk@gmail.com>
Date: Sun, 17 Mar 2024 02:34:00 +0100
Subject: [PATCH v2 2/3] dt-bindings: arm: sunxi: add T95 AXP313
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240317-add-t95-axp313-support-v2-2-e38032811758@gmail.com>
References: <20240317-add-t95-axp313-support-v2-0-e38032811758@gmail.com>
In-Reply-To: <20240317-add-t95-axp313-support-v2-0-e38032811758@gmail.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Kamil Kasperski <ressetkk@gmail.com>
X-Mailer: b4 0.13.0

Add T95 AXP313 TV Box variant to dt-bindings.

Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 09d835db6db5..6fe137605ba5 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -860,6 +860,11 @@ properties:
           - const: allwinner,sl631
           - const: allwinner,sun8i-v3
 
+      - description: T95 5G (AXP313) TV Box
+        items:
+          - const: t95,t95max-axp313
+          - const: allwinner,sun50i-h616
+
       - description: Tanix TX6
         items:
           - const: oranth,tanix-tx6

-- 
2.34.1


