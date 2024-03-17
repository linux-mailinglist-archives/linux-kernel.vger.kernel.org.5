Return-Path: <linux-kernel+bounces-105318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6517187DC31
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 02:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B357A2822AE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 01:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2EC5234;
	Sun, 17 Mar 2024 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAKn5G07"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12917EF;
	Sun, 17 Mar 2024 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710639369; cv=none; b=K23jyNW+5sMwSpaVYQZ0JHHsxuRbe/vSJ+JDdC2h6YMpn82RY7gItRghVjt9PiaInAhRACTQ+CT4/SLfYMx1uGz7yRDzcXcu13oX05n1FEqOfF6PVc7YHFqN2ZWNxTdklZl2mCCDTTms/3K8SCMcTcX7wAkKbDX47VooZx0uSBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710639369; c=relaxed/simple;
	bh=j02q7jjG8JGXprfpOJo8e0jKvdXDrtHrvK2/2T6nX9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D+Pu6gnwtaJ9ksnwC/Q8tCCqZEPy6+BMuplhCp9oe8rxANzXi7HmDPLt8KSIZ9ychpeZ/FNVAKQOUaEDlAtmra/3LC1Lan1MBaEXqbaB3UJajrkwSV2BLO8eNCE+ullXL3QkqGwYuRi9nH6h7Nc3iF7zKUAYVtw7YEDN0KQkdcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAKn5G07; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513dd2d2415so1650892e87.3;
        Sat, 16 Mar 2024 18:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710639366; x=1711244166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5cIl0G6+U3PlWWvuEct8q0vVwSnOHBYDmQm09HKXis=;
        b=UAKn5G075rWfKrtPkcIY5+QZy1Z3DNThV2PY83WdDy4fIxAYX/Zl4/iuhjXrpoQ1XL
         3EIDNr19Vgu2M+rit1vFId0QdKn6VttTRYtniXqHLDnJQogyR2QQHRHRla5+RGMizoJf
         pAMAsQFjChbOeqH+c29X+P+TxB5QYA3RYkzEWMydD+P21iiElXHSd3RmeNv/QGkc0+Lm
         j0aO/R1Hn7f/BIALKscyGlig+TnpkAiJboZBTG1aTMsWoucWl1DvIBMo67v/wozCREzr
         Od9t5Do6R6ZDSaHnXGU5n9cVfI2ni2wf0UzOMMl7itQxAh9F/civupnEExY6PIJm/EIY
         Mrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710639366; x=1711244166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5cIl0G6+U3PlWWvuEct8q0vVwSnOHBYDmQm09HKXis=;
        b=tjqHZh0P9s1uZN3nJsxKtOFVdCsAgmYnFQQWzqsX7AtvT5nKmGaOjWkNunCwbEUZiR
         8iq4T/yUPzJcHLkvHpNo+QfL5nUQHppzE1qPWlPmbLVLznhUtbaDwsTbsnykf8jRyhlj
         pN3r5wG9o+rlpigUF5WCYainUmlVH6pbbYFRLZX7vM4/WjtAeu+F9vxN1UBcgCHcYcwM
         RHDi+jhzn0Ldm2flXFN7C2ZoFJ2XYepzRuu9uIOrG/gVB88PBKwz++QIoRxre6t3qoQr
         0UbMtrcf3gXox1PRcCjkwd1M6nv3s/OBgqL9mEWtyjEZS8cFHxjgMTxWVrE7jjm/C4FJ
         LUSw==
X-Forwarded-Encrypted: i=1; AJvYcCXVBI5UvYJcEKP4NdHfgf+jM9mHgA//RVYTJdCjRsEj6ndTNVzEzBGESsvIMIPNEp1nggZ7mc8GWZgd9XXIIl0Vk1MkOG4PlVxSjVwt
X-Gm-Message-State: AOJu0YyciCg3yPdegcp21MuAQEpbnuek8QPxl9FYqi4af718JfYZgLrR
	XayzQR3kUYFHOnQbxDrTjSTEi0LjccqlKLZwimUdczfcqbEOqd+Z
X-Google-Smtp-Source: AGHT+IE6EfWBotUXrEhlVyc8BxxMwF/tdsUu328c3ofLf+WzalH39pWBkQx1vZpJmRub//gJ1bG9cA==
X-Received: by 2002:a05:6512:1d0:b0:513:ce00:1a2 with SMTP id f16-20020a05651201d000b00513ce0001a2mr5052500lfp.30.1710639365781;
        Sat, 16 Mar 2024 18:36:05 -0700 (PDT)
Received: from ALDERLEJK. (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090635c700b00a465b6c9a67sm3273109ejb.6.2024.03.16.18.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 18:36:05 -0700 (PDT)
From: Kamil Kasperski <ressetkk@gmail.com>
Date: Sun, 17 Mar 2024 02:33:59 +0100
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add t95 string
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240317-add-t95-axp313-support-v2-1-e38032811758@gmail.com>
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

Add vendor prefix for T95 tv boxes of unnamed brand. It's hard to
determine the actual vendor, so let's assume t95 as default vendor for
all t95-branded tv boxes.

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


