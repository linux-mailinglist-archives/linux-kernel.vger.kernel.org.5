Return-Path: <linux-kernel+bounces-119126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D0088C485
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60871C3F67D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CFA129E7A;
	Tue, 26 Mar 2024 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ndoMdBkf"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5451C823B2;
	Tue, 26 Mar 2024 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461903; cv=none; b=GAlPqhoFQRJy+yrsqero44MP6ElIp5kkgG0+tI40UcSh93zPazHOExeG2WCNhvz7UsnQIWgHF4IobPA3zVMRc7O7VG0WktGURpOHLig5Wgz0W/RJ5B7A908lveJ8EKjrRVcFos8Wj8gwNjTJ8oFK4kxXLxMuX2cIhBl4Ig5EDtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461903; c=relaxed/simple;
	bh=lEtEq9V0RuFllRQfD4xXgr7vXGGhJ1GLPjsoHjPjsOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tfzS9smAgQJMKpamesPz6inT5KY59KpgOy0nOvWjopnZ+s3SuDUJuD0wZMu2N/gN33824u6P9h6B/40HjdxMlANQCNLW89A90t1Xlzbu5bsJ/hCz6qs5KtygQ7PHhG4iP4waJf4tmDxYfrF9wDI9Ug5ka13LkHh23wzr7yD6HZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ndoMdBkf; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 96FCA1C0016;
	Tue, 26 Mar 2024 14:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711461898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aX/QSO11UdB7CviNgZ7tOZxUEn4YEWW+iShs7kPcZvE=;
	b=ndoMdBkflwhXK2GiuSJhD8B8s9rFbDQc2GY+xNtlYzNlMMs4/KB5FCnWD8MRq5DgMdROjg
	tBs3u7B2sUQanriCaOj9rRr7Lml84IXF8XQnkqKKzVFjcBJUMjTc5SJSGCjWhB5l/ThhWq
	NKVnYlxYIZTmIz+qY5U7B/ETorRDGYM2Mgyj+O9SCcggUdF0SWZrRipzuFoKl8tzMJPM3z
	sbEd5Q/GrhHCupuF9ODb8HunesY/G5eL9DovpFwKZ8mVRAA5LzX6xFkA81uJ7rN1G6YHiU
	LjJHoglrLqFTanZ+Xpwx/KXpygvnxIUMYUMpg08Kcw9xsBL6HcZUggfrUriNpQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 26 Mar 2024 15:04:46 +0100
Subject: [PATCH net-next v6 09/17] MAINTAINERS: Add myself to pse
 networking maintainer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-feature_poe-v6-9-c1011b6ea1cb@bootlin.com>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
In-Reply-To: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
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
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

As I add support for PoE in PSE networking subsystem it seems legitimate
to be added to the maintainers.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ee2901581e1..e1180f6ae601 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17767,6 +17767,7 @@ F:	net/psample
 
 PSE NETWORK DRIVER
 M:	Oleksij Rempel <o.rempel@pengutronix.de>
+M:	Kory Maincent <kory.maincent@bootlin.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/pse-pd/

-- 
2.25.1


