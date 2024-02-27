Return-Path: <linux-kernel+bounces-83412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D3F8698AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536B11C2291F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608E11468E7;
	Tue, 27 Feb 2024 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fCjHrlHF"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1913A1EEE6;
	Tue, 27 Feb 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044997; cv=none; b=Zfs/nKUPvnvjVFW7wTztQGAcpeMlGBPrmKHWCCqihzbn3CoA4O21f7baIzwtinvGLTAOSjXKpPFXpjDmXUGDGFLLRbOo5Ba2oEtZMzdpgYcjbUnRxCJNktP+rk9lgA/WoAHVEuxTsvh/HrInQeLmI3ROhmyc0kxU7PX8JdTo4Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044997; c=relaxed/simple;
	bh=WpIWaIitdu21Ks1J/Y+EEHxZixdcva6v+wiNxRdH9VY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNhKLxxuCX4rlcht4FInq04TDig8/t73yH7VarowT7d375wI52Dc7FvIUtRa0b0JxwYp0FdUs3ALAWS7Fteg5slp8XyZgGXJ+RM3SW5VEQZ6iJWEBs3ubJ6AB2dbKP19aSx0VK0cUKqwcQ2SgwTIa6KBWz3X6pgD6ybtH1XQvhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fCjHrlHF; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DCD6A20013;
	Tue, 27 Feb 2024 14:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709044987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kEfi3iPlEEkOJpn9aGHgkThAMUfvgHQbNS7bH/pxoj0=;
	b=fCjHrlHFlK1cggB2QuXQPZtvcHWS5X4o63ixyMIzSICCYlQh0t19CSoOw6v84saUzxI7Qj
	Xxxq6t8E+7AdxeX7+USecAe4FFYc4krUFPU2yfo0v49z02gdUj6VnJOS8eqKw2iXeqt7rF
	fL81KkJzzVR6oTfH7BKic1vKPOHWHm0GNyA2FvDFuYPgTeDbP45804d8IsCOdWXyFauE8b
	YWRgcjVfwlfCwJJx9TNUn3cHBnC8I2hVHo3o6/Bwe+ajsFk5xo2ws9hjw4FBrt5OASRtAg
	ZNGI+M66kFKLvvchRZmnoMIv4sP19n/wcNSy8AOINFnlFtTSUY54Nom0EL+zvA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 27 Feb 2024 15:42:43 +0100
Subject: [PATCH net-next v5 01/17] MAINTAINERS: net: Add Oleksij to pse-pd
 maintainers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-feature_poe-v5-1-28f0aa48246d@bootlin.com>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
In-Reply-To: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
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

Oleksij was the first to add support for pse-pd net subsystem.
Add himself to the maintainers seems logical.

This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- New patch
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cfe44a876d8a..4f9b554f79da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17690,6 +17690,13 @@ F:	include/net/psample.h
 F:	include/uapi/linux/psample.h
 F:	net/psample
 
+PSE NETWORK DRIVER
+M:	Oleksij Rempel <o.rempel@pengutronix.de>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/pse-pd/
+F:	drivers/net/pse-pd/
+
 PSTORE FILESYSTEM
 M:	Kees Cook <keescook@chromium.org>
 R:	Tony Luck <tony.luck@intel.com>

-- 
2.25.1


