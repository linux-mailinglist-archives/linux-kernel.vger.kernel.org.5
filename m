Return-Path: <linux-kernel+bounces-67261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08888568C6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2E428B276
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C349D135A64;
	Thu, 15 Feb 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WLNFjQT2"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CD413342A;
	Thu, 15 Feb 2024 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013008; cv=none; b=tbqGNdGPXNpgp+os0sxxYbpTpr1VsLq6Dw9W4rnVbM74nfVBw+ndbLDTYG+YYqKtcJeUstE2V+z0m97o6F6Jp1Zr7jVQmg4G73VdRUOsaUkoTGGCWbStd+OOiSD3RrrQD6XF1Daw9sdCR8SuNP83KUL2yLxZB965b8Sdfzsz5aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013008; c=relaxed/simple;
	bh=SvAxJc48na4HvUMnyatKXSxAVw0H3dyvGGDTMWeUvBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jVhZjrN/r8jG79o7ASMMKNFwgz+LJmr6iGZNbp/O37sQsGTwWH1SHBBCKNVQxuP4AZsreV91NWi+bn22ir3O7DFKS1zSB9g2AxGmyfq2eduAZWrOMuQ6uTGpq7joEruRFlZWq9jYhJlp4o4X0Wm7hjtdGDwPxzv8HexUw9kq4LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WLNFjQT2; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9005220005;
	Thu, 15 Feb 2024 16:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708013002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ocKV4hgvR95HFRScEG0Z08EHiODK9cUBdzYmmCWey4=;
	b=WLNFjQT2pSMGwtPeIrlEDU3WjiD1bNxJGUY027YCPu8L53dGoVaOcqMYvpRCvzLYD3A0/j
	MK3Px6zU+YP9nuC8gB9Qvzwn1NP5pjc5HJsEMpakEPKOpvFC32TSNgJCIcr/+LufQp2Zao
	xAZ0tEnh+fyIBxFdbUw/fCw+LUZm6zBeqTUdgXtCHuRbWtajTTW89wLuGKoselQwZkbWU0
	9ElrbcWjBVSHjXZj5V53+NcZUrOhu2lyffKPY/ANRePkptDB3oFWptYKcR9M6Jdp2omcAZ
	XSpRqQd8FpZwtkZcaRMAk7A4iGFPRTsXuBd++apip8uAi5tF4VPsZAYAKX11PQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 15 Feb 2024 17:02:42 +0100
Subject: [PATCH net-next v4 01/17] MAINTAINERS: net: Add Oleksij to pse-pd
 maintainers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-feature_poe-v4-1-35bb4c23266c@bootlin.com>
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
index 2b775f4369e0..b3081334698d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17682,6 +17682,13 @@ F:	include/net/psample.h
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


