Return-Path: <linux-kernel+bounces-165764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE618B90E1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0044B1F22865
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EDC165FC8;
	Wed,  1 May 2024 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="l+/bF4+w"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3BF1635DC;
	Wed,  1 May 2024 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596497; cv=none; b=O40ST7QNC92+/HiAnsGccou4j8FASz16qAckTzWxttBRyjWndhoQL4USZddIzeMNM+9PoLCET7XNWbfV87GgH+EqwRl253d2h27DpZFJgI7/5xjb7rsLwyaceZuLwmRBX7eSJm4h2haBPEy1tl2ytDiePxpvc2cH7Yf6kARW+k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596497; c=relaxed/simple;
	bh=Tiy2F4jguHHFGevNV9k3bq5nr8j4GVd0yoOlkMy0hGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DS3jIDp9HNOFUcH9H6q1qOgHwozwJWZDhOkpaufL0vL5haxvAZ/Zhb1Q8TFBfOyFXOjIuBzHHyLbJybS3sLzicRtYZJQaO08u+Cfd1hvB/YV6W9/ek1/EV6hY8MyQLSTjsEH56YIXQvoOJ0sw14CdnusiL3YVINW6djuhgRR9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=l+/bF4+w; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2Grz-005PNf-2A;
	Wed, 01 May 2024 22:48:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uGNyEJyuD+UoCXn28eyMiHjYV2XmgAndE6khamSVnBQ=; b=l+/bF4+wLZxZMFHYtv3oDRmaDq
	pF8z6HbsngLMdVLKT5p+HeE3fQHSSlgn+J1+cxj9gTZ4XXNSqr9WO5Jv8RL62qLJFFwNhjazTY30g
	WdaMLIy1ZemFYHVqjVUL+MrW8C4bVdX6svyy3Vc4RQazuApQeQw83Byqx5cGjQTKkZKSrtL7PvujN
	IPS+KETkfyyvQc3adap3ocq4Cy+lqK1phvvEaGmaVMJC3OKWpWNmnzC9JWawyse0Nr1UPGsF8iN0Q
	0o8LXPadNDPmGC0h5E+4FJEgSOuw3QT09Tl2oJPQMdJiAYHqf6uipkFUG99nTdnkedtJWJTZfXusy
	2uxIWpig==;
Received: from p200300c2071a02001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:71a:200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2Grx-000OnS-25;
	Wed, 01 May 2024 22:48:02 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2Gry-003BKh-2C;
	Wed, 01 May 2024 22:48:02 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	o.rempel@pengutronix.de,
	andreas@kemnade.info,
	u.kleine-koenig@pengutronix.de,
	hdegoede@redhat.com,
	oliver.graute@kococonnector.com,
	ye.xingchen@zte.com.cn,
	p.puschmann@pironex.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy.shevchenko@gmail.com,
	felix@kaechele.ca
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: input: touchscreen: edt-ft5x06: Add ft5426
Date: Wed,  1 May 2024 22:47:57 +0200
Message-Id: <20240501204758.758537-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501204758.758537-1-andreas@kemnade.info>
References: <20240501204758.758537-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible for ft5426.
Searches for documentation reveal neither edt nor evervision
as some related company, only FocalTech.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
index f2808cb4d99df..71fd3c66c966e 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
@@ -39,6 +39,7 @@ properties:
       - edt,edt-ft5406
       - edt,edt-ft5506
       - evervision,ev-ft5726
+      - focaltech,ft5426
       - focaltech,ft6236
 
   reg:
-- 
2.39.2


