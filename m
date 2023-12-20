Return-Path: <linux-kernel+bounces-7201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D4581A321
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09499B22108
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B9140BF0;
	Wed, 20 Dec 2023 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTeO/bwl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF874175F;
	Wed, 20 Dec 2023 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-35f71436397so42746995ab.3;
        Wed, 20 Dec 2023 07:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703087533; x=1703692333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YhijXyfw3O8scS/NndOb/qu0F4jqnKn1xUMAlvfq/4=;
        b=WTeO/bwlvvp/2cO8hzpLZGqJH8SgY5UkZR09kTf/UqApFpe7HYckpa6JSslzIg5WoR
         jijja3G0sp2dLm7p3LBgWCRuBcDh6J5D5KO1VU0aIGD7OccJ3z2dGr2RI5UphE7GDprF
         eUhobyAwWm/2H0GhAeRM1xBoAhkKVafmmxbSJwL4mi43DLUnxKmHXsUV6YtJzP8K/SwW
         dycdMRBbAesMskeji6es3YY0kGxZ6KA/E7fdp+SdDfsxFfUaCkCpJujuyFRKXCBieloW
         b/xRBWJPD6l+E0WOI4f6uzM7/aL4hTmnMSxPNrOi/bELE7tMlwqAKOhGwnEyl93juh1v
         y2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703087533; x=1703692333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YhijXyfw3O8scS/NndOb/qu0F4jqnKn1xUMAlvfq/4=;
        b=bV/b0SGyN8+lKWKZMrvSMESEpI8OKebQzl9dRvkEMWoFkg8CMw07f7/OCEgX4J3WCG
         fI2h2PnKtAQrKsjZO4TFOIcMndXQG+n5RcXQIxdZ4bFJnZZGqB1JiFyGz1LrB1LoEcr0
         IhuYzL8oKfI5/RTYVV94z3az48CtD+OEMZ7VPrmN0nq8Ynjy2ip3iUakeg3luJox88mS
         n6Y2lOatep+J8XeZmgqqdEXmOSuRFudo85dpK6f2t2kUFCBDSOciolRBfpOFB/XkDMs0
         UWXOCwXhlHfmPkf7pH65qghQJtoEhsVQr15ZbDl4p0uOcT7pDkO2GTLkWCxOMv/bUmZf
         Tw4Q==
X-Gm-Message-State: AOJu0Yzjo11VvtDi3WajpWmAUTv4nE487MJwwaMXmQMT7BqcFm//BtPr
	50zkXe/0v/ZJ4slJhUIvztU=
X-Google-Smtp-Source: AGHT+IEBVyLA+ABgGkWuXkUwlBhcq2icMzTWEVVhbmk8aHTBP5mqMoYRxyR0WjfqDOb1nxj7Hti0iQ==
X-Received: by 2002:a05:6e02:12e4:b0:35d:58ce:2322 with SMTP id l4-20020a056e0212e400b0035d58ce2322mr28289150iln.5.1703087533223;
        Wed, 20 Dec 2023 07:52:13 -0800 (PST)
Received: from cosmo-ubuntu-2204.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id y188-20020a6364c5000000b00588e8421fa8sm4840847pgb.84.2023.12.20.07.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:52:12 -0800 (PST)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	corbet@lwn.net,
	broonie@kernel.org,
	naresh.solanki@9elements.com,
	vincent@vtremblay.dev,
	patrick.rudolph@9elements.com,
	luca.ceresoli@bootlin.com,
	bhelgaas@google.com,
	festevam@denx.de,
	alexander.stein@ew.tq-group.com,
	heiko@sntech.de,
	jernej.skrabec@gmail.com,
	macromorgan@hotmail.com,
	forbidden405@foxmail.com,
	sre@kernel.org,
	linus.walleij@linaro.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	chou.cosmo@gmail.com,
	cosmo.chou@quantatw.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add asteralabs
Date: Wed, 20 Dec 2023 23:51:40 +0800
Message-Id: <20231220155142.3060255-2-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220155142.3060255-1-chou.cosmo@gmail.com>
References: <20231220155142.3060255-1-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for Astera Labs, Inc.
https://www.asteralabs.com

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 309b94c328c8..5c49f63d4ef0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -155,6 +155,8 @@ patternProperties:
     description: ASPEED Technology Inc.
   "^asrock,.*":
     description: ASRock Inc.
+  "^asteralabs,.*":
+    description: Astera Labs, Inc.
   "^asus,.*":
     description: AsusTek Computer Inc.
   "^atheros,.*":
-- 
2.34.1


