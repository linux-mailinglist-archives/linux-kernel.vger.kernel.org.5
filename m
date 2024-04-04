Return-Path: <linux-kernel+bounces-132197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50784899137
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4BE6B27864
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D5713C69E;
	Thu,  4 Apr 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="sypY6/xj"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9EA13C3FC;
	Thu,  4 Apr 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269226; cv=none; b=N+1GUxXPoBnDD9i6L7q7t+kXR113WxIRB1/X3cYv4bjdWksGDkdJcUZ7XlKubcqczG46iIZ4KwFiiALQXXP8QthuzjMEjVa8WDYE8mI4y9ObjEsZTgad67GcCC+zI5SJdy6sNsYYwB7cJF2xvzZ2qnmb3C/8ow27S7dhBKJTrHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269226; c=relaxed/simple;
	bh=ZUkubquExJyKSjWHpg+U1DA7ZeoA0XxYRCWF35keD/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PK5AyNA75S/W55tYwWCCOOd8qkP0DSvcio5wqCdNVkBRkqVM7bm+PeIgCY/BVFRI9RIwBQiabYDzj//Lj8ZVDV98IWiOXYc4k9MT9PHWRrWft/jeYQ8XFA6QfrHPHTeRMzToTfQLAX5PGijtX09hXPK7RbQOahaaDCM8JtnH3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=sypY6/xj; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsVRR-003r6L-28;
	Fri, 05 Apr 2024 00:20:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bhCJc0sLbojqVjkDoA4ETQWLHY4COzkayJKhtYixrVI=; b=sypY6/xjHx91RTBnin7pC9vu9W
	IWq/TJjx5+IPsnh6yl05jODWi3lfFbF6F68tUbFmatj+7LSEuT/9YOwOaTZMGx0JYdIW8r0qug3ZU
	Cl73WsI3HCzZrH/meosQjcSjqb+75ZcgXjUhRmvO8j67x/ju64rPnpaHbjMmIJPFL75JLpYe3v1zZ
	HzXFL/im72+k9ImDh49awvMaLcshM5Wqff7X0mDE+OYnT7SON2W6VG2NB0rQGcQdnKMvKCHDu3ypZ
	2bSoK7YW5d3NQ2dH0o4S0XLywxMXR3MNglmDd1hIuI/ZWQFKTOgP9TdVS+FuD/8YUj0H6/rkQBL3q
	ok4ySiPA==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsVRO-000Nwp-28;
	Fri, 05 Apr 2024 00:20:15 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsVRO-002oTq-20;
	Fri, 05 Apr 2024 00:20:14 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andreas@kemnade.info,
	o.rempel@pengutronix.de,
	u.kleine-koenig@pengutronix.de,
	hdegoede@redhat.com,
	andy.shevchenko@gmail.com,
	ye.xingchen@zte.com.cn,
	p.puschmann@pironex.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	caleb.connolly@linaro.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: input: touchscreen: edt-ft5x06: Add ft5426
Date: Fri,  5 Apr 2024 00:20:08 +0200
Message-Id: <20240404222009.670685-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404222009.670685-1-andreas@kemnade.info>
References: <20240404222009.670685-1-andreas@kemnade.info>
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
index f2808cb4d99d..71fd3c66c966 100644
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


