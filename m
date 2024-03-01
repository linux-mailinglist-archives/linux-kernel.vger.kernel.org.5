Return-Path: <linux-kernel+bounces-88750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722B986E618
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E8228A193
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83B83A8F6;
	Fri,  1 Mar 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pFTSD/0k"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9961A3A1DA;
	Fri,  1 Mar 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311396; cv=none; b=ZqEG9S4wQnZbLtCtyo3wAKyJcTuO8NwHfIRZ0JBb5F45Co5ekuvef5JFwlkoACCt7kQ7xmMkI8MEMhOybxXmthycjE4pG6cOfgyYSh70odmSemDik5U0LBRxtlLOTkTamRr3nk9GS7foPHH4q9xlxNd+f+k4JNItiUOaJuge+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311396; c=relaxed/simple;
	bh=d88IbXBojHwL6DV2uZhvy9YjIo2iMnBl7jgt2E1FEtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZEGOLiFRaylgkzVYx5N0Kf1jBvQnJ4UlyWOZF+K2aCJwwsSM7qxojgBH2L0Bbd8/Jdg3Z2xQPTD1UcUrvgBjGyWQg0RBzCaqhCd202ap4Zdqk39dA0rtoBXRbZTG1vyZv9MF6arVbMujcnS8DoHR8/2gf2IvmtHPDMTKejPSvCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pFTSD/0k; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A56A240006;
	Fri,  1 Mar 2024 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709311391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s1kVtBo3wFo1/4oQQJ6i5NIv1hpQWWCqz+qSHUmD/D4=;
	b=pFTSD/0kVcP9ps/fq8QSVgFvLV84hl0UtNohbfFwMTV4Fi/oqisBzqPFOuCebwYV1Dl3Rt
	CcovQc08lJyu4geMrEl9tkXCR70kb/ZWuOJjeN8n3bibCQ+GZOmG8eaPiNqY/nhqhiiqLT
	IBRhPtu6xUS02gzQ12UTbFxYYoP/Z7jQtZ013uR66sYWbuV/WGt7uTEbBsVgVZfxUGBlxM
	YhabU7E9pJOjYwY08umqui8kCRlV9bPadfFJSGDbSpCRIDyBQlIJhk50SYe9AP9XvX/1dm
	5/aNwvaLTIDJ0sr/IONWLQOZ9OjMJHEzkKhpL5pSy+tExkNhUT7VPeHRXuPD4g==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v3 0/2] doc: sfp-phylink: update the porting guide 
Date: Fri,  1 Mar 2024 17:43:06 +0100
Message-ID: <20240301164309.3643849-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

Here's a V3 for an update on the phylink porting guide. The only
difference with V2 is a whitespace fix along with a line-wrap.

The main point of the update is the description of a basic process to
follow to expose one or more PCS to phylink. Let me know if you spot any
inaccuracies in the guide.

The second patch is a simple fixup on some in-code doc that was spotted
while updating the guide.

Link to V2: https://lore.kernel.org/netdev/20240228095755.1499577-1-maxime.chevallier@bootlin.com/
Link to V1: https://lore.kernel.org/netdev/20240220160406.3363002-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (2):
  doc: sfp-phylink: update the porting guide with PCS handling
  net: phylink: clean the pcs_get_state documentation

 Documentation/networking/sfp-phylink.rst | 147 ++++++++++++++++++++---
 include/linux/phylink.h                  |   3 -
 2 files changed, 133 insertions(+), 17 deletions(-)

-- 
2.43.2


