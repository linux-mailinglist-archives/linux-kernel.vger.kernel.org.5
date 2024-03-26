Return-Path: <linux-kernel+bounces-119122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE57288C47D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548C01C3E5F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034F1128392;
	Tue, 26 Mar 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T966mhM4"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7297581E;
	Tue, 26 Mar 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461900; cv=none; b=NOdK/zh/C0V8mDTb+dSq75gfsSb1X176nprN890NxIFGzUartSFFUjpiPAaCIVI5lJXL/xcPA6s5jOSfmZlcMfkgtHaQZ9LL0keNOFy0n/Wtw86Wg9KEl6ycTqxtogKr6gh9PkNss+jNsRMpfjtN7qqGjrSnjJ9uMTm1yVrupOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461900; c=relaxed/simple;
	bh=FH59797bInmj9cN9sp71rrKs6IDAr4DGgkKsv76D3NY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ok+/F+8zFTYk6WIOwu4o7FrIZdriO1RJjFEtKA1i5VUOYZx5AV9KW1NzgfRPtGJa3mt6G2UilksVsnjhd/FCjkYaABzwv6Eh/RtdICh1vZ1oN0pthSjFxFivLbceAvFui2ADbCV/xUT+1r+cFrkstD9JByJXbkS7HaFvGDFAwJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T966mhM4; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF2951C0011;
	Tue, 26 Mar 2024 14:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711461896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kO8IjfIavVGTVa8HmrxQ8s1k/vWMDrYAlJQlGwCj6b4=;
	b=T966mhM4efbuv7OuzmcU9PnfvklMVJnbJVQ53xiYpXFxV0UlbxNd2pYvKzxwz1g0xRgmOK
	uAJM3LHxxcJPddRQxUIwYzckygBmoQgSzPCJ9bNyvpUj0cCTPb/16GRx9Ojkt9pbMVaWCs
	HCQp0JXjnYdRNYe2JcVVlDK07m0G3BTMylQAN+mQywEk7vwfEu902eCCMr0P7tGaCwJZK7
	+/lkj38ssgW7rOMMCTpFzZ489sP+l1h3aE4xszM8AmoTJG9wirf1Udkk23GE8LIKbvcvzQ
	lVWwY5Uue4kLLaJBTCG/h2iewmI0W8rE+/wbSlLWubdOAVyGR/boK+2KBPxTvA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 26 Mar 2024 15:04:44 +0100
Subject: [PATCH net-next v6 07/17] netlink: specs: Modify pse attribute
 prefix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-feature_poe-v6-7-c1011b6ea1cb@bootlin.com>
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

Remove podl from the attribute prefix to prepare the support of PoE pse
netlink spec.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- Add the ethtool auto generated code.

Changes in v3:
- Remove the ethtool auto generated code.
---
 Documentation/netlink/specs/ethtool.yaml | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 197208f419dc..33e81fa189ca 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -878,17 +878,17 @@ attribute-sets:
         type: nest
         nested-attributes: header
       -
-        name: admin-state
+        name: podl-pse-admin-state
         type: u32
-        name-prefix: ethtool-a-podl-pse-
+        name-prefix: ethtool-a-
       -
-        name: admin-control
+        name: podl-pse-admin-control
         type: u32
-        name-prefix: ethtool-a-podl-pse-
+        name-prefix: ethtool-a-
       -
-        name: pw-d-status
+        name: podl-pse-pw-d-status
         type: u32
-        name-prefix: ethtool-a-podl-pse-
+        name-prefix: ethtool-a-
   -
     name: rss
     attributes:
@@ -1571,9 +1571,9 @@ operations:
         reply:
           attributes: &pse
             - header
-            - admin-state
-            - admin-control
-            - pw-d-status
+            - podl-pse-admin-state
+            - podl-pse-admin-control
+            - podl-pse-pw-d-status
       dump: *pse-get-op
     -
       name: pse-set

-- 
2.25.1


