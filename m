Return-Path: <linux-kernel+bounces-9466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AB381C600
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144EB1C218D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C103BE50;
	Fri, 22 Dec 2023 07:55:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5832ABE48
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rGaMz-00027g-BL; Fri, 22 Dec 2023 08:54:57 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rGaMu-000hcp-CW; Fri, 22 Dec 2023 08:54:53 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rGaMv-008FUz-CD; Fri, 22 Dec 2023 08:54:53 +0100
Date: Fri, 22 Dec 2023 08:54:53 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <20231222075453.GJ1697233@pengutronix.de>
References: <20231205064527.GJ981228@pengutronix.de>
 <4b96b8c8-7def-46e5-9c85-d9e925fb9251@sirena.org.uk>
 <20231205140203.GK981228@pengutronix.de>
 <88ed0c94-d052-4564-be0c-79a0f502eda8@sirena.org.uk>
 <20231221163610.47038996@kmaincent-XPS-13-7390>
 <ffda1003-b752-402e-8e51-e2e24a840cff@sirena.org.uk>
 <20231221171000.45310167@kmaincent-XPS-13-7390>
 <501f671d-4e03-490b-a9d6-e1f39bb99115@sirena.org.uk>
 <20231221174246.GI1697233@pengutronix.de>
 <81f0ddba-5008-43a4-a41c-c7b6ba8e2e3b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81f0ddba-5008-43a4-a41c-c7b6ba8e2e3b@sirena.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2023 at 06:05:28PM +0000, Mark Brown wrote:
> On Thu, Dec 21, 2023 at 06:42:46PM +0100, Oleksij Rempel wrote:
> 
> > The main question is - how to represent a remote consumer (Powered
> > Device)? It looks for me like having a dummy regulator consumer for each
> > (PSE PI) withing the PSE framework is the simplest thing to do. User
> > should enable this dummy consumer from user space by using already
> > existing interface in case of PoDL - ETHTOOL_A_PODL_PSE_ADMIN_CONTROL
> > or new interface for Clause 33 PSE.
> 
> That's not even a dummy consumer - the physical power output from the
> system is a real, physical thing that we can point at just as much as
> any other physical device.  Some kind of library/helper thing that
> connects up with other interfaces for controlling network ports like you
> suggest above does seem like a good fit here.

@Köry,

It will be good if you add vin-supply property to your DTs. It will
allow to track all needed dependencies. If I interpret PD692x0/PD69208
manuals properly, each Manager may have only one Vmain shared for
different ports. But different managers may have different Vmains.

I assume, regulator tree will be like this:
Vmain-0
  manager@0 (assigned to ethernet-pse@3c controller)
    port0
    port1
    ..
  manager@1 (assigned to ethernet-pse@3c controller)
    port0
    port1
    ..

More complex system may look like:
Vmain-0
  manager@0 (ethernet-pse@3c)
    port0
    port1
    ..
Vmain-1
  manager@1 (ethernet-pse@3c)
    port0
    port1
    ..


Not sure how to properly represent even more complex system with
multiple controllers, in this case manager names will overlap:
Vmain-0
  manager@0 (ethernet-pse@3c)
    port0
    port1
    ..
  manager@0 (ethernet-pse@4c) <----
    port0
    port1
    ..

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

