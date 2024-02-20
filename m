Return-Path: <linux-kernel+bounces-72152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2739D85B014
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37921F22682
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545D31754C;
	Tue, 20 Feb 2024 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH9W4cg4"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280B6FBF6;
	Tue, 20 Feb 2024 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708389731; cv=none; b=rsw5euvdlnJjvM3J4+F9mX3PYqgXbIH+H970inq0s60BfQqRgFDMqK/6l+7OYwLAqD99Q1Yokd+kVbfImy4exnzUkE9NNdX3vP7A8htVTz4t9GdvFq5ekDjNFy4yxrNeuQx35y7WQhoeBLKkiIEcdx18Go7awg5xxCzKcXUvZes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708389731; c=relaxed/simple;
	bh=9lxj8u4aDM7kKtk7HKEsPhYcu6NOgcXgkGng+hS9kkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kpOdD3Rc8vrDkZ2EFPi5B5eYfcQSi/dFQDZdc2pNvoQY3KkjkAbfXz5nUcKXDP1O62tnuQTy9jhnoa39dhZ0kmeNx55Etb6hDxcGbl/rJvtyHJ75I0Lp4YXDSG66tDbVglgvlTSXqfZYmMq0f9fqNTDQOy26dO/L30+j4mN2Kvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QH9W4cg4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6da202aa138so3303425b3a.2;
        Mon, 19 Feb 2024 16:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708389729; x=1708994529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XuZnshTHKl9Tg/cmKKixm6682TVpUXXm5RT75oPZP8=;
        b=QH9W4cg4cSMF9pQos/f8Wj4T8qfawpGkYUJITw/mBxKT4HbuvD8yvId89nASmvwms/
         33AkrFgUVMBarP2TSKQmrutsw7jX5fSEnAvqZQbcXMyQjZBlsX1j62smTEm88kyILvpg
         D7Bkf2IbMiSEFTf5ubyQFRxdzDgrS4fIsftJRY07q7RIlcYv6v9FHemBrhqHcN7fP5h7
         ffkOkFr/flJNq/C6N18hFpc5evmieFy+9UAiKGsW4k76nsICfBFsXbSvFB4ZZdeKfYzF
         WQV8GlkLX8q637GOkxdc9hE9/vhDBSZMn3Ckxj7a6uERwipzwf/S5Qx2y0CzPNN7RFmB
         wdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708389729; x=1708994529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XuZnshTHKl9Tg/cmKKixm6682TVpUXXm5RT75oPZP8=;
        b=HlY3fLXcYdfsHV+Pbm6nR4YDYEZB/JIdSmH6r1gpFyte+fOcr7/WStUFpQ79HuFVSm
         GQVxTYKL8WxdH2ZfYIoyOIhM83+s98FFcd8z+efXdSotYzMQ2/q+n1fmaOWpFJAffWKA
         VSaLa1vRn6JDYJVgBhpG2yocBFd3oRbCsT6imj0PU76bg9sEoIEq4NV90euBupnGtCjt
         /8wV+3n4NPX7x3fX9bfUb/J9e0Scyzy4YfAYa3HH8MmHZz64uYpZ3IczI/hY8u29fiRR
         RJkeAeBXFWK5ucTTYndf4xQpovfNjA/J81prMbCxhM1JiS7YifNnx3pjqnkztwnfjj1P
         3aLw==
X-Forwarded-Encrypted: i=1; AJvYcCW5jHNYRukdC9ZDCWjpzA6by+TPwjm2pacCgEkGqNZjj3RqhdqMvfdKhmuPl6dcFtWlrmT550WJY98MVN5PSgi9hLBVaMG2M5R2UQO30bwFdNPsA+XIxJ2HDN0H9y8H8b1n5qdVbeZ5MHb2eJB1LxjM0VRsalsjHTMF37I/FaM+o2mZGHo=
X-Gm-Message-State: AOJu0YyDFHDwK7yCBj80suzRMfoZeeJb2DjOGe1c5D1+zKsdA83OY+SM
	jEZL0MjjTeNmP1WOxVPQlBH5LYQczOrUUo75F0AlSncJDGKIJJdVrRGYXQPc
X-Google-Smtp-Source: AGHT+IFZePH30+BP1VYusdwyKaNoh7HFraYNAuDzOSubqmLs0CqcMF2UyXsCeCPHB71JCIFjpuFNtw==
X-Received: by 2002:a05:6a20:b91a:b0:19e:a520:105 with SMTP id fe26-20020a056a20b91a00b0019ea5200105mr12531279pzb.34.1708389728721;
        Mon, 19 Feb 2024 16:42:08 -0800 (PST)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id cz3-20020a17090ad44300b00299bf19e872sm1831393pjb.44.2024.02.19.16.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 16:42:08 -0800 (PST)
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
Subject: [PATCH v5 1/4] dt-bindings: reset: Add syscon to nuvoton ma35d1 system-management node
Date: Tue, 20 Feb 2024 00:41:56 +0000
Message-Id: <20240220004159.1580108-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220004159.1580108-1-ychuang570808@gmail.com>
References: <20240220004159.1580108-1-ychuang570808@gmail.com>
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


