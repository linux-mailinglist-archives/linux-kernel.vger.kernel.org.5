Return-Path: <linux-kernel+bounces-162032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AF88B54E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863541C2080D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0657C2C6B2;
	Mon, 29 Apr 2024 10:17:12 +0000 (UTC)
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35A428398;
	Mon, 29 Apr 2024 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385831; cv=none; b=JwOUbVJMOKRgsM7vBEdraXueIoHYUJB9lJzptTkZiW7P/wTfCzQthfDbUXlmrg82sR9WZMhoeZc8lViKSjZ+eealytEO33lcS5i2wk/yebG+DBIG0qOSQgsQlMSLmmKSQ6lMv7Ceor/78iDeR1+nfTJCtlgtHhx5ib4xdlH7RPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385831; c=relaxed/simple;
	bh=/b2S7quzfSSk3+q+FH7ikzOPKBAguy1mqKvir6ggqwo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHjQr+SgYdDmivom8WdyQdzUwpvFugXdIAf7ukZGhJxNlVdYBLjAdmBOWLufPcBk9eRZm3T8naXkRcb0RzCeDmpwDx5HvcrrYWYQDjTCKRrSkdG/N8GNJDhhU5767CThuwhyJHJuk+LwcDTTAbhhKnVZrtUO23fgKQkn4Pki80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3367353:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 29 Apr 2024 18:16:55 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 18:16:54 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 29 Apr 2024 18:16:54 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH 1/2] regulator: dt-bindings: rtq2208: Add property to get ldo of RTQ2208 is adjustable or not
Date: Mon, 29 Apr 2024 18:16:46 +0800
Message-ID: <1714385807-22393-2-git-send-email-alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714385807-22393-1-git-send-email-alina_yu@richtek.com>
References: <1714385807-22393-1-git-send-email-alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Since there is no way to check is ldo is adjustable or not.
'richtek,use-fix-dvs' is added for that. user is supposed to know whether vout of ldo is adjustable.

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
 .../devicetree/bindings/regulator/richtek,rtq2208.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
index 609c066..3951679 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
@@ -75,6 +75,14 @@ properties:
         description:
           regulator description for ldo[1-2].
 
+        properties:
+          richtek,use-fix-dvs:
+            type: boolean
+            description: |
+              ldo vout ability is determined by this setting. If it's set, the voltage is unadjustable.
+              There is no risk-free method for software to determine whether the ldo vout is fixed or not.
+              Therefore, it can only be done in this way.
+
 required:
   - compatible
   - reg
@@ -180,6 +188,7 @@ examples:
             regulator-min-microvolt = <1200000>;
             regulator-max-microvolt = <1200000>;
             regulator-always-on;
+            richtek,use-fix-dvs;
             regulator-state-mem {
               regulator-on-in-suspend;
             };
@@ -188,6 +197,7 @@ examples:
             regulator-min-microvolt = <3300000>;
             regulator-max-microvolt = <3300000>;
             regulator-always-on;
+            richtek,use-fix-dvs;
             regulator-state-mem {
               regulator-on-in-suspend;
             };
-- 
2.7.4


