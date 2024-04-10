Return-Path: <linux-kernel+bounces-138251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8551089EEC9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384FE28237B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4C2156962;
	Wed, 10 Apr 2024 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ShY5u6HQ"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8D1552EF;
	Wed, 10 Apr 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741355; cv=none; b=aKX9TXgXEzWxJPIQsaAIsLv/sGAgHOViJmzjB2R5smyuuXAMHSz2TQa48hS5qm1d5YlN67AQMGkrLvB4QKgOcphxc/gHMrBoj95VZKJfoT4gEx2J9EMX2I8s9UeQnvGtQbpTDjECaFdPhOMcaEc+5kbwGK8HLV1ZbtjZIhTnx5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741355; c=relaxed/simple;
	bh=j7jp4MN+LYsXlZP8dNCi02N09LjgAISkwlJ4l3i8sX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c01EP8ZRMPFFAiIpFppMTVzMK9dfeciyyOenGDcHpxRbWPojdCPhxX24PERttt+HZLyWanpT9NouB/PI8ZCCHXMTTILlhBguZY6o1Wex9tE6EVFmtMGjO/29aL48ekmy+42/fJUEVZN5sY5CgAb3biQ/ieNzft4qPq60VpMWpgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ShY5u6HQ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D0E77C0012;
	Wed, 10 Apr 2024 09:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712741351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1LLm8lZtTD1zK+wyxxMiKmW0zGXnL2EmRjIXVJmlh0=;
	b=ShY5u6HQKpRjc9102JH/yeSKOKqNlzqtHFNDhJUmcL6DZxI7jY7CLMsSbKxXhGvJfGdceH
	A58Pot/m0M3MMrodrmWO/N8ROTyROR04/hvwSgY/Ah9kAjLpxtpey5UjQg5BlZZ0thqfqr
	7CHxue0v3VWpH6KeADzxOy+BBYJlnwh5BVwCxQVkdyNB5lmzmNRIitBbbT5u2q4Pz589Qf
	W4B1WXvJXjxazWKSN9OtitzacjGIoB310anB4VyLiKLGYP+XhEGZqAfBdZ9UI4bxfSxN2l
	fa6ohyeNP1Y7exaFfezZ4kUQomnzGcbqqlM6rJ07sKzMeVA75laMfKfVdBZ+iw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 11:29:06 +0200
Subject: [PATCH v3 3/9] spi: dt-bindings: cdns,qspi-nor: make
 cdns,fifo-depth optional
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-cdns-qspi-mbly-v3-3-7b7053449cf7@bootlin.com>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
In-Reply-To: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Make cdns,fifo-depth devicetree property optional.
Value can be detected at runtime.

Upper SRAMPARTITION register bits are read-only. Procedure to find FIFO
depth is therefore to write 0xFFFFFFFF and read back to get amount of
writeable bits.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 587baf35e4e3..d48ecd6cd5ad 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -146,7 +146,6 @@ required:
   - reg
   - interrupts
   - clocks
-  - cdns,fifo-depth
   - cdns,fifo-width
   - cdns,trigger-address
   - '#address-cells'

-- 
2.44.0


