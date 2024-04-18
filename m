Return-Path: <linux-kernel+bounces-149866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBCD8A96FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F2D1C21DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031CC15B57C;
	Thu, 18 Apr 2024 10:07:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AE015B543
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434875; cv=none; b=r1qKrfs0FvTXjYHjHyaZmRXpPAISTJ7aUA12kFXdPlkgW7TRjcrisRZh3hV4KK3gvRecf0GTslDOipty29yzAmm75sOptnO3RR3kiwRpkuriIYZGR+vtiOONRJKXleDW+FiLUh7Hl0/M9cbScGHrFKtL/DJaIioBDOBofY5kY+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434875; c=relaxed/simple;
	bh=7O+LNSXVNCaHl6Nfv33MAGBk4qvosexTJdATWUtdkM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPhIekJGj847N4YZjnTHJXnmS6MyDNxtfHkIlnGSHZetdQHFjboYrP/GYc38NSYM73P2AFzO3eGyOPTFp5bLig8WxUnDpG2Fm4vfUJehGSZPZxYKDkXjgh/toOOCYaAG3lohNm4XDNJrPeROT2AOLnmIbZ8yMnfSGm+THmq6nWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rxOfi-0008GD-F0; Thu, 18 Apr 2024 12:07:14 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rxOff-00CxIk-Fp; Thu, 18 Apr 2024 12:07:11 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rxOff-001VPQ-1C;
	Thu, 18 Apr 2024 12:07:11 +0200
Date: Thu, 18 Apr 2024 12:07:11 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rob Herring <robh@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Dent Project <dentproject@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	kernel@pengutronix.de, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Russ Weight <russ.weight@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Mark Brown <broonie@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH net-next v9 08/14] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <ZiDwz7_2nGzwVHy8@pengutronix.de>
References: <20240417-feature_poe-v9-0-242293fd1900@bootlin.com>
 <20240417-feature_poe-v9-8-242293fd1900@bootlin.com>
 <171336806575.2618779.157615998420721814.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <171336806575.2618779.157615998420721814.robh@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Apr 17, 2024 at 10:34:26AM -0500, Rob Herring wrote:
> On Wed, 17 Apr 2024 16:39:56 +0200, Kory Maincent wrote:
...
> > ---
> >  .../bindings/net/pse-pd/pse-controller.yaml        | 101 ++++++++++++++++++++-
> >  1 file changed, 98 insertions(+), 3 deletions(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> 
> 
> doc reference errors (make refcheckdocs):
> Warning: Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml references a file that doesn't exist: Documentation/networking/pse-pd/pse-pi.rst
> Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml: Documentation/networking/pse-pd/pse-pi.rst

Hm... this documentation was added by patch 7. I assume refcheckdocs
is searching in the wrong place or should the path be relative?

Is this warning a blocker for this patch set?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

