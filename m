Return-Path: <linux-kernel+bounces-165875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E7D8B92CC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2BECB21E01
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC201078B;
	Thu,  2 May 2024 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="IX0KgHvq"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC9B28FA;
	Thu,  2 May 2024 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714609761; cv=none; b=YsTvXjGjq3Gkui/DZdkYWHKgd4g688Bkhlf9WlkqG19mkt5PYPX9oXP/KXvG6j5C1hY2RqyDWUEfM01/DI9LVwoKKcV8q431mb+w0kIQpf06UVlvb1YwIryQ3VEYzacqSLHTWjMtJddwliqE8Qd3ojBB76ouRZEVNkoTMwjyatQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714609761; c=relaxed/simple;
	bh=LCLLYQoX7UgIy1JgZgp0zmrlNPl0wn3tRlgFm+YPGWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWE0qj28v45JWU9h38l54w2Gbl5udJhJSzxqsA5pjgabFM5bbSVF8uGR2qoyhI0uEhWUeZNxEIIsIqP+5WHcXhpqFVZahgoAQP0zrKA/oAdFY+gO82l1WS0KNLV6L3c6HCvbZSkqj3SGCiKZut6PbRHj6xgRufQN6eyd0/jcT+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=IX0KgHvq; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 163ED42EF;
	Wed,  1 May 2024 17:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1714609759;
	bh=ewqqi7nu89LLxrbMttqUm9ECguf9JhK/MmU4szHH39Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IX0KgHvqOxIvWt1SYxsW0AhfQInkcV3tWcQGCyuOYOjYKpysq9LX5NF/wYI+nD/JQ
	 sXQ0gwazEOZc3ZktrqQGDGocVZR0UD/Rd1b0YA64diDUtLBhrHapha0WegVqrrpnXZ
	 Z7a1FVR2wwPpNCO7oYwjAuMlp3E85s558FSVvVFc=
From: Zev Weiss <zev@bewilderbeest.net>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Zev Weiss <zev@bewilderbeest.net>,
	Guenter Roeck <linux@roeck-us.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/3] dt-bindings: arm: aspeed: document ASRock E3C256D4I
Date: Wed,  1 May 2024 17:28:32 -0700
Message-ID: <20240502002836.17862-7-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502002836.17862-5-zev@bewilderbeest.net>
References: <20240502002836.17862-5-zev@bewilderbeest.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document ASRock E3C256D4I board compatible.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3ff8..c330eba0e869 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -35,6 +35,7 @@ properties:
               - ampere,mtjade-bmc
               - aspeed,ast2500-evb
               - asrock,e3c246d4i-bmc
+              - asrock,e3c256d4i-bmc
               - asrock,romed8hm3-bmc
               - bytedance,g220a-bmc
               - facebook,cmm-bmc
-- 
2.44.0


