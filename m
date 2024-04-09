Return-Path: <linux-kernel+bounces-136463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EA189D446
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB71281585
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F2A84FDA;
	Tue,  9 Apr 2024 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aXF27tGv"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D127F46F;
	Tue,  9 Apr 2024 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651235; cv=none; b=Hj5Rq2yc9itjRzX/TdA694KIWM20wiQgKVNptvCbSHiDu6ibvnXmpmLztpTtQQhFzB3zVOxvNsnCAcancjzRrZXt4jTcqiVQv0NJNdln9OzyttBmbOtXEG3tAdxei6SN+Cy96qjjH+RACPO1VhuouoF5K9Vrbmczdmt/HMbQaZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651235; c=relaxed/simple;
	bh=IjMflVvqVRERvYARWe4LKlkVuXmMgcYCDaoitd2X9iQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mVVHM+kzuUHotSVznv6RgHeR6XDJvwQQXoOfmgNCJWy+vqiEp/86GAaSaR+F0/EnqwUk4XIUHJrt0u9tdKXKbVV3ZlZlz5jtacohFVpBtSe/zZYFocStYwKra2F7F/+hQasFUqNVIJBI8LIgg1yP4Us1ZOtzYsr/e658PICLZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aXF27tGv; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1DF7FFF80F;
	Tue,  9 Apr 2024 08:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712651231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrY8w0IMosIqtvCpNeKN+wcauJqxms1gGg8T+SvT1J8=;
	b=aXF27tGvEZW+Moe0BLe53dC+U/FPJA/8jWeTAeaMy6kCQZ3oNd5SBZx4/uA06C4qUBv6IL
	t1p1oVrPendf3N4Ofbq0DHMe/pygeEG0A0FnQ6W2ygQQoBcovxw3Fej1ucsvuRdvrkeC8q
	uYoz8TSfoABI37Wys3H6ZqyKLuMI8lfMu9nOzyxqd24QJu5ULtYLU/y89XqgFDDuc1+QOJ
	OCREortG2Q/4l0VEUL3Jgul3jzpM+9xaanGXMePyEwZvG3oRSYN1S5H8Ho4JeDLI8pt5kn
	MjTy04ChjlmqSEW3NAWtpHLIvrZu5/C9K00WGqCBKhGsaXN4jADWrTvFcobqZg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 09 Apr 2024 10:26:28 +0200
Subject: [PATCH net-next v10 06/13] net: net_tstamp: Add unspec field to
 hwtstamp_source enumeration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-feature_ptp_netnext-v10-6-0fa2ea5c89a9@bootlin.com>
References: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
In-Reply-To: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Prepare for future support of saving hwtstamp source in PTP xarray by
introducing HWTSTAMP_SOURCE_UNSPEC to hwtstamp_source enum, setting it
to 0 to match old behavior of no source defined.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch
---
 include/linux/net_tstamp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index 3799c79b6c83..662074b08c94 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -14,6 +14,7 @@
 					 SOF_TIMESTAMPING_RAW_HARDWARE)
 
 enum hwtstamp_source {
+	HWTSTAMP_SOURCE_UNSPEC,
 	HWTSTAMP_SOURCE_NETDEV,
 	HWTSTAMP_SOURCE_PHYLIB,
 };

-- 
2.34.1


