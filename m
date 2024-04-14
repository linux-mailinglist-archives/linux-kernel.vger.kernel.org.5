Return-Path: <linux-kernel+bounces-144198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B188A4303
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3334F1C20CC6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070F05D747;
	Sun, 14 Apr 2024 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gOhhSZmP"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8AC5D49F;
	Sun, 14 Apr 2024 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713104605; cv=none; b=VusYemqd1hW4uJ/onQtQMGnY8FLxVWln/K0CWE83t0am76swY1XP0UJUPPbxoGZH4SknkPp6i5zdBLwt80lwFmYuwpbFY6w8NveQfgJHxql02gC2Z3LpH0kNBQAub/3YmuZACoBEYt1DI2QXSLdlLPvCwUA4EMm3IOGP9Itpy5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713104605; c=relaxed/simple;
	bh=gokalcX3WXY0vMEV3heZ+JRkNOxiX5XhaHOXIaK5kOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cFei3lEONGJf9K4UJR5ivVJhIJNuwhk9rKb7/M9CpaY01czis4iTHVjdvnBCPcLTEfdvcFfPeg2wW8kWnLb/IHxzOPbGX9mRenBq7HwK8eQIQxdWu64FA4kjy64uxH7dQNonq2KDI6zkewV651Ie6ZEYbfFK2sBENMPcyzwJGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gOhhSZmP; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14C38C0007;
	Sun, 14 Apr 2024 14:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713104601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVjtEGNqaX+gge+DZ3iXXzFwuVZc1uJVfI4+BJJlna4=;
	b=gOhhSZmPi/VEWKvmg4CUGvFld6eSS9vDlU6MOS9Z/J5Q1kjnWIah8mZhArSqreXH7FA+QF
	TAPlGwDNQVguB6HXdLrBT++H+NfIgDOW0rC4Og00lihOv5Ste0J0Pcz1WfkfZgKmjztqve
	ttgdBQJWSncXjBnVJW67UQtBxUfH/2Xltlnmh+n9OvBNoBtjRxQsdNLYp6HStX5e8u9eGS
	Y03Iq8IAnV/OeN1OthEhsCTer01Pi8eX3+Oi2sHejrdEeYvWazuwL+OQG8V9HXc+6SIc2o
	X1tsuDyi44/aYI2MxWliL5IwtqI5CQLbO42DqHjPhni0qC9znq37R6/uC41Txw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Sun, 14 Apr 2024 16:21:56 +0200
Subject: [PATCH net-next v8 07/17] netlink: specs: Modify pse attribute
 prefix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-feature_poe-v8-7-e4bf1e860da5@bootlin.com>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
In-Reply-To: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
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
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
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
index 87ae7b397984..9a454cb924f7 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -899,17 +899,17 @@ attribute-sets:
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
@@ -1593,9 +1593,9 @@ operations:
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
2.34.1


