Return-Path: <linux-kernel+bounces-58115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E49084E183
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D989E1F223A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6A17994E;
	Thu,  8 Feb 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IWrOk/A0"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9536F097;
	Thu,  8 Feb 2024 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397806; cv=none; b=SOycRAey5BFJ/nF2HNnjm5jXWqc2QAvVQHRdYPryOe1inKIMFYtwEl9nvnmnpwHDQ/uNrdkFEOeO47qqEWm0JiynagfLfqAgGFsS+hvZ8jczDkbSgqpWL9XH9354fHTjjIpUbXR69jA/3g6uFDzmm+fws/ESMKi4fVJEW4m3mxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397806; c=relaxed/simple;
	bh=O4JrOmwONE7XoBbMJ6P6XwBfKh+9vXZQm3jgPm6/pFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZnPmkPMQcKwUO4IUeUqE54e7afNm8ehlB8hWjY7QznQw9JmTv7uL+W9xQInHCSRj7/aDZullYRPPLp68GWp8gl+ki+TOGLR4ZFQRC5uzw6NPf/l66798ind2jsaCkvwv8Z8uKgVYuI7i6Gno4TgBnXaWZhKQPaUdDN+ehIx6Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IWrOk/A0; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E1C711BF217;
	Thu,  8 Feb 2024 13:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707397801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nz2rsEGQVUk+8dGhffLMTLpgk2opuZ6DdqVgCG9hr5s=;
	b=IWrOk/A0hN/KnZtAlfWlTvYQiUzlrH9BcK5cLqD7hHXjCaNNXCNUSA1m1J6GddzXi07KJm
	nXlsTvZ3zR2RXeoe/d8AOLP8RGf4w5yDdqJXnZhM3tyCej5hSO8k7b0Vn9kX0toCsLcvUs
	pQ91Wv3e5qUq2BH9crfEWP3RSfkw50K0KRfohBUyL2A3yPMAqVDxMuEUhA2tlnyV3F2y0z
	agIL/BrWAbLrhk8Z1Fdk/UXfC204rCE/lNWomNLTDpye2RC/KS2/6RxQCnHrY8D4pMIhQg
	JlAA8ZDp5vqCWwM0R53UpxREc5avNdMjNyggyX+dSvjMOE0NJsvnSh1pbNCetw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 08 Feb 2024 14:08:44 +0100
Subject: [PATCH net-next v3 07/17] netlink: specs: Modify pse attribute
 prefix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-feature_poe-v3-7-531d2674469e@bootlin.com>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
In-Reply-To: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
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

Remove podl from the attribute prefix to prepare the support of PoE pse
netlink spec.

Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
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


