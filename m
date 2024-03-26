Return-Path: <linux-kernel+bounces-119801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D0D88CD1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9BD28750E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11EE13D52D;
	Tue, 26 Mar 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="GSS34oC6"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFE613D299;
	Tue, 26 Mar 2024 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480994; cv=none; b=D/F+VwN5O1E11MnZnstBVo+DVRiaAmTRkY8fybpuVvNho5jQcIbLgzOBmeBgNt9zASs0IMHl6tAyx0BHOeP+bl69bYKKuOMaUYEaKgW8mFqWta0Onm+wAbX5+fdfVq2G/efL8BGc+bYMhqQqUebsVm5uj4Y1VGE9NV2SJfYw+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480994; c=relaxed/simple;
	bh=WDvr8oUzIY615IYKFFDaDoBBU9YupDLybvVcIxw84Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=neh1cA7R9lfjWRro2kQq0qov7ErtnqRtrlcn5zLbqz8GywdXh9UQOn2rKsw937bcROcvKFys9ukDlcr+q1Gcn4Pum/bsoZARBG2o6ahQACr+8vYDYq+q5HNZwQzGwr4IW6+AOb9G6RwFPAiwV7uYrru2poHmI1kZgJ/+8GAVOeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=GSS34oC6; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rpCO0-003QYR-2U;
	Tue, 26 Mar 2024 20:23:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vv126PhSztFkrcdCy/6OCfsPMqKAQOQ3JJmexhOQoA8=; b=GSS34oC6UlNqXI29og8Y9Qzy6b
	5MJd77uvKrUxrfUKqjQkHFfnUZztkRcCSqq+SaC98mKITiohSTwfRCdxr+c/EvKv3QLavJLdXmVct
	joy+4Y3I1UkVXwGDwW8zsXxbuznvT3DBccaZQixyPxFBsj2ArjQHe5q/dfeuTplzEac3CzBaNdHdo
	NtTvLrVdo5SrJoyel4HbZ4oJG4KnGiFg/734iDoole6mE/kYg39pu6d96zZAHVAVrSCxU9cp0r9k0
	rAGDd2/ioJf2nhSuaAA/aLFvyXDBRjfTLFXnfePbBQV2DqxKaLxiTeVl0bEy5B8tvvHaJUA9ycGrw
	7vHCBr8A==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rpCNy-0002bX-0b;
	Tue, 26 Mar 2024 20:23:02 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rpCNy-001FZ6-0T;
	Tue, 26 Mar 2024 20:23:02 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: mfd: Add ROHM BD71828 system-power-controller property
Date: Tue, 26 Mar 2024 20:22:57 +0100
Message-Id: <20240326192258.298143-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326192258.298143-1-andreas@kemnade.info>
References: <20240326192258.298143-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the PMIC can power off the system, add the corresponding property.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
index 11089aa89ec6..0b62f854bf6b 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
@@ -73,6 +73,8 @@ properties:
       used to mark the pins which should not be configured for GPIO. Please see
       the ../gpio/gpio.txt for more information.
 
+  system-power-controller: true
+
 required:
   - compatible
   - reg
-- 
2.39.2


