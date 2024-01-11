Return-Path: <linux-kernel+bounces-23577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD15582AE95
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73082284829
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C54915AFD;
	Thu, 11 Jan 2024 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxxFDPoj"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7931F15AE4;
	Thu, 11 Jan 2024 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2c375d2430so98099466b.1;
        Thu, 11 Jan 2024 04:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704975588; x=1705580388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZKjNuKFpBIgAPNQXHjE+zGWxeFXDpn+QzaU3wJuCUk=;
        b=PxxFDPojDW5l0Gg8xEs8wrD4wb9+68IQC+nKGfncy9fRbXCueQVMvOhCHUAnqNkIrg
         sy43l2wI67c3ypLHUGVriSLONzsmXiHnYWWi6XvV5KxAHloURA4f+9OMABsng/YpxvDz
         cJwL7QGIh2n6jBvSOIPK5hcRLpKBOLekFKKh0nBpRZGRy4PORfrs3Qz78q04wlTJG6Fx
         1Ol63RkzwSGJZJZ8OBeXteUffNcxFsC0E5IDCsvMH5TRg0KMbg/LzVnRoF6c9mXHPyEu
         CLcqfmVYyeHI6cq7qIUzLtUrxpfM3sXX6ahD3+qugZLdOGoYx4uMB5OeKHhl8TIl57wi
         r6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704975588; x=1705580388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZKjNuKFpBIgAPNQXHjE+zGWxeFXDpn+QzaU3wJuCUk=;
        b=i/OTBuPMbSHpTUAw4Nkh7Sg3uqRk8JuwL1vtzFbaPFij8gv7zbpSeM/T9jyZcoeoAG
         ly2ugEgtPxe2Os1DH0PAVShbNONz5aHDUSh8b3GMoM4Ci8PuJbjYIIT8d2nGKi4r+vSJ
         /GUYFvqGf4WEQyKHyISX3juxLNoHNjGZM6FvA2ApoMU/vS33l3jEhQQFf3sJy+BeFVuW
         xZeyXamfdvDV/oOh1QP1QToziHyTDt86CGLoGUn4ryr+ajdZ9mskQ36q0CnJx5h50dfc
         ntJZUC0kOVjy40QkoI0Z+gJ8yIj79nvw0O0k98BFN50LsvAD75BQubFbuWGwGQgzYqQv
         7YUg==
X-Gm-Message-State: AOJu0YxochAvMQtd7FnuUgoIRIJf+O6LZS9eCwtnfq4BpzWvBrfuOTYA
	8TTdtiVdT7ZPIRCC6MamhzI=
X-Google-Smtp-Source: AGHT+IE0vYW1NN1IddmhLKD400aKBqGOGGa9hyMtY0jMcoJXItKOxufMxs964noz+aSuTeIAVwliDA==
X-Received: by 2002:a17:906:ae54:b0:a28:7dd0:adb4 with SMTP id lf20-20020a170906ae5400b00a287dd0adb4mr551156ejb.83.1704975587591;
        Thu, 11 Jan 2024 04:19:47 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id m17-20020a170906235100b00a26ade46618sm516628eja.99.2024.01.11.04.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 04:19:47 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Ansuel Smith <ansuelsmth@gmail.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: mtd: partitions: make partition an NVMEM provider
Date: Thu, 11 Jan 2024 13:19:40 +0100
Message-Id: <20240111121940.15628-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MTD partition provides flash device data and can be used as NVMEM
device.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/mtd/partitions/partition.yaml       | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index 1ebe9e2347ea..7b1d84ce5ef5 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -57,13 +57,15 @@ properties:
       user space from
     type: boolean
 
-if:
-  not:
-    required: [ reg ]
-then:
-  properties:
-    $nodename:
-      pattern: '^partition-.*$'
+allOf:
+  - $ref: /schemas/nvmem/nvmem.yaml
+  - if:
+      not:
+        required: [ reg ]
+    then:
+      properties:
+        $nodename:
+          pattern: '^partition-.*$'
 
 # This is a generic file other binding inherit from and extend
 additionalProperties: true
-- 
2.35.3


