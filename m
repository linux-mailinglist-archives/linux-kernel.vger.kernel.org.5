Return-Path: <linux-kernel+bounces-31918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC48883365C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FA32829E8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7480214AAC;
	Sat, 20 Jan 2024 21:17:30 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F2CEC9;
	Sat, 20 Jan 2024 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705785450; cv=none; b=HX8DpIrQ+I2o1hzxDbINID27/R/J+et1sQ/PQA4Jxdl62zstg6EXvuGunazXOM0NDjv+dmAMwJuiuS6HgQsjD5VN8oBUnoZKjQjA+3zuFTdR3qwEUhtJzCjJ2HSrTTdtjEMrmfPlrJpCcm2N+aSTpGXSK1IiIfm/vxaZJAMVJLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705785450; c=relaxed/simple;
	bh=TQbvdedocH+ZVWb2kPtn6fq1z3XkIwKlGuuer4LHqsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jTLFbx8orpwX/w2jsPdFSysoK6/61NF4U7nNVfJUX4CI64YNKarNmvLIvd4LlbdRuFfAobmaDoyj0ktZTHvUsiqLWky0c3mwH98R/eOnukAZ2lDrWnxeK/Aj6xAEHhry7a67wR4rZcnZNLlMaMDd3R5f6hbHPUw44Xgwo5+vTi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 620FA86C66;
	Sat, 20 Jan 2024 22:17:19 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Sat, 20 Jan 2024 22:16:13 +0100
Subject: [PATCH v2 2/3] dt-bindings: input: imagis: Document touch keys
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240120-b4-imagis-keys-v2-2-d7fc16f2e106@skole.hr>
References: <20240120-b4-imagis-keys-v2-0-d7fc16f2e106@skole.hr>
In-Reply-To: <20240120-b4-imagis-keys-v2-0-d7fc16f2e106@skole.hr>
To: Markuss Broks <markuss.broks@gmail.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=991;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=TQbvdedocH+ZVWb2kPtn6fq1z3XkIwKlGuuer4LHqsM=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlrDg698+s1stUHo6E4hlj8Bs2/NjFik9nJaD4F
 TZyGdtFaWSJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZaw4OgAKCRCaEZ6wQi2W
 4Q2VD/9fBmq7wp16hYjZFFEYFLh4ZSsLjHfJOQZihoNJ4t6awI+4cdp9OdagsufIiEHoUGasHeo
 sXibTy/3xflg0npikVBiuwUdGP8kuO/ZJfPML2DcZNpA0TCnueBD2+/Obd1B8RmPTsTKGeX1cX8
 VnpsTzYISm7+JPOY/q2TrmkAi28cgMFPYfQlgpAtQw4rT3v2ouhGbCtw9PqfFdJ4geEpBkxx5eA
 DYRtLJgg2ZyOzpu679VJWxB5DTUd44rnAMChwO3Q63LYrjW7hlXywNVaNX5qxwQ7jzIIicIudtv
 mEWBcMs3997tJyE1KGuAYFOPfrdqRRPCD370YYa4TQyqCjHPNw56dBl9nfFE5Td8SUT5afpIvzk
 mDef9BCtlq+PK5ktnnPtQqsrC7VeDl4GFfXPfxOjaa3kGHB70CiWFQiSTWd7hOEnxhSMgWesS6T
 GHOx25VdTkNG5y160x7DHvRo/bATOTovsWjJDgZadIb2Z57/Nkg5R4OZszMFte03eKw6efu594s
 u6mZqDuN1/hZBhhdsxPv52kTxG60/vPblkZj8s57mu65gLEHvV3jtg9aZsGDqS+AZVbSd+T53GP
 mK97pxt8SbNOgp74BYJVmLR3ER8RE2xAZ4QzElDyXJivbDi9Xr7VVN57J/TOfjyq25Xv9gJ3/Bo
 +z+czi7YqJrAusw==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

IST3032C (and possibly some other models) has touch keys. Document this.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 .../bindings/input/touchscreen/imagis,ist3038c.yaml           | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
index 2af71cbcc97d..960e5436642f 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -42,6 +42,17 @@ properties:
   touchscreen-inverted-y: true
   touchscreen-swapped-x-y: true
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: imagis,ist3032c
+then:
+  properties:
+    linux,keycodes:
+      description: Keycodes for the touch keys
+      maxItems: 2
+
 additionalProperties: false
 
 required:

-- 
2.43.0



