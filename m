Return-Path: <linux-kernel+bounces-15494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D708822CBC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E53B1C231C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE0F199D2;
	Wed,  3 Jan 2024 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxnDUHJv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E618EC9;
	Wed,  3 Jan 2024 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d76923ec4so41850975e9.3;
        Wed, 03 Jan 2024 04:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704283747; x=1704888547; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WYvQJBKPTze3DHEG/ddyiPavhb8SAmoWAb8gifhRQs=;
        b=WxnDUHJvRqBSaV6pjQ9sBK61Qf7uoakgGDCkgErPcObbaRJGj7OFlEOMrwe7uF478A
         YO1LcEAYKJwAuFF4eCTBcu+H1Tru4PNgscWJ+jXlO5Yeter2wx9f4L+YI1iyY4cVPtJ8
         jJi0XWtG0nm7K857mh4aUUnKPyFDyu/KqwhbDXoBBWD3KuWgAJnUvGbnc40o1mZ1b0oL
         Icu3ZOKFDHTsSRDSyQMOpQdgfhZW9wL0ZoBzJbBxCmknxyFzENOOGoYz4jHInB+5uBkW
         VGpGmugtLr/iMHX7BjXSWpDfSOTscRbl48x15EhALobVab+XrGtIYBA34F9Q7FKEjGem
         uLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704283747; x=1704888547;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WYvQJBKPTze3DHEG/ddyiPavhb8SAmoWAb8gifhRQs=;
        b=hkuqGFR4CCorRa8YM2jzQrpGVo2WeTKsleFCPGpJ/3DIBIM5JQM9WfLLp+1ypEzAb2
         GYJgY/7trfVcVtnLTFgPniXA7DCr35WVbyjuoGcHKjp47PA/+rqf10caB4lxgf0hUU/y
         K2gCDxq2DwkCn7GaV0nUI3vWA6PEOb6sTOa/AMTAaABIaSwql4fXUSos0UY6BdEPk4V8
         II7qgBVOcWlpuklOuz3K6PpMWXitIcvlp5ubo0pcRQLbpAhs3pTKymZ6vdrU/2QCkN8s
         w9izzASQtRa0TCRBfiFy3oEel7xMskxPJgxmeIJG8STL7UWNTCQtaFvQvGzXN6V/Spjt
         LrUA==
X-Gm-Message-State: AOJu0Yzpeq7LUQl5KJJxv9GJBptBWfj3Bsgk1wGHmerygOSwxdGUvvto
	lPT0S5eWK2RtSo2RDHY71YeyWAdUjFfDsXAG
X-Google-Smtp-Source: AGHT+IE/nUm5+KwneTEnHsQrqVQ+yStInen24AvslGTUMTC+s0cqfocye0aOigqpWo0TeoX/GidK5g==
X-Received: by 2002:a1c:6a04:0:b0:40d:6032:fa8b with SMTP id f4-20020a1c6a04000000b0040d6032fa8bmr5099308wmc.72.1704283747584;
        Wed, 03 Jan 2024 04:09:07 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-1a90-a88c-d3fe-4285.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1a90:a88c:d3fe:4285])
        by smtp.gmail.com with ESMTPSA id o28-20020a05600c511c00b0040b37f1079dsm2106443wms.29.2024.01.03.04.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 04:09:07 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jan 2024 13:08:52 +0100
Subject: [PATCH v2 2/3] dt-bindings: iio: light: as73211: add support for
 as7331
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-as7331-v2-2-6f0ad05e0482@gmail.com>
References: <20240103-as7331-v2-0-6f0ad05e0482@gmail.com>
In-Reply-To: <20240103-as7331-v2-0-6f0ad05e0482@gmail.com>
To: Christian Eggers <ceggers@arri.de>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704283743; l=1584;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=EVcVlVkKVxVo7dqyNLXpMvZHU1y8Zir+Ulin1WweGiY=;
 b=BOyh1NHjmxJqR1GjgOUOH45Sy+y6lMzcPBfOwYbufIf45EYuzl/tzUKyp3FhoXWCnE/1L9p01
 AuWZq1uFVMOA36b2NTRvxVroYGb2HAfDl9haHVVmXOW9Cs3U4a01+Qm
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This device has the same properties and I2C addresses as the as73211.
The only difference between them is the photodiodes they use internally,
which in this case is irrelevant for the bindings.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/ams,as73211.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/ams,as73211.yaml b/Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
index 0e8cd02759b3..062a038aa0ff 100644
--- a/Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
+++ b/Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
@@ -4,19 +4,22 @@
 $id: http://devicetree.org/schemas/iio/light/ams,as73211.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: AMS AS73211 JENCOLOR(R) Digital XYZ Sensor
+title: AMS AS73211 JENCOLOR(R) Digital XYZ Sensor and AMS AS7331 UV Sensor
 
 maintainers:
   - Christian Eggers <ceggers@arri.de>
 
 description: |
-  XYZ True Color Sensor with I2C Interface
+  AMS AS73211 XYZ True Color Sensor with I2C Interface
   https://ams.com/documents/20143/36005/AS73211_DS000556_3-01.pdf/a65474c0-b302-c2fd-e30a-c98df87616df
+  AMS AS7331 UVA, UVB and UVC Sensor with I2C Interface
+  https://ams.com/documents/20143/9106314/AS7331_DS001047_4-00.pdf
 
 properties:
   compatible:
     enum:
       - ams,as73211
+      - ams,as7331
 
   reg:
     description:

-- 
2.39.2


