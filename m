Return-Path: <linux-kernel+bounces-101085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D0787A21E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45288284556
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7C412E7D;
	Wed, 13 Mar 2024 03:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dweECmoy"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4342910A35;
	Wed, 13 Mar 2024 03:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710302251; cv=none; b=IcHmJjMztEESbFTxRIeucFRAP7WKqOy/9D3DNCoi5hq/gZ5AtjGVLabbcFgZPltiM0oMBrk3WgIUJQJeXwwoGBHxiUR3Ahj2DT5altZ3gnVOl+nEViaERnWwuOeVF3QEo1KgaqrYNIBpzpz52ulotF6r4UxPr/u5Tud4eGZiRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710302251; c=relaxed/simple;
	bh=9lxj8u4aDM7kKtk7HKEsPhYcu6NOgcXgkGng+hS9kkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yk+4XkUZ1gBVyNZn9ILyNilJeADLIfJYzaOhSYyBAW0+x//ErYdQsum/DFe2VhFVUtF8r04/ZDo+DhphLVYeUaKnRA8rWAp683wCSE4gGDMbJ3/kSqlQLDZAy7VohA5rji/CBU55YQg05DzYVM4WfEYYAUaLJTArVrY3YVn+C3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dweECmoy; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e4e9cdb604so2246314a34.2;
        Tue, 12 Mar 2024 20:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710302249; x=1710907049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XuZnshTHKl9Tg/cmKKixm6682TVpUXXm5RT75oPZP8=;
        b=dweECmoy+Lw+u52Dnk2qhufOxFwoDvKRwvR+VrJ7f3l639LtT6xQLEawGJUOoP9Ivj
         gVA304+3iEZnFJoK5nWzl3DgMWvTVP+N3vUylEAo+I3eCVx9nLgVrnu5IlUZ2hBsbopq
         bwMmYKC+un1uG+UrsJAIngbIfsmI3lqAbqrof2oRhvxMfVlkqyCzoh7EuMI0hVZ/b7gd
         zMgA6TLmw+RxUJef5G7/ddrIN/n80jSZTpuLtY7rsV3l3p+uNIPkfhrRE2wyChU4fIBD
         OCgWNlaw+KJCCUXbJxq1dRrJhDGpKGoiArms84ykCv29u8h1Hl2ClCujkwDo7qSOy03P
         7ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710302249; x=1710907049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XuZnshTHKl9Tg/cmKKixm6682TVpUXXm5RT75oPZP8=;
        b=sPd7ZuM0j/Ce/uzyZdOXi8N7kO/6nfRPKBgz+1lxv5NOTxrzyDGXwiXPg2KPyVhzTG
         50o8Havnv+JKrpqygNXXhOdPiJ2a1SIxJmus81+f4Dn5xJTlEA/GU42Gi51ljSo5Go7q
         m/soZRH1CYBNlXfR9qmWlUTrSG/8Y8VOLlc2MzDglL7KxRnkxu1MrA22ebpfXpuDWGXK
         HkinHTK7r9FgznstAX6j488qF6eXupBOSA6vbaq9DQUXh62NQm/ALFbceYgbMkRqpkJe
         /qGTojl+p0pl2sQEVa2ilmt1R0NzNGG62/rXg8YBliR98ia4RmpaUyna54gVK461FOrs
         nHpw==
X-Forwarded-Encrypted: i=1; AJvYcCVXq/7HeqDuQz3xeb3YRH+J7HrGzEUOeOYBZbc1anqbB9fJgbzMLsK6zPClhbro4la0Zr15JZK3Y7twDph2IYoD3u9TLvqztnlAzqdUBNuWwVOgzKs/kY34ZdjTaf0LFdb/bbAFM3WRKtMt4ID4tHlTJds7Yn1wujXcTTAeRVDKtH6pJns=
X-Gm-Message-State: AOJu0YymvVbKZIUDSzP3aRXwz9mdvWqFkRE68qavqIfiPxFRfAusgtUp
	ILRXU8ZPsaqvbrdwjduws/Ku1anoQWtLg3JUi/P3JKVJswbuv6kb
X-Google-Smtp-Source: AGHT+IFp6/jR6OTJQBWZSvOQb8gQl9BfjYlQBvp2KADlIIEPW/uZ0I2x7E2nROsK6QOyD9ScrLNQGw==
X-Received: by 2002:a9d:7f19:0:b0:6e5:3d92:2fcd with SMTP id j25-20020a9d7f19000000b006e53d922fcdmr3459323otq.21.1710302249240;
        Tue, 12 Mar 2024 20:57:29 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id o17-20020a63fb11000000b005cd835182c5sm6721605pgh.79.2024.03.12.20.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 20:57:28 -0700 (PDT)
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
Subject: [PATCH v6 1/3] dt-bindings: reset: Add syscon to nuvoton ma35d1 system-management node
Date: Wed, 13 Mar 2024 03:57:17 +0000
Message-Id: <20240313035719.768469-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313035719.768469-1-ychuang570808@gmail.com>
References: <20240313035719.768469-1-ychuang570808@gmail.com>
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


