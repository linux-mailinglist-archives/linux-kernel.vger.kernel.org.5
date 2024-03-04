Return-Path: <linux-kernel+bounces-90785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEE2870506
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CE128B552
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386B2548F0;
	Mon,  4 Mar 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KS7bF7Mo"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6BE47772;
	Mon,  4 Mar 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565027; cv=none; b=NsvOo+NnP0JbZSjQC6+7rZ+s2oxq7LtRTK5u00E34yJZXXuxtBoi9uCTsWkjlI8DDSas/hTpW23PuGbLAnJVnsKjBT9cxUTaDx3vP+nMeGgOFcVx/LFhw6EkuSgoZ5eIGL9TuG1rd1PIMJLYBRm+wqUl4faPy9w7A/p98dIyRPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565027; c=relaxed/simple;
	bh=FObpKjZwmA5qdngYK9icddLLLWJb/ZpGOA9fXbSUY2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDlCCrkxKB+xk5c7xFtqY0buvgPMKgpSgkMxC+VaYJ0PMfhy4fDIhQhGS8RL1+hGPoAJCGlXO9NREXgogG/V+s0pPDTbIxtt/LaF1toQf+6fZxgaTQux3z532z2HiedBfFAp1WJKD06KIm37SawnFetBs7Ao8h4j/EjVEwZqN8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KS7bF7Mo; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D0141BF207;
	Mon,  4 Mar 2024 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709565022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pgzFb+b0po/iP/C9MLnMjDEAAPz/mzUfU3a45pXWto=;
	b=KS7bF7MoGQSpfMPtTUNNE0XVL0mtZfB3dZUlx5A5ulCMoYBvbepxnj6GmYh7vr2EM2isB2
	KqiGoNpNkIkN96b4yWT+ke2OIMB76f22P42C1PgVjGLWmEwjBYReDaZ4PrylxPhrJQ/CfG
	1iCySfk/j1PsVIU4y8B7WoLmfge1qLCZETcY22xAgfWpZMdT2i37z69hCSm5CKPESNjHNb
	DPWN4vxbpP1X1uVDS1SCcuS3H9vTrIcsb5UTEno2eZjL8+RDOl1svbH03W4/c0+Ss5Zoq6
	krrGgmg+3zg8oGXEhoFKkksAaBXA6b47QAnTvFj6GbqQ57QYN4uJbzAq6U8vCQ==
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
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org
Subject: [PATCH net-next v10 06/13] netlink: specs: add phy-index as a header parameter
Date: Mon,  4 Mar 2024 16:10:02 +0100
Message-ID: <20240304151011.1610175-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304151011.1610175-1-maxime.chevallier@bootlin.com>
References: <20240304151011.1610175-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Update the spec to take the newly introduced phy-index as a generic
request parameter.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
V10: No changes
V9: No changes
V8: No changes
V7: No changes
V6: No changes
V5: Added Andrew's R-b
V4: Ditch the ethtool-user generated code
V3: New patch

 Documentation/netlink/specs/ethtool.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 197208f419dc..bb6e1dc6d1c5 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -30,6 +30,9 @@ attribute-sets:
       -
         name: flags
         type: u32
+      -
+        name: phy-index
+        type: u32
 
   -
     name: bitset-bit
-- 
2.44.0


