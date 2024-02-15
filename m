Return-Path: <linux-kernel+bounces-67269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1C18568E8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D3C2828FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DDB13957E;
	Thu, 15 Feb 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jf95WS1V"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E1138490;
	Thu, 15 Feb 2024 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013016; cv=none; b=SvY7Ji+oy4w8HpbKuxSld8KFLWo59QFuvMI5oU5ZbW8R6g/P4vpwl9CAKzWumiJFMKIlT75H8D6K8SUkrmDDb9crNXGyiYzZ/ZNEDeEsZhPQmIVAGzqnBnjNzSlCUmd0Cewi5Ho9g8OVaYh70z4nHhMkDtwUNQUscRxn1BnD3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013016; c=relaxed/simple;
	bh=Wn0rMsWt35FbGlMIQwTEUhz12Fx1B/zaBbRqFVGd3kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T4IhGDT6ccF2cf0z5Pe69PCXvnVwZThZYTeBqEiyHB3z6gst7KLv/VuLrVaslkZrIChK3tiTklV0pIqhC/zaf/3nXC6xAIvyXpc1SgYgqbZcuoggk7PW2mPsdvgUP5zOKgLYsmv73c0lVFwVfj9ysGxRqmboatRDb2GJR/8d4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jf95WS1V; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D0AE2000A;
	Thu, 15 Feb 2024 16:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708013012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbAF30UGO2hwQ90//5WT0Na0GWCs/V5ZAZK9ncKJm0U=;
	b=Jf95WS1VK6t9d+DvvNHsYFJsC/deVd9J/ZOaICo0lZ5/KZtl0BZWi8qxg3yDqqEXjR8DMd
	i66+lLfG9jKkGMgIu8aogdc9dN+HRKceYIStIiD38oIssInFPbwLAG0AEk93zEcylRacT8
	IQwgHkc273a9y6ZOxtILcSWW8Gu7o6yqoImtpo/lmCH/hBiKU4jWv4B4hzfISBAmq6pOGC
	qsRH/HSzbHxtQ7RIptLvMpX8kjvJjGZnrkZlZv8qB4rIoyM3nz+VLJFqf6K7QpFRWmA7Ml
	6N2C92qN8HR9lfDiCFgV+DyFLcFNnxxuOEAg/NlytkpzWn8bJzIkQJHFbFlkzA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 15 Feb 2024 17:02:50 +0100
Subject: [PATCH net-next v4 09/17] MAINTAINERS: Add myself to pse
 networking maintainer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-feature_poe-v4-9-35bb4c23266c@bootlin.com>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
In-Reply-To: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

As I add support for PoE in PSE networking subsystem it seems legitimate
to be added to the maintainers.

This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b3081334698d..48b08114d804 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17684,6 +17684,7 @@ F:	net/psample
 
 PSE NETWORK DRIVER
 M:	Oleksij Rempel <o.rempel@pengutronix.de>
+M:	Kory Maincent <kory.maincent@bootlin.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/pse-pd/

-- 
2.25.1


