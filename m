Return-Path: <linux-kernel+bounces-146755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEF28A6A61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C37B2104A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3C712BEA9;
	Tue, 16 Apr 2024 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRfw9yae"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D16912A17F;
	Tue, 16 Apr 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269438; cv=none; b=fLV9sWjFslHjiQr8ax6pXp7zArsIEU67Jnu7j7hEGWcQTizirhEC3BQarIMUkIa4+jq0AqVGX9bzhsCexFRK8VATaeHqdPOHKTpkwmBQVZp+G0d7Tn0fDDmBjge0/tXcUZFfCuhAWCsvXgoifvEbABRit3C+9shSHFUqUuXY8nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269438; c=relaxed/simple;
	bh=7HYteCqzMBVNnPZJ467F/B4yXEixmL6lB2fxTh4FCiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ruxgBufv77WWoworu+y9cfofJw95jsTmZnmvEskVKvfPb63y+MiRfTzYwb6yX7yMeod+tHliVPMjFHh5lRHswQg9qqqPtTsCJzyVh95rqnB1Y4g/FYaeapwCWHF4Xbh7pcki0akRy9H2JB+Vq3/g5qDoGm2967HEFVQlCtX5QBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRfw9yae; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5200afe39eso533370366b.1;
        Tue, 16 Apr 2024 05:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713269435; x=1713874235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qunSwPKc7mLDKqqj/ytcrTEeCRQTTp7HPOMCEfR0Oks=;
        b=cRfw9yaeg54xPTipDbj/+0hg9Rs7ufr+dezFea6I2sLaoAt1wh2AzYDOQv9gkgg+EN
         d0dj5ZUuVfEigFZdg3ZJ73og1GWFB9bL6Of6R2CV7uIPM44Ys8DHJN8vXYcDIuVZpAEQ
         GW2L7P/dBzmEzcQJvzgGPi4s0PaDhVpyV5qNeEa3Jo+tPYM7+SAbimq7yOJ+9pNmk3VK
         O2iaNVezPUggTscs+DvS5E4p43K7bEbaVLZ8DwxzibIEiLrUJ0hcPWi+BtO/Nr9o3CkH
         YSfHzbTiW6zgtKuKpPMxIi5I2OPExygaBYm4y8RmmTNlGupN++yuBz52vVIUleRssixR
         flEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269435; x=1713874235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qunSwPKc7mLDKqqj/ytcrTEeCRQTTp7HPOMCEfR0Oks=;
        b=hfXTaruIxuyWa/uB1dAjkbRccta7OReSNRf6fLi9ZkKQUdWcX37c/38ozWJveoDAHX
         4wkanQDBMJqZRztsaZTyqhhWitV/ztLulkxI3tLJHRsBt+9wX4YWtiXhAmuytMB8Jvpp
         CYY5TmNEB8ZQytS0YI7cpP4la4nDAihHAYweTnlDPaITZiYEZoTxvYgiOn25kdpATN/A
         B4ipTM4oVxj6x+dCGbQBgQXFWOREsOKsPC9AEwhoKdFOkP7tffzasK1wMbJPAt6RBfx0
         5TbWPIAMWcBdSxL9tfMlR0BQQh2sfXHiTKXwqEwP1CcXdW6E+QOPlJMjLZiOVi4kght5
         NVfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Yo7PDFTrjSqdq9DZc1mmv8QPAOvEKF18t4+RuoNkYqitkidRSE4BJ6cw3oPuuOFFtuptLFQZuDLEP9RneuLe0pAPwoDzwbtkmu1m46rl4Jkmj6xEuPSDPruEIa6C6SgfJ/sgp0oEDA==
X-Gm-Message-State: AOJu0YxTKoaVcKCL2hSOd/hQ0Ivn2RrKZf5XKft/y8mGx/ryUQAPmXTz
	HLOrQepQyneb4kqttJVffBW+edHrb+wcZBPTBygr5OT2QaghMaUH
X-Google-Smtp-Source: AGHT+IFLd32PpfiMZS/7VU2QkkCZR1Wf817qWky5Xivl1b/LeGM3OeLirKtJfDe2F38dHsegA/iweQ==
X-Received: by 2002:a17:907:36c2:b0:a54:4f06:375d with SMTP id bj2-20020a17090736c200b00a544f06375dmr4575931ejc.62.1713269434792;
        Tue, 16 Apr 2024 05:10:34 -0700 (PDT)
Received: from eichest-laptop.netmodule.intranet ([77.109.188.34])
        by smtp.gmail.com with ESMTPSA id hg17-20020a170906f35100b00a469d3df3c1sm6767509ejb.96.2024.04.16.05.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:10:33 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lxu@maxlinear.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	michael@walle.cc
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] dt-bindings: net: phy: gpy2xx: add sgmii-match-tpi-speed property
Date: Tue, 16 Apr 2024 14:10:31 +0200
Message-Id: <20240416121032.52108-2-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240416121032.52108-1-eichest@gmail.com>
References: <20240416121032.52108-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new sgmii-match-tpi-speed property to the gpy2xx binding to allow
the phy to match the SGMII link speed to that negotiated on the TPI
interface.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
---
 Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
index 8a3713abd1ca..9deae36bd837 100644
--- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
+++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
@@ -27,6 +27,12 @@ properties:
       Affected PHYs (as far as known) are GPY215B and GPY215C.
     type: boolean
 
+  maxlinear,sgmii-match-tpi-speed:
+    description: |
+      When this property is present, the SGMII speed is set to the twisted
+      pair interface (tpi) speed.
+    type: boolean
+
 dependencies:
   maxlinear,use-broken-interrupts: [ interrupts ]
 
-- 
2.40.1


