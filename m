Return-Path: <linux-kernel+bounces-154753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 756378AE08E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE6E2815B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD6E56B95;
	Tue, 23 Apr 2024 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QmfZFATO"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ADD4F8BC;
	Tue, 23 Apr 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863176; cv=none; b=TdeX4u+3HF7S7IivvRHaUKHsX6uO+5pm/NiHof0dnaGZG7nabTtmlPN2c1fSjlAlLUtJUJplt8SMcIbAtQu0119xXhkixp6xLpcK4NvYFfBXGiEu5bMNkjYR9NkCqM0T102nSnYq9dzTcqLYvcYmyxLgUOhyAYDaZy1jMrLqgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863176; c=relaxed/simple;
	bh=d7grghopQB8+ZV6SUWtgd/HHnw0xUUXAvoi+YyytVmc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ssu3VHxTXtGoZRnuEcaNyxPO0r8rPSq9A4Oku0yOZjpf7aYX9l7Or40oiFe1Xge/LReixqVzyaGAanwg/S2iSqV005Js0BqOmCxNKkeZidGATz9AJ5Oq9rN9LLt93PQkbp87uPmke6LK5b/pqjxzmw/RXKaybie+9cfKScD8g64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QmfZFATO; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19C4FE0005;
	Tue, 23 Apr 2024 09:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713863172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1X2zJZiM3d1QSAauORVozcYGN0DQAyvHVAJSx5oOYK8=;
	b=QmfZFATO2Wk5Ba3vDn2iO51HylG/LKHv5eqhsPZjH3tZMdFEYB4T4ngEnOCntyOv5H5aIA
	OIQoca+XWyHTSi7eFitaLW/fl6rBhRGlfjTcUoTRctNe5kfr42Cjbmrm4xphkL1+rwYWa6
	KqoRCsiHXtndmFQgKxFXUqaqprjovzjVCuQHDqohMruuAxhU0wkEsy4AvLVW4ZgwWUmyKq
	3SIzaq407KplK0t1h+4XJzsDoq5UdPVdjXJowl1ENm0R01bIUDkjjJ0aWzwPQVT45/GPI8
	GwtZv7hd6ByTBPJjYg8OXa+xXoe9SLnTDtA0gsBUR/wub+Ih0cvpRmwj2/pvwg==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH ethtool-next 0/2] Add support for Power over Ethernet
Date: Tue, 23 Apr 2024 11:05:40 +0200
Message-Id: <20240423-feature_poe-v1-0-9e12136a8674@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOR5J2YC/x3MQQqAIBRF0a3EHyeoWURbiYioZ30IDbUIor0nD
 c/g3ociAiNSVzwUcHFk7zJUWdC8TW6F4CWbtNRGGl0JiymdAePhIawyUqJuG7UYysURYPn+bz0
 hbcn7XTjciYb3/QAIv805awAAAA==
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Expand the PSE support with Power over Ethernet (clause 33) alongside
the already existing PoDL support.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (2):
      update UAPI header copies
      ethtool: pse-pd: Add support for Power over Ethernet (clause 33)

 ethtool.c                    |  1 +
 netlink/pse-pd.c             | 66 ++++++++++++++++++++++++++++++++++++++++++++
 uapi/linux/ethtool.h         | 55 ++++++++++++++++++++++++++++++++++++
 uapi/linux/ethtool_netlink.h |  3 ++
 4 files changed, 125 insertions(+)
---
base-commit: e7700bcc192c1a184f9fc3a5eee02939392a8f08
change-id: 20240423-feature_poe-f1400e5861d4

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


