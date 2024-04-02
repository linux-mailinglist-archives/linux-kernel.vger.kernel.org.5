Return-Path: <linux-kernel+bounces-127843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA9A89519E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5D21C22C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3496A8A8;
	Tue,  2 Apr 2024 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="FjjTtpK+"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D62627E8;
	Tue,  2 Apr 2024 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056640; cv=none; b=AU8xoP4D0LDk8TVmceMMRzjky7BIB9ORVk17UUzTs09jYzBiDuG3HuG6odG8dMRheQTO70vDlM44HAjgNZ6OkdUQkTlitwpyuteDZmaOmTwOZTswcYx1IrY4SJ9d0z6yfu0k8hs6oIMJIRUuiMma1mlTLDdh99ZwZaoCupQmU3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056640; c=relaxed/simple;
	bh=WDvr8oUzIY615IYKFFDaDoBBU9YupDLybvVcIxw84Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r6kH7VlKISuQEcgiliI88IVZn1ixtiAk50wqATlvfBsYNSIiHs8bwpP8kLlglhvVD0xBteHtyLiDXQmqKNd9QRcwABt50SoPEfLzMWTI5tJLkDapWocxAFRHBgo8WXNHJ5jR96UNdT0KL9HdvHv2qTTy9gOvJV97nz0X0sisZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=FjjTtpK+; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrc8d-003kpB-0M;
	Tue, 02 Apr 2024 13:17:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vv126PhSztFkrcdCy/6OCfsPMqKAQOQ3JJmexhOQoA8=; b=FjjTtpK+rXHIt0ifGJ6x+2MR7m
	sGpnho0ds55jAC0PpEyE9B1xoh1/jcXiiac3VuIdTVLs1mQSsMScDSs/fBbSngYJc21IbwvUjYVXK
	nKNZ9elS7I+RUNUsWG08a0Mz3yGaZZBxHoGwLO4mLLELYeMMgp6oNWbl6Xga8XaV3vvru8KfnaGkh
	PxM4X/TVVejxgv4F9ZKWPpDZ1RHq5EiQSYT7mJawm8cMDYJJ6rioYp6vlSsYZ8Bh50Ix/H+w8AAFS
	hpIq+lZxQ3ph+mePixKZ/Wtj7ZH9Cdx5tQXrhw/FC+uyRb3hmxZsaMcwXmPB/WgM1rf/XaVoJv1x+
	caFPSSjg==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrc8b-000IAG-2P;
	Tue, 02 Apr 2024 13:17:10 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrc8b-0024WC-1z;
	Tue, 02 Apr 2024 13:17:09 +0200
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
Subject: [PATCH v3 1/2] dt-bindings: mfd: Add ROHM BD71828 system-power-controller property
Date: Tue,  2 Apr 2024 13:16:59 +0200
Message-Id: <20240402111700.494004-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402111700.494004-1-andreas@kemnade.info>
References: <20240402111700.494004-1-andreas@kemnade.info>
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


