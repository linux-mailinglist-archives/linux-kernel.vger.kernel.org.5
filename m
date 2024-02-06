Return-Path: <linux-kernel+bounces-54220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886C184AC60
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456D0287742
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960C16EB4C;
	Tue,  6 Feb 2024 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMvmifBr"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1F6E2C8;
	Tue,  6 Feb 2024 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707187955; cv=none; b=Oi6Fe9TV9arF+VkzXk6uMetE4n42q7dXwGqZKRnIi/bO7LU2ruvK41YUfQLpAosSF3dUY8EpUaLvsxJB/pBCaTT+dwjpuUwFgn0glkZ5kLEXERXP+Q+wnlDz2JBwFRuJtEWY7xSg+v5j7aIEWuVvgC0yWidXKPtsaYwEdqvba3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707187955; c=relaxed/simple;
	bh=9lxj8u4aDM7kKtk7HKEsPhYcu6NOgcXgkGng+hS9kkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RAvr62D/IOZO6h6ARAOy6I8IBjT+THXFET3FoRgH1od7W+fToDs519r3Sl3YWyz81ZjbW8lAvv6WecdHeYGYiDLRkqoyre2qqiw8EGMXg7PHSFR7owJr7Dj4cZ3M6wvUsVnDR6KH3VtE4lLTej3JGr5ewhpQBSOysgli1BjI6Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMvmifBr; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e04f29c7bcso648703b3a.0;
        Mon, 05 Feb 2024 18:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707187954; x=1707792754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XuZnshTHKl9Tg/cmKKixm6682TVpUXXm5RT75oPZP8=;
        b=SMvmifBrbCpHVCDHxOk8uZSVqza1g2DRqyOpGuq+OEZrWUk0ankGsTgEXpKdg89Udx
         My1cwI83gzcVzQGomdHca3IaxMd+ge6w+15X4G5Ovsg5zw3s/LmjPlU+a4czUOs3IJVM
         9LdFPUtuY7OdMlLaXoxJwXLs08c1UULJVVocfPUK+LZix93YEsUBenx+OCpcagv+ZDL1
         Pwva46l0PQlRoFhLiue2TFC6zGiIPiLHzPcBMLgEmMUUvXyMJQTHS+xiTAq2DvmMw8TG
         OmqDpa6uJAaskGI+8QcLkjBD7Od9MH8yPg1dBp5H21mvFiAvCVrTX95LdCJv0gRJpkA5
         AU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707187954; x=1707792754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XuZnshTHKl9Tg/cmKKixm6682TVpUXXm5RT75oPZP8=;
        b=eDoa6PgqRbS05qzllRmC0YReU1OFmFvraajPAr3waGx0bZtlP0cE+VtPjj8QWD8hsB
         XeGaJZD6AL6p+0IRsvSGvXlSj4z5SMiPRiBZUPiG/mexE2Uok5iF32GUhaXsahnSaNV/
         EiOT+VSqYwWt2kAmPkYcrOYGXLMyPz2IkSpXzbHWBIJGGVjHvlEFnT7VpQQKjCWX9JQL
         FdbUBxpJH/XzDIAneuYey49pQLVQUo/KLY83PM+lIfyp+p4F4L7KtKvJd8AgaD4rPVNW
         OhbQYlmlrna/1fU/ktEoV1xJVJ0ENs26fQ+RYUlvYV4jXmxa5+P5JDQMa7fyIh1wEjjZ
         phgg==
X-Gm-Message-State: AOJu0Yzhdad8YxAN2wu2rMiuPWW1J9t6oc+gAjaJBySMX2KHJR7tpMIr
	w+NzG8WvggiFCAlh1RsP986M6Bw3IH4i0MuUUn79h+68oN3qTSkak8SIXyvh
X-Google-Smtp-Source: AGHT+IExQHm3LPkOO+KSmh724R5EiT7wL480O8gxc/ylKr2XlQF2H4+LPhiNpnCOo/+H5TMkiK2OLA==
X-Received: by 2002:a05:6a00:6c95:b0:6e0:54c4:878c with SMTP id jc21-20020a056a006c9500b006e054c4878cmr1154146pfb.32.1707187953659;
        Mon, 05 Feb 2024 18:52:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWucaJbrmJtfE1rykJ/g2NI8bSa2oTeaC4YpqnJGa/5+s8ZyZD8TWt7L4LVL1I+ZFlE7uHYq3NDItJ9GkAV1TmBApcSlE6v/HFrVcd3FTGpvmmDc56BLbdSr+b5ysJI8qQOBXtWFFFxzwWG5aAnbTqmwnB2cHnxz0UZOHEyZgfjbeC1Ykd57WPo52X2KiQeRT5kh36rH4KIRJQ/fBq6F/QPcGZAitkSD0Xo4bmjcp8A1eIaIIQz7X9WYMODrcZfHBugbwITIA2eA0Eg4AuU6qqFng9z9MWwvbR5oX7TKmxX64COKB7sd5BWeBiOxI6IydRzdMrrv4fi2nqijBYyefKQvm2wsnlv4ziLzCCyn2Xm+8RoGBOH1pQdAEKV9TkEG4XYgpwBAsLadKcL3e7QIat7qXdsDYAMMlQLW2/nx4j4OCL+mgaB4s8QuQ==
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id gx22-20020a056a001e1600b006d94291679asm622542pfb.78.2024.02.05.18.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:52:33 -0800 (PST)
From: Jacky Huang <ychuang570808@gmail.com>
To: linus.walleij@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	j.neuschaefer@gmx.net
Cc: linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: reset: Add syscon to nuvoton ma35d1 system-management node
Date: Tue,  6 Feb 2024 02:52:20 +0000
Message-Id: <20240206025223.35147-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206025223.35147-1-ychuang570808@gmail.com>
References: <20240206025223.35147-1-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacky Huang <ychuang3@nuvoton.com>

Add a compatible 'syscon' to the system management node since the system
control registers are mapped by this driver. The other driver must access
the system control registers through 'regmap' using a phandle that
references this node.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml        | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
index 34c5c1c08ec1..3ce7dcecd87a 100644
--- a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     items:
       - const: nuvoton,ma35d1-reset
+      - const: syscon
 
   reg:
     maxItems: 1
@@ -37,7 +38,7 @@ examples:
   - |
 
     system-management@40460000 {
-        compatible = "nuvoton,ma35d1-reset";
+        compatible = "nuvoton,ma35d1-reset", "syscon";
         reg = <0x40460000 0x200>;
         #reset-cells = <1>;
     };
-- 
2.34.1


